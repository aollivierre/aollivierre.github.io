from fabric import Connection
from getpass import getpass
import time

def update_ubuntu_system():
    host = "192.168.100.206"
    username = "admin-abdullah"
    password = getpass("Enter password: ")

    # Connect to remote host
    c = Connection(
        host=host,
        user=username,
        connect_kwargs={"password": password}
    )

    # Commands to run
    commands = [
        f'echo "{password}" | sudo -S apt update',
        f'echo "{password}" | sudo -S DEBIAN_FRONTEND=noninteractive apt upgrade -y',
        f'echo "{password}" | sudo -S pro status',
        f'echo "{password}" | sudo -S pro auto-attach',
        f'echo "{password}" | sudo -S shutdown -r now'
    ]

    try:
        # Execute commands
        for cmd in commands:
            print(f"Executing: {cmd}")
            try:
                result = c.run(cmd, pty=True)
                print(result.stdout)
            except Exception as cmd_error:
                print(f"Command error: {cmd_error}")
                if "shutdown" not in cmd:  # Continue if it's not the shutdown command
                    continue
                break

        # Wait for system to go down and come back up
        print("Waiting for system to reboot...")
        time.sleep(30)  # Initial wait for shutdown

        # Check for system to come back online
        max_attempts = 20
        attempt = 0
        
        while attempt < max_attempts:
            try:
                print(f"Checking system status (attempt {attempt + 1}/{max_attempts})...")
                new_conn = Connection(
                    host=host,
                    user=username,
                    connect_kwargs={"password": password}
                )
                result = new_conn.run('uptime -s', pty=True)
                print(f"System is back online! Boot time: {result.stdout}")
                new_conn.close()
                break
            except Exception:
                time.sleep(15)
                attempt += 1

        if attempt >= max_attempts:
            print("Timeout waiting for system to come back online")

    except Exception as e:
        print(f"Error: {e}")
    finally:
        try:
            c.close()
        except:
            pass  # Connection might already be closed due to reboot

if __name__ == "__main__":
    update_ubuntu_system()




#Note: This script requires Python 3.13.1 or later


# Yes, absolutely! The direct SSH approach would have been much simpler. Here's what we could have done:

# 1. First establish SSH connection:
# ```bash
# ssh admin-abdullah@192.168.100.206
# ```

# 2. Then run these commands directly in the SSH session:
# ```bash
# sudo apt update
# sudo apt upgrade -y
# sudo shutdown -r now
# ```

# This would have:
# 1. Been more straightforward
# 2. Let us see the output in real-time
# 3. Avoided all the complexity of wrapping commands and handling sudo prompts
# 4. Given us an interactive terminal by default

# The main reason to use PowerShell or Python scripts would be:
# - If you need to automate this across many servers
# - If you need to parse and process the output
# - If you need to run this as part of a larger automation workflow

# But for a one-off maintenance task on a single server, direct SSH is much simpler and more reliable. Sometimes we can overcomplicate things by trying to script everything!
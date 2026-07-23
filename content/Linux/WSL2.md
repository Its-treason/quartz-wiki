## Reclaiming disk space

All data of WSL2 Distros and Docker is stored in `.vhdx` files under the current user's “AppData” directory. The problem is that the virtual hard disk files size will not shrink when disk space in freed on the WSL2 distro. This issue has already been discussed on GitHub: [https://github.com/microsoft/WSL/issues/4699](https://github.com/microsoft/WSL/issues/4699) but currently the only solution is to manually optimize the virtual hard disk to reclaim disk space.

### Locating the virtual hard disk files

The easiest way to locate them is to use “WinDirStat” it will show the files clearly and allows copying and pasting the path.

Without “WinDirStat” the files can be found under `C:\Users\<User>\AppData\Local\Docker\wsl\data\ext4.vhdx` for docker and `C:\Users\<User>\AppData\Local\Packages\<Distro>\LocalState\ext4.vhdx`.

### Reclaiming space

First, be sure to shut down all WSL2 distros by running `wsl --shutdown` inside a PowerShell. After that, executing `wsl --list --running` should print out `There are no running distributions.`.

After shutting down all WSL2 distros, you can run `optimize-vhd -Path <Path> -Mode full` in a PowerShell with administrator privileges. The optimization process will take a few minutes to complete.
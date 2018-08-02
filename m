From: Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 02 Aug 2018 10:00:24 +0000
Subject: Re: [PATCH 5/5] zfcpdump: Add install script for zfcpdump
Message-Id: <20180802100024.GE5361@linux.ibm.com>
In-Reply-To: <fd6898dc-3016-fd1e-1e4c-31cec7b21a7c@redhat.com>
References: <fd6898dc-3016-fd1e-1e4c-31cec7b21a7c@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 25, 2018 at 01:36:15PM +0200, Philipp Rudo wrote:
> Since version 198 (Feb 2013) systemd contains kernel-install, a script
> managing kernel installs. This script allows execution of drop-in scripts
> for customization. Add such a drop-in script to s390-tools to handle the
> installation of zfcpdump kernels and simplify interactions between zfcpdump
> and zipl.
> 
> The script supports two installation modes. One recommended by the
> BootLoaderSpecs [1] to /boot/<machine-id>/<kernel-version> directories and
> one directly to /boot. In the second case files are renamed during
> installation to <original-name>-<kernel-version> to guarantee unique names.
> 
> Because the zfcpdump kernel is so special make the script stand-alone and
> prevent any other script from being executed (exit 77) when a zfcpdump is
> installed. Especially avoid functionality like creating an initrd (already
> provided by s390-tools) or creating a boot entry (the zfcpdump kernel
> should not be used for any other purpose than dumping).
> 
> The script requires systemd >= 203.
> 
> [1] https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
> 
> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
> ---
>  .gitignore                      |   1 +
>  common.mak                      |   3 +-
>  zfcpdump/10-zfcpdump.install.in | 114 ++++++++++++++++++++++++++++++++++++++++
>  zfcpdump/Makefile               |  16 ++++--
>  4 files changed, 130 insertions(+), 4 deletions(-)
>  create mode 100755 zfcpdump/10-zfcpdump.install.in

Looks good to me :)

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

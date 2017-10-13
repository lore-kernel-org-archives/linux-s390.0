Return-Path: <stable-owner@vger.kernel.org>
Date: Fri, 13 Oct 2017 10:28:59 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: fix zfcpdump_defconfig failing to perform
 zfcpdump
In-Reply-To: <1507804646-6197-1-git-send-email-xnox@ubuntu.com>
References: <1507804646-6197-1-git-send-email-xnox@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171013102859.7e603a48@TP-holzheu>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/stable/>
List-Post: <mailto:stable@vger.kernel.org>
To: Dimitri John Ledkov <xnox@ubuntu.com>
Cc: linux-s390@vger.kernel.org, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am Thu, 12 Oct 2017 11:37:26 +0100
schrieb Dimitri John Ledkov <xnox@ubuntu.com>:

> zipl from s390-tools generates root=/dev/ram0 kernel cmdline for
> zfcpdump, thus BLK_DEV_RAM is required.
> 
> zfcpdump initrd mounts DEBUG_FS, thus it is also required.
> 
> Without above two options kernel images built with zfcpdump_defconfig
> fail to perform zfcpdump. Affects v4.10+.
> 
> Bug-Ubuntu: https://launchpad.net/bugs/1722735
> Bug-Ubuntu: https://launchpad.net/bugs/1719290
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dimitri John Ledkov <xnox@ubuntu.com>
> ---
>  arch/s390/configs/zfcpdump_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
> index afa46a7..04e042e 100644
> --- a/arch/s390/configs/zfcpdump_defconfig
> +++ b/arch/s390/configs/zfcpdump_defconfig
> @@ -27,6 +27,7 @@ CONFIG_NET=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  # CONFIG_FIRMWARE_IN_KERNEL is not set
> +CONFIG_BLK_DEV_RAM=y

In https://launchpad.net/bugs/1722735 was reported that the ramdisk
problem was introduced with kernel 4.10. But to me it looks like
the kernel config option CONFIG_BLK_DEV_RAM is also not there in
kernel 4.9:

 linux-master ((v4.10))$ git checkout v4.9
 Previous HEAD position was c8d2bc9bc39e... Linux 4.8
 HEAD is now at 69973b830859... Linux 4.9
 linux-master ((v4.9))$ make zfcpdump_defconfig
   HOSTCC  scripts/basic/fixdep
 #
 # configuration written to .config
 #
 linux-master ((v4.9))$ grep CONFIG_BLK_DEV_RA .config
 # CONFIG_BLK_DEV_RAM is not set

Regards
Michael

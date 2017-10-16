Return-Path: <stable-owner@vger.kernel.org>
Date: Mon, 16 Oct 2017 11:24:05 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: fix zfcpdump_defconfig failing to perform
 zfcpdump
In-Reply-To: <CANBHLUhd3a89qaK2XgS7jSKMcA75-MQ3tUizia+j1FrEBH3jkg@mail.gmail.com>
References: <1507804646-6197-1-git-send-email-xnox@ubuntu.com>
        <20171013102859.7e603a48@TP-holzheu>
        <CANBHLUhd3a89qaK2XgS7jSKMcA75-MQ3tUizia+j1FrEBH3jkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171016112405.7693bf82@TP-holzheu>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/stable/>
List-Post: <mailto:stable@vger.kernel.org>
To: Dimitri John Ledkov <xnox@ubuntu.com>
Cc: linux-s390@vger.kernel.org, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am Fri, 13 Oct 2017 14:36:11 +0100
schrieb Dimitri John Ledkov <xnox@ubuntu.com>:

> On 13 October 2017 at 09:28, Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> > Am Thu, 12 Oct 2017 11:37:26 +0100
> > schrieb Dimitri John Ledkov <xnox@ubuntu.com>:
> >
> >> zipl from s390-tools generates root=/dev/ram0 kernel cmdline for
> >> zfcpdump, thus BLK_DEV_RAM is required.
> >>
> >> zfcpdump initrd mounts DEBUG_FS, thus it is also required.
> >>
> >> Without above two options kernel images built with zfcpdump_defconfig
> >> fail to perform zfcpdump. Affects v4.10+.
> >>
> >> Bug-Ubuntu: https://launchpad.net/bugs/1722735
> >> Bug-Ubuntu: https://launchpad.net/bugs/1719290
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Dimitri John Ledkov <xnox@ubuntu.com>
> >> ---
> >>  arch/s390/configs/zfcpdump_defconfig | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
> >> index afa46a7..04e042e 100644
> >> --- a/arch/s390/configs/zfcpdump_defconfig
> >> +++ b/arch/s390/configs/zfcpdump_defconfig
> >> @@ -27,6 +27,7 @@ CONFIG_NET=y
> >>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> >>  CONFIG_DEVTMPFS=y
> >>  # CONFIG_FIRMWARE_IN_KERNEL is not set
> >> +CONFIG_BLK_DEV_RAM=y
> >
> > In https://launchpad.net/bugs/1722735 was reported that the ramdisk
> > problem was introduced with kernel 4.10. But to me it looks like
> > the kernel config option CONFIG_BLK_DEV_RAM is also not there in
> > kernel 4.9:
> >
> 
> True.
> 
> The actual symptoms on v4.10 is that /dev/ram0 does not exist. And I
> guess BLK_DEV_RAM is one way to get it working once again.
> I did a checkout of v4.9 generated zfcpdump_config; did a checkout of
> v4.10 generated zfcpdump_config and diffed the two, grepping for
> removed keys which points at
> 
> $ diff -u v4.9 v4.10 | grep '^\-' | grep =y
> -CONFIG_DEVKMEM=y
> 
> Which is from
> commit e334cd69fa65fc9e916d6adc8d860a9b6b9e7281
> Author: Dave Young <dyoung@redhat.com>
> Date:   Mon Oct 10 13:34:33 2016 +0800
> 
>     Move CONFIG_DEVKMEM default to n
> 
> I will retest again a v4.10 kernel with just CONFIG_DEVKMEM toggled
> back to y. As an end-user of kernel config it feels surprising that
> toggle of /dev/kmem controls whether or not initrd is available to be
> used as root=/dev/ram0.

Indead it is - especially when looking into drivers/char/Kconfig:

v4.9:

config DEVKMEM
        bool "/dev/kmem virtual device support"
        default y
        help
          Say Y here if you want to support the /dev/kmem device. The
          /dev/kmem device is rarely used, but can be used for certain
          kind of kernel debugging operations.
          When in doubt, say "N".

v4.10:

config DEVKMEM
        bool "/dev/kmem virtual device support"
        help
          ....

There is no "select" statement that enables initrd/initramfs support.

I have no idea why disabling DEVKMEM leads to your observation.

> I would have thought CONFIG_BLK_DEV_INITRD=y
> should be sufficient to get initrd available as /dev/ram0.
> 
> If all that checks out, what would the preference be DEVKMEM=y or
> BLK_DEV_RAM=y to guarantee that booting with `root=/dev/ram0` works
> (which is what `zipl -d` generates), irrespective of any other kernel
> defaults changes?

IMHO we should enable CONFIG_BLK_DEV_INITRD as described in the
zfcpdump README:

src/s390-tools/zfcpdump $ git grep BLK_DEV_INITRD
README.part: * CONFIG_BLK_DEV_INITRD=y

Michael

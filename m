Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-6-arnd@arndb.de>
 <20180909041114.GD19965@ZenIV.linux.org.uk>
In-Reply-To: <20180909041114.GD19965@ZenIV.linux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Sep 2018 22:26:54 +0200
Message-ID: <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Theodore Ts'o <tytso@mit.edu>, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Sep 9, 2018 at 6:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 08, 2018 at 04:28:12PM +0200, Arnd Bergmann wrote:
> > These are all handled by the random driver, so instead of listing
> > each ioctl, we can just use the same function to deal with both
> > native and compat commands.
>
> Umm...  I don't think it's right -
>
> >       .unlocked_ioctl = random_ioctl,
> > +     .compat_ioctl = random_ioctl,
>
>
> ->compat_ioctl() gets called in
>                         error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
> so you do *NOT* get compat_ptr() for those - they have to do it on their
> own.  It's not hard to provide a proper compat_ioctl() instance for that
> one, but this is not it.  What you need in drivers/char/random.c part of
> that one is something like

Looping in some s390 folks.

As you suggested in another reply, I had a look at what other drivers
do the same thing and have only pointer arguments. I created a
patch to move them all over to using a new helper function that
adds the compat_ptr(), and arrived at

 drivers/android/binder.c                    | 2 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c | 2 +-
 drivers/dma-buf/dma-buf.c                   | 4 +---
 drivers/dma-buf/sw_sync.c                   | 2 +-
 drivers/dma-buf/sync_file.c                 | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c    | 2 +-
 drivers/hid/hidraw.c                        | 4 +---
 drivers/iio/industrialio-core.c             | 2 +-
 drivers/infiniband/core/uverbs_main.c       | 4 ++--
 drivers/media/rc/lirc_dev.c                 | 4 +---
 drivers/mfd/cros_ec_dev.c                   | 4 +---
 drivers/misc/vmw_vmci/vmci_host.c           | 2 +-
 drivers/nvdimm/bus.c                        | 4 ++--
 drivers/nvme/host/core.c                    | 6 +++---
 drivers/pci/switch/switchtec.c              | 2 +-
 drivers/platform/x86/wmi.c                  | 2 +-
 drivers/rpmsg/rpmsg_char.c                  | 4 ++--
 drivers/s390/char/sclp_ctl.c                | 8 ++------
 drivers/s390/char/vmcp.c                    | 2 ++----
 drivers/s390/cio/chsc_sch.c                 | 8 ++------
 drivers/sbus/char/display7seg.c             | 2 +-
 drivers/sbus/char/envctrl.c                 | 4 +---
 drivers/scsi/3w-xxxx.c                      | 4 +---
 drivers/scsi/cxlflash/main.c                | 2 +-
 drivers/scsi/esas2r/esas2r_main.c           | 2 +-
 drivers/scsi/pmcraid.c                      | 4 +---
 drivers/staging/android/ion/ion.c           | 4 +---
 drivers/staging/vme/devices/vme_user.c      | 2 +-
 drivers/tee/tee_core.c                      | 2 +-
 drivers/usb/class/cdc-wdm.c                 | 2 +-
 drivers/usb/class/usbtmc.c                  | 4 +---
 drivers/video/fbdev/ps3fb.c                 | 2 +-
 drivers/video/fbdev/sis/sis_main.c          | 4 +---
 drivers/virt/fsl_hypervisor.c               | 2 +-
 fs/btrfs/super.c                            | 2 +-
 fs/ceph/dir.c                               | 2 +-
 fs/ceph/file.c                              | 2 +-
 fs/fuse/dev.c                               | 2 +-
 fs/notify/fanotify/fanotify_user.c          | 2 +-
 fs/userfaultfd.c                            | 2 +-
 net/rfkill/core.c                           | 2 +-
 41 files changed, 48 insertions(+), 76 deletions(-)

Out of those, there are only a few that may get used on s390,
in particular at most infiniband/uverbs, nvme, nvdimm,
btrfs, ceph, fuse, fanotify and userfaultfd.
[Note: there are three s390 drivers in the list, which use
a different method: they check in_compat_syscall() from
a shared handler to decide whether to do compat_ptr().

According to my memory from when I last worked on this,
the compat_ptr() is mainly a safeguard for legacy binaries
that got created with ancient C compilers (or compilers for
something other than C)  and might leave the high bit set
in a pointer, but modern C compilers (gcc-3+) won't ever
do that.

You are probably right about /dev/random, which could be
used in lots of weird code, but I wonder to what degree we
need to worry about it for the rest.

       Arnd

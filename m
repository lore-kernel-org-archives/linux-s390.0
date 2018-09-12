Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-6-arnd@arndb.de>
 <20180909041114.GD19965@ZenIV.linux.org.uk> <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
 <20180912072854.13b4c3b8@mschwideX1>
In-Reply-To: <20180912072854.13b4c3b8@mschwideX1>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Sep 2018 16:02:40 +0200
Message-ID: <CAK8P3a19rCHbtuV65A4rZbUkxHngep44dtitmEM3p99VdWcjdA@mail.gmail.com>
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 12, 2018 at 7:29 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Tue, 11 Sep 2018 22:26:54 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sun, Sep 9, 2018 at 6:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:

> > Out of those, there are only a few that may get used on s390,
> > in particular at most infiniband/uverbs, nvme, nvdimm,
> > btrfs, ceph, fuse, fanotify and userfaultfd.
> > [Note: there are three s390 drivers in the list, which use
> > a different method: they check in_compat_syscall() from
> > a shared handler to decide whether to do compat_ptr().
>
> Using in_compat_syscall() seems to be a good solution, no?

It works fine for you, but wouldn't work on architecture-independent
code, since 32-bit architectures generally don't provide
a compat_ptr() implementation. This could of course
be changed easily, but after this change it, your drivers
work just as well with a couple few lines, and more consistent
with other drivers:

--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -93,12 +93,8 @@ static int sclp_ctl_ioctl_sccb(void __user *user_area)
 static long sclp_ctl_ioctl(struct file *filp, unsigned int cmd,
                           unsigned long arg)
 {
-       void __user *argp;
+       void __user *argp = (void __user *)arg;

-       if (is_compat_task())
-               argp = compat_ptr(arg);
-       else
-               argp = (void __user *) arg;
        switch (cmd) {
        case SCLP_CTL_SCCB:
                return sclp_ctl_ioctl_sccb(argp);
@@ -114,7 +110,7 @@ static const struct file_operations sclp_ctl_fops = {
        .owner = THIS_MODULE,
        .open = nonseekable_open,
        .unlocked_ioctl = sclp_ctl_ioctl,
-       .compat_ioctl = sclp_ctl_ioctl,
+       .compat_ioctl = generic_compat_ioctl_ptrarg,
        .llseek = no_llseek,
 };

This should probably be separate from the change to using compat_ptr()
in all other drivers, and I could easily drop this change if you prefer,
it is meant only as a cosmetic change.

> > According to my memory from when I last worked on this,
> > the compat_ptr() is mainly a safeguard for legacy binaries
> > that got created with ancient C compilers (or compilers for
> > something other than C)  and might leave the high bit set
> > in a pointer, but modern C compilers (gcc-3+) won't ever
> > do that.
>
> And compat_ptr clears the upper 32-bit of the register. If
> the register is loaded to e.g. "lr" or "l" there will be
> junk in the 4 upper bytes.

I don't think we hit that problem anywhere: in the ioctl
argument we pass an 'unsigned long' that has already
been zero-extended by the compat_sys_ioctl() wrapper,
while any other usage would get extended by the compiler
when casting from compat_uptr_t to a 64-bit type.
This would be different if you had a function call with the
wrong prototype, i.e. calling a function declared as taking
an compat_uptr_t, but defining it as taking a void __user*.
(I suppose that is undefined behavior).

Unless I'm missing something, compat_ptr() should
always just clear bit 31. What I'd like to confirm is whether
you have encountered any code that actually passes
a pointer with that bit set by a user application in the
past 15 years. As Al said, it's probably best to just always
apply the compat_ptr() conversion in each case that s390
needs it even for drivers that don't run on s390, but I'd also
like to understand how much it matters in practice.
(A separate question would be how long we expect to need
32 bit compat mode on arch/s390 at all, but for the moment
I assume this is not up for debate at all).

       Arnd

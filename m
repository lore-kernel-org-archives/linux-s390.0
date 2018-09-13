Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-6-arnd@arndb.de>
 <20180909041114.GD19965@ZenIV.linux.org.uk> <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
 <20180912072854.13b4c3b8@mschwideX1> <CAK8P3a19rCHbtuV65A4rZbUkxHngep44dtitmEM3p99VdWcjdA@mail.gmail.com>
 <20180913084242.217e6b77@mschwideX1>
In-Reply-To: <20180913084242.217e6b77@mschwideX1>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 13 Sep 2018 10:13:31 +0200
Message-ID: <CAK8P3a3jacWumTAw=tbj1LcPgih+s1ZNa7Hyk-rxVzUhP3_UTw@mail.gmail.com>
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 13, 2018 at 8:42 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Wed, 12 Sep 2018 16:02:40 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > On Wed, Sep 12, 2018 at 7:29 AM Martin Schwidefsky
> > <schwidefsky@de.ibm.com> wrote:
> > > On Tue, 11 Sep 2018 22:26:54 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> >
> > This should probably be separate from the change to using compat_ptr()
> > in all other drivers, and I could easily drop this change if you prefer,
> > it is meant only as a cosmetic change.
>
> So generic_compat_ioctl_ptrarg will to the compat_ptr thing on the
> "unsigned int cmd" argument? Should work just fine.

It will do it on the "unsigned long arg" argument, I assume that's
what you meant. The "cmd" argument is correctly zero-extended
by the COMPAT_SYSCALL_DEFINE() wrapper on architectures
that need that (IIRC s390 is in that category).

> > I don't think we hit that problem anywhere: in the ioctl
> > argument we pass an 'unsigned long' that has already
> > been zero-extended by the compat_sys_ioctl() wrapper,
> > while any other usage would get extended by the compiler
> > when casting from compat_uptr_t to a 64-bit type.
> > This would be different if you had a function call with the
> > wrong prototype, i.e. calling a function declared as taking
> > an compat_uptr_t, but defining it as taking a void __user*.
> > (I suppose that is undefined behavior).
>
> That is true. For the ioctls we have a compat "unsigned int"
> or "unsigned long" and the system call wrapper must have cleared
> the upper half already. There are a few places where we copy
> a data structure from user space, then read a 32-bit pointer
> from the structure. These get the compat_ptr treatment as well.
> All of those structure definitions should use compat_uptr_t
> though, the compiler has to do the zero extension at the time
> the 32-bit value is cast to a pointer.

There is actually one more case: A number of the newer
interfaces that have ioctl structures with indirect pointers
encoded as __u64, so the layout becomes
and we don't normally need a conversion handler.

An example of this would be the sys_rseq() system call
that passes a relatively complex structure in place
of a pointer:

struct rseq {
        ...
        union {
                __u64 ptr64;
#ifdef __LP64__
                __u64 ptr;
#else
                struct {
#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) ||
defined(__BIG_ENDIAN)
                        __u32 padding;          /* Initialized to zero. */
                        __u32 ptr32;
#else /* LITTLE */
                        __u32 ptr32;
                        __u32 padding;          /* Initialized to zero. */
#endif /* ENDIAN */
                } ptr;
#endif
        } rseq_cs;
       __u32 flags;
};

We require user space to initialize the __padding field to
zero and then use the ptr64 field in the kernel as a pointer:

        u64 ptr;
        u32 __user *usig;
        copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr));
        urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;

but we don't ever clear bit 31 here. A similar pattern is used
in many device drivers (I could not find any that would apply to
s390 though). In theory, 32 bit user space might pass a pointer
with the high bit set in the ptr32 field, and that gets misinterpreted
by the kernel (resulting in -EFAULT).

It would be interesting to know whether there could be user space
that gets compiled from portable source code with a normal
C compiler but produces that high bit set, as opposed to someone
intentially settting the bit just to trigger the bug.

       Arnd

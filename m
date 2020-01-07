Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200102145552.1853992-1-arnd@arndb.de> <20200102145552.1853992-3-arnd@arndb.de>
 <87woa410nx.fsf@mpe.ellerman.id.au> <CAK8P3a17GshP1KmCpvCkWGDGJLC_JrGUFQZTLbfe5+sSwTjyxw@mail.gmail.com>
 <202001070820.0078K3ZN3264752@mail.zytor.com>
In-Reply-To: <202001070820.0078K3ZN3264752@mail.zytor.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Jan 2020 09:40:05 +0100
Message-ID: <CAK8P3a21u6FacA-EfGoaVMmd-iXux=wACG5JTpoUZ8cwvNjuOg@mail.gmail.com>
Subject: Re: [PATCH v3 02/22] compat: provide compat_ptr() on all architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Robert Richter <rric@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev@zytor.com

On Tue, Jan 7, 2020 at 9:20 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> <linuxppc-dev@lists.ozlabs.org>,oprofile-list@lists.sf.net,linux-s390 <linux-s390@vger.kernel.org>,sparclinux <sparclinux@vger.kernel.org>
> From: hpa@zytor.com
> Message-ID: <41625F06-D755-4C82-86DF-A9415FEEE13D@zytor.com>
>
> On January 7, 2020 12:08:31 AM PST, Arnd Bergmann <arnd@arndb.de> wrote:
> >On Tue, Jan 7, 2020 at 3:05 AM Michael Ellerman <mpe@ellerman.id.au>
> >wrote:
> >> Arnd Bergmann <arnd@arndb.de> writes:
> >> > +
> >> > +static inline compat_uptr_t ptr_to_compat(void __user *uptr)
> >> > +{
> >> > +     return (u32)(unsigned long)uptr;
> >> > +}
> >>
> >> Is there a reason we cast to u32 directly instead of using
> >compat_uptr_t?
> >
> >Probably Al found this to be more explicit at the time when he
> >introduced
> >it on all the architectures in 2005. I just moved it here and kept the
> >definition.
> >
> >       Arnd
>
> Did compat_uptr_t exist back then?

Yes, compat_uptr_t (and the earlier compat_ptr_t) goes back
to at least 2003 with the introduction of compat_ptr().

These are some related commits from bitkeeper:

commit 29d04cca305a93cfa90afe1c6440ce5421837213
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Sun Mar 23 04:59:16 2003 -0800

    [PATCH] compat_uptr_t and compat_ptr

    This creates compat_uptr_t (to represent a user mode pointer passed to
    the kernel other than as a syscall parameter) and compat_ptr() to
    convert it to a kernel pointer.

    This fixes a couple of bugs in s390x (where the conversion of pointers
    actually does something).

diff --git a/include/asm-s390x/compat.h b/include/asm-s390x/compat.h
index 55e23c9b36fe..d1e948ae4bff 100644
--- a/include/asm-s390x/compat.h
+++ b/include/asm-s390x/compat.h
@@ -101,4 +101,17 @@ typedef u32                compat_sigset_word;
 #define COMPAT_OFF_T_MAX       0x7fffffff
 #define COMPAT_LOFF_T_MAX      0x7fffffffffffffffL

+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef        u32             compat_uptr_t;
+
+static inline void *compat_ptr(compat_ptr_t uptr)
+{
+       return (void *)(uptr & 0x7fffffffUL);
+}
+
 #endif /* _ASM_S390X_COMPAT_H */


commit 9d814250b08868cb39cc5a4f43f5cbf5e517f5f4
Author: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Date:   Tue Feb 1 21:21:39 2005 -0800

    [PATCH] sparc64 compat annotations

    same story as for amd64 - ptr_to_compat() + normal __user annotations

    Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/include/asm-sparc64/compat.h b/include/asm-sparc64/compat.h
index 874b136ded90..e26d7d85c55a 100644
--- a/include/asm-sparc64/compat.h
+++ b/include/asm-sparc64/compat.h
@@ -121,6 +121,11 @@ static inline void __user *compat_ptr(compat_uptr_t uptr)
        return (void __user *)(unsigned long)uptr;
 }

+static inline compat_uptr_t ptr_to_compat(void __user *uptr)
+{
+       return (u32)(unsigned long)uptr;
+}
+
 static __inline__ void __user *compat_alloc_user_space(long len)
 {
        struct pt_regs *regs = current_thread_info()->kregs;

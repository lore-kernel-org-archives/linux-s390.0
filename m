Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com> <20200615141239.GA12951@lst.de>
In-Reply-To: <20200615141239.GA12951@lst.de>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 15 Jun 2020 10:48:26 -0400
Message-ID: <CAMzpN2heSzZzg16ws3yQkd7YZwmPPx_4RFCpb9JYfFWJ9gfPhA@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 15, 2020 at 10:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 15, 2020 at 03:31:35PM +0200, Arnd Bergmann wrote:
> > >  #ifdef CONFIG_COMPAT
> > > -       if (unlikely(argv.is_compat)) {
> > > +       if (in_compat_syscall()) {
> > > +               const compat_uptr_t __user *compat_argv =
> > > +                       compat_ptr((unsigned long)argv);
> > >                 compat_uptr_t compat;
> > >
> > > -               if (get_user(compat, argv.ptr.compat + nr))
> > > +               if (get_user(compat, compat_argv + nr))
> > >                         return ERR_PTR(-EFAULT);
> > >
> > >                 return compat_ptr(compat);
> > >         }
> > >  #endif
> >
> > I would expect that the "#ifdef CONFIG_COMPAT" can be removed
> > now, since compat_ptr() and in_compat_syscall() are now defined
> > unconditionally. I have not tried that though.
>
> True, I'll give it a spin.
>
> > > +/*
> > > + * x32 syscalls are listed in the same table as x86_64 ones, so we need to
> > > + * define compat syscalls that are exactly the same as the native version for
> > > + * the syscall table machinery to work.  Sigh..
> > > + */
> > > +#ifdef CONFIG_X86_X32
> > >  COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
> > > -       const compat_uptr_t __user *, argv,
> > > -       const compat_uptr_t __user *, envp)
> > > +                      const char __user *const __user *, argv,
> > > +                      const char __user *const __user *, envp)
> > >  {
> > > -       return do_compat_execve(AT_FDCWD, getname(filename), argv, envp, 0);
> > > +       return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0, NULL);
> > >  }
> >
> > Maybe move it to arch/x86/kernel/process_64.c or arch/x86/entry/syscall_x32.c
> > to keep it out of the common code if this is needed.
>
> I'd rather keep it in common code as that allows all the low-level
> exec stuff to be marked static, and avoid us growing new pointless
> compat variants through copy and paste.
> smart compiler to d
>
> > I don't really understand
> > the comment, why can't this just use this?
>
> That errors out with:
>
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> `__x32_sys_execve'
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> `__x32_sys_execveat'
> make: *** [Makefile:1139: vmlinux] Error 1

I think I have a fix for this, by modifying the syscall wrappers to
add an alias for the __x32 variant to the native __x64_sys_foo().
I'll get back to you with a patch.

--
Brian Gerst

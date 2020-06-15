Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
In-Reply-To: <20200615130032.931285-3-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Jun 2020 15:31:35 +0200
Message-ID: <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 15, 2020 at 3:00 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The only differenence betweeen the compat exec* syscalls and their
> native versions is that compat_ptr sign extension, and the fact that
> the pointer arithmetics for the two dimensional arrays needs to use
> the compat pointer size.  Instead of the compat wrappers and the
> struct user_arg_ptr machinery just use in_compat_syscall() to do the
> right thing for the compat case deep inside get_user_arg_ptr().
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice!

I have an older patch doing the same for sys_mount() somewhere,
but never got around to send that. One day we should see if we
can just do this for all of them.

> -
> -static const char __user *get_user_arg_ptr(struct user_arg_ptr argv, int nr)
> +static const char __user *
> +get_user_arg_ptr(const char __user *const __user *argv, int nr)
>  {
>         const char __user *native;
>
>  #ifdef CONFIG_COMPAT
> -       if (unlikely(argv.is_compat)) {
> +       if (in_compat_syscall()) {
> +               const compat_uptr_t __user *compat_argv =
> +                       compat_ptr((unsigned long)argv);
>                 compat_uptr_t compat;
>
> -               if (get_user(compat, argv.ptr.compat + nr))
> +               if (get_user(compat, compat_argv + nr))
>                         return ERR_PTR(-EFAULT);
>
>                 return compat_ptr(compat);
>         }
>  #endif

I would expect that the "#ifdef CONFIG_COMPAT" can be removed
now, since compat_ptr() and in_compat_syscall() are now defined
unconditionally. I have not tried that though.

> +/*
> + * x32 syscalls are listed in the same table as x86_64 ones, so we need to
> + * define compat syscalls that are exactly the same as the native version for
> + * the syscall table machinery to work.  Sigh..
> + */
> +#ifdef CONFIG_X86_X32
>  COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
> -       const compat_uptr_t __user *, argv,
> -       const compat_uptr_t __user *, envp)
> +                      const char __user *const __user *, argv,
> +                      const char __user *const __user *, envp)
>  {
> -       return do_compat_execve(AT_FDCWD, getname(filename), argv, envp, 0);
> +       return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0, NULL);
>  }

Maybe move it to arch/x86/kernel/process_64.c or arch/x86/entry/syscall_x32.c
to keep it out of the common code if this is needed. I don't really understand
the comment, why can't this just use this?

--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -379,7 +379,7 @@
 517    x32     recvfrom                compat_sys_recvfrom
 518    x32     sendmsg                 compat_sys_sendmsg
 519    x32     recvmsg                 compat_sys_recvmsg
-520    x32     execve                  compat_sys_execve
+520    x32     execve                  sys_execve
 521    x32     ptrace                  compat_sys_ptrace
 522    x32     rt_sigpending           compat_sys_rt_sigpending
 523    x32     rt_sigtimedwait         compat_sys_rt_sigtimedwait_time64
@@ -404,7 +404,7 @@
 542    x32     getsockopt              compat_sys_getsockopt
 543    x32     io_setup                compat_sys_io_setup
 544    x32     io_submit               compat_sys_io_submit
-545    x32     execveat                compat_sys_execveat
+545    x32     execveat                sys_execveat
 546    x32     preadv2                 compat_sys_preadv64v2
 547    x32     pwritev2                compat_sys_pwritev64v2
 548    x32     process_madvise         compat_sys_process_madvise

       Arnd

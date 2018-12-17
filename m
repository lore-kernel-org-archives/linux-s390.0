From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] seccomp, s390: fix build for syscall type change
Date: Mon, 17 Dec 2018 09:54:47 -0800
Message-ID: <CAGXu5jJqMtpzO2xCKJE3s0qthRFmGD6Q4_puXk27WaGxrdhDMQ@mail.gmail.com>
References: <20181213201030.4072-1-tycho@tycho.ws> <CAGXu5jLY16CjNZZ0QvkyaKep-qD8kEVZEnTQ7JqfozqAm=so_Q@mail.gmail.com>
 <20181217124154.GA3560@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181217124154.GA3560@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, James Morris <jmorris@namei.org>
Cc: Tycho Andersen <tycho@tycho.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>, prudo@linux.vnet.ibm.com, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Next <linux-next@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 17, 2018 at 4:42 AM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Thu, Dec 13, 2018 at 04:50:06PM -0800, Kees Cook wrote:
> > On Thu, Dec 13, 2018 at 12:10 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > > A recent patch landed in the security tree [1] that changed the type of the
> > > seccomp syscall. Unfortunately, I didn't quite get every instance of the
> > > forward declarations, and thus there is a build failure. Here's the last
> > > one that I could find, for s390. It should go through the security tree,
> > > although hopefully some s390 people can check and make sure it looks
> > > reasonable?
> > >
> > > The only oddity is the trailing semicolon; some lines around this patch
> > > have it, and some lines don't. I've left this one as-is.
> > >
> > > [1]: https://lore.kernel.org/lkml/20181212231630.GA31584@beast/T/#u
> > >
> > > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> >
> > Thanks! Added to my -next tree.
> >
> > -Kees
>
> Hi Kees,
>
> did you forget to push your tree? At least today's linux-next kernel
> fails to compile on s390 because of this missing patch.

I sent a pull request to James for this. James, can you pick this up please?

-Kees

>
> > >  arch/s390/kernel/compat_wrapper.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
> > > index 2ce28bf0c5ec..48c4ce668244 100644
> > > --- a/arch/s390/kernel/compat_wrapper.c
> > > +++ b/arch/s390/kernel/compat_wrapper.c
> > > @@ -164,7 +164,7 @@ COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, fla
> > >  COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
> > >  COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
> > >  COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
> > > -COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
> > > +COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, void __user *, uargs)
> > >  COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
> > >  COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
> > >  COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
>


-- 
Kees Cook

Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
 <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com>
 <CABnRqDfQ5Qfa2ybut0qXcKuYnsMcG7+9gqjL-e7nZF1bkvhPRw@mail.gmail.com> <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com>
In-Reply-To: <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 15 Jan 2021 16:07:46 -0800
Message-ID: <CALCETrUtyVaGSE9fcFAkhrGCpkyYcYnZb6tj8227o2EH5hgOfg@mail.gmail.com>
Subject: Re: [PATCH] Adds a new ioctl32 syscall for backwards compatibility layers
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Ryan Houdek <sonicadvance1@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <christian.brauner@ubuntu.com>, Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Sargun Dhillon <sargun@sargun.me>, Miklos Szeredi <mszeredi@redhat.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Amanieu d'Antras <amanieu@gmail.com>, Willem de Bruijn <willemb@google.com>, YueHaibing <yuehaibing@huawei.com>, Xiaoming Ni <nixiaoming@huawei.com>, Heiko Carstens <hca@linux.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Joe Perches <joe@perches.com>, Jan Kara <jack@suse.cz>, David Rientjes <rientjes@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "David S. Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Fri, Jan 15, 2021 at 1:03 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jan 15, 2021 at 3:06 AM Ryan Houdek <sonicadvance1@gmail.com> wrote:
> > On Wed, Jan 6, 2021 at 12:49 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >> On Wed, Jan 6, 2021 at 7:48 AM <sonicadvance1@gmail.com> wrote:
> >> > From: Ryan Houdek <Sonicadvance1@gmail.com>
> >> ...
> >>
> >> For x86, this has another complication, as some ioctls also need to
> >> check whether they are in an ia32 task (with packed u64 and 32-bit
> >> __kernel_old_time_t) or an x32 task (with aligned u64 and 64-bit
> >> __kernel_old_time_t). If the new syscall gets wired up on x86 as well,
> >> you'd need to decide which of the two behaviors you want.
> >
> >
> > I can have a follow-up patch that makes this do ni-syscall on x86_64 since
> > we can go through the int 0x80 handler, or x32 handler path and choose
> > whichever one there.
>
> I'd say for consistency
>

We need to make it crystal clear on x86 what this ioctl does.  We have
a silly selection of options:

 - ioctl32() via SYSCALL, x32 bit clear -- presumably does an i386 ioctl?
 - ioctl32() via SYSCALL, x32 bit set -- this needs to do something
clearly documented.
 - ioctl32() via int80 -- presumably you're not wiring this up

In any case, the compat alloc thing should just go away.  It's a hack
and serves no real purpose.

Finally, I'm not convinced that this patch works correctly.  We have
in_compat_syscall(), and code that uses it may well be reachable from
ioctl.  I personally would like to see in_compat_syscall() go away,
but some other people (Hi, Christoph!) disagree, and usage seems to be
increasing, not decreasing.

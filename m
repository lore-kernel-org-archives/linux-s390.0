Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34704 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfJKJpc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Oct 2019 05:45:32 -0400
Date: Fri, 11 Oct 2019 11:45:28 +0200
From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
Message-ID: <20191011094527.ftevtkeitjqafhdd@wittgenstein>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190924064420.6353-1-christian.brauner@ubuntu.com>
 <201910101450.0B13B7F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201910101450.0B13B7F@keescook>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, luto@kernel.org, oleg@redhat.com, tglx@linutronix.de, wad@chromium.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>

On Thu, Oct 10, 2019 at 02:53:24PM -0700, Kees Cook wrote:
> On Tue, Sep 24, 2019 at 08:44:20AM +0200, Christian Brauner wrote:
> > Afaict, the struct seccomp_data argument to secure_computing() is unused
> > by all current callers. So let's remove it.
> > The argument was added in [1]. It was added because having the arch
> > supply the syscall arguments used to be faster than having it done by
> > secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> > though.
> 
> Yes; thanks for cleaning this up!
> 
> > diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> > index ad71132374f0..ed80bdfbf5fe 100644
> > --- a/arch/s390/kernel/ptrace.c
> > +++ b/arch/s390/kernel/ptrace.c
> > @@ -439,7 +439,7 @@ static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
> >  long arch_ptrace(struct task_struct *child, long request,
> >  		 unsigned long addr, unsigned long data)
> >  {
> > -	ptrace_area parea; 
> > +	ptrace_area parea;
> >  	int copied, ret;
> >  
> >  	switch (request) {
> 
> If this were whitespace cleanup in kernel/seccomp.c, I'd take it without
> flinching. As this is only tangentially related and in an arch
> directory, I've dropped this hunk out of a cowardly fear of causing
> (a likely very unlikely) merge conflict.
> 
> I'd rather we globally clean up trailing whitespace at the end of -rc1
> and ask Linus to run some crazy script. :)

Oh that was on accident probably. It usally happens because I have vim
do whitespace fixups automatically and then they end up slipping in...
Sorry. Thanks for removing it! :)

Christian

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285B1877;
	Thu, 16 May 2024 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819046; cv=none; b=V/TIrWS3SwCcMSfMryZJ4Q64BlJjUobYFyQGbteHtMPbaeKF/DB7JC4tQp3pwcP4hrHK9/bKsHTCYimQ5lkEOaAkhnmJyyDXhsr5K/kUN4coeb0Uob0O7ZcSKlFKOm/BaklkchzUj70t0hqUZMON349WufcAHNC/WcSMxtK6N08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819046; c=relaxed/simple;
	bh=2mTyV3yHsXnpIz+Hf8dHwdpSsS9bL76Nasiv3NlJOGU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l1QI9khiLElR7VFjzE5or0yCKtQTm1UPHdHFUtG8qZM/wRHYZZaRZmRraCJx+an6l6BO1PV8A6GVEiqLQm20tEPYY995CkuIwhIYYNEczIM7+014gTqnGq+xOz5amnD7OukLZYAwkx/JrjT1pmJKQRzhBrH86B3fx+r4YzJTjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyhYvQrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyhYvQrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B95C116B1;
	Thu, 16 May 2024 00:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715819045;
	bh=2mTyV3yHsXnpIz+Hf8dHwdpSsS9bL76Nasiv3NlJOGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eyhYvQrhNljUOqI7QNUxGGddgXbxg9y2eAf3SrTd+rZn8BqfPQoiuSPf3cJR34dYa
	 zSvce/f+OH48w4hBDOW3RJtYyeJg/nH46JmYm2E1PnSRHy3kF0o/T3lOVha7lvTJZL
	 uwq0IQjHw/2eZmSVpTKVdnQCl4UR4thsmYHeiq/1GVjfoMBQqd3nuLCklTZ9PM9S84
	 D8LoRdc+cO+u2c30aTUmBWeafhneREBkpHfzgJUF++utFsobb1GHqqrDGDR8WHyFxG
	 uiknNVRd2iWPJ5aH2ELN/FibJPqRnrW3ba5PPk+Mf7re8cp/Bm8sj9dFC7CoxlOg4B
	 VDJeBnkbZygiA==
Date: Thu, 16 May 2024 09:23:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Guo Ren <guoren@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark
 Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3] kprobe/ftrace: bail out if ftrace was killed
Message-Id: <20240516092355.4eaab560b7f4e22953f73cfc@kernel.org>
In-Reply-To: <87r0e2pvmn.fsf@oracle.com>
References: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
	<CAJF2gTT8a4PBU3ekZFNTi6EuETT9hhKfhXrPgGGpn92rQMNSvg@mail.gmail.com>
	<20240502110348.016f190e0b0565b7e9ecdb48@kernel.org>
	<87r0e2pvmn.fsf@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 May 2024 15:18:08 -0700
Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> > On Thu, 2 May 2024 01:35:16 +0800
> > Guo Ren <guoren@kernel.org> wrote:
> >
> >> On Thu, May 2, 2024 at 12:30 AM Stephen Brennan
> >> <stephen.s.brennan@oracle.com> wrote:
> >> >
> >> > If an error happens in ftrace, ftrace_kill() will prevent disarming
> >> > kprobes. Eventually, the ftrace_ops associated with the kprobes will be
> >> > freed, yet the kprobes will still be active, and when triggered, they
> >> > will use the freed memory, likely resulting in a page fault and panic.
> >> >
> >> > This behavior can be reproduced quite easily, by creating a kprobe and
> >> > then triggering a ftrace_kill(). For simplicity, we can simulate an
> >> > ftrace error with a kernel module like [1]:
> >> >
> >> > [1]: https://github.com/brenns10/kernel_stuff/tree/master/ftrace_killer
> >> >
> >> >   sudo perf probe --add commit_creds
> >> >   sudo perf trace -e probe:commit_creds
> >> >   # In another terminal
> >> >   make
> >> >   sudo insmod ftrace_killer.ko  # calls ftrace_kill(), simulating bug
> >> >   # Back to perf terminal
> >> >   # ctrl-c
> >> >   sudo perf probe --del commit_creds
> >> >
> >> > After a short period, a page fault and panic would occur as the kprobe
> >> > continues to execute and uses the freed ftrace_ops. While ftrace_kill()
> >> > is supposed to be used only in extreme circumstances, it is invoked in
> >> > FTRACE_WARN_ON() and so there are many places where an unexpected bug
> >> > could be triggered, yet the system may continue operating, possibly
> >> > without the administrator noticing. If ftrace_kill() does not panic the
> >> > system, then we should do everything we can to continue operating,
> >> > rather than leave a ticking time bomb.
> >> >
> >> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> >> > ---
> >> > Changes in v3:
> >> >   Don't expose ftrace_is_dead(). Create a "kprobe_ftrace_disabled"
> >> >   variable and check it directly in the kprobe handlers.
> >> > Link to v1/v2 discussion:
> >> >   https://lore.kernel.org/all/20240426225834.993353-1-stephen.s.brennan@oracle.com/
> >> >
> >> >  arch/csky/kernel/probes/ftrace.c     | 3 +++
> >> >  arch/loongarch/kernel/ftrace_dyn.c   | 3 +++
> >> >  arch/parisc/kernel/ftrace.c          | 3 +++
> >> >  arch/powerpc/kernel/kprobes-ftrace.c | 3 +++
> >> >  arch/riscv/kernel/probes/ftrace.c    | 3 +++
> >> >  arch/s390/kernel/ftrace.c            | 3 +++
> >> >  arch/x86/kernel/kprobes/ftrace.c     | 3 +++
> >> >  include/linux/kprobes.h              | 7 +++++++
> >> >  kernel/kprobes.c                     | 6 ++++++
> >> >  kernel/trace/ftrace.c                | 1 +
> >> >  10 files changed, 35 insertions(+)
> >> >
> >> > diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> >> > index 834cffcfbce3..7ba4b98076de 100644
> >> > --- a/arch/csky/kernel/probes/ftrace.c
> >> > +++ b/arch/csky/kernel/probes/ftrace.c
> >> > @@ -12,6 +12,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >> >         struct kprobe_ctlblk *kcb;
> >> >         struct pt_regs *regs;
> >> >
> >> > +       if (unlikely(kprobe_ftrace_disabled))
> >> > +               return;
> >> > +
> >> For csky part.
> >> Acked-by: Guo Ren <guoren@kernel.org>
> >
> > Thanks Stephen, Guo and Steve!
> >
> > Let me pick this to probes/for-next!
> 
> Thank you Masami!
> 
> I did want to check, is this the correct git tree to be watching?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/log/?h=probes/for-next
> 
> ( I'm not trying to pressure on timing, as I know the merge window is
>   hectic. Just making sure I'm watching the correct place! )

Sorry, I forgot to push it from my local tree. Now it should be there.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

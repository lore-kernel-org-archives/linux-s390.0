Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEA4266AE
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686741; cv=none; b=YB8xoqBrBR2vKE5FsJk/T0OBS4TJKMHTjrL2J3W3Ev3nqi0XtLtLowtjYkJvG3VC6v3zZftZE8cDSWE9Z2OaZ4kKuzSiWYAPy0p9F/+44XfV7WrrFjAsWf1gACupSj1EwOZpvPkmqR91/55uCKQG4WvW8EmKsaf2V73oSulZpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686741; c=relaxed/simple;
	bh=ys9eY4ViqB4VHoA/lZua2Zw3TzyK+DqDveJx1YabTEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWiBmRAny+3s2qcaTyj1SgE+d++uLoRKGGGr5CEMttM4ddyzu4KnbHW6UNbKVCyjw3eQyq8KKvQMixm9bH6SI83d2qiWLjsm/2Iugd6qb3RwUxhp/QQA7fBSWV2T2+JtNLp81OFPbdaZX3sBUk28n4EpvfjLn+HJKLOqkh8TL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE9AB764C1;
	Fri, 10 Jul 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Fri, 10 Jul 2026 14:32:13 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type bool
Message-ID: <alDmTcgzMlKiio9H@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
 <alDaOw8t-e3rxIPm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alDaOw8t-e3rxIPm@redhat.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -2.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrpyf51xp5ujasy9bitsaikab)]
X-Rspamd-Queue-Id: AE9AB764C1
X-Rspamd-Action: no action

On Fri, Jul 10, 2026 at 01:40:43PM +0200, Oleg Nesterov wrote:
> On 07/10, Michal Suchánek wrote:
> >
> > On Wed, Jul 08, 2026 at 10:34:38PM +0200, Thomas Gleixner wrote:
> > >
> > >   1) The set in stone rule is that if the entry code returns -1L as the
> > >      syscall number then the architecture code has to skip the syscall
> > >      invocation _and_ is not supposed to change the return value.
> >
> > Which stone?
> >
> > Pics or it did not happen.
> >
> > >
> > >   2) There is no guarantee and never has been that any of the involved
> > >      mechanisms (ptrace, seccomp, tracing) will change the return value
> > >      when it sets the syscall number to -1L.
> >
> > For ptrace to correctly emulate a syscall it needs to set the syscall nr
> > to an invalid value on entry, and the desired result if the syscall on
> > exit AFAICT.
> 
> I can only say that ptrace users do want to skip the syscall and set the
> return value on entry.
> 
> See
> 	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
> 	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/
> 
> The changelog explains that currently this doesn't work because
> among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
> broken in this regard.

Or it could be documented that setting the return value has to be done
in the exit trace, and that would than work on any architecture AFAICT.

With ppc and s390 using the same register for the syscall number and
syscall return value it's very much impossible to poke the return value
on entry into a register using the generic register access function. As
of now there is no place to store the value ot of the return value
outside of the registers, either.

And the current PTRACE_SET_SYSCALL_INFO indeed sets the syscall nr and
arguments on entry and the syscall return value on exit, that
disctincion is implemented.

Not sure how the patchset you point out is relevant, it only adds
changes in the exit case.

Thanks

Michal

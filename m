Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B140BCB0
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681269; cv=none; b=mNFfXFikyeGbVQwuPhIKj24vCfGzEcysYbnLUll8KqpU/5Z/trvYXHHGcsWRjeQN2OZsJHT0cOhR9LxPqy/27PPu63U3wVoCtjMhrMlkC4dkQUb9pfHhf+WaveC499sp6QQ/V80apwnBJ1q/qIEJfFeWpH74G1NE87OOePmwJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681269; c=relaxed/simple;
	bh=N/iKtwVV/SDgLjSMeMB99yFSgCAkegP3YEkiL+SWjvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq0OLWK+ICERqogLWrcGwX4ZWyH1aInZyC7lvPSNwpDUuzO9fwYdprSIX8qy7ybq3cysfr3ajK+2MNIrDUzw+AFX+x7uui22gqpj49kO8vWf9zZqoprjkzjh+kSVdOHh9TyTONGyCmxJMqpLb4T42kREcsSJGZgSNdMxNQWaeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O6RrK+c+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZOMjVeZg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O6RrK+c+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZOMjVeZg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O6RrK+c+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZOMjVeZg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O6RrK+c+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZOMjVeZg"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8391876715;
	Fri, 10 Jul 2026 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783681263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYsS2vBan7uQzdgEWEddgopbLcVe02BSX1ZYLs9ZgnU=;
	b=O6RrK+c+yEUCBz7JS8C/n3uvL2/ffj5axWsd+OY7/CEczrcwTTxEsLs/dGrk0viRn5MzUe
	GtnTNGDpvD2O3TvWKyCZYWhXnzThvycDzjVezp2doDQRDuZWsQfOU+4cVOIOZhNJKRbxfw
	fx3PQHPrPfFlb6kdRd1H2jQ1bqYybjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783681263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYsS2vBan7uQzdgEWEddgopbLcVe02BSX1ZYLs9ZgnU=;
	b=ZOMjVeZgmcYQW+gxCYgmXBRA3lul7pjSYwltV7OQTpYYU1+O+3dJHoeOdjPx+vWowECub2
	kiZTkZ3pFRD1rDAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O6RrK+c+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZOMjVeZg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783681263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYsS2vBan7uQzdgEWEddgopbLcVe02BSX1ZYLs9ZgnU=;
	b=O6RrK+c+yEUCBz7JS8C/n3uvL2/ffj5axWsd+OY7/CEczrcwTTxEsLs/dGrk0viRn5MzUe
	GtnTNGDpvD2O3TvWKyCZYWhXnzThvycDzjVezp2doDQRDuZWsQfOU+4cVOIOZhNJKRbxfw
	fx3PQHPrPfFlb6kdRd1H2jQ1bqYybjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783681263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYsS2vBan7uQzdgEWEddgopbLcVe02BSX1ZYLs9ZgnU=;
	b=ZOMjVeZgmcYQW+gxCYgmXBRA3lul7pjSYwltV7OQTpYYU1+O+3dJHoeOdjPx+vWowECub2
	kiZTkZ3pFRD1rDAw==
Date: Fri, 10 Jul 2026 13:01:02 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
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
Message-ID: <alDQ7isUKJFl8Va4@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87se5tqkyp.ffs@fw13>
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.15 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.96)[0.988];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,arm.com,huawei.com,redhat.com,linaro.org,armlinux.org.uk,linux-m68k.org,alpha.franken.de,gmx.de,users.sourceforge.jp,nod.at,zankel.net,lists.linux-m68k.org,arndb.de,monstr.eu,davemloft.net,gaisler.com,lwn.net];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLs1yuyu6ywojxyk8y3ncu5g39)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 8391876715
X-Spam-Score: 15.15
X-Spam: Yes

On Wed, Jul 08, 2026 at 10:34:38PM +0200, Thomas Gleixner wrote:
> On Wed, Jul 08 2026 at 17:52, Michal Suchánek wrote:
> > On Tue, Jul 07, 2026 at 09:06:48PM +0200, Thomas Gleixner wrote:
> >> In preparation of converting the return value of
> >> syscall_enter_from_user_mode[_work]() bool, rework trace_syscall_enter() to
> >> 
> >>  - update the syscall number via a pointer argument
> >> 
> >>  - Return True if the syscall number is != -1, False otherwise
> >
> > This does not achieve the goal of the initial RFC: To detangle the
> > return value of syscall_enter_from_user_mode from the syscall number.
> 
> As I explained to you before: Your RFC broke the implicit assumption of
> tracing, which is way worse than having this oddity.

It would be so nice to make the assumptions about the entry API explicit
so that platforms can agree on the semantics.

> 
> > This still conflates them, making it impossible to tell if the syscall
> > was rejected or syscall number was -1 to start with. Now also obfuscated
> > by performing the check deeper inside the common code.
> 
> That's where it belongs. It's a problem to solve within the given
> semantics of trace_syscall_enter() and not a problem to be worked around
> at the call sites if you want to have consolidated semantics.
> 
> >> The only difference is that this also returns False, when the syscall
> >> number was already -1 to begin with, but there is not much which can be
> >> done about that. As the architecture has to preset the return value to
> >> -ENOSYS anyway, that results in the correct return value for such an
> >> invalid syscall.
> >
> > That's not possible to do for architectures where the syscall number and
> > the syscall return value are in the same register.
> >
> > You suggested that it is possible to not write the return value into an
> > actual register but use an additional field for that, and have the exit
> > code write the register.
> >
> > However, that's not what is documented, nor what is currently done.
> 
> Just because S390 screwed up their ABI and then on top of that failed to
> do what _every_ other architecture in the kernel does, i.e. having a
> result storage which is preset to -ENOSYS does not mean that S390 did
> the right thing just because it was not documented. Kernel documentation
> is known to be incomplete and I fixed it up in the last patch as you
> might have noticed.
> 
> Just for the record. Presetting the return value to -ENOSYS has been
> practice for three decades. I couldn't be bothered to do a full search

No, it isn't practice anymore for decades.

The moment ppc and s390 support was merged they do not preset the
syscall return value to -ENOSYS, for obvious reason.

That is how the undocumented, implicit, 'as implemented' API goes. It
silently changes as the implementation evolves.

> in the history trees to figure out the exact point, but as of 2.1.9,
> which was released in Nov. 1996, this is definitely the case.
> 
> So don't tell me that because S390 missed the train when it was
> added to mainline in 2007 (, i.e. 11 years _after_ this "undocumented" rule was
> established that now 20 years later the world has to revolve around S390
> and your personal idea of "clear and intelligible":

Don't tell me you missed the train on what the actual API of syscall
entry is.

> 
> > While this is an improvement in some respects the goal to have clear and
> > intelligible API around the generic entry is not acheived.
> 
> I'm honestly not sure whether I should laugh or cry.
> 
> You are completely missing the point:
> 
>   1) The set in stone rule is that if the entry code returns -1L as the
>      syscall number then the architecture code has to skip the syscall
>      invocation _and_ is not supposed to change the return value.

Which stone?

Pics or it did not happen.

> 
>   2) There is no guarantee and never has been that any of the involved
>      mechanisms (ptrace, seccomp, tracing) will change the return value
>      when it sets the syscall number to -1L.

For ptrace to correctly emulate a syscall it needs to set the syscall nr
to an invalid value on entry, and the desired result if the syscall on
exit AFAICT.

Relying on platfrom quirk to assume that the return valu is set to
ENOSYS is insufficient.

I doubt many platfroms have an ABI that dictates that the register that
has the syscal nr is set to -1 on exit from syscal. Then even if the
-ENOSYS is preset by the kernel the syscall nr needs to be poked back on
exit for the emulation to be correct.

> 
>      Quite the contrary there has been a long time (30 years at least)
>      expectation that the return value has been preset to -ENOSYS.

That is your opinion, not the fact. Multiple platforms do not work like
that.

> 
>   3) It's trivial as demonstrated to make ptrace and seccomp more
>      comprehensible but that does not invalidate #2
> 
>   4) Due to the historical integration of tracing (+probes/BPF) there is
>      an implicit assumption that the return code is preset to -ENOSYS.
>      See #2

False again

> 
>   5) There is an obvious ambiguity between the initial syscall number
>      being -1 and the change of syscall number to -1 in the case of
>      tracing, but that's not unique to tracing:
> 
>      If e.g. seccomp() observes the handed in syscall number to be -1
>      and tells in the return code to skip the syscall, then it can
>      rightfully assume that the return code will be -ENOSYS and has no
>      obligation to set it explicitly. See #2

False again

> 
> Q: Is it perfect?
> A: No
> 
> Q: Can it be made perfect?
> A: No, because you can't change history and established practice.
> 
> Just for illustration. Changing the logic in trace_syscall_enter() to:
> 
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -9,13 +9,15 @@
>  
>  bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
>  {
> +	long orig_syscall = *syscall;
> +
>  	trace_sys_enter(regs, *syscall);
>  	/*
>  	 * Probes or BPF hooks in the tracepoint may have changed the
>  	 * system call number. Reread it.
>  	 */
>  	*syscall = syscall_get_nr(current, regs);
> -	return *syscall != -1L;
> +	return *syscall == orig_syscall || *syscall != -1L;
>  }
>  
>  void trace_syscall_exit(struct pt_regs *regs, long ret)
> 
> does not make #2 magically go away. It's still the same problem whether
> you like it or not.

However, reading the syscall number from pt_regs only after
syscall_enter_from_user_mode exits does.

Thanks

Michal

Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781073FAE14
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017233; cv=none; b=hr+0ku9+MDED0/eyj1tKTjYK7A2C/umcFwwNS0csZUIHfbOAMwCjTSlZ1dtO5gFbklhBY2xIMXuWLMYZGJ3wmQNt7b90+cH9Kmh7oMIX98yPdCBWuQG4spVMI6PXMqkfY1xLpMffU6Eo3v5ryN7VPfJMS+SnEMAo8Gm0/PohaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017233; c=relaxed/simple;
	bh=TGt1HFaW/THuzsrHNEcoHdyo6LaeCt1ApJr4+qFvNmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6iVhbqaGP3MuMkZoEx1UV3SSGxMvm2BVvgrJ/8bQR0QD/9RYPQq3YEgBikzL3TFURBJ0iNT/vz7yy3/bhYRg8UYcs+pkC3NWcS8k5QTbuQgfOUziamyVXt0MZn0GuxfEaKBBSCq9Sw182ZFEP1OFQQ9u+I0p8PcB4ofR1VjqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKJ09ll/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kyKADJBo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DKJ09ll/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kyKADJBo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKJ09ll/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kyKADJBo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DKJ09ll/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kyKADJBo"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B37B77D67;
	Tue, 14 Jul 2026 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784017221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1nzoIiIS1i6/8kifcmUM+0AdKBs7HiZlyka0H+4a9w=;
	b=DKJ09ll/zFwCXlbl6voF6Ew/i+nGfuIXvwr6+pPYyJYkjrugeEud/q+Ki5j7VPl5fqg4RU
	7v0Fr5aEHfh6wFz8BRS8uap35P8g2QzVdrMcXNhwITMtJjhdQjQ/wGAESjusjginjvTIaB
	s/IaH99ENQnMIs5WMPNIymEU1PqEzNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784017221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1nzoIiIS1i6/8kifcmUM+0AdKBs7HiZlyka0H+4a9w=;
	b=kyKADJBodi7qpCF8SOU3elSKX6/nsxl0ZSGyW3McIGkcmKNlth+AD/XvcaQdtO7s/xaBLW
	/BdlcT2IZYRDreCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DKJ09ll/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kyKADJBo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784017221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1nzoIiIS1i6/8kifcmUM+0AdKBs7HiZlyka0H+4a9w=;
	b=DKJ09ll/zFwCXlbl6voF6Ew/i+nGfuIXvwr6+pPYyJYkjrugeEud/q+Ki5j7VPl5fqg4RU
	7v0Fr5aEHfh6wFz8BRS8uap35P8g2QzVdrMcXNhwITMtJjhdQjQ/wGAESjusjginjvTIaB
	s/IaH99ENQnMIs5WMPNIymEU1PqEzNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784017221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1nzoIiIS1i6/8kifcmUM+0AdKBs7HiZlyka0H+4a9w=;
	b=kyKADJBodi7qpCF8SOU3elSKX6/nsxl0ZSGyW3McIGkcmKNlth+AD/XvcaQdtO7s/xaBLW
	/BdlcT2IZYRDreCA==
Date: Tue, 14 Jul 2026 10:20:20 +0200
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
Message-ID: <alXxRMjQsBas4AJv@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
 <87a4rxqnar.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4rxqnar.ffs@fw13>
X-Spamd-Bar: +++++++++++++
X-Rspamd-Queue-Id: 5B37B77D67
X-Spam-Flag: YES
X-Spam-Score: 13.02
X-Spam-Level: *************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [13.02 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_SPAM_SHORT(0.83)[0.278];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
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
X-Spam: Yes

On Sat, Jul 11, 2026 at 10:33:16PM +0200, Thomas Gleixner wrote:
> Michal!
> 
> On Fri, Jul 10 2026 at 13:01, Michal Suchánek wrote:
> > On Wed, Jul 08, 2026 at 10:34:38PM +0200, Thomas Gleixner wrote:
> >> does not make #2 magically go away. It's still the same problem whether
> >> you like it or not.
> >
> > However, reading the syscall number from pt_regs only after
> > syscall_enter_from_user_mode exits does.
> 
> That does not solve anything at all.
> 
> TBH, your communication style is annoying as hell. You fail to provide
> any useful arguments and explanations despite me giving you a proper
> analysis. And I'm absolutely tired of this.
> 
> So let me try again for _ONE_ last time to explain you why your ppc/s390
> world view is broken and let's look at the current code (irrelevant
> portions omitted).
> 
> static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
> {
> 	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
> #1		if (syscall_user_dispatch(regs))
> 			return -1L;
> 	}
>         
> 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
> #2		ret = arch_ptrace_report_syscall_entry(regs);
> 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
> 			return -1L;
> 	}
> 
> 	/* Do seccomp after ptrace, to catch any tracer changes. */
> 	if (work & SYSCALL_WORK_SECCOMP) {
> #3		ret = __secure_computing();
> 		if (ret == -1L)
> 			return ret;
> 	}
> 
> 	/* Either of the above might have changed the syscall number */
> #4	syscall = syscall_get_nr(current, regs);
> 
> 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> #5		syscall = trace_syscall_enter(regs, syscall);
> 
>         return syscall;
> }
> 
> #1) The user dispatch mechanism does not modify the syscall return
>     value, but it can rollback the syscall and tell the call site to
>     skip the invocation.
> 
>     The mechanism used in upstream today is to return -1L as the syscall
>     number which makes the architecture specific entry code skip the
>     syscall and refrain from touching the return value.
> 
> #2) ptrace
> 
>     ptrace can poke whatever it wants into the syscall number storage
>     via ptrace_set_syscall_info_entry() -> syscall_set_nr()
> 
>     It does not set the return code.
> 
>     It does not abort the syscall when the poked syscall number is -1L.

Indeed, it does not abort on -1 syscall number anymore although there
are still comments around that claim that setting the syscall number to
-1 is special.

Thanks

Michal

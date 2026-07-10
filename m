Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51433630AD
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696809; cv=none; b=Ddgw3/bBV8KGrk8SCS22maqSlAKT8JfAsyfUfmO8hJGN+XeGOom+hIBh9BKlvUD4ZZoYkFn7xTrCE1rnfFYA5PgMkJ18MLrbeTpdZlOh0QKeDTOUiL+Mz1gAdsGSYcYEB/T/mjvB5bfqp9tJKZvOaxHo0hzwkPWQWRgXciU9GD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696809; c=relaxed/simple;
	bh=bhIYmmI03GH5yV64n+12XWMrt5l5IMtbkoVv62BqL3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur0TmFum/u8MnMVXLWcQ8+b5fZZF8I5i/FbK78/YJqlCLQOZPi5nzsCVOtYySaGDXodD7JaRf5OSdXm3SBAmwVhPX/DSAS5kCuOxVE2BnrAyef7pUTViA8ocUEbi7JbWXKetetjn064zrneamdTu4KVogRwXjvFOMHDlNVHyed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rRfHvU7h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pk/+bbw3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PEvxjgpH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p4USxO4M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rRfHvU7h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pk/+bbw3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PEvxjgpH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p4USxO4M"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B43DE76801;
	Fri, 10 Jul 2026 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783696805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQD0gbHT/+/4nEi6V44a4a6X/c8Qb54PXXTiWjk/u8=;
	b=rRfHvU7hwvxSxH/yhWy3u/UmnKewb4V/Z4b30wYyACRHS2pvvGsK3hzGOrADXnhSphQb6B
	TJO7bjd1/2FVOhXCYNiRGDpELYNIfYY2dwQ6Y49rIZ1WBugDexsBsCaHyF140dt8k3TjmV
	UWP5O1yIlbcNFepPxleuBxi0o0QQDRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783696805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQD0gbHT/+/4nEi6V44a4a6X/c8Qb54PXXTiWjk/u8=;
	b=pk/+bbw3K3lpKh/bJanZxO9C8hJb0ZZOIjqryyeda12Q6eGbOK0xFb2lDAgDT0IE8bAo9T
	Y31J/JbRgJZSmhDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PEvxjgpH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p4USxO4M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783696804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQD0gbHT/+/4nEi6V44a4a6X/c8Qb54PXXTiWjk/u8=;
	b=PEvxjgpHDkYAsWHBvOJnCwi8Aqh7iUKS6UnrUW8IsLNixt7v9VdTF6VpKe/6vGC/h1xgM2
	uQXypgGxDhZQFurqRWyXGrIHbe4ykOmc1FofcTQPuLdfVOHR9PXQBW7Js2xqnQRuLq0aZj
	LLSWX+cwuBo/Mg5E6/LeKOba5LZ7xYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783696804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQD0gbHT/+/4nEi6V44a4a6X/c8Qb54PXXTiWjk/u8=;
	b=p4USxO4MP+4N45GZtMpBPez/DEQVEMysX4p56b8ql7l7r16Ar/kLpYHwhTAobjb9FOy99M
	EDSZAKc2nxg1qgBA==
Date: Fri, 10 Jul 2026 17:20:03 +0200
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
Message-ID: <alENozSQmA3nU86B@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
 <alDaOw8t-e3rxIPm@redhat.com>
 <alDmTcgzMlKiio9H@kunlun.suse.cz>
 <alDrGBMdTuoLcVyy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alDrGBMdTuoLcVyy@redhat.com>
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.15 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.96)[0.987];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	R_RATELIMIT(0.00)[to_ip_from(RLrpyf51xp5ujasy9bitsaikab)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,infradead.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,lists.linux.dev,dabbelt.com,lists.infradead.org,arm.com,huawei.com,linaro.org,armlinux.org.uk,linux-m68k.org,alpha.franken.de,gmx.de,users.sourceforge.jp,nod.at,zankel.net,lists.linux-m68k.org,arndb.de,monstr.eu,davemloft.net,gaisler.com,lwn.net];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:helo,kunlun.suse.cz:mid,suse.de:dkim]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: B43DE76801
X-Spam-Score: 15.15
X-Spam: Yes

On Fri, Jul 10, 2026 at 02:52:40PM +0200, Oleg Nesterov wrote:
> On 07/10, Michal Suchánek wrote:
> >
> > On Fri, Jul 10, 2026 at 01:40:43PM +0200, Oleg Nesterov wrote:
> > >
> > > I can only say that ptrace users do want to skip the syscall and set the
> > > return value on entry.
> > >
> > > See
> > > 	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
> > > 	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/
> > >
> > > The changelog explains that currently this doesn't work because
> > > among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
> > > broken in this regard.
> >
> > Or it could be documented that setting the return value has to be done
> > in the exit trace, and that would than work on any architecture AFAICT.
> 
> Well, ptrace users know the problem. And this what they have to do
> currently.
> 
> > With ppc and s390 using the same register for the syscall number and
> > syscall return value it's very much impossible to poke the return value
> > on entry into a register using the generic register access function. As
> > of now there is no place to store the value ot of the return value
> > outside of the registers, either.
> 
> I know nothing about ppc and s390. Can't comment right now.
> 
> > And the current PTRACE_SET_SYSCALL_INFO indeed sets the syscall nr and
> > arguments on entry and the syscall return value on exit, that
> > disctincion is implemented.
> >
> > Not sure how the patchset you point out is relevant, it only adds
> > changes in the exit case.
> 
> No. It allows to skip-and-set-retval on PTRACE_EVENT_SECCOMP.

And if it was hooked correctly to seccomp indicating to seccomp that the
syscall needs to be skipped it could work but it is not, and will fail
on ppc.

Thanks

Michal

> 
> But ENTRY -> EXIT transition is not yet allowed due to the problems
> above.
> 
> Oleg.
> 

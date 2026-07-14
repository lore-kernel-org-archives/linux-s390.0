Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9883F39DB
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018410; cv=none; b=skwNvQ+p7CrpOf5F8tptPhZRsVM+YAS2rgWvHPtBp5ta/h6fLOWnmBWNXTUzLMVgIQT6JMhIasbJrY8d2X97gh3O+EoEe+MqGPwtu0ounQm1JyNkqWWRpWckD1k8X70BZWPOE2Dv2f9wU54tJkbU7kOTu/WR/GtQqt26ywIW+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018410; c=relaxed/simple;
	bh=tBC5GAfYqzzIKHW4i9rpzCVQlvK4uJUv+NEEABETIBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIuV28wQiaO/8JfqUjdhg4/1PyitaeNb5NbC2bTV5VV8ceKn1ZKaRR6XINfUdLlGAhRfVuvAn+oUuBFIjDpAc4EuvAwrjyDD0LKSo5xLYKjJ1WUdHrGWIOTlva5NWBEOsNPkqymXO7LeXlzMxHyHjX4vBPCDUIy9qUGai2SnAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fd90Yu/v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZLKthYKr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=swPFPzDc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yGiPbGwq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fd90Yu/v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZLKthYKr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="swPFPzDc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yGiPbGwq"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFAE277D88;
	Tue, 14 Jul 2026 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784018403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9715Yz9COQgcSHQikGgGymVBJrFS/wJDfe2eKWAzmY=;
	b=fd90Yu/vYqin+DOmDo2grtNXGLfs/4fl+7Ivvh4GJRpGOavVQ0e0E35Sv7Ow7Aaxd/A/Q2
	i4gB8qLldsbRqxmXPDhEacFuNqb8gaLjdP1esJ5/W4GyNh6LYdzY0m0hiJKJEu86lwsy6r
	n8O+jsJQgHwWcMDbOVg4RL49AkwH0Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784018403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9715Yz9COQgcSHQikGgGymVBJrFS/wJDfe2eKWAzmY=;
	b=ZLKthYKrCuejE3fTIMfqv83NTR83YNCQml6R8ku17Vga3LwVRNbnafLfo6b0SX47fqIJoB
	i0VeYcs90YvokhBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=swPFPzDc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yGiPbGwq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784018402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9715Yz9COQgcSHQikGgGymVBJrFS/wJDfe2eKWAzmY=;
	b=swPFPzDcs8ZGYwuQDuJ0V5yul8A9oQIF/esqALj1kVj0w9dIfq3r+3W7zxHry1UROiQ+80
	oqSZbbTm7ZmLh4N0ZOb4kxQpomPOCgb+Q9XcWvFEXCapw8CQA0kITGEqapRNisjdoHdpf5
	5zekOTzHk/+6np+AAxSb2SQ7aTKvL18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784018402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9715Yz9COQgcSHQikGgGymVBJrFS/wJDfe2eKWAzmY=;
	b=yGiPbGwqtW7Lt8OjX6gJRodZOTMEtzl9msgc/30cP/QVfPyq7E2RA0QfMPO3OGCKfQc4Nc
	IWnrgidLqmHVo0Dg==
Date: Tue, 14 Jul 2026 10:40:01 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>
Subject: Re: [patch 4/4] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
Message-ID: <alX14R_pxloY_baW@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.772209074@kernel.org>
 <alSlg72c8xmjaj48@kunlun.suse.cz>
 <871pd6r0ou.ffs@fw13>
 <alXlSUcT2TWOlM7r@kunlun.suse.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alXlSUcT2TWOlM7r@kunlun.suse.cz>
X-Spamd-Bar: ++++++++++++++
X-Rspamd-Queue-Id: BFAE277D88
X-Spam-Flag: YES
X-Spam-Score: 14.86
X-Spam-Level: **************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [14.86 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.67)[0.891];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,arm.com,huawei.com,gmail.com,lwn.net,rendec.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:mid,kunlun.suse.cz:helo]
X-Spam: Yes

On Tue, Jul 14, 2026 at 09:29:13AM +0200, Michal Suchánek wrote:
> On Tue, Jul 14, 2026 at 12:20:49AM +0200, Thomas Gleixner wrote:
> > On Mon, Jul 13 2026 at 10:44, Michal Suchánek wrote:
> > > On Sun, Jul 12, 2026 at 11:25:32PM +0200, Thomas Gleixner wrote:
> > >> The return values of syscall_enter_from_user_mode[_work]() are
> > >> non-intuitive. Both functions return the syscall number which should be
> > >> invoked by the architecture specific syscall entry code. The returned
> > >> number can be:
> > >> 
> > >>   - the unmodified syscall number which was handed in by the caller
> > >> 
> > >>   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
> > >> 
> > >> That has an additional twist. If the return value is -1L then the caller is
> > >> not allowed to modify the return value as that indicates that the modifying
> > >> entity requests to abort the syscall and set the return value already. That
> > >> can obviously not be differentiated from a syscall which handed in -1 as
> > >> syscall number.
> > >> 
> > >> The most trivial way to deal with that is:
> > >> 
> > >>     set_return_value(regs, -ENOSYS);
> > >>     nr = syscall_enter_from_user_mode(regs, nr);
> > >>     if (valid(nr))
> > >>     	handle_syscall(regs, nr);
> > >> 
> > >> That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
> > >> preset the return value, so when user space hands in -1 and there is
> > >> nothing setting the return value in the entry work code, then the syscall
> > >> is skipped but the return value is whatever random data has been in the
> > >> return value register.
> > >
> > > The reason why PowerPC and S390 do not preset the return value is that
> > > the return value uses the same register as the syscall number. There are
> > > apparently other architectures on which the return value overlaps with
> > > the arguments which also do not preset the return value for that reason.
> > > If they would use the generic entry the same problem would arise.
> > 
> > That's an implementation choice of PPC/S390 as I explained before, which
> > could trivially be solved by having an explicit pt_regs->return_val
> > member,

Sorry, I got confused, and was looking at the previous revision of the
patchset.

In this revision I do not see any obvious problem that did not exist
before.

Thanks

Michal

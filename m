Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E86370AE5
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014163; cv=none; b=M/rh0V9sc0wCfCUZs2vUiTy6GDJnQz5PLRzBC/6bD3AVpDsgFu0Ok7Mm4s9c/wY31d8uwayP14rFq0VGhsDqqyPiDjhqicOpkcd6vQ9KzfbyYPt/Nyceb9pIMW7WDX1Qjp8MjfHJ9vguL6CZEw3SUBsmBn4FY0e60RT4tA5Ajfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014163; c=relaxed/simple;
	bh=qDt93a+EwrorpyaBSh1iasbFveXzrdCrAoSZ4MwufC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyD6JFP7i2uvR6PL2MS7QioQNifeqmmYLSyvzy2/cSB64pKt7G8kg6igIDIi/14hDl3mqHlFIAxtZSYppp5Ub5jA5BJDRN+8PT8GajmN92jv1+UNhwvI9Aw1+KJr2EGveiiAmZhG6gCsupJyW1b7tFV58j3n6pIUosDvjUtROlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0B5C77D39;
	Tue, 14 Jul 2026 07:29:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Date: Tue, 14 Jul 2026 09:29:13 +0200
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
Message-ID: <alXlSUcT2TWOlM7r@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.772209074@kernel.org>
 <alSlg72c8xmjaj48@kunlun.suse.cz>
 <871pd6r0ou.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pd6r0ou.ffs@fw13>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: D0B5C77D39
X-Spam-Flag: NO
X-Spam-Score: -2.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]

On Tue, Jul 14, 2026 at 12:20:49AM +0200, Thomas Gleixner wrote:
> On Mon, Jul 13 2026 at 10:44, Michal Suchánek wrote:
> > On Sun, Jul 12, 2026 at 11:25:32PM +0200, Thomas Gleixner wrote:
> >> The return values of syscall_enter_from_user_mode[_work]() are
> >> non-intuitive. Both functions return the syscall number which should be
> >> invoked by the architecture specific syscall entry code. The returned
> >> number can be:
> >> 
> >>   - the unmodified syscall number which was handed in by the caller
> >> 
> >>   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
> >> 
> >> That has an additional twist. If the return value is -1L then the caller is
> >> not allowed to modify the return value as that indicates that the modifying
> >> entity requests to abort the syscall and set the return value already. That
> >> can obviously not be differentiated from a syscall which handed in -1 as
> >> syscall number.
> >> 
> >> The most trivial way to deal with that is:
> >> 
> >>     set_return_value(regs, -ENOSYS);
> >>     nr = syscall_enter_from_user_mode(regs, nr);
> >>     if (valid(nr))
> >>     	handle_syscall(regs, nr);
> >> 
> >> That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
> >> preset the return value, so when user space hands in -1 and there is
> >> nothing setting the return value in the entry work code, then the syscall
> >> is skipped but the return value is whatever random data has been in the
> >> return value register.
> >
> > The reason why PowerPC and S390 do not preset the return value is that
> > the return value uses the same register as the syscall number. There are
> > apparently other architectures on which the return value overlaps with
> > the arguments which also do not preset the return value for that reason.
> > If they would use the generic entry the same problem would arise.
> 
> That's an implementation choice of PPC/S390 as I explained before, which
> could trivially be solved by having an explicit pt_regs->return_val
> member,
> 
> >> Change the return values of syscall_enter_from_user_mode[_work]() to
> >> boolean and return false, when either ptrace or seccomp request to skip the
> >
> > There is a difference between seccomp and ptrace.
> >
> > When seccomp indicates to skip the syscall it has also set the syscall
> > return value.
> >
> > However, when the syscall number is -1 and the return value is not
> > preset that does not indicate anything.
> 
> I agree it's an invalid syscall, but the current generic entry code made
> the rightful assumption that returning -1L as the syscall number either
> results in -ENOSYS or in the value which was set by one of the entry
> mechanisms as that code originated from the x86 implementation.

You know, the world is not x86. For 20+ years that is not true.

> 
> It's not the fault of that code that PPC and S390 converted their stuff
> over without paying attention to that detail.

So this is not generic entry but rather x86-like entry do I get it
correct?

> 
> > The return value can still hold garbage. ptrace does not have the
> > ability to indicate that a syscall is to be skipped, at least on the
> > entry trace. It needs to be skipped based on the syscall number being
> > invalid.
> 
> That's what I explained you before and you told me I'm all wrong.
> 
> But that's moot as this latest version does not care anymore. The
> architectures whixh preset the return value are correct under all
> circumstances and PPC/S390 can keep their own world view.

So do I get it that you do not care about breaking userspace then?

Thanks

Michal

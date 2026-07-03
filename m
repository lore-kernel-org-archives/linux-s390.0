Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64863B3BE9
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077932; cv=none; b=SstbKAG2MPqfOmDsmzeYDZVqACo23JEKHmICaSLjb3SdTCruikQm+YC52LFxhwMpSpYa6/xEQqJ0W7EqKbkoWKaE5zwg0kGdh8GcoQDROyw3M+qBr+dAHpYHV9DiqtCwFMrsFnXU/cQebj/jzFtOGzvRc1QamgJsD5UNvBbX6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077932; c=relaxed/simple;
	bh=z3pGW6hOv1fA8gmDBkYs8QU1BjeVuZL/SAlikVDpokQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irOlChjZS5KsdJ8BT1bh2WT70xCRusQYgDASbggfHNtcYdbQChJ++2Jz1ZbSEpM3gpRKVQJcmDBXc1eOB8ea80jlhzU8xBAyIEa6tUyjiQ/LiUiGVDeFI+qz0/nbAqFoI9hAUIJmkDqN08xY7bDzHWpi4rtU08V0ebwALj/7cUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEE26758B0;
	Fri,  3 Jul 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Fri, 3 Jul 2026 13:25:25 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Zong Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>,
	Deepak Gupta <debug@rivosinc.com>,
	Lukas Gerlach <lukas.gerlach@cispa.de>,
	Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
Message-ID: <akecJWAJP-e5CYP_@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
 <87h5mhnjsr.ffs@fw13>
 <yt9dwlvca8rn.fsf@linux.ibm.com>
 <87ldbsmnie.ffs@fw13>
 <yt9d5x2w5r84.fsf@linux.ibm.com>
 <20260703105718.GO751831@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703105718.GO751831@noisy.programming.kicks-ass.net>
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
	TAGGED_RCPT(0.00)[kernel]
X-Rspamd-Queue-Id: AEE26758B0
X-Rspamd-Action: no action

On Fri, Jul 03, 2026 at 12:57:18PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 03, 2026 at 11:59:07AM +0200, Sven Schnelle wrote:
> > Thomas Gleixner <tglx@kernel.org> writes:
> > 
> > > On Fri, Jul 03 2026 at 08:26, Sven Schnelle wrote:
> > >> Thomas Gleixner <tglx@kernel.org> writes:
> > >>> It's less than obvious and I have no objections to clean that up and
> > >>> make it more intuitive, but I still fail to see what Michal is actually
> > >>> trying to solve and what the magic flag is for. If s390 requires it,
> > >>> then that's an s390 problem, but definitely x86 does not.
> > >>
> > >> The difference between x86 and s390 is that on s390, regs->gprs[2] is
> > >> used for both the syscall number and the syscall return value.
> > >> That was a design mistake early in the begin about 25 years ago, but
> > >> it's ABI now, so it cannot be changed.
> > >
> > > Cute.
> > >
> > >> When seccomp decides to skip a syscall, it write a return value into
> > >> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
> > >> returns this number. If it's negative all is good - the 'if (likely(nr <
> > >> NR_syscalls))' conditiion would just catch it and skip the syscall.
> > >>
> > >> But if it's a positive number, the code cannot distinguish whether
> > >> that's a return value or a syscall number.
> > >>
> > >> So I introduced PIF_SYSCALL_RET_SET when converting s390 to generic
> > >> entry. This flag tells the syscall code that a return value was set in
> > >> ptregs and the syscall should be skipped.
> > >
> > > You also could have added a 'syscall_ret' member to pt_regs, operate
> > > on that for the return values (seccomp, syscall...) and swap it into
> > > gprs[2] right before returning to user space.
> > 
> > That would likely also work, but I found it easier to read and
> > understand to have an additional flag with a descriptive name than having
> > yet another 'somehow-related-to-gpr2' member in ptregs.
> 
> I find this very odd; I would think that having both syscall-nr and
> syscall-ret in separate (virtual) registers for most of the normal cycle
> would be most obvious and less surprising -- given that this is what all
> other architectures do.
> 
> Entry either grabs a copy of gpr2 and preserves it in orig_gpr2 as the
> syscall nr, or as Thomas suggests, you keep syscall_ret and copy that
> into gpr2 on return to userspace (and ptrace and signal and whatever
> other surface bits are affected).
> 
> Either way around you then have separate values for the entire range of
> at least the C part of the kernel syscall handling -- just like every
> other arch. How is munging things in a single value and a flag easier?

The same could be asked of syscall_enter_from_user_mode. I find it very
odd. Why does it conflate the syscall number with its return value?

It never uses the syscall number passed in except when returning it
unchanged. When it pokes the registers it reads the syscall number from
them.

If the caller of syscall_enter_from_user_mode only read the syscall
number from the registers when syscall_enter_from_user_mode returns and
indicates the syscall should be still executed this whole shenigan would
be avoided.

Thanks

Michal

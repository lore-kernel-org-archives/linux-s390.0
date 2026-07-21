Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB8375F7B
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631855; cv=none; b=QC/vziFKlX4rxweczvq3QJLYWLKRlqIOFyqBdMQopFVCO2nHFGpiZdXRBRCQUH7pdYpfVXyRc77IhaSqfPVEs3zBIBKZBU6RdTT2IwHEhD8ihvdnjqD+5bMtNjvlAmRmGpKxPkvi6WTkeNT8KBm8yCtbCR2rL6TDkNxbFHVpTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631855; c=relaxed/simple;
	bh=t5pjSKrGNSqWKvaNZ0EUjm3DHVQdnbw/NOq3yilEdes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptwPOpP6JeSoluDlSOMvIVCFFUSR3icuicYHBGTNV1Z9iiIvAJ+Im22BtPD9thlXs2Sb0JvgvC5ndsrjW/j7WDWTNbHRJoNLp2O7BUNP3oQgzEUKLmPqcfgPH3PyvqXjz5Km1x+weiSNTnWoe49ItaR2WZb8Zqc9XvGzJkQ4XVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rq1/Ng9C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C+6C8oeG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KNxOSiG2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gmUuX1Z4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rq1/Ng9C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C+6C8oeG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KNxOSiG2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gmUuX1Z4"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 049A43E09;
	Tue, 21 Jul 2026 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784631851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuE2qzP5TR2H8th0GJx8QRoWsG9NwmD+jXlWApIGZZk=;
	b=Rq1/Ng9CJRUBdCSMgOB6c7GxMYU1UpeKHnO18JcMkGVKM3cEVgobMqYJRZ1isJ3kKIfFQD
	XifpFuSACqV+WEfejfqA1XVXWlvPGZsyAoJIeBDO92kwI+JFIk/cRKoKNaBGztNbTSY/Cq
	AN4P4IK6H9730ExmJFkSpdAqSF3YlQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784631851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuE2qzP5TR2H8th0GJx8QRoWsG9NwmD+jXlWApIGZZk=;
	b=C+6C8oeG7Gqhp2pv5ID5tV3mDvds64LQR+0ApKf7V9lAc1GN9G3GERp1gO74ASl/gZ1eqv
	5U73v7fI0CiqUkBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KNxOSiG2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gmUuX1Z4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784631850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuE2qzP5TR2H8th0GJx8QRoWsG9NwmD+jXlWApIGZZk=;
	b=KNxOSiG2vpe40bUpJxXcBeZMxsr9MONH0kVP5JTRk6hFgtQmFlD27QkL+AQV5aCUz6rBMQ
	cmPjpQWnzmKJ6HnpVW2DugjrFqhaj/q/rV8Mc6ur2UmnEA24U+497HXtZnZ/ZUdQ8labYP
	mn9dvEtGrvcqvckDZwbzvQE+TUVtR2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784631850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuE2qzP5TR2H8th0GJx8QRoWsG9NwmD+jXlWApIGZZk=;
	b=gmUuX1Z4XRzsmYSWD/KHPQn1GCnIGlUut5ktm2znK0iZkaAf+hm/iUOHELL2TDOIz0GlFz
	X8Ws/8F3b16bz7Bg==
Date: Tue, 21 Jul 2026 13:04:08 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/syscall: Keep syscall return in extra ptregs
 member
Message-ID: <al9SKABzeTH8GXp9@kunlun.suse.cz>
References: <20260715133830.2619853-1-svens@linux.ibm.com>
 <20260715133830.2619853-2-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715133830.2619853-2-svens@linux.ibm.com>
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 049A43E09
X-Spam-Flag: YES
X-Spam-Score: 15.16
X-Spam-Level: ***************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.16 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.97)[0.989];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:mid,kunlun.suse.cz:helo,infradead.org:email]
X-Spam: Yes

On Wed, Jul 15, 2026 at 03:38:29PM +0200, Sven Schnelle wrote:
> On s390, both syscall number and return value share ptregs::gprs[2].
> Before executing the syscall, gpr[2] contains the syscall number,
> and after execution it gets the return value assigned.
> 
> This is problematic with tracing: When either seccomp or ptrace set
> a return value and the syscall number to -1 to skip the syscall, the
> return value will be overwritten. If the return value is positive,
> it's impossible to determine that the syscall should be skipped.
> 
> During conversion to generic entry a PIF_SYSCALL_RET_SET flag was
> introduced which is set when syscall_set_return_value() is executed.
> 
> Peter Zijlstra proposed in [1] to introduce a new member in ptregs
> which keeps the return value and copy this to ptregs::gprs[2] before
> exit to userspace instead.
> 
> To avoid increasing ptregs size add it to the union which contains
> int_parm_long and struct tpi_info as these members are not used during
> syscalls.
> 
> [1] https://lore.kernel.org/all/20260703105718.GO751831@noisy.programming.kicks-ass.net/
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/include/asm/ptrace.h  |  9 ++++++---
>  arch/s390/include/asm/syscall.h |  5 ++---
>  arch/s390/kernel/syscall.c      | 15 +++------------
>  3 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index 495e310c3d6d..f39b349da9a7 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -15,9 +15,8 @@
>  
>  #define PIF_SYSCALL			0	/* inside a system call */
>  #define PIF_PSW_ADDR_ADJUSTED		1	/* psw address has been adjusted */
> -#define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
> -#define PIF_GUEST_FAULT			3	/* indicates program check in sie64a */
> -#define PIF_FTRACE_FULL_REGS		4	/* all register contents valid (ftrace) */
> +#define PIF_GUEST_FAULT			2	/* indicates program check in sie64a */
> +#define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) */
>  
>  #define _PIF_SYSCALL			BIT(PIF_SYSCALL)
>  #define _PIF_ADDR_PSW_ADJUSTED		BIT(PIF_PSW_ADDR_ADJUSTED)
> @@ -130,6 +129,10 @@ struct pt_regs {
>  			unsigned int int_parm;
>  			unsigned long int_parm_long;
>  		};
> +		struct {
> +			unsigned long __unused;
> +			unsigned long syscall_ret;
> +		};
>  		struct tpi_info tpi_info;
>  	};
>  	unsigned long flags;
> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> index 4271e4169f45..22b6ed20a9ae 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -52,15 +52,14 @@ static inline long syscall_get_error(struct task_struct *task,
>  static inline long syscall_get_return_value(struct task_struct *task,
>  					    struct pt_regs *regs)
>  {
> -	return regs->gprs[2];
> +	return regs->syscall_ret;
>  }
>  
>  static inline void syscall_set_return_value(struct task_struct *task,
>  					    struct pt_regs *regs,
>  					    int error, long val)
>  {
> -	set_pt_regs_flag(regs, PIF_SYSCALL_RET_SET);
> -	regs->gprs[2] = error ? error : val;
> +	regs->syscall_ret = error ? error : val;
>  }
>  
>  static inline void syscall_get_arguments(struct task_struct *task,
> diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
> index 75d5a3cab14e..ce244dceec6d 100644
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -117,25 +117,16 @@ void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
>  		regs->int_code |= nr;
>  	}
>  	regs->gprs[2] = nr;
> +	regs->syscall_ret = -ENOSYS;
>  	if (nr == __NR_restart_syscall && !(current->restart_block.arch_data & 1)) {
>  		regs->psw.addr = current->restart_block.arch_data;
>  		current->restart_block.arch_data = 1;
>  	}
>  	nr = syscall_enter_from_user_mode_work(regs, nr);
> -	/*
> -	 * In the s390 ptrace ABI, both the syscall number and the return value
> -	 * use gpr2. However, userspace puts the syscall number either in the
> -	 * svc instruction itself, or uses gpr1. To make at least skipping syscalls
> -	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checked here
> -	 * and if set, the syscall will be skipped.
> -	 */
> -	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
> -		goto out;
> -	regs->gprs[2] = -ENOSYS;
>  	if (likely(nr < NR_syscalls)) {
>  		nr = array_index_nospec(nr, NR_syscalls);
> -		regs->gprs[2] = sys_call_table[nr](regs);
> +		regs->syscall_ret = sys_call_table[nr](regs);
>  	}
> -out:
> +	regs->gprs[2] = regs->syscall_ret;
>  	syscall_exit_to_user_mode(regs);

Hello,

I think this would break ptrace PTRACE_SETSIGINFO on syscall exit.

It should use syscall_set_return_value but that now sets
regs->syscall_ret, not regs->gprs[2]. At the same time the return value
is in regs->gprs[2] at this point.

Thanks

Michal

>  }
> -- 
> 2.53.0
> 

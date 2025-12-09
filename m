Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE35328264;
	Tue,  9 Dec 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283747; cv=none; b=q+hQBP85BeWzPwyB4m/wlx9zVr1F9L2XrMo7bkO4qhECbsWh5sX8LrHqqcRYR33hTtO9DqYUsrDREAJJofXkPNNoPWGF6ojS09/+YJ6wHTu/Slbyv3BViik87KekIDciz2WpRSWiuvLjCfI2Jce+2pqqDM8cEdrQ3QUOXa3VNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283747; c=relaxed/simple;
	bh=yM9BNWcvBodYx/pbt1hk3eEFbW2TeV4b3Opu6poaDhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8OkRNVolN7tIKP+lAUXVOt0wQ809mi9vQybOhfMyCP2BJa27sbdvbAtYhJPIPwgxDecsjOnJ+87smPgI9FKrF4NxrTdOi33gmjGz9jgduzpXvQMT0jOBsjg0SnsNsWn0LbajwnFuqJXSpDj6nJY2eRJzo34winD6HazYjaGhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kTbEzj64; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTbEzj64"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XruE/qkgnxYbFkMy7mrYf/gxQ9ZxQN/VUZraHKTx0XY=; b=kTbEzj647dNkC8/X10Br1/PZ4e
	gqZY7Z3wwJLIyX5MOlx0n8uCErQXV0ox+T91NpfKDIM1m6B93f2CEAc6loCtt/cAag/O4XbRMHEb8
	Y88y3i4qalCOr+yimDUJ3XQfpwCoWbFo96lXqqyhkaIdu2n3bwdOEnpRTdH4WzK/UH5w74QY150ly
	FD5gVd/gQiPYnyUJwKBM5qddnYgptxjyxRyVkvHzcit07QtgWirAMJ6DeIF8876jQTdVvvCkoZycI
	Zgwzpx7BK9i5wLX0c4oumCHWRzfHMjF4vNa74ExMkRgYtbtlwmSPWDKq1XujuIrm5Ir3/nkPHuz/P
	PMkDKbUw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSw4u-0000000Bkii-0hxf;
	Tue, 09 Dec 2025 11:40:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 06C8830045C; Tue, 09 Dec 2025 13:35:41 +0100 (CET)
Date: Tue, 9 Dec 2025 13:35:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Remus <jremus@linux.ibm.com>,
	Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/9] s390/bug: Implement __WARN_printf()
Message-ID: <20251209123540.GE3707837@noisy.programming.kicks-ass.net>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
 <20251209121701.1856271-7-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209121701.1856271-7-hca@linux.ibm.com>

On Tue, Dec 09, 2025 at 01:16:58PM +0100, Heiko Carstens wrote:

> +#define __WARN_print_arg(flags, format, arg...)				\
> +do {									\
> +	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS;		\
> +									\
> +	__WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
> +} while (0)

So on x86 I had to add:

	asm("");

after the __WARN_trap() call above, to inhibit tail call optimization,
because:

> +void *__warn_args(struct arch_va_list *args, struct pt_regs *regs)
> +{
> +	struct stack_frame *stack_frame;
> +
> +	/*
> +	 * Generate va_list from pt_regs. See ELF Application Binary Interface
> +	 * s390x Supplement documentation for details.
> +	 *
> +	 * - __overflow_arg_area needs to point to the parameter area, which
> +	 *   is right above the standard stack frame (160 bytes)
> +	 *
> +	 * - __reg_save_area needs to point to a register save area where
> +	 *   general registers (%r2 - %r6) can be found at offset 16. Which
> +	 *   means that the gprs save area of pt_regs can be used
> +	 *
> +	 * - __gpr must be set to one, since the first parameter has been
> +	 *   processed (pointer to bug_entry)
> +	 */
> +	stack_frame = (struct stack_frame *)regs->gprs[15];
> +	args->__overflow_arg_area = stack_frame + 1;
> +	args->__reg_save_area = regs->gprs;
> +	args->__gpr = 1;
> +	return args;
> +}

that would affect the stack layout here. You don't suffer this because
you have a link register like setup?

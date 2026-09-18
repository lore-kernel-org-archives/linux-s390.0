Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C54C0436;
	Fri, 18 Sep 2026 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728030; cv=none; b=WrC9iTa8zfDq5Ml4LFqxqkSFS6MhxZtz2Gc9A7LgNPUyH6K7dtAxHiV81DIwVpO2rqd7a2RNoMZkytBgG+GeJAZZ0LlfifwP2KBeO9KqxG374d7EIH95GgvNE+12BYiZZy7w7FzHeK6E3eQuFFhciRujPi2U765j5jrP4+BJEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728030; c=relaxed/simple;
	bh=VP7aoU9fmlXnzysqckFwfPaqCFtCP6iSWl4Du7598+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvYBPW87Zff7vX/XNGsm1JtpWlyszUiaasRd86equi0+huv4AHUYNyxtROjCzRrNIHnUoD0A60vfOf+Eh0ehkWOhySFmVE9zgdnM8KdfT/Ks4/ZqbSL+UrEVcJ/UGEM5ZFCuen1QW5EeGNRYz6Ks28cab0Ub+rV3CA1FFkM14Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mjLPBzfz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mjLPBzfz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E59FC1596;
	Fri, 18 Sep 2026 03:40:21 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFFCD3F86F;
	Fri, 18 Sep 2026 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789728025; bh=VP7aoU9fmlXnzysqckFwfPaqCFtCP6iSWl4Du7598+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjLPBzfzPP2TeFm0oML0w4TWvM2ufzlsqfh2CQVo2r63d3BI6YHdegToC/baT1EP/
	 9n7nlgGkVvvELqeNA2VdjugkiIQnj1cySZIzeIBQ1HDf2Ix3GrLlURshbqr9rhHyhR
	 xrcRaHhZU5eRytQi21G4I369Xs78cVQnLuMlnzTU=
Date: Fri, 18 Sep 2026 11:40:21 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 12/12] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Message-ID: <aq0VFSS_81QTKjcj@J2N7QTR9R3>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-13-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918084842.2333237-13-hca@linux.ibm.com>

On Fri, Sep 18, 2026 at 10:48:42AM +0200, Heiko Carstens wrote:
> The percpu code section functionality uses a rather complex method to
> figure out if the register, which contains the address of the current
> cpu's percpu variable, needs to be adjusted.
> 
> If an interrupt happens within a percpu code section (indicated by a
> lowcore field), the instruction at the interrupted location is
> checked. If it is not a specific AG instruction, the register needs to
> be updated. This mechanism needs to take kprobes into account, and
> enforces a specific instruction ordering.
> 
> Mark Rutland provided with a different solution for arm64 [1] which
> comes without such limitations, but requires to use one more
> instruction, and two more registers. Given that this simplifies
> percpu_entry() and percpu_exit() it seems to be worth to go that
> route.
> 
> Change s390 to implement a similar approach. This requires to encode
> three register numbers into the "percpu_register" field, which is used
> to indicate if a percpu code section is executed.
> 
> The used mviy instruction can write only one byte, which allows to
> encode only two register numbers. Use a register pair for the inline
> assemblies, and only encode the even register number of the register
> pair to work around this.

Neat trick!

I have one minor comment below, but this looks good to me regardless.

> -static __always_inline void percpu_exit(struct pt_regs *regs, bool needs_fixup)
> +static __always_inline void percpu_exit(struct pt_regs *regs)
>  {
> +	unsigned char regval, regpcp, regoff, regptr;
>  	struct lowcore *lc = get_lowcore();
> -	unsigned char reg;
>  
> -	if (user_mode(regs))
> +	if (!regs->percpu_register)
>  		return;
> -	reg = regs->percpu_register;
> -	lc->percpu_register = reg;
> -	if (likely(!needs_fixup))
> -		return;
> -	/* Check if process has been migrated to a different CPU. */
> +	regval = regs->percpu_register;
> +	lc->percpu_register = regval;
> +	/* Migrated to a different CPU? */
>  	if (regs->cpu == lc->cpu_nr)
>  		return;
> -	/* Fixup percpu base register */
> -	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
> -	regs->gprs[reg] += lc->percpu_offset;
> +	regpcp = FIELD_GET(PCPU_REG_PCP, regval);
> +	regoff = FIELD_GET(PCPU_REG_OFF, regval);
> +	regptr = regoff + 1;
> +	/*
> +	 * Update register 'regoff' which contains the current CPU's percpu
> +	 * offset, and recalculate and update current CPU's percpu variable
> +	 * address contained in register 'regptr'.
> +	 */
> +	regs->gprs[regoff] = lc->percpu_offset;
> +	regs->gprs[regptr] = regs->gprs[regpcp] + regs->gprs[regoff];
>  }

> +#define PCPU_REG_PCP_SHIFT		0
> +#define PCPU_REG_PCP			GENMASK(3, 0)
> +#define PCPU_REG_OFF_SHIFT		4
> +#define PCPU_REG_OFF			GENMASK(7, 4)
> +
>  #define __PCPU_MVIY(lcreg, imm)							\
>  	ALTERNATIVE("	mviy	" lcreg			"(%%r0)," imm "\n",	\
>  		    "	mviy	" lcreg "+" LC_ALT_ADDR "(%%r0)," imm "\n",	\
>  		    ALT_FEATURE(MFEATURE_LOWCORE))
>  
> -#define __PCPU_AG(reg, lcoff)							\
> -	ALTERNATIVE("	ag	" reg ", " lcoff		 "(%%r0)\n",	\
> -		    "	ag	" reg ", " lcoff "+" LC_ALT_ADDR "(%%r0)\n",	\

> +#define __PCPU_MVIY_REGS(lcreg, regpcp, regoff)					\
> +	DEFINE_GR_NUM								\
> +	"_GR_NUM .Lregpcp, " regpcp "\n"					\
> +	"_GR_NUM .Lregoff, " regoff "\n"					\
> +	UNDEF_GR_NUM								\
> +	".if .Lregpcp == .Lregoff\n"						\
> +	"	.error \"Registers must not be identical\"\n"			\
> +	".endif\n"								\
> +	".set .Lregval, ((.Lregpcp << " __stringify(PCPU_REG_PCP_SHIFT) ") |"	\
> +	"		 (.Lregoff << " __stringify(PCPU_REG_OFF_SHIFT) "))\n"	\
> +	__PCPU_MVIY(lcreg, ".Lregval")
> +
> +#define __PCPU_LG(regoff, lcoff)						\
> +	ALTERNATIVE("lg	" regoff ", " lcoff		    "(%%r0)\n",		\
> +		    "lg	" regoff ", " lcoff "+" LC_ALT_ADDR "(%%r0)\n",		\
>  		    ALT_FEATURE(MFEATURE_LOWCORE))
>  
> -#define __PCPU_BEGIN(lcreg, lcoff, reg)						\
> -	DEFINE_GR_NUM								\
> -	"_GR_NUM .Lreg, " reg "\n"						\
> -	UNDEF_GR_NUM								\
> -	__PCPU_MVIY(lcreg, ".Lreg")						\
> -	__PCPU_AG(reg, lcoff)
> +#define __PCPU_AGRK(regptr, regpcp, regoff)					\
> +	"	agrk	" regptr "," regpcp "," regoff "\n"
> +
> +#define __PCPU_BEGIN(lcreg, lcoff, regpcp, regoff, regptr)			\
> +	__PCPU_MVIY_REGS(lcreg, regpcp, regoff)					\
> +	__PCPU_LG(regoff, lcoff)						\
> +	__PCPU_AGRK(regptr, regpcp, regoff)

Since percpu_exit() relies on regptr being regoff + 1, maybe it's worth
having a check here to verify that? Perhaps in __PCPU_MVIY_REGS() with
the uniqueness check.

Hopefully that never goes wrong, but catching a violation at build time
might save some future pain.

Mark.

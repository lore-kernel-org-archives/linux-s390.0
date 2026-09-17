Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8D4E36C7
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674182; cv=none; b=fVPDq9tSZ1GsA7dMUaamsxgqVEOe5QB3NWIm8xa5CpVKGjFEQ2s3+r+PnZOIsyVO/QQXiI0vAANs8w839lthl5qReTIdYDqopNYzmeklAoxTfPq/fDKvqt3pAqzaJ0a4gTx+Q1PTD1hfuqN6iTsxut91wRO7KSPnkVdhNnJ65zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674182; c=relaxed/simple;
	bh=A6X5mGOI0uqKhyjv8H0bU/FPFu8ElC8p701wh8Moy9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZZDHL1TAgJgoqgcwAVYz5vqSQnKdPnxmKyT2Zhm5jAg5rRxkrTSU0P7isqb/XPdp6hBkaN85oTR1TeDTq8NBk50YYXlLNDXvGDodUxKZkLc+ihVUMR0rAIaTpiR96g7dkshsgEGTU8BIM0ctek7VL9lMjJHcsM8iLSPDh2bhCGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWusUwoL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWusUwoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF361F000FF;
	Thu, 17 Sep 2026 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674179;
	bh=zys4v/s6po8BGBa8B/yt/67RlArhCjW6RnoHcHJjEKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWusUwoL6MX5oG+4XtLhRxYG4h4b4+WEbGklSIYoPm8kJIHxleDLZo7NTE6fuFVIS
	 RX11HuJMgjdgMEn/t4pnRYgabvs57kn4fTcT+XwyH4CedVkwrho8QJrMen6folmqxz
	 bvXaerH1t7FYizjvCpE/Bu4+nHN6VEY0rg72OZs/40dxpKsNMx58zslcKkKqftInr9
	 wp1TqpwexnFinm67CklrVHgodtyAaS2d8NZCxgkfUDG0xzi3EZaMC/QhPXYgb20t0W
	 PhhWWnuy80MO+HrcCqE+ySYFCHH+fl4+Vnci70zMqbwPpL+YBj+/Zqsh0/IKpOW5H4
	 W8O62+eASr2Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917192237.638324-13-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-13-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:42:59 +0000
Message-Id: <20260917194259.7EF361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/percpu: unconditional register fixup in percpu_exit() corrupt=
s GPRs on NMI
--

commit 9424e4df4698f4a6dd024548cb15a93aae1331e4
Author: Heiko Carstens <hca@linux.ibm.com>

s390/percpu: Rework to simplify percpu_entry() and percpu_exit()

This commit changes s390 to implement a new approach for percpu code
sections similar to arm64, removing the need to check instruction opcodes
during interrupts. It encodes three register numbers into the
percpu_register field and uses a register pair to work around the
single-byte limit of the mviy instruction.

Link: https://lore.kernel.org/all/20260908151741.394589-1-mark.rutland@arm.=
com/

> diff --git a/arch/s390/include/asm/entry-percpu.h b/arch/s390/include/asm=
/entry-percpu.h
> index 89c9e44f6f833..7ec5d976db471 100644
> --- a/arch/s390/include/asm/entry-percpu.h
> +++ b/arch/s390/include/asm/entry-percpu.h

[ ... ]

> -static __always_inline void percpu_exit(struct pt_regs *regs, bool needs=
_fixup)
> +static __always_inline void percpu_exit(struct pt_regs *regs)
>  {
> +	unsigned char regval, regpcp, regoff, regptr;
>  	struct lowcore *lc =3D get_lowcore();
> -	unsigned char reg;
> =20
> -	if (user_mode(regs))
> -		return;
> -	reg =3D regs->percpu_register;
> -	lc->percpu_register =3D reg;
> -	if (likely(!needs_fixup))
> -		return;
> -	/* Check if process has been migrated to a different CPU. */
> -	if (regs->cpu =3D=3D lc->cpu_nr)
> +	if (!regs->percpu_register)
>  		return;
> -	/* Fixup percpu base register */
> -	regs->gprs[reg] -=3D __per_cpu_offset[regs->cpu];
> -	regs->gprs[reg] +=3D lc->percpu_offset;
> +	regval =3D regs->percpu_register;
> +	lc->percpu_register =3D regval;
> +	regpcp =3D FIELD_GET(PCPU_REG_PCP, regval);
> +	regoff =3D FIELD_GET(PCPU_REG_OFF, regval);
> +	regptr =3D regoff + 1;
> +
> +	/*
> +	 * Update register 'regoff' which contains the current CPU's percpu
> +	 * offset, and recalculate and update current CPU's percpu variable
> +	 * address contained in register 'regptr'.
> +	 */
> +	regs->gprs[regoff] =3D lc->percpu_offset;
> +	regs->gprs[regptr] =3D regs->gprs[regpcp] + regs->gprs[regoff];

[Severity: High]
Does this unconditional fixup corrupt GPRs if an NMI interrupts the kernel
return path?

If a standard interrupt occurs during a percpu code section, the handler's
percpu_exit() restores the non-zero lc->percpu_register right before
returning to assembly. During the subsequent assembly return sequence (e.g.,
in .Lsysc_restore), lc->percpu_register remains non-zero.

If a non-migrating exception (such as a Machine Check NMI) hits during this
precise window, s390_do_machine_check() will save the return sequence's
current registers into pt_regs, call percpu_entry(), and then percpu_exit().

Because this patch removed the migration check (regs->cpu =3D=3D lc->cpu_nr=
),
percpu_exit() now unconditionally overwrites the regoff and regptr GPRs.
Since the compiler's "=3D&d" constraint can allocate register pairs heavily
used by the return sequence (like %r10/%r11 where %r11 points to pt_regs,
or %r14/%r15 where %r15 is the stack pointer), the NMI will clobber them.

When the NMI returns, the interrupted return sequence continues with
corrupted GPRs, potentially causing fatal faults on instructions like
lmg %r0,%r15,__PT_R0(%r11).

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D12

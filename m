Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982882;
	b=vkMF30KpOh7cJwmrV4ExaBvc/mKqaqF8NNt3kktGbn1AHib2NPuBkhbydkwWrAU0IPFc
	 YMf0JUBs7faFntQoLkJL7Tvp7NCH2r6iIf/E58wHLI6OWRlveamNiXN0UPrWK9xUuamHG
	 JiGSm8ttLItpEgxt62/PGkfWKvyeEl2od3M7PG8V0/d+65zh+t6LOWKZJdKrL2XzbYmfq
	 eLBOmQB+IGrmfTM54/dUc5hSSX1sU5oQT4qeRe23oNWFzBUHVZOrse11yZzUhlOgn/tJq
	 pn0nobOxncqHErOWYKoajKE4+TUOe6xNlupALdJ5815A2295QOrR4ziaf5KmxGwvS8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cp+tZVOrkmD7nG2RhQ6YN+Z0lOkuIfJ+qQn8uFGND2c=;
	b=RBFvRJU7S+4it8sR7dLk7eu8BmWRWKa1FhGJF4H2VDpIFeMK04XaPVTcwqukhnn9zQCC
	 GjWF2Stc1tLjjYwQINOdL1xSNSoM7Lvf0b0ddIZwggbTpRQMMnP1zDYWI20MwUBbAZ8gt
	 z58udOEMkY5YUr3AGUq3RqM9GaJuq1InnP7+xgBM+aCr6JIlQu0qzLZ2MlA+1uRGzh0M2
	 upn6vSUlW+zRTH0u21/7JH017sOjw5b7fAP6PHOr+cr0RxGaEiz+7rsdkpFW98ASXpeAk
	 vNDedjW2sr+COnmu9isEZY1GnEYcVaZXaL0shersyxaXHLwZFhbeBtdUXv8eQ6R1Q+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHANWA66;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846D606A338;
	Fri,  6 Nov 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHANWA66
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728A71F008BC;
	Fri,  6 Nov 2026 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982882;
	bh=Cp+tZVOrkmD7nG2RhQ6YN+Z0lOkuIfJ+qQn8uFGND2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHANWA66ONkLPMq3+7IOO+507vY2TicQubzfBZAMq1QAD945Nrxeb08V/q98v/99K
	 qkoCCgYy1dnzSfK1GolMPt1pvCJ5teZq7K+gFrQ72n0oNFjR1rB1V/Mk7nE6E5IitI
	 7RTScJG7oqTyU7y+1h4V3Ojx0KqsIiARMPXVJ3gw62QajcVtWelM/ydUFf/g5mmNNK
	 vV4T7V2eIwaQCwuXkx1mqnmImGU3TZi9ezc6nP7Cp8Ozge4jwEsica42PICwOa/eNK
	 gS6dqm/Ov92ckqUHOEUcajS4xxXCN+IhaTIi+aCLM6hHDMPia8+YT7PjG2/2WIzO7Z
	 o71mIuLmwMA6g==
Message-ID: <sashiko-outbox-201828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/23] arm64: sysreg: Convert OSLSR to automatic
 register generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-3-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-3-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:34:41 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] arm64: sysreg: OSLSR_EL1_OSLK redefinition in tools/ sysreg.h
  breaks perf
--

commit 33e9aa857b4dfa390c27f99a1a44127d7465fe7b
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: sysreg: Convert OSLSR to automatic register generation

This commit converts OSLSR_EL1 to automatic system register generation in
arch/arm64/tools/sysreg and renames OSLSR_EL1_OSLM_IMPLEMENTED to
OSLSR_EL1_OSLM_IMP.

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sys=
reg.h
> index e3b60ee030230..2ec9ba9cd896f 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -186,11 +186,13 @@
>  #define SYS_DBGWCRn_EL1(n)		sys_reg(2, 0, 0, n, 7)
>  #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
> =20
> -#define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
> -#define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
> -#define OSLSR_EL1_OSLM_NI		0
> -#define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
> -#define OSLSR_EL1_OSLK			BIT(1)
> +#define OSLSR_EL1_OSLM_MASK (OSLSR_EL1_OSLM0_MASK | OSLSR_EL1_OSLM1_MASK)
> +#define OSLSR_EL1_OSLM_NI						\
> +	((OSLSR_EL1_OSLM1_NI << OSLSR_EL1_OSLM1_SHIFT) |		\
> +	(OSLSR_EL1_OSLM0_VAL_0 << OSLSR_EL1_OSLM0_SHIFT))
> +#define OSLSR_EL1_OSLM_IMP						\
> +	((OSLSR_EL1_OSLM1_IMP << OSLSR_EL1_OSLM1_SHIFT) |		\
> +	(OSLSR_EL1_OSLM0_VAL_0 << OSLSR_EL1_OSLM0_SHIFT))

[Severity: Medium]
Should tools/arch/arm64/include/asm/sysreg.h receive the same update?

The tools build generates its own asm/sysreg-defs.h from
arch/arm64/tools/sysreg, which now defines OSLSR_EL1_OSLK as GENMASK(1, 1).
Because tools/arch/arm64/include/asm/sysreg.h includes asm/sysreg-defs.h and
still defines OSLSR_EL1_OSLK as BIT(1), building tools/perf fails under
-Werror with a macro redefinition error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D3

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790647;
	b=mCNX1GEgpP+x5HC6hhdkUvfy+7p0fRpvs3lR5yWmh4TuByVsFBtap5HSw8ztU1hEozCF
	 qA/F2fDdkLXUR1400w/F1Ey+nuuhNzP9kvLTq0DqwZUjLJwfRhdy/za7FiP0WdU4GuS9t
	 i5TeHF6jdCii2iWK+umR23y6irYuNPf1QFUQXyvQV8I7wF3znPdhO+W/POa7uhOrABfv0
	 nIGUJVQsdkYF1gBTGJgOLGWlyUfagD+Bu94A1XcOZfoJA78EnWJT80nXLS+wCBSEdYCds
	 y9gqWXcN8hnx1PKbxZyoPf2c2MmikviQJGjKmrSos8thwu5KqaCTWxjQHdJMeAPsb8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Qte7Kp7DAtGXMMfrUS4X7SMr01p5Z5GRH/0ba5utLo=;
	b=Cy6ew/+4IY116YBLRzeyALfH2sy2cwUZdLLa5LuPVsH5h4LiAqU7c8wItUkyS8b5lt+f
	 HDdLjzblSYcjwcNkMX80NhEle5kjnVQnqm3yfNa7/2ZpeV6unEDnJRwVtQOEKl+sIRqok
	 18uw92m0bdKkXJ0tP/uEKSAaNye5ffYkTwGD5RcIPmZmHzKc1RPmpm5uenTlrPQJxddMa
	 s7cmqEZ/7gIWZDZXA4RY8p3OrkktVGS5SzHXuoU4m5zP7n1uxd1vVD7o/sHVfLWXbiY3G
	 XLeEcfkMrN+VZcp3zy6JEjr2rwHw6CSG0pj4ZZ6stnM+iQWxrqAqMYvPpS/Tdt9Y3hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdbnCcbe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B64606A682;
	Fri, 27 Nov 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdbnCcbe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF831F0092A;
	Fri, 27 Nov 2026 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795790646;
	bh=3Qte7Kp7DAtGXMMfrUS4X7SMr01p5Z5GRH/0ba5utLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdbnCcbea6W/e3Ydt6MJpfzVYSI+LmurXxm6J4uP2rNJtNm9hvY+FG6Ds/An9T5jg
	 hk8bCsudguI3O6IUbdw9DQstFncUACPkiLivZ3TKmrXk+TbokdrWLlpNuWREtvt1iW
	 XUEuoURtfqHH4h2BDSXGzcezrrvEk/grQN0QAGWuAzDfREInGqfONxt+y6mzBA4C1a
	 f8pK890FTdscO3xBeRzX8jRSLsBWO6T6Rhn9q9g6svXROZkaNL+IAI7eltHRZ79ffl
	 reL+yOtt+SK0Y+0HhDD1Kas3wYaArxCT8hs2FJSlVQOTBGtr5j3wr6geY71G+Il51L
	 3TZBazrlU3bog==
Message-ID: <sashiko-outbox-237594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/25] KVM: s390: arm64: Implement feature
 sanitisation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-17-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
 <20261127-sysreg-v4-17-a6318d18aab5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:44:05 +0000
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
- [Low] KVM: s390: missing ID_AFR0_EL1 masking in
  kvm_arm_host_sanitize_features()
--

commit 1121664ab9b9682fba8b52f02bbdb9eec39e1d2d
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement feature sanitisation

This commit implements feature detection and ID register sanitization for
arm64 KVM guests on s390 using the QAAF instruction.

> diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
> new file mode 100644
> index 0000000000000..8fd278ace9426
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/feature.c
> @@ -0,0 +1,153 @@

[ ... ]

> +void __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_q=
mc)
> +{

[ ... ]

> +	MASK_RESERVED(qaaf_qmc, ID_PFR0_EL1);
> +	MASK_RESERVED(qaaf_qmc, ID_PFR1_EL1);
> +	MASK_RESERVED(qaaf_qmc, ID_PFR2_EL1);
> +
> +	MASK_RESERVED(qaaf_qmc, ID_DFR0_EL1);
> +	MASK_RESERVED(qaaf_qmc, ID_DFR1_EL1);
> +
> +	MASK_RESERVED(qaaf_qmc, ID_MMFR0_EL1);

[Severity: Low]
Should ID_AFR0_EL1 also be sanitized with MASK_RESERVED() here?
kvm_qaaf_read_ftr_reg() exposes QAAF_REG_ID_AFR0_EL1 for SYS_ID_AFR0_EL1,
so omitting it leaves reserved bits [63:16] unmasked when queried via
read_sanitised_ftr_reg().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-sysreg-v4-=
0-a6318d18aab5@linux.ibm.com?part=3D17

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791847;
	b=KcrWZTmuNNH4UTAIzqj0sGxmvWcp880NNXsgQ6CSmuGFIwTLe4S+qxO1i+A4RwWUVWEt
	 D4k/vhdYWImE8itPXHJf+pKyAqwW6EcC4R09RX/Xi/oEkoYOrzdFfYjZ6RO0eEHzxMl/7
	 ey7g4csttOMMcR1+QRhYGH/IYU4Rn2EiUJDFhxfBEb1ZsEtyuNQ9TwJuNVc1nmLZ4/Ev+
	 Z/psuj46J7+xq6Qt2fMPZ5kRasYAd/skGiKSIUau4AbQfWCg5+RPEGOwA+zUDK8YN0KFT
	 hDkvZ25VUbEOM/Y+HoNBePV9HQ8krmxuFS94s0F7TgTRcH6/fHXhmY13x5AVxgOmbsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791847;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U3c++Uj+UHAoqFFiB1EKXeNNJOFEUngS8YdKGAytKDU=;
	b=MaTVuAWz/V8Q1Ups0inheDFDklIdL9RkreB1c4v5j8UwDaZcPc1bJ3dTQ/UuwsJoY8Sn
	 YCUCAqFomqLjaHPj61c8rbL05WUPz+25iAtvTY4M9FRg+UUDNbaHOoi6AvbDwkMRGenu2
	 pk4UHdNvSxLzndI4Pv4eQ6KrUQm+xySUHenyxzb4XlKJ6jlq7Z8autvEu+H5XWijm9Vas
	 A590ugzw9H9bHJ2jigVZbT2WLugWLj9tDq7qVwB9v4v2n/6RqXvxXOVhdv0Bcrqof5KXv
	 5TOronol+a7W2TBzO9eAWJ2L4Xb9hkq3BKnLLDTib0clC9Qd1q5GPtJdQX++vrzZqjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BaHYVdwe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF6606A31C;
	Fri, 27 Nov 2026 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BaHYVdwe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D967B1F000C1;
	Fri, 27 Nov 2026 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791846;
	bh=U3c++Uj+UHAoqFFiB1EKXeNNJOFEUngS8YdKGAytKDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BaHYVdweYexZ+2iegz7+2sDs5h8ZT6d/xevc29Pc+DWsWllUEiyRo51VvPQHrXrkK
	 Wu8HOCAmS+keChoFZAvnELGwO5NKoWz2UcyOKlV0EQxdhTBzIPgWG9iKFR3/E8vXBE
	 nS2z/54n0imZT5ZpxsZ8f0AXeLUahHfGnsyLDpZaEV9dQXP8rBNsxNOPU/keDPgasS
	 bd871w4qXlzBhi3TmQIdZnQ1wXbhTH4AT5AL0jpDNWnUZZj56RBbCLeA4X82TNJ+dM
	 3Vb8NHolFpJ91W6xHYTdNYl9jMxK3JAdd9nKmYeUDdyE4Z/BRla+2ByTUff1Ulv3BB
	 Jv67vu+QUZsYw==
Message-ID: <sashiko-outbox-237671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/25] KVM: s390: arm64: Implement arm system
 register managing infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-18-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
 <20261127-sysreg-v4-18-a6318d18aab5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:04:05 +0000
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
- [Low] KVM: s390: arm64: check SYS_CTR_EL0 against host_val in
  arm64_check_features()
--

commit 1217d103aa61e7d71cfb3221749c5c2dc344fb25
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement arm system register managing infrastructure

This commit implements the infrastructure for the s390 KVM host to read,
write, trap, and sanitize arm64 guest system registers.

> diff --git a/arch/s390/kvm/arm64/sys_regs.c b/arch/s390/kvm/arm64/sys_reg=
s.c
> new file mode 100644
> index 0000000000000..e240efb77b9b7
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/sys_regs.c
> @@ -0,0 +1,825 @@

[ ... ]

> +static int arm64_check_features(struct kvm_vcpu *vcpu,
> +				const struct sys_reg_desc *rd, u64 val)
> +{
> +	u32 id =3D reg_to_encoding(rd);
> +	u64 host_val;
> +	u64 old_val;
> +
> +	/*
> +	 * This is a very minimal implementation to sanitise only the craziest
> +	 * shenanigans we could get from userspace. The final goal is to share
> +	 * the sanitisation with arm as well but this needs access to arm
> +	 * (core) kernel code for which there is no suitable solution yet. TODO
> +	 */
> +
> +	/*
> +	 * If the register is RAZ we know the only safe value is 0.
> +	 */
> +	if (sysreg_visible_as_raz(vcpu, rd))
> +		return val ? -E2BIG : 0;
> +
> +	host_val =3D read_sanitised_ftr_reg(id);
> +
> +	switch (id) {
> +	case SYS_ID_AA64MMFR0_EL1:
> +		/* Forbid PARANGE values larger than the host supports */
> +		if (SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, val) >
> +		    SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, host_val))
> +			return -E2BIG;
> +		if (kvm_parange_to_address_sanitized(
> +			    SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, val)) <
> +			    vcpu->kvm->arch.guest_phys_size)
> +			return -E2BIG;
> +		break;
> +	case SYS_CTR_EL0:
> +		/* forbid upgrading from VIPT to PIPT */
> +		old_val =3D read_id_reg(vcpu, rd);
> +		if (SYS_FIELD_GET(CTR_EL0, L1Ip, old_val) =3D=3D CTR_EL0_L1Ip_VIPT &&
> +		    SYS_FIELD_GET(CTR_EL0, L1Ip, val) =3D=3D CTR_EL0_L1Ip_PIPT)
> +			return -E2BIG;
> +		break;

[Severity: Low]
Should SYS_CTR_EL0 check L1Ip against host_val rather than
read_id_reg(vcpu, rd)?  read_id_reg() returns the mutable per-VM value in
vcpu->kvm->arch.id_regs, so if userspace writes CTR_EL0_L1Ip_VIPT and
later writes CTR_EL0_L1Ip_PIPT on a PIPT-capable host before the VM is
finalized, the second write is rejected with -E2BIG (-EINVAL).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-sysreg-v4-=
0-a6318d18aab5@linux.ibm.com?part=3D18

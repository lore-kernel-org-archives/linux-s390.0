Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4237DE8D;
	Mon, 31 Aug 2026 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205616; cv=none; b=EdUPMGYNnwoqNo/IvFw8UyHWPvnWsiOUu1FpPzzJwDFEIRsXGB1pgSZDFf3lNaXPb7KaW9SgAhlfCJ+KM4xzme/V5YbOSghtuAoe7seAXG3KUjweQwHk/gAE54VpbfolWO7uB8dBiyuKIPnT00hKolk2C5Ah8RgVYtoq4HliiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205616; c=relaxed/simple;
	bh=42/7gMgSmV/LE2c35J8YuO+9eeCCrYo0oTkboCh/Iu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lg75v14LNxkn5R2lA2EZ2lt2LKe2ayNPqpXdRXtuxdCQtpRyarsUlvWhH2qXpfSBaBNSGjA1N4bucfxTf8o/A5FFYhJdri0wmcyvTz3MCTBydC47rLAqpheC8dwJOI72re9DZzywP1o88Ud99fEHEfbXT7Zrp+VZIpXALZbeqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtKMDser; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtKMDser"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B451F000E9;
	Mon, 31 Aug 2026 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205614;
	bh=4uIN6dioUmlAEUyjrkI7d0TgMBo9zHi6OwDbMT4mFSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZtKMDserjcOqZ6QZXUc9HajxElI8pjkUPEjTeOcLl8uSjx7Jp2S4CpD4btlukQiN/
	 MN2Sw4cvqfLoEyB2tL6gOSrPbDUntdHc4EtpErWfERmUd+9zoI5pvoYuMgg6qd/rmr
	 AW54CpGSbICeiKY8EFTwql9LNgIZsAg8WsssR7LNyZDwkeqzK5YTrOxfpqtRTb9XSg
	 HCDxf7KEVGz+gT++9mroD0LVPe7sVJ0nWNHr0iYA7Bs2u/r0mzzUtCU+9exrEI9s4I
	 moySRFL8sXot/gCZNZcBBGk8lg0x7sHIqgq013xd6JPSP4ylfRL/7a4Dy7CO4UKh6Z
	 6VQgDzz3BVazg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/20] KVM: s390: arm64: Query Available Arm features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831145536.913567-12-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-12-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:46:53 +0000
Message-Id: <20260831194654.39B451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The EX_TABLE entry in the `qaaf` inline assembly incorrectly p=
laces the exception fixup label on the non-faulting `lhi` instruction inste=
ad of the potentially faulting `.insn` instruction, which will cause unhand=
led hardware exceptions to panic the kernel.
- [High] `aef_sysfs_init()` unconditionally calls `aef_init_save_area()`, f=
ailing to skip it when the AEF facility is not present, causing a crash on =
older hardware.
- [High] Off-by-two index error when accessing the QAAF registers array in =
`kvm_qaaf_read_ftr_reg()`, causing KVM to read incorrect memory offsets for=
 all features.
- [High] If QAAF initialization fails, the global capability flag `info.arm=
_guest_supp` is not cleared, leading KVM to initialize using uninitialized =
hardware capability data.
--

commit a7cb3705acf7ea96c94b5937368fbc6655fb99e7
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Query Available Arm features

This commit introduces the QAAF (Query Available Arm Features) instruction
support for s390 hosts. It allows KVM to query machine-supported ARM featur=
es
and provides an initialized save area for running ARM guests.

> diff --git a/arch/s390/include/asm/kvm_host_arm64_types.h b/arch/s390/inc=
lude/asm/kvm_host_arm64_types.h
> index 2c922ef478d13..93fd649a26f47 100644
> --- a/arch/s390/include/asm/kvm_host_arm64_types.h
> +++ b/arch/s390/include/asm/kvm_host_arm64_types.h
[ ... ]
> +/* QAAF Query Model Capabilities */
> +struct qaaf_qmc_block {
> +	u64	_0000;			/* 0x0000 */
> +	u8	ssdf;			/* 0x0008 */
> +	u8	_0009;			/* 0x0009 */
> +	u8	ssaf;			/* 0x000a */
> +	u8	_000b[3];		/* 0x000b */
> +	u16	maxncpu;		/* 0x000e */
> +	u64	regs[0x1fe];		/* 0x0010 */
> +} __aligned(PAGE_SIZE);

[ ... ]
> +enum {
> +	QAAF_REG_MIDR_EL1		=3D 0x02,
[ ... ]
> +};

[ ... ]
> diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
> index 6580536544eef..f88d15b8f1e90 100644
> --- a/arch/s390/include/asm/sae.h
> +++ b/arch/s390/include/asm/sae.h
[ ... ]
> +static __always_inline int qaaf(u64 gr0, union qaaf_block *qaaf_block)
> +{
> +	int exception =3D 1;
> +
> +	asm volatile(
> +		"	lgr	0,%[r0]\n"
> +		"	.insn	rre,0xb9ad0000,%[r1],0\n"
> +		"0:	lhi	%[exc],0\n"
> +		"1:\n"
> +		EX_TABLE(0b, 1b)
> +		: "=3Dm"(*qaaf_block), [exc] "+d"(exception)
> +		: [r1] "a"(qaaf_block), [r0] "d"(gr0)
> +		: "r0"
> +	);
> +
> +	return exception;
> +}
> +

[Severity: Critical]
Does the exception table entry point to the wrong instruction?=20

The EX_TABLE(0b, 1b) targets the `lhi` instruction at label `0:`, but the
instruction that would actually fault is the preceding `.insn` instruction.
If this executes on hardware without the AEF feature, won't this result in
an unhandled hardware exception and a kernel panic?

[ ... ]
> diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
> new file mode 100644
> index 0000000000000..825e2643a8921
> --- /dev/null
> +++ b/arch/s390/kernel/aef.c
[ ... ]
> +static int  __init aef_query_info(void)
> +{
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_KVM_S390_ARM64)) {
> +		info.sae_avail =3D sclp.has_aef;
> +		info.ptff_avail =3D ptff_query(PTFF_QAGTO) &&
> +				  ptff_query(PTFF_QAGPT);
> +		info.arm_guest_supp =3D info.sae_avail && info.ptff_avail;
> +	}
> +	if (!info.sae_avail)
> +		return 0;
> +
> +	ret =3D qaaf(QAAF_FC_QMC, (union qaaf_block *)&qmc);
> +	if (ret)
> +		return ret;

[Severity: High]
If the qaaf instruction fails and returns an error here, `info.arm_guest_su=
pp`
remains set to true.

Because aef_sysfs_init() is called via an arch_initcall, the initialization
failure is ultimately ignored by the kernel. Later, kvm_s390_arm64_init()
checks `aef_info()->arm_guest_supp` and will proceed to initialize KVM using
the uninitialized `qmc` block.

Should `info.arm_guest_supp` be cleared before returning when qaaf() fails?

[ ... ]
> +static int __init aef_sysfs_init(void)
> +{
> +	int rc =3D -ENOMEM;
> +
> +	if (!IS_ENABLED(CONFIG_KVM_S390_ARM64))
> +		return 0;
> +
> +	rc =3D aef_query_info();
> +	if (rc)
> +		return rc;
> +
> +	rc =3D aef_init_save_area();
> +	if (rc)
> +		return rc;

[Severity: High]
Will this execute the new qaaf instruction unconditionally on all hardware?

aef_query_info() correctly returns 0 if the AEF facility is absent (since
`info.sae_avail` would be false). However, aef_init_save_area() is called
immediately after without checking if the facility is actually supported.

Could this trigger an operation exception on older hardware?

[ ... ]
> diff --git a/arch/s390/kvm/arm64/qaaf.c b/arch/s390/kvm/arm64/qaaf.c
> new file mode 100644
> index 0000000000000..c3124d38afc23
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/qaaf.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/kvm_host.h>
> +#include <asm/aef.h>
> +#include "qaaf.h"
> +
> +#define _qaaf_reg_case(id) case SYS_##id: return aef_qmc()->regs[QAAF_RE=
G_##id]

[Severity: High]
Does this index into the regs array using the wrong offset?

Looking at struct qaaf_qmc_block in asm/kvm_host_arm64_types.h, the regs
array already starts at offset 0x0010:

    u64 regs[0x1fe];        /* 0x0010 */

However, the QAAF_REG_* enums represent the absolute doubleword offset from=
 the
start of the block (e.g., QAAF_REG_MIDR_EL1 is 0x02, which represents byte
offset 0x0010).

By using the enum to index into the regs array, doesn't this double-apply t=
he
0x0010 offset, causing KVM to read incorrect values for all feature registe=
rs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D11

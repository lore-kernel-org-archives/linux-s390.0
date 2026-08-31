Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2137AA7A;
	Mon, 31 Aug 2026 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207395; cv=none; b=FnrcHcK4ZPVus4CSEEkxcMCTuSx2lgxvKq4AfFKwNZF8p9X+Com/hYwx8JL/uLIO/ehTiXkqq049qV/8OfbwB42SmHW/A9+Gu3sivBwgUKU8VWZaBFish7b4I29498f5KU1zvFU30++lAaMw4FqFhCzatsK88oAoPSFnGUckWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207395; c=relaxed/simple;
	bh=JXsXJZ8LQZ9Fs9q6jR+/3kR0If99cdGhAhCAlYwfQMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CeTqmXXYolCU3av1aC4CxeNoDx/4oDxYUmfaMqtUry6Xj/E8f8DQJG1gPy94NmFHkwGttdmdblVdMjFKShD9CFv9GkELnB3VeCpBqlizlkc1nu3u30Bi6pvd4bQy8iKMFQraiKrYZmDqudh6NcxGiD2zOTI5NLrC3GXcKWquNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH0k1sXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH0k1sXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFB71F000E9;
	Mon, 31 Aug 2026 20:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207393;
	bh=eUhkw+2bFJnBzGDEI9QpdvTckvv136Nw8rEPnLSHIiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FH0k1sXrkj3P37fdpvNxOyGlhU0Hx5tHhGrE+FuS2BUJzXM+R4mHRSKoDAg+IPj+E
	 iPMf6DZi8iZ/5IfI+Pqrib3zI4LsaolfQsuaTm1G2K5MK5NjRNsa1NOLaAdEbKg5WJ
	 qWTwIMHu+hcHwUJaUzNwiv1S6ybLW/PvByLh6tP2GOLO2YcI5kcn6c9coUbVmFdrwv
	 FBW1Bkeexci7E6DP9SsJKUkPC270UZqMm8hoAe7IaWUxOP8ys04ub17Ab/xygrqvuk
	 TJxobQPeYs03gHhx0iyeSku1CjA1nwDSF7afX5gVvgAM+BKlI1K7zTbDlBWexjgiMK
	 VhjHDOgXUE+KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/23] KVM: s390: arm64: Introduce host definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831144802.834315-17-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-17-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:16:33 +0000
Message-Id: <20260831201633.7FFB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The vCPU Hypervisor Configuration Register is named `hcr_elz` inste=
ad of `hcr_el2`, introducing a confusing typo/naming anomaly.
--

commit 22fd1b09d8ddab9e5e022c14adc2bbf3373594b6
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Introduce host definitions

Add all basic definitions the arm on s390 KVM host requires. This includes
struct kvm*arch definitions, various functions, and macros to run arm64
guests, and updates asm/kvm_host.h to use the new header if KVM_S390_ARM64
is defined.

> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/a=
sm/kvm_host_arm64.h
> new file mode 100644
> index 0000000000000..b8a689c649bd8
> --- /dev/null
> +++ b/arch/s390/include/asm/kvm_host_arm64.h
[ ... ]
> @@ -0,0 +1,211 @@
[ ... ]
> +struct kvm_vcpu_arch {
> +	struct kvm_sae_block sae_block;
> +	struct kvm_sae_save_area save_area;
> +	struct kvm_cpu_context ctxt;
> +
> +	u32 host_acrs[NUM_ACRS];
> +
> +	/* Hypervisor Configuration Register */
> +	u64 hcr_elz;

[Severity: Low]
Is hcr_elz intended to be hcr_el2 here?

While this might be an intentional pun and does not break compilation=20
because shared ARM64 KVM logic compiled under ARM64_S390_COMMON does not=20
currently access vcpu->arch.hcr_el2, naming this register hcr_elz departs=20
from standard ARM64 architectural nomenclature.=20

Could this cause confusion for future development trying to match ARM64=20
architectural registers?

> +
> +	/* Configuration flags, set once and for all before the vcpu can run */
> +	u8 cflags;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D16

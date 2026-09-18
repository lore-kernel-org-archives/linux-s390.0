Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A435200A;
	Fri, 18 Sep 2026 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746625; cv=none; b=axFAyBpVT2hpjBHPNf1r85n0ueNXw/ds5U8+HRj8zdHQ/sYMW5l0LnFJJd9ZmwXv9xRusR+qxdjnq0bjcvAPV0iJ1wxYyH/KhUFwKGz9N6F8BT37vbvBOE9T8A6JQNmKjXvPUayR1/L8NkwZad5cIsS3lOUMtipcV5fVyhFetSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746625; c=relaxed/simple;
	bh=3pydJXIY6t+I/XfxRLCONssK3/5BuI74h/FogHWBZS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HqMnMWcHBeC/b53Y3kCy43iuGGnKRPPfgG87WDkc1USQ5sxfO9KnxEq5Z5mp3B4fNZQMGeSt2vbE7hLGUpEZ9LV6ovZush0SMnRaqNxXJdW0mEacxgm8vdLsdiZIeCpGSfW79eloJWltdcgDDlNaUPmdmvmu4BBasd2THXmDNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXvmXkRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXvmXkRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40151F000FF;
	Fri, 18 Sep 2026 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746624;
	bh=xRP/XXIBu2PhX3zWK2M82UVWtfYpK8lLARY3tJ1TmyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXvmXkRVU7LXbEHp1reV62bvKj0/utGHvxE4Yjnz0luD8NZZ++y7HunXKU3+7xLF1
	 5QtqwLZOmm8qFWum3oBiPdKGZwBXyb2JIzfnZNfpdFeZQEsMsnKOLc5gv/RPAW0sCh
	 CmGWZsNFuYlriPKDTenWw9iiv9oh8xlFzKvlbYtgJ8tf4J9mtibvTjklHDXIE3tk8o
	 vLqFcUXGWlTgC6331vB5bHJ1nkyWJhd09gbBa6KfdxetQg6rnygHZeZQyL1UzteKOD
	 N8K88ZBXab+GGyQAYyzjnZPoRb68/Deab0s7Q0+SWjt79Xqo5rSPFt4/tJhFYNod6W
	 k0ye4OVkUJSfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/29] arm64: Share arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260918133107.1042730-17-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-17-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:50:23 +0000
Message-Id: <20260918155023.F40151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: fragile cross-architecture coupling via text extraction
--

commit 7c91cae0fde64b5f320fb846c975eb58dd534362
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: Share arm64 headers with s390

This commit prepares arm64 headers to be shared with s390 by adding
ifdef markers and comments. A preprocessor symbol is added to the arm64
Makefile to keep the code active on arm64 while s390 can extract it.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6b005c8fef706..12cbad460258f 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -45,6 +45,11 @@ KBUILD_CFLAGS	+=3D $(CC_FLAGS_NO_FPU) \
>  KBUILD_CFLAGS	+=3D $(call cc-disable-warning, psabi)
>  KBUILD_AFLAGS	+=3D $(compat_vdso)
> =20
> +# Enable all code shared to s390
> +KBUILD_CFLAGS	+=3D -DARM64_S390_COMMON

[Severity: Low]
Does adding a global define purely to wrap code for an s390 extraction
script create a fragile build coupling? This couples the s390 build to=20
the exact formatting and macro placement in arm64 headers.

> +KBUILD_AFLAGS	+=3D -DARM64_S390_COMMON
> +KBUILD_CPPFLAGS	+=3D -DARM64_S390_COMMON
> +

[ ... ]

> diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/br=
k-imm.h
> index beb42c62b6acc..dd2d153dc0d81 100644
> --- a/arch/arm64/include/asm/brk-imm.h
> +++ b/arch/arm64/include/asm/brk-imm.h
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2012 ARM Ltd.
>   */
> +/* Whole file is shared with s390 */

[Severity: Low]
Is it robust to rely on an informal textual comment to drive cross-architec=
ture
sharing instead of moving the file to an architecture-neutral location like
asm-generic? Normal refactoring by arm64 maintainers could trivially break
the s390 build if they remove or modify these marker comments.

> =20
>  #ifndef __ASM_BRK_IMM_H
>  #define __ASM_BRK_IMM_H

[ ... ]

> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/as=
m/kvm_emulate.h
> index a34a9417ff4da..09f04a5686a18 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -47,6 +47,7 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
>  int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
>  int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
> =20
> +#ifdef ARM64_S390_COMMON
>  void kvm_inject_undefined(struct kvm_vcpu *vcpu);

[Severity: Low]
Could this genuinely shared component be factored into a common include
directory like include/kvm or include/linux instead of being spliced via
build-time regex parsing? Adding s390-specific extraction guards into
arm64 headers requires arm64 maintainers to accommodate s390 build scripts
when modifying ifdef boundaries.

>  void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);
>  int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D16

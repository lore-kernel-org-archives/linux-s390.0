Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5351AEC1;
	Fri, 18 Sep 2026 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755599; cv=none; b=uZ4gqk4hzLtt2Gxo24wpeR5Vwqtkx/zOHLpuUd4pXZpo1rrs6tlp0gCqZ3txszwuAMyUgxPvoHByaIRgRYfLIBL96vjnu6zZbiqiO3bf3Ak/AR6D18W0ACZgNgWOFe6pBSTlmqrXiZxykACRWtRc6mMWAnfXHy1G4ICTSy7+BYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755599; c=relaxed/simple;
	bh=2dKl2Ks9kaUzo1Ol4g2yAg1ZM79evmXhl4vh2ixXST0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AFyVVYbqYCsahvK97LWtwxIsur3LloRRWo0Nl/au4+zy9TMEZUsv3IzNMkjetz41OYI8et0R910rSin7Q2p/vPipV3vsEEou0WMP8uYn1aXaDyVpr0zzhVU/c9CXPxX5d9/80DpOMrvY0KRAH2cygNfSLbT3vnwkfGDCI9TL55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwDCB+VT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwDCB+VT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643671F000FF;
	Fri, 18 Sep 2026 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755598;
	bh=krBlm5UecImFXaj8qTF7VVyVleWMYC7KPUA5P4no+RQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SwDCB+VTPqYB4jteqrvvUdtTvR0PEwtNdNFgPfrHGuta71lYTNWAiyBFUeqo+N0F3
	 ZPfiQ6Yw8qj3Bww4gEK4IpJOvSskeAoj+ZbmoWP1Vr+J9Sn2lNsNUKpzDdwdp50I8h
	 Yg2DslrhyNUh8xkLU5vfD+6IruKdgjjg2rkugoAdXDVwFjgayzIEneaAaH7Ofn6j+t
	 l//YisGd5dwqn1c563EdK62tR4L8cjRKaaJQiNd0GENyUtxeR2eoQqdmfknOacHSq8
	 jtOb0fb7yv2xEWUhTss7S/fTK7YYNwXQj3OtrgZLHaLhqpstRYyIdDKK80yzxN/sHV
	 BHvnKk9iYUwmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 29/29] KVM: s390: Enforce no unexpected external
 symbol exports in s390 KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260918133107.1042730-30-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-30-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:19:56 +0000
Message-Id: <20260918181957.643671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Makefile: kvm_check_exports prints false-positive violations in err=
or log
--

commit 539bcae6d5e99f65300c56bf0e306743cc8f639c
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Enforce no unexpected external symbol exports in s390 KVM

Add a Makefile check to arch/s390/kvm that fails the build on any
EXPORT_SYMBOL_GPL or EXPORT_SYMBOL not in the allowed list. A symbol
may only use EXPORT_SYMBOL_GPL if it is defined in exactly one of the
two s390 KVM modules (kvm or kvm-arm64).

> diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
> index bd78d64939d1a..d84d3be74037d 100644
> --- a/arch/s390/kvm/arm64/Makefile
> +++ b/arch/s390/kvm/arm64/Makefile

[ ... ]

> @@ -91,3 +92,16 @@ targets +=3D kvm-unnamespaced.o kvm_symbol_list kvm-na=
mespaced.o
>  endif
> =20
>  obj-$(CONFIG_KVM) +=3D kvm-arm64.o
> +
> +# Fail the build if there is unexpected EXPORT_SYMBOL_GPL (or EXPORT_SYM=
BOL)
> +# usage in arm64 KVM code. A symbol may only use EXPORT_SYMBOL_GPL if it=
 is
> +# defined in exactly one of the two s390 KVM modules (kvm or kvm_arm64).=
 A
> +# symbol defined in both would cause a conflict during linking if builti=
n is
> +# selected. Catch the issue early.
> +
> +# This "symbol" is not exported by arm on s390 but still in the source c=
ode and the
> +# export check scans unexpanded source code.
> +kvm_exports_allowed :=3D kvm_file_to_kvm_fn
> +
> +$(eval $(call kvm_check_exports,EXPORT_SYMBOL_GPL))

[Severity: Low]
Will kvm_check_exports print false-positive violations in the error log her=
e?

While KVM_CHECK_EXPORT_DIRS is overridden in this Makefile to restrict the
export check to its own specific directories, __kvm_get_exports ignores this
customization and hardcodes the search path to:
$(srctree)/virt/kvm $(srctree)/arch/$(SRCARCH)/kvm

This search path covers the entire s390/kvm tree. If an unwanted export
triggers a build error in the arm64 module, the error message invoking
__kvm_get_exports will inadvertently list valid, allowed exports from the
s390 module as unwanted occurrences.

> +$(eval $(call kvm_check_exports,EXPORT_SYMBOL))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D29

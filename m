Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B986341;
	Wed, 12 Aug 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552041; cv=none; b=EAW8a1aRIasUYckS73xn6q2P8XxvfA23qA3o/wylvHReIMXxsCJye7PcZIdbNwEw5sU7nfeWFiinVKqPXOdlA2qwnVr/R1qNVsLaXDvdtV57tkUY1an8RabtGkTYuj70Mc9Tn2HhmGEgV22nNfAf9DXugHgBXblSchHnnWKfJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552041; c=relaxed/simple;
	bh=vQpSLFklztsXIzACp5l/NzVQqqC9Bg+xcL9sxMCY6Is=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0/ItUlli0cz1qBu7+86GALLeEGvenwfE3SgslQoNjIXHO0YIbXxcbizvPBGY46AJqbCyfIS1yAK/8+EBkjvxJj4oHZibVq8qkk6PjWSEv7HfQCjl1ltQvc0J3Q4G+lxTNNarPHLGUKywEzCyHAWSDb+SGnk7lH2kNTVdyNY68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF8WuTez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF8WuTez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE931F000E9;
	Wed, 12 Aug 2026 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552039;
	bh=RwM0+WViKuyQRQrItx1lD1tXwYTMLhAi72lTSuNoH2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iF8WuTezE9v2D7LHBypTUUInpr3zTNskyVpLHv7moBBiYQ09dd7y6t9q7UsOvYbjk
	 m5AODAVmAHFICcH+rA2gx9z5qwLZv8dNU6Qm6HuEHyeb0oHLcQZbQRU9zc7jKxVIPj
	 CJ0n3Sh0iQjAoNkz8I2VKIzDRoVE+DVxStJiaRP7Adap73CvW0pa1t637E1+gimhEt
	 Z4MojapFCi60jkwiKe70CSRFd5/d0Ti5ZNGsLAnP3z6oUtxXj6ijaLLjAbxn4bRAVV
	 x8CUBmclUV2+gjASHResDLbfq/JMEQ4GNy14QvV2GbN0cqlacSGxMSy+19AFKQb9/3
	 nZUItNQS3zrcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 26/33] KVM: s390: arm64: Introduce host definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-27-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-27-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:27:18 +0000
Message-Id: <20260812162719.4DE931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The vcpu flag wrapper macros (`_vcpu_get_flag`, `_vcpu_set_flag`, e=
tc.) are syntactically broken and will cause build failures if instantiated.
--

--- Patch [26]: [PATCH v6 26/33] KVM: s390: arm64: Introduce host definitio=
ns ---
commit 9d09eb59e082ce9c0d035d93867a0ac53fc503a3
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Introduce host definitions

This commit adds basic definitions required by the ARM on s390 KVM host.
It introduces struct kvm*arch definitions and various defines needed to
run arm64 guests, selecting the new header variant if KVM_S390_ARM64 is
defined.

> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/a=
sm/kvm_host_arm64.h
> new file mode 100644
> index 0000000000000..8088409bb0411
> --- /dev/null
> +++ b/arch/s390/include/asm/kvm_host_arm64.h

[ ... ]

> +#define _vcpu_get_flag(v, flagset, ...)	\
> +	__vcpu_get_flag(&(v)->arch.flagset, __VA_ARGS__)
> +#define _vcpu_set_flag(v, flagset, ...)	\
> +	__vcpu_set_flag(&(v)->arch.flagset, __VA_ARGS__)
> +#define _vcpu_clear_flag(v, flagset, ...)	\
> +	__vcpu_clear_flag(&(v)->arch.flagset, __VA_ARGS__)
> +#define _vcpu_test_and_clear_flag(v, flagset, ...)	\
> +	__vcpu_test_and_clear_flag(&(v)->arch.flagset, __VA_ARGS__)

[Severity: Low]
Will these wrapper macros cause a build failure when instantiated?

Looking at __vcpu_get_flag() and the related macros from the shared arm64
headers, they expect exactly four arguments: v, flagset, f, and m.=20

In these wrappers, we pass &(v)->arch.flagset as the first argument and
__VA_ARGS__ as the remaining arguments. Since standard flag constants usual=
ly
expand to two arguments (for example, BIT(0), BIT(0) for f and m), this
invocation only provides three arguments in total instead of the required f=
our.

Does this need an additional argument or a different macro structure to
resolve the arity mismatch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D26

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984287;
	b=p87GnCIwoblWd7kx46peizT8/5mnitTK47h8ak7s+NZ03pxxZYlOQcuw/6oApzpYrX32
	 aoV3EZcav4QEQLVz4gjCd1NuuznQfBy/q/20A0S1HZ5NJWQKDZ10RgkTvUPF2q6bfDgGH
	 ZPmWg9QkrbiFB6bn7kvYdyOq0XK+CJfHPUUuqWJ2V2gWEzSG5YSYajXib/Hz/Cun+OmHq
	 AJb03hg5pKPAdk0GLdnbutDZZ1JNEFS3hqlcn98Rj5DV4S2KGKe0t/7EHetYV4v+8Us/8
	 4OCSGN2EmAd3m/WGpJKfkluOvlZP8MhSCHMPhC78JyFBqH/T6lkcy/SCWcosCm/JQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=drIAGdN6syBZttzw4rRm9YSIRB8yXAVXMEUUr3NJrr0=;
	b=dQvjmwTJ/OyJRnPvdegjFDNXJnu4XbKB0oukvftS/cmnOn6+72Y1FxcXAOFN2QCvvXMx
	 62SEluFmKHkLr0ZzxFP4CIiicrTj/Cd060WaKq5mLLALD2c6wGgkk2DemJWkX3lowVbyx
	 rnSGgUg192ZjTmg+pEu/ZG0z99bm0m/R2FZLiTd/jzbxnGhiQaUbS7Tf5I3EPwCRthZkU
	 IUyguH7dNWKkXZN7mhDvFOqu3FkQmTWJAEin9X2/mwGSbi4kyNlxummqY0/Lzw3v2+6zm
	 k/kvEmnGKHsBW0eh2KUFghiD9F7OA6AYGJybdI588vSwuAVkX7PK63gmFM18QucK8Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHkLTiSX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F113606A32E;
	Fri,  6 Nov 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHkLTiSX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D021F008A2;
	Fri,  6 Nov 2026 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984287;
	bh=drIAGdN6syBZttzw4rRm9YSIRB8yXAVXMEUUr3NJrr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WHkLTiSX2k72ZGTjIUncGmqE/LpKbXAkpQkreRunHYfvBKSIB4ghJMQ8D9LNAxPgf
	 JQT5kfd/JVfmxzn0rXHetL8kD+e3AxHimuMUuJGE3c7VqmpgEzRIFKgBE7v8NRoDXy
	 EK06rozXsz9X36souXjs3fWyJll84Bq+lQEbNz3nO36BrTQ7zfrJCy1w0ugzzRt/JK
	 l2bb4n4P5cqvK37vIii9/KZTiQ6S9U5NUvHGHjvvJL+dg/MQpBe5nN9HFoRksBzG+W
	 OBdRgMlfbW6Q++pAF71DKoPjyCI2mLbtQE+ZpED1toRAf5Mqk01A2EtZ2quTOf0oQS
	 oLVW0ExqQa1zQ==
Message-ID: <sashiko-outbox-201877@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/23] arm64: Share system register related headers
 and functions with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-5-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-5-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:58:06 +0000
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
- [High] arm64: cache.h: -Wundef build failure in vdso32 on
  ARM64_S390_COMMON
--

commit fc7c54ef2eb921844dfa6922455b5c6e7c8095c4
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: Share system register related headers and functions with s390

This commit marks arm64 system register, CPU identification, exception
emulation, and mitigation definitions as shared with s390.

> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cach=
e.h
> index 10a7ffadee3da..ee3078c687687 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -8,6 +8,7 @@
>  #define L1_CACHE_SHIFT		(6)
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
> =20
> +#if ARM64_S390_COMMON =3D=3D 1
>  #define CLIDR_LOUU_SHIFT	27
>  #define CLIDR_LOC_SHIFT		24
>  #define CLIDR_LOUIS_SHIFT	21
> @@ -25,6 +26,8 @@
>  /* Ttypen, bits [2(n - 1) + 34 : 2(n - 1) + 33], for n =3D 1 to 7 */
>  #define CLIDR_TTYPE_SHIFT(level)	(2 * ((level) - 1) + CLIDR_EL1_Ttypen_S=
HIFT)
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */

[Severity: High]
Does evaluating ARM64_S390_COMMON outside the !defined(BUILD_VDSO) guard
break the 32-bit compat vDSO build with -Wundef?

arch/arm64/kernel/vdso32/Makefile sets VDSO_CPPFLAGS from scratch without
inheriting KBUILD_CPPFLAGS (where -DARM64_S390_COMMON=3D1 is defined) while
enabling -Wundef in VDSO_CFLAGS.  When arch/arm64/kernel/vdso32/vgettimeofd=
ay.c
includes asm/cache.h via vdso/datapage.h -> vdso/cache.h, ARM64_S390_COMMON
is undefined, causing a -Wundef warning and a build regression when
CONFIG_COMPAT_VDSO=3Dy and CONFIG_WERROR=3Dy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D5

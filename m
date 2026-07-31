Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC0288C96;
	Fri, 31 Jul 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506069; cv=none; b=ggKo3nNHd5m/jPmLVSBZJ5AKP3jZC2n5+/J76p5veDhbyaBy/K5vnmEWKoDB9ijIo94KrLIAEs2akT8UpZhLNDNJdYURaerARzb2c6gvdDpQDBvQCmNCTGubu+7rPFQ8fXHss+/EC38BTIrhf2JBw6YJrhbShcIB78wXlX0nHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506069; c=relaxed/simple;
	bh=mX3Cdnfv/EmbroFH8cv+AoKiuJJHpw8mx7XJz4b2xAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QdtulIA08d1m4hwWJwH3y8QdhAaN7eF+XF0ecBLYl42H1FQHd1LsqDX/CxnZ+2yGbyHSvYPOQ+YldRdWVTm7GfNfZp63BK2r3scJxdz8wNbwu5AQ+1MNVJJ2DkyX22Uyd0c+fh2JcXeKWlLwLZBtalA5P6S88bcrLkPW+rzV1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESgRGFAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESgRGFAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF21F000E9;
	Fri, 31 Jul 2026 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506068;
	bh=gz62H9ecNuH3BZkezeGKJSB7C9m5LWqy9Gv2RV3Ph1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESgRGFAkmom1COrjpJXq4uYwT0L8WEyGykQ5Pa8R8pYA3F9WADBrA9yJurbbC3064
	 LrNZ2ANYm8rz5H7b+AaVZbmXQ0TdOhr0SmyG5eDOkD2iMO3vrCFGn9WQeiX8iWSyQD
	 32LDCCnQYzchl5U5uKGEBmy64OlpQlwSgPG/vqHpPHeZevX8MOk8CXEXbc+bNPFaG8
	 pqb2nMg0L5zaBNg5I2AODvfgD97T0XJLAwxiFoG3+0bQz0WXpcbU4XSxIXTHm4IUnK
	 5M3jyVdXm5Pg8yiq2jXScDLBMx76YkcW5fHdE3hnTLXG4CvmGDCmNDxg5V9duYOD9N
	 WZSUhuKGyu3zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/31] s390: Use arm64 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260731130902.654679-22-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-22-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:54:27 +0000
Message-Id: <20260731135428.35FF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] ARM64 headers are extracted unconditionally on s390 because they=
 are explicitly listed as a dependency in the `kapi` target, and the condit=
ional assignment uses the wrong Kconfig variable.
- [Low] The generated ARM64 headers are written to a path with a duplicated=
 `$(objtree)` prefix, which causes them to be placed in an incorrect nested=
 directory during out-of-tree builds and silently breaks Kbuild dependency =
tracking.
- [Low] Using AWK scripts to parse C headers and extract snippets based on =
s390-specific markers (`ARM64_S390_COMMON`) inside ARM64 architectural head=
ers is a brittle design pattern.
--

--- Patch [21]: [PATCH v5 21/31] s390: Use arm64 headers ---
commit 0aa161b5c002de946626485d254baf5277503c38
Author: Steffen Eiden <seiden@linux.ibm.com>
s390: Use arm64 headers

This commit introduces a system for sharing ARM64 headers with s390 KVM.
It uses awk scripts to extract marked sections from arm64 headers and
integrates this into the s390 build process.

> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index f2862364fb422..3e0f21b552daf 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
[ ... ]
> @@ -3,12 +3,20 @@
>  # Makefile for s390 specific build tools
>  #
> =20
> +include $(srctree)/arch/s390/tools/Makefile.arm64h
> +
>  kapi :=3D arch/$(ARCH)/include/generated/asm
>  kapi-hdrs-y :=3D $(kapi)/facility-defs.h $(kapi)/dis-defs.h
> =20
> +targets +=3D $(addprefix ../../../,$(kapi-hdrs-y))
> +# Convert ARM64 absolute paths to relative before Kbuild adds $(obj)/ pr=
efix
> +targets +=3D $(patsubst $(objtree)/%,../../../%,$(ARM64_TARGETS))
> +
> +kapi-hdrs-$(CONFIG_KVM_ARM64) +=3D $(ARM64_TARGETS)
> =20
>  PHONY +=3D kapi
> =20
> -kapi:	$(kapi-hdrs-y)
> +kapi:	$(kapi-hdrs-y) $(ARM64_TARGETS)

[Severity: Medium]
The commit message mentions this should be conditional on CONFIG_KVM_S390_A=
RM64,
but the code uses CONFIG_KVM_ARM64 instead.=20

Additionally, since $(ARM64_TARGETS) is added directly as an unconditional
dependency to the kapi target here, does this mean the headers will be
extracted unconditionally on every s390 build regardless of the Kconfig val=
ue?

> diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.a=
rm64h
> new file mode 100644
> index 0000000000000..8fbd9cb486952
> --- /dev/null
> +++ b/arch/s390/tools/Makefile.arm64h
[ ... ]
> +arm64api :=3D $(objtree)/arch/$(ARCH)/include/generated/arm64
> +arm64uapi :=3D $(objtree)/arch/$(ARCH)/include/generated/uapi/arm64
[ ... ]
> +arm64-src =3D $(srctree)/arch/arm64/include/$(if $(filter uapi,$(call ar=
m64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1))
> +arm64-dst =3D $(objtree)/$(if $(filter uapi,$(call arm64-type,$(1))),$(a=
rm64uapi),$(arm64api))/$(call arm64-base,$(1))

[Severity: Low]
Does this result in a duplicated $(objtree) prefix? The arm64api and arm64u=
api
variables defined earlier already contain $(objtree)/, so prepending it aga=
in
here could cause Kbuild to generate files in a malformed path like
$(objtree)/$(objtree)/... during out-of-tree builds and break dependency
tracking.

[ ... ]
> +quiet_cmd_gen_sysreg_arm64 =3D GEN     $@
> +      cmd_gen_sysreg_arm64 =3D mkdir -p $(dir $@); $(AWK) -f $(srctree)/=
arch/arm64/tools/gen-sysreg.awk $(srctree)/arch/arm64/tools/sysreg > $@

[Severity: Low]
This invokes an ARM64 internal build script directly from the s390 Makefile.
Could this tight coupling cause the s390 build to break silently if the ARM=
64
generator scripts are refactored?

> diff --git a/arch/s390/tools/copy-arm64h.awk b/arch/s390/tools/copy-arm64=
h.awk
> new file mode 100644
> index 0000000000000..d74df368c1b57
> --- /dev/null
> +++ b/arch/s390/tools/copy-arm64h.awk
[ ... ]
> +BEGIN {
> +	# Constants
> +	start_pattern =3D "^#ifdef ARM64_S390_COMMON$"

[Severity: Low]
Relying on rigid regex patterns to extract C code blocks and forcing
s390-specific markers into ARM64 headers appears brittle. Could minor
whitespace changes or formatting updates in the ARM64 headers break this
parsing pattern?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D21

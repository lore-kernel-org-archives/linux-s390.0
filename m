Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BC37F727;
	Wed, 12 Aug 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551500; cv=none; b=ChV+IDrwEneVUzKa81Js4zfPBflhlK25GHKjCDL/9rpzPy/+AqbP4LCYc5ey5wVXLpAukxdwRAzKcv1y9ajxBupVmwvNn7byASE1j+845/8Mlpos16uu4WhDljN2UvdJI4lZoT5a8e1YSsRgymkwv0h0vIb9angi3VnrhPSQi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551500; c=relaxed/simple;
	bh=nYKgVA5A1rqc1nNrsIP3u+/YerhaskZ7UmGRk4r4LYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FC5x9G99yuCluiGZPRslRn7BeVJrYUKGqAnL3D6BT/NYOzqf8zx+/ZRbtdKJAf+5jwSx+20npPJj6ISLoUnSGNKIY0CHx073zkSw5+HG1IOFtiV++2A9bYXCse07/nATskjjmtg/8CPgyq7/RwN68EQiuosFofxTOU/qhbNTRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5KgHVi7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5KgHVi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D7E1F000E9;
	Wed, 12 Aug 2026 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551498;
	bh=ESfw2QzgKzCZ2j2JTyBZ8NtahcFfnwcrDuY2DBfKptY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5KgHVi7t5HH63bzKhzoDFHXfnpns+ENdtyhpWhWH/nbZLXmC7egjILOqgfA7bH9X
	 VSArfiL2wbJGH4fXFyhjOpD1Rczc57S06SZmm3PoKfj+99s7JPaxZZ0a3bQPecXXzG
	 3Xxqpsy7oYi/gbCcnaoLDeNjIEYcWoVcWq9BDaObqj0ZUPVwrZlvOzUgIgkH8q9wqj
	 EODYyqGeJfpTpg/O+jfa5SFLdDtS9X+T6UlpyDN+0+PfPNfOdWnCzXChNN2UnqWSpd
	 +M5k0tSNsvQE0Bmm2WEiCCevhuyvJVCa05sR8Z4+bu9zgC5FodqoJsfoERdlHyYeQX
	 Ded0xmSo9d+EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/33] KVM: s390: Use arm64 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org
In-Reply-To: <20260812153631.3376090-25-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-25-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:18:17 +0000
Message-Id: <20260812161818.27D7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Potential Makefile syntax error due to an incorrectly named variabl=
e `kvm-arm64-obj`.
--

--- Patch [24]: [PATCH v6 24/33] KVM: s390: Use arm64 code ---
commit e4207bffe34b1de1b2b51c1d13254c153e76c1b6
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Use arm64 code

This commit adds the infrastructure to extract KVM/arm64 code into s390 at =
build
time. It introduces an awk script to extract marked sections into .inc files
and a Makefile.gen to generate these dependencies. A guard macro is also
included in the generated files to prevent accidental double consumption.

> diff --git a/arch/s390/kvm/arm64/Makefile.gen b/arch/s390/kvm/arm64/Makef=
ile.gen
> new file mode 100644
> index 0000000000000..cb9482eb947b9
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/Makefile.gen
> @@ -0,0 +1,29 @@
[ ... ]
> +ARM64_INC_FILES :=3D $(foreach cfile,$(ARM64_CFILES),generated/$(basenam=
e $(cfile)).inc)
> +
> +targets +=3D $(ARM64_INC_FILES)
> +clean-files +=3D generated/*.inc
> +
> +$(addprefix $(obj)/,$(kvm-arm64-obj)): $(addprefix $(obj)/,$(ARM64_INC_F=
ILES))
                        ^^^^^^^^^^^^^

[Severity: Low]
Will this result in a fatal make syntax error if the Makefile is included?

The variable kvm-arm64-obj is used here to declare dependencies, but it does
not appear to be defined anywhere in the tree. If this evaluates to an empty
string, the addprefix function will return empty on the left side of the
colon, breaking make with a missing rule before recipe error.

Should this variable be defined before use, or was a different variable name
intended?

> +
> +$(foreach cfile,$(basename $(ARM64_CFILES)),\
> +	$(eval $(obj)/$(cfile).o: $(obj)/generated/$(cfile).inc))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D24

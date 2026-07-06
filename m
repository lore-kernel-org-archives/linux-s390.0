Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E336F42B;
	Mon,  6 Jul 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330306; cv=none; b=iyL02eXR/ASFVqCxth7GtaJtjo5CCdNdwUsoS3sTuU9TjN8ekdRnzYLITfMUZ/79wiqldfPojXd2BAEBprNKzHGqbbrpl/bG9B0Tqpcu66m9fLcZFZ2xioQebZ6RWPIXGvYM/RYxskXs396+aBdVkaGgZmydQrkJffZ0pFrCTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330306; c=relaxed/simple;
	bh=VUrPPe16q8B1BGJJDCBjfH2ieY9dRJYGDCRIOoR+DAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hEryQfreXijLfiXsKr37wpRMFq2zTqrdxXFppdCxNW3fABY3u5Pvk01156qJc8JbUNTLQVcsM5phPWJqHpzEfb4vorxbbDc6cyBnulYwRI8blqGJ7ZBLwz/fw9t3GD+ngCdGPS1R7Az+pPfoQ4tVQCNxK46Odfpg99RpvYsTvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLhDWNOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLhDWNOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9700C1F000E9;
	Mon,  6 Jul 2026 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330301;
	bh=6D0PywIxNmLYs2d1cm0thC1XJs6vlKqoQ1kOrHVoU1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kLhDWNOzPnQFGXePLFeRD0yDmBCWCjpIXbZYS8sofQUtVlC0xq219PTyssZRVomY8
	 shqfbykGmjU/F5e9orasZiW7Af7DluZ5Rdl+bUZZZaHHCoqRBe5QPeDk93/xcAdfIg
	 JZHqH1If39k3ZexU4rHWC58jK5mLAHglOW3zkFj8FHx+BZYMkLh5UM7wVp/fMbDxCy
	 vLIKyAyy7nseNjoXFZHP0h1T4xgUeoyUJappoYRFJZMfKYkxf/WSsR7Pt5FTh1Pnzo
	 TAV5UiV9f0ccjx2ACzWtC1Zaz3blaKP8fJO4Qra14Xon2qMIa1N6IeoyWYiTLbbMsz
	 +i5MbnE57x1YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/27] s390: Use arm64 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260706085229.979525-12-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-12-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:31:38 +0000
Message-Id: <20260706093139.9700C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Double `$(objtree)` prefix in `arm64-dst` causes out-of-tree build=
s to fail.
- [Medium] The `sysreg-defs.h` target will be unnecessarily rebuilt on ever=
y `make` invocation during out-of-tree builds due to a `targets` array mism=
atch.
- [Low] The include guard regex in `copy-arm64h-full.awk` fails to match st=
andard ARM64 KVM headers that contain numbers.
- [Low] The commit message incorrectly states that included headers are rew=
ritten to `#include <arm64/asm/...>`, but the implementation correctly rewr=
ites them to `#include <arm64/...>` instead.
--

commit 622a9e9498e4f7fc1aed85088dd8016c40e7fc8b
Author: Steffen Eiden <seiden@linux.ibm.com>

s390: Use arm64 headers

Introduce a flexible system for sharing ARM64 headers with s390 KVM.
Selected arm64 headers or snippet of headers will be reachable by s390
code through asm/header.h.

> Transform copied includes by replacing '#include <asm/...>' with
> '#include <arm64/asm/...>' and similar for uapi headers to ensure
> correct path resolution on s390 and allow for a clear separation of s390

[Severity: Low]
This isn't a bug, but the commit message states the headers are rewritten to
'#include <arm64/asm/...>', while the awk scripts in this patch correctly
rewrite them to '#include <arm64/...>' without the 'asm/' component.

> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index f2862364fb422..bd2a00d5ce2c9 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
[ ... ]
> @@ -3,8 +3,13 @@
>  # Makefile for s390 specific build tools
>  #
> =20
> +include $(srctree)/arch/s390/tools/Makefile.arm64h
> +
>  kapi :=3D arch/$(ARCH)/include/generated/asm
>  kapi-hdrs-y :=3D $(kapi)/facility-defs.h $(kapi)/dis-defs.h
> +kapi-hdrs-$(CONFIG_KVM_ARM64) +=3D $(ARM64_TARGETS)
> +
> +targets +=3D $(addprefix ../../../,$(kapi-hdrs-y))

[Severity: Medium]
Will this unnecessarily rebuild sysreg-defs.h on every make invocation duri=
ng
out-of-tree builds?

In Makefile.arm64h, sysreg-defs.h is added to ARM64_TARGETS using an absolu=
te
path because arm64api includes $(objtree).

Then here, it gets appended to the targets array with a relative directory
traversal using $(addprefix ../../../,$(kapi-hdrs-y)).

Prepending a relative traversal to an absolute path
(like ../../..//build_dir/...) creates a malformed path. This prevents Kbui=
ld
from locating the .cmd file and breaks the if_changed cache.

> diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.a=
rm64h
> new file mode 100644
> index 0000000000000..0b32c124707d9
> --- /dev/null
> +++ b/arch/s390/tools/Makefile.arm64h
> @@ -0,0 +1,58 @@
[ ... ]
> +arm64api :=3D $(objtree)/arch/$(ARCH)/include/generated/arm64
> +arm64uapi :=3D $(objtree)/arch/$(ARCH)/include/generated/uapi/arm64
[ ... ]
> +arm64-src =3D $(srctree)/arch/arm64/include/$(if $(filter uapi,$(call ar=
m64-type,$(1))),uapi/)asm/$(call arm64-src-base,$(1))
> +arm64-dst =3D $(objtree)/$(if $(filter uapi,$(call arm64-type,$(1))),$(a=
rm64uapi),$(arm64api))/$(call arm64-base,$(1))

[Severity: High]
Does this double prefix of $(objtree) break out-of-tree builds?

Since arm64api and arm64uapi are defined above with the $(objtree) prefix
already, arm64-dst prepends $(objtree)/ to them again.

This causes paths to resolve to a nested build_dir/build_dir/... structure
during out-of-tree compilation.

> diff --git a/arch/s390/tools/copy-arm64h-full.awk b/arch/s390/tools/copy-=
arm64h-full.awk
> new file mode 100644
> index 0000000000000..a9b85b347f780
> --- /dev/null
> +++ b/arch/s390/tools/copy-arm64h-full.awk
> @@ -0,0 +1,43 @@
[ ... ]
> +# Find and process the include guard in the first few lines
> +NR <=3D max_guard_line && !guard_found && /^#ifndef [A-Z_]+$/ {

[Severity: Low]
Does this strict regex fail to match include guards containing numbers?

For standard ARM64 KVM headers that contain numbers in their guards
(e.g., __ARM64_KVM_ARM_H__), this fails to match.

This silently omits the 'This header was copied from...' preamble in the
generated files.

> +	guard_name =3D $2
> +	guard_found =3D 1
> +	print "/* This header was copied from " srcfile " */"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D11

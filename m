Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1E38B7D4;
	Wed, 12 Aug 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551790; cv=none; b=OesHc10F0YLkwfSS3wV/Rq3La/MgLBCpfTPmPQkCoX8hfrjR9rVigd3YETKsB/okwcU3zfVwndVydpcPJMJ/R/eQZ2new+nHE7Z53jLv5oqUs+iwGip9LN8m+GG0/RPGci6vObp2XvnlZ0hOXu9PDHg+IKFPOrlVc4mmDI2JiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551790; c=relaxed/simple;
	bh=6GCoAqRbWhtlUXL2rzIyGDpxGYH7lLt29p/M4CltXXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TLHGk8O7rWwevs4LgTtj5y7VvtltZa9uL/74UeLezKNYXhuuVS8ghXhbqMxUsHWYFLmXwGHuE0B+nL7L5KNoOrpNfcKwC57A2669JTcpXEhABrSPTk2dmBiiX4GZaoQ8QgrHrn8oWb8qLju41cF115ZzjalUlyn/k+OvW/ogfrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASAjg6GK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASAjg6GK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867BF1F000E9;
	Wed, 12 Aug 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551789;
	bh=ZQlB65IJN8Vjj7WURMNIfDf0nshW3740sPSTWjufRLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASAjg6GKwIhDGJXMDFr1LEwzOKBXA2ss6m61ytJsjIygmQCL9MI2+MzUS7E3ln5Oa
	 fAiWj2OB/V3r2AmJqVCK6UaFNlXXcTymC9cFe+iGianKBAQcjVrfkolA/3/9ANkiez
	 WRJo4Iarl7EZIrQOttxGT4WSzkHK5A+E8NkPGDymZDHJvkJOJEfZvtLifa4OWQUM6C
	 baMuk+Hsk6L4IFRHPZTrlAEsm7kIz8xVKLHzLNCjG+9MQxZ5VbbaID+KhaIfTK45N5
	 OcpaLAGBowibZYe2jHnRHsZW2QQ/NugrqafLyKbjWXt6XIroMAQ8vHaN6/4c/PknWW
	 s+zxzPQ7utSow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/33] s390: Use arm64 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-24-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-24-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:23:08 +0000
Message-Id: <20260812162308.867BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The header sharing mechanism generates sysreg-gen.h instead of sysr=
eg.h, causing unresolved includes. esr.h is fully copied since it has no AR=
M64_S390_COMMON markers, meaning its `#include <asm/sysreg.h>` is retained =
and transformed to `#include <arm64/sysreg.h>`. However, because sysreg.h i=
s mapped to sysreg-gen.h in ARM64_SHARED_HEADERS, the target file is genera=
ted as arm64/sysreg-gen.h. As a result, the include in esr.h will fail to f=
ind arm64/sysreg.h.
- [Low] The Make rule for generating $(ARM64_TARGETS) uses `$(call cmd,gen_=
arm_hdr)` without `if_changed` or `FORCE`. In Kbuild, files added to `targe=
ts` must be generated using `if_changed` so that `.cmd` files are created t=
o track command-line modifications. The omission of `if_changed` defeats th=
is dependency tracking.
--

--- Patch [23]: [PATCH v6 23/33] s390: Use arm64 headers ---
commit 505a7f9c35b46d1872a2e9da2ab63e0bc5a7471f
Author: Steffen Eiden <seiden@linux.ibm.com>
s390: Use arm64 headers

This commit introduces a flexible system for sharing ARM64 headers with
s390 KVM. It adds awk scripts to extract marked sections or copy full files,
and transforms includes to ensure correct path resolution on s390.

> diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.a=
rm64h
> new file mode 100644
> index 0000000000000..3e033630470a1
> --- /dev/null
> +++ b/arch/s390/tools/Makefile.arm64h
> @@ -0,0 +1,57 @@

[ ... ]

> +ARM64_SHARED_HEADERS :=3D \
> +	brk-imm.h \
> +	esr.h \
> +	kvm_arm.h \
> +	kvm_emulate-gen.h \
> +	kvm_host.h \
> +	ptrace-gen.h \
> +	sysreg-gen.h \

[Severity: Low]
Will this result in an unresolved include when esr.h is compiled?

esr.h has no ARM64_S390_COMMON markers, so it is fully copied using
copy-arm64h-full.awk. That script transforms #include <asm/sysreg.h> into
#include <arm64/sysreg.h>. However, since ARM64_SHARED_HEADERS maps
sysreg.h to sysreg-gen.h, the generated file will be arm64/sysreg-gen.h,
and the include in esr.h will fail to find arm64/sysreg.h.

[ ... ]

> +ARM64_TARGETS :=3D $(sort $(foreach hdr,$(ARM64_SHARED_HEADERS),$(call a=
rm64-dst,$(hdr))))
> +
> +$(ARM64_TARGETS):
> +	$(call cmd,gen_arm_hdr)

[Severity: Low]
Should this use if_changed and FORCE instead of directly calling cmd?

In Kbuild, files added to targets must be generated using if_changed so that
.cmd files are created to track command-line modifications. Omitting
if_changed here prevents automatic rebuilds if the command-line arguments
or rules change.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D23

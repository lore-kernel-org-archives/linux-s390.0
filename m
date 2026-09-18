Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B15172C2;
	Fri, 18 Sep 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748090; cv=none; b=hl9DfQD35fxxFBdpWjnm51cTwhMr4lFlxswFKs+Cu+wSQdiIUwcmkUVGb9lOz5dB/i9hsAAOVNnrbL5X+GiJLKnUcY81w6SQCHNjTdM1BR+xfED71pLY5oqDn7Ty83YvPPHdJf/j9bL7e54QUhRLGmW4Fcv9SZHa1FBHnMO+oxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748090; c=relaxed/simple;
	bh=l9nYo3fnLVcP3EfwMY2HprXsggbhOGLXy3Rp82L/0ng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shUdXpAdW8vZiqrIT9mFggmRb6I/awHiDTiNHymv7DLqS8a0orP1ncJZtSlPJdXhfd2wcIMlxzUjy3HHrY7E51Kyt4NKx5gkUJsW2G2DhNxuCc+7KhAQgxQ+l8RhM8CB0KBJx5Yc0MukC+s7BlirW8ZoPXRDk5ODhPrJErC6fkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8cf7bZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8cf7bZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B61C1F0089A;
	Fri, 18 Sep 2026 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748089;
	bh=OIio10vJFuWpSQCOrKEwPrmMGhRjb55Qi4/sWOshmbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8cf7bZbFSdo6H80Fsnx77yNEQxSTpwZSx05d3kPyzIaXh5cCPUUOQohxb4kdwl2X
	 vV4FhquCU/ZN2Z4zv1V7QY9N4N8lJFDs+ddxLR8tPVHPqIEt1cFWHuc/oWDd0mqdpK
	 DCbu+zjp2n9GrWLRpIB1MVyTi4Pe8LyucixB0evn0KhMF+5uq7bRvHjETlPXzO4JyE
	 JtkKl5wNX/1unBLmziQuoA0XZDTDq+VVgGjoZaHdAAjCmZNBn2/s58dG/4YbGmgyeH
	 MgB34uc1rO+tFXp7K2fmPE7sDMokIOZwMU3CVoM5QtG6HpLZjVdvd3kwxh2TmC/2XJ
	 pCgPUx8NLImCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/29] KVM: s390: Use arm64 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-20-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-20-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:14:48 +0000
Message-Id: <20260918161448.9B61C1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] build: cross-arch C code extraction via awk breaks tooling and m=
odularity
--

commit e83a74be06a131ec905dd0c83821e6279b998572
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Use arm64 code

This commit introduces build infrastructure to extract marked sections
from ARM64 C files into generated .inc files for use in the s390 KVM
host code. It adds the copy-arm64c.awk script that searches for
ARM64_S390_COMMON markers and copies the matched code verbatim.

> diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/co=
py-arm64c.awk
> new file mode 100644
> index 0000000000000..5561619aa70c8
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/copy-arm64c.awk
> @@ -0,0 +1,72 @@
[ ... ]
> +BEGIN {
> +	# Constants
> +	start_pattern =3D "^#ifdef ARM64_S390_COMMON$"
> +	end_pattern =3D "^#endif /\\* ARM64_S390_COMMON \\*/$"

[Severity: Medium]
Does tightly coupling the s390 build to the exact source code formatting
in the arm64 tree present a maintenance burden?

Sharing architecture code via text extraction of C files violates kernel
modularity principles. It imposes a burden on ARM64 maintainers who must
now preserve s390-specific markers (ARM64_S390_COMMON) and formatting.
The established Linux kernel paradigm for cross-architecture code sharing
is to abstract common logic into standalone .c files in a shared
location (e.g., virt/kvm/).

[ ... ]
> +copying {
> +	gsub(/#include <asm\//, "#include <arm64/")
> +	gsub(/#include <uapi\/asm\//, "#include <uapi/arm64/")
> +	print
> +	next
> +}

[Severity: Medium]
Does copying C source code into a new file without emitting C preprocessor
#line directives break standard developer tooling?

Without #line directives, compiler errors, warnings, and debugger (GDB)
symbols will map to the generated .inc files instead of the original
arch/arm64 source, degrading debuggability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D19

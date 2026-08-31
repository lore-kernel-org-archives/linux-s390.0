Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052A380FF2;
	Mon, 31 Aug 2026 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204372; cv=none; b=FiYkTcZ7h/h6RBiY9Z8TvUCyqoi84JN7fteYS4bs9yePlId0e8/+RI5vJGhQJS9t5EtGA0Vmnw79/zGBbI+6dRRCZwQT5Yg2K1VYevXgKEIMrJ+nL0FjhdJ2XeEQhK+SFBlc7w0Y3dAPEi7TEqJ7951WP2sBNucnZ+m8krHWVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204372; c=relaxed/simple;
	bh=vpFDkR3fb1dD1pbqPUxyj0trnsrVSvrPniuibQ1Jex0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzJONQSlqPVcSFvBHB+pY1C2uAXSwObISIgdGyMIO+bfonIrzhhX+9F0+8Ja92trcnUqQB8rdQQRLz7SRgIRzDp4LVXwS+ma7N6wPs7z3osTYjj7VvCXQGrDDPUv5bhv+zcGW7RFagRlCNudaRgHXgJxnl8GmtsWuay/54ZupPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhKGHt+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhKGHt+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB261F00ADB;
	Mon, 31 Aug 2026 19:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788204370;
	bh=J2egU+Ub9yt8NWQcz8CrB2uyYyB/k0bPFwVHdOLvfR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZhKGHt+mLDWeTj2JOa+DsU9ZFgNEWGltKnqVXLEjtQ6F5P3c1JUeeZCrq3IGm0gg2
	 S8UFK4Fl0lx16hy9YZ4Sk+0PCZuUhJw93QHe5xTh0iagXZkVUBeZfWBn3Y9edh2kj/
	 6yxOXC0WO9x1ZheGn7Qp6UEvZAOCfZxknr/w/ff+rD27bGSwESeNKdmz683VaCCDYp
	 kMfrPFQacqxPAcZupPQuTBBE1bTef1xrd3DBvbvfCM87t5UBYPiIqJEoH7V/3fYj9h
	 QUOHyxAPh/a2I0Q0cWWZN1HiYmTF3mcG2zj+bC2xRK4SybfxPydwcllkDLu/OwHd2Z
	 FdZFB1hZJ+pXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/23] KVM: s390: Use arm64 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev
In-Reply-To: <20260831144802.834315-14-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:26:10 +0000
Message-Id: <20260831192610.7CB261F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The AWK extraction script silently suppresses errors for unbalan=
ced end markers if a valid block was already processed, potentially leading=
 to silently dropped code.
--

commit 695b985ed66a46463a7810ac95a1f61e48477f7a
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Use arm64 code

This commit adds infrastructure to extract KVM/arm64 code into s390 at build
time. It introduces copy-arm64c.awk to detect ARM64_S390_COMMON markers and
extract marked sections into .inc files.

> diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/co=
py-arm64c.awk
> new file mode 100644
> index 0000000000000..20bd73c52ec48
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/copy-arm64c.awk
[ ... ]
> +$0 ~ end_pattern {
> +	if (!copying) { exit 1 }
> +	copying =3D 0
> +	next
> +}
[ ... ]
> +END {
> +	exit !found_marker || copying
> +}

[Severity: Medium]
Does the END block unintentionally suppress errors from unbalanced end mark=
ers?

If a source file contains a valid ARM64_S390_COMMON block, found_marker
becomes 1 and copying becomes 0 after it finishes. If an extra, unbalanced =
end
marker is encountered later in the file, the end_pattern block evaluates
if (!copying) and calls exit 1.

However, when exit 1 is called, awk proceeds to the END block. Since
found_marker is 1 and copying is 0, the expression !found_marker || copying
evaluates to 0. This causes the script to override the exit 1 with an exit =
0,
silently returning success and stopping file processing instead of failing =
the
build.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D13

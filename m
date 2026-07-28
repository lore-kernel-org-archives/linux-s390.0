Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5618A6CF
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217018; cv=none; b=Btm1OzC49yKAWJNEFAZlergWHE7pyJA9ADd0DpDKi2Wh4KIqrvd3bnfYZ0p4ei1s3zX96TmFhfRnBSaJEqcq1VGLh3VervX6rRfuh/L2HTMSsM+4uVG1fLM3EcE83IKQiDM6s6hRiVIlt0hG4GhXQSG/dMray5DcV0rYsxX2g5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217018; c=relaxed/simple;
	bh=o5FtbMXMif9Pl2FcLjsDzOVyrLMGZTv8qmxItUj1ZiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k71U4IjC4Lq07kZL3Xpx08cV10AqXFnbS+o5WYjOijBesEz5Irz5BTCB/YLapAgRNDuBQsBupAEzmeRKEkWKnWSfsLVmMsks1Ia9jWxuy90RBOD0NUFBD9rPBAei+39Le65KshamP3eiynMsVCyP1OnEXJtosQqptjpmBknK6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPhwTbnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPhwTbnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00441F000E9;
	Tue, 28 Jul 2026 05:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785217016;
	bh=o5FtbMXMif9Pl2FcLjsDzOVyrLMGZTv8qmxItUj1ZiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QPhwTbnkfR8P0CRvwrJkvF+fVbtOVnJNO3wnOy5MaZRddFGT7w5qdQ/ZIU4/F7X2i
	 PPjrMJxr3v4lhlGswL+ANnTk6o3poCs7PQbhhtZAUvKLLqM5gd31evIZRLYPCKJVfL
	 3hs+Ikex+BoUpA2HTqyVohlIYbd4jB2N8v9IPjxFNYOqj0cCJgOIcJs45EXN97sQln
	 UsRDcy4uZdeKMWzmx4bUjhJZyvZYcTuBWHJwGmQnd35AzSPHYhHVZ8bwMQavPJYZaB
	 1cBdCLjvcPXEpS1la8uOhmCVf+ObdU1+mkgm+Sk/rkCr3UijO+kQsrsxWAJ6ToAeDX
	 f9hJR/NYyqbow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260728052540.4728-4-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:36:56 +0000
Message-Id: <20260728053656.A00441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message incorrectly states the optimization is for 'amd6=
4' instead of 'arm64' and misspells 'density'.
--

--- Patch [3]: [PATCH v6 3/8] arm64/runtime-const: Introduce runtime_const_=
mask_32() ---
commit 42eccec62a5249e8cefa9cbda5e62f01751903e8
Author: K Prateek Nayak <kprateek.nayak@amd.com>

arm64/runtime-const: Introduce runtime_const_mask_32()

This commit introduces runtime_const_mask_32() to optimize futex hash
computation mask operations on arm64. It utilizes a single UBFX instruction=
=20
for masks of the form GENMASK(n, 0) and implements runtime patching for the
width field.

Link: https://developer.arm.com/documentation/ddi0602/2026-03/Base-Instruct=
ions/ [1]
Link: https://lore.kernel.org/lkml/20260430094730.31624-4-kprateek.nayak@am=
d.com/ [2]

> instruction is used for amd64 to improve instruction dinsity and
> performance.

[Severity: Low]
This isn't a bug, but there are a couple of typos here: "amd64" instead of
"arm64", and "dinsity" instead of "density".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D3

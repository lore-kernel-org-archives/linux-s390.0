Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33640B102
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966859; cv=none; b=fpxEGQLJ++HwhSB4O61ItuA2fnP8Gpg92T09TiInuRb0Wct5DRUo7SpExB9mjyJRg2+Uu1uOm5oLX7V88b7IrVHsGPr4veOLXQ1z3XDISiPF7OnD0oAKX/ikpjCIcWNnff8TcAlZ12EuHwzmOQP9S/mZAnn8UtzsqdwE2aB2qCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966859; c=relaxed/simple;
	bh=FPiZVFgF21PlJn4Do4wDyDCHucO379tGmu06yKFqFp8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HrF8jyMsR0hiy26SM+zKQWximcln7QO5QEiwNtJQtk3zYP23ymMNbQvwTjY8A6TyCnJ6JItc7JcasNtvwIXwdX0hGS8IpZCifP75kmtuwqp+n7Yxe193kquPenM2T/OAWX6qigh3xLbrxAePeTm49DJCHjGknToIt7q9Gc1a4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiOAAc/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiOAAc/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AF01F000E9;
	Mon, 17 Aug 2026 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786966857;
	bh=FPiZVFgF21PlJn4Do4wDyDCHucO379tGmu06yKFqFp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iiOAAc/DqPzWNtlkyz+iZFI1veJ4hpkLASYZDZnuVVoO6Hx/7tBjy84QRm/KOyFX+
	 JI2RxPF3OihV8C+llGjw7M8MLRWoXHPFpuOv9caHGXSy7LVNgITMBiDQRY+w/x6gFj
	 ngvq99VVSuGgXTWabEbo0vTUj1sXKLAD4hiyul2ihnoWp56a6xzfYHYpK6DFIHcQrc
	 V731S9uh35qZaJQVWna3m3xJFbb1ZF+FgG/Fr4pqweTn2hR+oRLHzTuSZz1YxgFB3J
	 4js0Bptu+DEkWggjD0Na6VRDDkEn6hPb+8h4J72u0DeFHKgJauP5EcIs9hx2N3kSNZ
	 BbuGKqSaAKOpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] s390/mm: Lazy MMU mode sanitizer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <064436ca2fcc3221f12a37acd0a41d995a794cf7.1786956464.git.agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <064436ca2fcc3221f12a37acd0a41d995a794cf7.1786956464.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:40:56 +0000
Message-Id: <20260817114057.27AF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Detect PTE entries access in lazy MMU mode by means other
> than set_pte() and ptep_get() primitives, which would be
> a read hazard.
>=20
> The access to kasan shadow memory from ptep_get_lockless()
> mistakenly hits invalid access in case a concurrent lazy
> MMU access to the same PTE is happening. To avoid that
> disable instrumentation for ptep_get_lockless() altogether.
>=20
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786956464.gi=
t.agordeev@linux.ibm.com?part=3D4


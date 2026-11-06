Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996645;
	b=dKxE4jKlmlr8J8MGSGJcTbGuOVBtJvnOrYPaf39UvkMPSr2/Pwkd7lOr5O7uaYinlNGR
	 M9OD6dmObr4sqjUXOAmzg3sdRR3xvTBZ2KxrnCDlRIAKYjjS+qMr0T9MNgTIOd+LsKc70
	 2gPVklvpq2UrmeIgnhpyq8R/54AGfgM3eXB9V1o0S3iTv4/gHy9zC3MXIzs2a8wkez5JZ
	 Ex3k5GAgQWIuXGqwFDqYJOLqTRrC561MLYSeZVWXpTcoAMcolb79pn4XPBFOvVe7IahSr
	 /MljYjWoXV26MeE977loY/xN03UNwBabW+HEWK3BOdr41igRgUcW1hLFLVZW6IlN4Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/VBRtBeHuB9YGjdNT9iRyx5cYNuOEEA5uwYQ73v6vKY=;
	b=Jn1J0EpFOyYhX3V6C2AyKwmAN2mXIEJN+W7SDsSwDCDRibQjvprcJud9liHgK4zJ54cx
	 Qnbyt+pmoZfPqOueFYexBPjiTlkTt9lGbJK//NjKcwvs/cD9pgl2iLQ+CHoDNcJzAQgrI
	 G3vR0SUgrw5YXw+GwnvlBypQUqiI8zMD4oUGSaE6XHgDC2m8Exy2q/7GRdqEpywgWA+XA
	 0HvruYKMHXC4uB4FWRsKrL9k9rqeZl+51wemaraOgL5+a9LUgAdI7eCEvJB+pS24PmBnF
	 GfC08iWq1ecyqVBLd8hQ3kOKPL8pQyJs2ukkqzdtRvCgehX2djh971d+s/Li07fZPAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiDqap7I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC16606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiDqap7I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F481F0089F;
	Fri,  6 Nov 2026 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793996644;
	bh=/VBRtBeHuB9YGjdNT9iRyx5cYNuOEEA5uwYQ73v6vKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aiDqap7I65TFTO6W4hrPzS7W4oj6lkAF3qG1vUAr29oCIRgv8wXXeHzMIR5MxXfYu
	 jMBe893olPUzLJL0i4FT6/XCaZxOI+L3mHELhvES1p7qwZU03ssBuDrrqqv/4J407j
	 FFteIiGDO2SBOew9B/vaZRTOf9UNQ1FX9LgUYHpO//8hNBfJqTLAmkjThUQ78B+x7l
	 iE4wU5m0y+/i9LqRuoE4dJbrGlJjCuC4ceR2n07z9uHeSpXEXwVNNe8gq9spDcQx1c
	 qqHsklfgqP87Tw0mP1XgZn3ZupYvC0LS/FG+XRszX1uZ3+Lp/Ag1o/nov4TieOiJKz
	 ACq07Cea/cdgA==
Message-ID: <sashiko-outbox-202200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/23] KVM: s390: arm64: Implement SVE for arm guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-21-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-21-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:24:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add support for Scalable Vector Extension (SVE) in ARM64 guests running
> on s390 hardware, providing 128-bit vector operations backed by s390's
> Vector Extension (VX).
>=20
> The implementation is limited to 128-bit vectors (VQ=3D1) matching s390 VX
> register width. Z registers reuse existing FP/SIMD register space (vregs),
> while P registers and FFR are stored in the SAE block.
>=20
> Co-developed-by: Friedrich Welter <fritz@linux.ibm.com>
> Signed-off-by: Friedrich Welter <fritz@linux.ibm.com>
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D21


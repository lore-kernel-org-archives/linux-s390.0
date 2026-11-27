Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794468;
	b=Q9F8kkFW/bvRnCy8WuEDcgRGsw7mB9XrX50ok98Cvj4URFF3oIN5vJZr/xVUWucQDWGq
	 eayGOO79vdaGBQwk841GaaTDo8GriBluSmI38Buv7qnVR5xUZWbZdxaObBU+83rWTb0u8
	 tJsVDLRE0X0p3VsY/MvwSFpgyOaqyhPmgqR81tbAs0sL3qrPXhth+tZSvyD1tPn+FjfpC
	 QulwBzUfrEUQkosYvmZayQb7Z6BkN2eKCABtBWFDx2F+jcylS0/xqvv7SDtejZ0BVAcU0
	 y5EeGbZsUrRKr+S/J67dnc+j7TTzhDeD7uvfaxg+zK/NR5NzLE396tbiZBoY2X2bf9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VMdTG030BF+QzHjtemiMAtLGoAA5YKAD2Yg2VprR6WA=;
	b=uQkokPXMkyiXZ2D5zfHdnj1alQWykXMHAT/2vbQ5gu2qhaBtgyj4NXdt/SgDUyN3OJep
	 BNkmLO3oHmVj77pynatLIvuawtJMnSujBD4Xs1++GU6FH5eLrbZnjs4JLObVmz0v3Vxw4
	 qr4dIlfi5f490/onum01Zl9bDLu7+htwo2lZQtVqAnhiS+pqbj53Tak7C/iU1gdTLqbjy
	 Smovo98fwr694SEbg9QzLDa2pe5oc8SVPo68b5HWKxJOfmogDXyqqTB89oNkcBCZWy+Yy
	 DDy2WkHcIElYuUpzDQkkJ8zkPF8/dl2Wbdgg09kp9nNke8+Gs0qJvT55JHlC7TmzJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVrBgqgY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3165606A32A
	for <linux-s390@vger.kernel.org>; Fri, 27 Nov 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVrBgqgY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C801F00897;
	Fri, 27 Nov 2026 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794467;
	bh=VMdTG030BF+QzHjtemiMAtLGoAA5YKAD2Yg2VprR6WA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVrBgqgY3GGHMaVjPg9SsNayFqV9qsXwHn/jbd4f/F56CCsiTocd1FbpcpkIJUx+z
	 lEbSrOT1Rg7/wJtpdN4sQE3zU+cH7rSTYagBjHV1+c2kyoN8bh7RFl9gOT4XF3IZZa
	 INsMnFBsUSq2zXaNtdjL2VuQ3LXS3ebS9lV5DXeBayfbEeT4icZ4r1nLjuP13P0X0f
	 S+ZaIWWhwGbpyx6brgBrfGOJyHpiwn8LEKLpgc7NuokzLfQEJf1CJuKDH5rwGKwHhG
	 XlNZwc2JDOP7EETEWmyirc8CbiazDqZQvk3QLA9aB2fyL4KCvZkhMeyhzksLcTUwTm
	 e155vIwuDFwGg==
Message-ID: <sashiko-outbox-237782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 00/12] KVM: s390: More fixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:47:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 12-patch series:

- Patches 1, 2, 5-8, 11, and 12: no issues found.
- Patch 3 ("KVM: s390: Introduce gmap_enable_cmm()"): 3 potential issues
  (1 High, 2 Medium)
- Patch 4 ("KVM: s390: Allocate page tables when CMMA is used"): 1
  potential issue (1 Medium)
- Patch 9 ("KVM: s390: Fix *_test_and_clear_softdirty() functions"): 1
  potential issue (1 High)
- Patch 10 ("KVM: s390: Do not unnecessarily drop the soft-dirty bit"):
  1 potential issue (1 Low)

Detailed reviews have been sent as separate replies to patches 3, 4, 9,
and 10.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127150411.2210=
72-1-imbrenda@linux.ibm.com

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B948CD63
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330525; cv=none; b=HTIRA9AeEJOq88tmqeAe1EoSp/U6Emis5Z2UgeM7geIYG0LeaYPr1y/ey0stWWp70qJumHuYAgctgwpj9o2aCGBa92/8ZfVH0Qmhc+fs1MIxdT1B9eOngwukP2Selo1+wmQNV2onNK61HmsPYoLebmvCSNfoOw/8ycDmGjVe2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330525; c=relaxed/simple;
	bh=X0BqywGd8P/kpDzJtjk/uI2fPi9FjRCf3QynRFfBDNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nE8PuaTAtQ20XV3+Bz1MaLwX2W/NaeimaZ+O+d/OBFJ5pKJuLkfEUoCAaySV2Taz+6nfDCej+ELEdH0tcVR3pcG28I3y2XAdmtM5639r/qsmdEbg3KKg56YLz02MKOCkQGHKknh3ydZa8RyR+TeyKVHtip71lgpG9yMWKe37S50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoW5G4xk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoW5G4xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14BD1F000FF;
	Fri, 25 Sep 2026 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330519;
	bh=X0BqywGd8P/kpDzJtjk/uI2fPi9FjRCf3QynRFfBDNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IoW5G4xkJUg4o5xD+s215JeSxIjgIKsREbZhq2N7h4W1RCeFxyfFpV3jQNzg7nB9N
	 xDqX7Q1GO0vi0ezsq51BKzt/3oqgQdvbmfCyPmvbzOtieEE1/jCQtSvLC9oKhL6xgs
	 ZHqFDrzFy93mEbj8mEiWYW8xptyPifYK0HXaTnv2LYYUBP9vA+2uH5xSZGuz6e/+bv
	 DUqNGhXCt66tkKVWjWhdINlgTiwdm0Bi+KRgd/YuycaGW2q+sF7ckp9VhBO/muVtF9
	 LDOqM/7+mXM50VGOQQ9xeODbwvIzNBvJqB1mFSOpQPdadbTjri/k1sGYvKsrX/Ipcy
	 UUhHdIp0oxTaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arch, mm: promote DEBUG_WX to CHECK_WX
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260925-direct-map-verify-wx-v1-1-7fd2f7d6d23b@kernel.org>
References: <20260925-direct-map-verify-wx-v1-1-7fd2f7d6d23b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 10:01:58 +0000
Message-Id: <20260925100158.E14BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Verification that the kernel does not have writable + executable
> mappings is about detecting security risks rather than a pure debug
> feature.
>=20
> Major distribution configurations enable it in their kernels as well as
> defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
>=20
> Rename relevant generic configuration options to use CHECK_WX and move
> their definitions from mm/Kconfig.debug to mm/Kconfig.
>=20
> For arm that does not widely enable it, only rename its variants of the
> config options.
>=20
> Enabling CHECK_WX adds a few kilobytes to the kernel binary and while
> the added size can be slightly reduced with churny updates of
> architecture implementations of ptdump, the core functionality takes
> most of the added size. It cannot be moved to .init.text because the
> verification has to happen after init sections are freed.
>=20
> With this, make generic CHECK_WX default to STRICT_KERNEL_RWX while
> still leaving users targeting small kernels the possibility to opt-out.
>=20
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-direct-map=
-verify-wx-v1-1-7fd2f7d6d23b@kernel.org?part=3D1


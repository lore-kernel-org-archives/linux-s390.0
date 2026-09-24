Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3233939D2
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231169; cv=none; b=EMQ8kvbPY5wk7eRm1OOcLTgMc/kVBnul/WC488x1ZIa/mw6Xgy+WMQoHjfP3HY8sdmn64tJuOUqicrezOe9ivG6GIg7xpMeJlKeU5t1L9eGLoPiZQOffGw8xsM+xlfmHxcDRmv4a5thb5ioNXymhkvNdRq88o8rtriPzHqCmuUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231169; c=relaxed/simple;
	bh=NaLKWlVMin7ub7bIriG2frGgcYxeZNZBzzgTRcsf06E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t7/6uKE+VrGQ+obsao2ZvJul24AbDiwDG5f3hY/D+cgz/YA1AuszE1PkHo5HKt0kaJaTCu/rWsEfeyz5YnBJNa+zhLvghOW7M8VX2/9vD+ARw96qqFG00OtJRP25ipxNUgI9G8Lr0jg1ZSwmF22IYkfmWrG+pQHrjH6v+9vAKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsiBsMYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsiBsMYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF0C1F000FF;
	Thu, 24 Sep 2026 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231167;
	bh=NaLKWlVMin7ub7bIriG2frGgcYxeZNZBzzgTRcsf06E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RsiBsMYRecB7UwthnKmkG0qdxrZWjwRe8PN22daTO1ccmTsTZ7inAMKga4BOdkss3
	 LCLzMvZE5v7AJLwMJf2E6Fg8rtBJ8R+PR81QG5blsg4Yid4RAunZeoRzAfEPyBorfw
	 S+NQe+fboBmMFNgQbpIBlIFR4Y61980kpYDISbahQU+jp8HET/+fSdGB4CX0TVYUGE
	 kNfqRtQX0xAL7d2XG677+VuYMQFR9tw9xVdYjWUjUh09gr/pj76lT1cHRxowAGDN6H
	 Tza96gUyV76W+w7QMCgHSqOLLjVNb2/dWIsE6cLTVLw50QN17xhV0L6weDYtlh37zv
	 SnGw2/agm2XZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] dma: swiotlb: Remove SWIOTLB_ANY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-9-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-9-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:26:06 +0000
Message-Id: <20260924062607.3AF0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> swiotlb pools are currently allocated below the architecture's low
> address limit by default. SWIOTLB_ANY overrides this and permits
> allocation anywhere in directly mapped memory.
>=20
> SWIOTLB_INIT_ADDRESSING_LIMIT now explicitly identifies callers which
> need a pool that is reachable by devices with limited DMA addressing.
> Use it as the placement constraint and remove SWIOTLB_ANY.
>=20
> This changes the default behavior for callers which do not set either
> flag. Previously, omitting SWIOTLB_ANY placed the default pool below the
> architecture's low address limit and also constrained dynamically
> allocated pools to the same range. After this change, omitting
> SWIOTLB_INIT_ADDRESSING_LIMIT permits both static and dynamic pools to
> use any directly mapped memory.
>=20
> [ ... ]
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060756.1325=
156-1-aneesh.kumar@kernel.org?part=3D8


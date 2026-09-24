Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577043B7769
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231205; cv=none; b=B4UfpYF+bDpI4CFp9M/pyjwpJXGT7njhPcVeXZ5zbDExKEPg+LL/mvd3Xhx6miq94/uoDKZLf/I8G1e/YjAUISRngEjBK8nwV0ZigXOGx3UUCtDb4nF3SsZ/zrKFRALl/TxGUqZrqxBzo97lcNuIizJh1o3Rvt6evFmkRIFNOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231205; c=relaxed/simple;
	bh=5LmnsNriw4TZG4R6bDY2+yq7jVMxcODc8lGslpM33dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZkCQA/L8bjmHtFint64dgn1pHsnKLIbfZaK6mdhVVr87wBvJTH9LMpFkwUg+uQ026QOecBv9XQBWAX/T0/fnw1PQ32Zi8lo7R3oDKz2f7V5wJ85NeSTWOk3bNRp0Y0uO/GTLWj3F5oH4HFPaGzSMVb6WlQERSUABAXdP3j6RGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajd+yjrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajd+yjrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D391F000FF;
	Thu, 24 Sep 2026 06:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231203;
	bh=5LmnsNriw4TZG4R6bDY2+yq7jVMxcODc8lGslpM33dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ajd+yjrnZ9kXlZTF/R5AN1I9xvD2k14qPuos/3krjPHf7/Gfx/9419bp9P6TO5oFx
	 aprsCLKLzR/LpG0XZYddqPtres2esJsVHHE9Mpv6M2TYsNZNe6quX5rIGp3C8tKIF5
	 katwJ76sdFjbRQjZqLiyxu/V1RleKeiLTFuc5lKvJiv6AnwoBbzIQidFQGa6xsHWQn
	 o+zONddVYk9q4ELinC4wucor+z3RBzjnAkMb4nEQUpq0Rpgwgj5eBiwriWeP7cuHZF
	 Lv1nP7N1Q/SnEl72LmYQfp55vN7XavJ3An0z4n27MvgZNyMuR7ntnYWkCvUrywKZQZ
	 gPDGv7uxeTp9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] dma: swiotlb: Add an overridable architecture
 pool opt-out
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-8-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-8-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:26:43 +0000
Message-Id: <20260924062643.A9D391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On x86, iommu=3Doff historically prevented SWIOTLB initialization by not
> setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
> controls both whether a pool is selected and where the pool is
> allocated. If another requirement, swiotlb=3Dforce selects a pool
> independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
> the addressable range of devices which need bounce buffering.
>=20
> Add SWIOTLB_INIT_DEFAULT_OFF to let an architecture opt out of normal
> pool initialization without discarding the pool placement constraints.
>=20
> Unlike swiotlb_force_disable, which is set by swiotlb=3Dnoforce and
> unconditionally prevents pool initialization, the new flag is an
> architecture default. Explicit requirements such as memory encryption,
> architecture remapping, or swiotlb=3Dforce take precedence over it.
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
156-1-aneesh.kumar@kernel.org?part=3D7


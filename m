Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B362EA173
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230785; cv=none; b=OJijRExqQWtO08U8WwGAy1o38tMotpCOPu+r+rbfguvSudrIdsT6AedQXkLLP4iq55k+sWkPSsaObO3XIkrNuRF0uFkKVjn5PIf8nlI191naqm0VQ39m2PZRrtSwq6RWMa73Vt0PKWnDJ7IMbTVBQSXfnsqKeHdrjQ4POqHp6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230785; c=relaxed/simple;
	bh=OuL3IxsteWZOiiV9ozov4Fi/E1u7wtADgdXuoLsTWSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EF9rkBgxbRHFVO+QzaZbKQPVV9+G58etCx3wgTDYF3mwwyVCztBPB2hECOEUQqmxZiLo344dQQqXNFB46K8tb/d7NFeU7nPguGD4HBptP8Gl+3BOlDf7kL72J6jGEUNy90eMwp2aRaYkme4ANZ0dfKPC/Y2jknStjaQIEyvD2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW/eVbXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW/eVbXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF8E1F000FF;
	Thu, 24 Sep 2026 06:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230783;
	bh=OuL3IxsteWZOiiV9ozov4Fi/E1u7wtADgdXuoLsTWSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PW/eVbXRYE0ts9SwAVDPBAJOl1zgIIYYGhLKkZpgd6r6efj3YI0Ke44gMNYZlJYeL
	 CKnaaERW/ekc/Ctx8JEtO7zdesQ8OsoaJ8QmaaNkrMMUbwGuEhZTFNUxfM9QekHbLm
	 ywGY19bkdHIlyO4Plamlc2sVxwn/myL8uHO2IMmR4s+ZY6ddp5ySuk8bPP0wPZRthJ
	 NLkgCl8qtEePft4R/1vja9ZlkPLp6rrlIb2Bw52KHBLZkM46f/g3wxXkr0YXuDnUi4
	 exIRy7Avj05P2iTXYR3trz1Vy4ud3UUkFGjM8z0C+XpaQhFxHyUikL5qr9Xgq7y1+I
	 5KILubKtkZORA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/8] dma: swiotlb: Consolidate slab rounding
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-3-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:19:42 +0000
Message-Id: <20260924061943.7CF8E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Pass the area count explicitly to swiotlb_calc_nslabs() and keep the
> calculation separate from updates to the default_nslabs . Move the
> default_nslabs update into swiotlb_adjust_nareas().
>=20
> Round slabs to a power of two even before the area count is initialized.
> For early swiotlb_adjust_size() calls, this moves rounding from area
> initialization to size adjustment, so early queries see the rounded
> size.
>=20
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060756.1325=
156-1-aneesh.kumar@kernel.org?part=3D2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8B407CDF
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230578; cv=none; b=Nc5f39mk1x+UMac4B3uNzCQRYXvVL1ec2j0YAig5KmlOOJwzZu/DZs01zKmWw3a46nrG98fNjDxpxluyShF4xhoxJ1EB1TCUVHhJv749PSBuE3U6SXrCGqeH/3F9mHG39mbWbGRRVzbfuGq3FWxnk5HPjh49gZAStcz6pcJn4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230578; c=relaxed/simple;
	bh=hiVRC7JUha5QRXJ9DtUfaMP+ikACA0hhiax+GigyNbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onMe70HKpMoZk7LuFs3DkxmoXDmZ3kjGuJceXx2Dvuf0LUXNcyzA4Oy86X4ZyhIm1leVSHgJ3M4O3EAaAbzg5e+ldc6o1F7iuINZMzZCd8FZ+2kNksYYLMgXUyq+mwBSenT3rkiUTyQXdYdTZ2kwt2MwtWmcGxn/a/XpgYjkmdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co6xDnjm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co6xDnjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B7D1F000FF;
	Thu, 24 Sep 2026 06:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230575;
	bh=hiVRC7JUha5QRXJ9DtUfaMP+ikACA0hhiax+GigyNbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Co6xDnjmajZjXWZavh1Q8aL6XE3kgp8GUrbVd86xp0Hj7ryTXcWI4xm9aLTNEMpHP
	 IiZaP/7OizyX42iix+OYYTAPMi8QqM6lSamVm1FNFAqejoyDDhRaCx12KZKQDoFQlC
	 n4eIwy+9X/2Fp6+qARPh0VfxB2K+IArbuKXgNwErQYlOn5nXZbogz7ol+a8R08ELgP
	 3PLDtl0WMpPrpn42PFyU71AnUeW/zwMv+t3ibezBK+T2dOcUW6W5E40q+nCbSt2aUX
	 9lnXHTto44Ggmo+gMRCJjn7SuQtxBRrVl+cvNuQD8kwNZHggtT/OA+PejCm4oIis/E
	 8+sT1iTzVT2Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] dma: swiotlb: Track whether the pool size was
 explicitly set
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-4-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:16:15 +0000
Message-Id: <20260924061615.82B7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> swiotlb_adjust_size() must not override a pool size supplied through the
> swiotlb=3D command-line parameter.
>=20
> Currently, it determines whether a size was supplied by comparing
> default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
> explicitly requests the compiled-in default size, allowing the request
> to be overwritten by automatic pool sizing.
>=20
> Record whether swiotlb=3D supplied a numeric size in swiotlb_cmdline_size=
_set
> and check that flag directly before adjusting the pool size.
>=20
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060756.1325=
156-1-aneesh.kumar@kernel.org?part=3D3


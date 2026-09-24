Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465043AE190
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230704; cv=none; b=iHsCsSWpqkpfKP6EGrRN/KnnlcFwshzuzzbpWdWPt7krOeZwTozNTcFsmvgTHUhkCsvwZkIDn3LxrncM3GM4Yj4ERvPDbuCv45uWJ3uQdXsqcc4Jq6DkNWwjKIHHF9qvr3In/n0AzY306CmeZYkO7MA6bucI8iWsqciinNTGxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230704; c=relaxed/simple;
	bh=f9ZnZk3/WlKW30M1phRXgVBxqhcVYl5i+CpzGdst31c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UAMneI6kdKJsKjxPIhUYulbPFDrt8+dDUqhYj/vxsj/sarvBwkUWU+kTKYjGS8kRksdSddS6vXYJ1LP471a+Huud+fzx+r+NKUINlnDLsS8rfrLCVImsHwlIMNAWZnrgd8XnISOi4BWNDGd4Y5HbFzA2bSbQ6VoxmWBFx24K0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3k2ADtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3k2ADtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6A81F000FF;
	Thu, 24 Sep 2026 06:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230702;
	bh=f9ZnZk3/WlKW30M1phRXgVBxqhcVYl5i+CpzGdst31c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3k2ADtIV29qc8cPxUe7ROasx4v6m0b+77Ak6dMiX8COHTJfu61vpF2nk+02wkzOy
	 2GjSCy1k9gc0Y9CD/me57oRfmyfEuMp0hcYczK5UmdzZsOuVUkTH398a9b4we8WXIh
	 iQVAebpzXxacopy8fU5srNSsGKFDWkq9i1mZTL688g2izVOF1duvJ7DsPQCWstdBf3
	 jdK7ww27x026GxIJZFZwmtoBNzRBW/mJKBUMqHLGKkZuCoLyWDASzckPaF8OWudgCY
	 OLKFrhbxY+3Ocp28IrimcoY4MFDfo57RVS/hr49jgKLSn8G4Wk8UB9C3K8UCkhLQjR
	 7cd/Kq36wFE5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] dma: swiotlb: Centralize minimal pool sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-6-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:18:21 +0000
Message-Id: <20260924061822.7C6A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
> smaller than one required for limited DMA addressing. Arm64 and RISC-V
> currently implement this sizing independently, using 1 MiB of SWIOTLB
> space per GiB of RAM.
>=20
> The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
> Size that policy in swiotlb_adjust_pool_size() and remove the
> architecture-specific adjustments.
>=20
> Explicit swiotlb=3D sizing remains unchanged because swiotlb_adjust_size()
> preserves a user-configured size.
>=20
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060756.1325=
156-1-aneesh.kumar@kernel.org?part=3D5


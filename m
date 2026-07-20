Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7C291C10;
	Mon, 20 Jul 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539181; cv=none; b=YB8TYeKxbQyLo/gFTsfk4SA5NpscshH0OgvYVHcUA+Qd+oaKsDbsja1H7pfKzxmy04Z3FJMwwSSz1p2A7rOk3rK+nrSrxfXZCsI1eCfp51tKgOew/DMD8eJV6ZlhS79FHDtFrMW0o0e4RcQsdsZ6JvMjlI6pIZSaRYlE3dxq8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539181; c=relaxed/simple;
	bh=FuEa0fXWTNB+yPwvpWFEB32UsAHwFqk0qY52xWPdxhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MTD3CU1JCWlpUWnDh+e8Pyz+4YFqFk1zPqaCVj4jbHmaEirQwJD3hmLvdHzV2iA9GO9fy5VTDpxdV/UYkondvRMU7TwVdfJgCnU3Lwxk3JNsxiDiT7GzAtJjE+CTSENPCC4dGDewKJcUUIEviudveWg0CbnqFYjfZnuD6sdYlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB5AdWy0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB5AdWy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016ED1F00A3A;
	Mon, 20 Jul 2026 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539180;
	bh=FuEa0fXWTNB+yPwvpWFEB32UsAHwFqk0qY52xWPdxhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hB5AdWy0UVVlPafM19a7VILH9NdJ/oEMG02JmFFlpJ0Lx4rSpmdDlDuui3Tzyu5Bd
	 2QH6pC1DTHIsrjtZOA+k96fYp4xMn19vdLTZ3X4qBGgrfoE2j5uEziYFlpDjQbcDa1
	 XuD+/l/1PBKVvA69fIxn1jP09C+8rhB77R8Hny9qMN7NdMQvSn0HarUkju4SdAz6XK
	 FCxVfjGgKChthzCwc+cejhh0HriH/c6BinrVYRmk4lQHTa9HSp1eufDgvDc8GEwOjn
	 SLoIqkAhmn+/bb9D2jY8N75nlUutHNW6nzQxhNbdUNMhc0rBlGjswkgvl6PMa+vGrB
	 n0/wdivtYw10w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] s390/mm: Use lock_mm_and_find_vma() in
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260720085834.898025-4-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:19:39 +0000
Message-Id: <20260720091940.016ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> do_secure_storage_access() uses find_vma() without verifying that the
> faulting address is within the returned vma. Add this missing check by
> converting to lock_mm_and_find_vma().
>=20
> This is not a critical fix, since the worst that could happen is a
> WARN_ON_ONCE() in folio_walk_start().
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kern=
el.org/
> Link: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel=
.org/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D3


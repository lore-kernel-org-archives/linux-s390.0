Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855904;
	b=jkrX1YsZ1J/4xjqVd58KZ4VczIawZQJ7H7mqMBcR/wnceaR6GKzOskv7kpVJUxo59d0H
	 3xaoSMbEqS2bHlPwS8M4ID2t1l/HtOQIPahBUn4tnsArWJiV6gfdSy+gDgR4UuiI9yX0D
	 Zu/EAglWAp4Itrm/WHrQljhKYBGa3o8NGK/59De+FCYUD3jLHEiZ2REB0oQDGrtsKGRR1
	 /ZzfIQVdG93lKB1G32szZVRaKDmvM/H/RWThPMsellP0H4XVAzhNUTTkPVjZ0KqKTvyTp
	 xStKUDpGum9b2NddLTGDvhidExXnbv0rxH5S8UCsl1vaGY6BZLfTFtx/ZB78a9l6/zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ycuJs+IPtbjOVhZmCkGyWUfwzxAyslHZdmTkdx5zzI=;
	b=IRp1bDbGc0zCrJtRzV7JSmuyU1LOC0Ex7quqdSPDzjSoF4gS9eKSG8q0U5n++IzmtyY5
	 L1+x9y74A3DdefZ87NUdEncq5JhrKVAkIMR+swcfuF4QC8ulZi2e02Bwg+0WULQjJqxWR
	 bNg4Ir1jpqD1KzdFIZoTv58eR3ZesVzYUOsFOH7HEtL8zVawyVV3pJXYqlL/gS7rISRl+
	 zmqr9sdLXvyC3QKiQ7fh9bQNPRXM2H/bsINXiJgPSNMF8oz3iXIry+KQl9ZebisVTq8Sq
	 mpa4A8yxXR8yD+2qkWDd5WS9ZycfEj+gcvPkMXKRKXUSGb4e3jerBVEPlw7BUR84Taw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iElM7uu3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE5606A32A
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iElM7uu3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4BA1F000C4;
	Mon, 16 Nov 2026 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855904;
	bh=4ycuJs+IPtbjOVhZmCkGyWUfwzxAyslHZdmTkdx5zzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iElM7uu3T05xrnorPQckzn5DNYAb4oNu8FaV0O0VeOVe6kO/IR3E6bTSxf2y2bNDq
	 20P040H8Up38Ey7tsKODPpmlr9U0ImMXWGr7brjVW6hPYSwEah90cxfEg5nPc4G2yU
	 pBKc2sEeomTyT0MsaGKtQRt8Q//tOXV0ZN4R0AUGneQhptnWVi6RqZhP7hXrOK1bay
	 5IKsOlZbDMraVzX91RbVAwG4R+aSYGLnwdPKxBHiEX6oov7gwq67EvG8wGgMGbBfUy
	 xBVvuho7PHb/eurT/gB983t+U2XDZCdzNAVX9JWA7Kt5f461DAx4ICAD412PBlZHEP
	 +Os47WK+KzIzw==
Message-ID: <sashiko-outbox-217525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/15] hugetlbfs: fix integer overflow in fallocate()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-1-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-1-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:03 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> hugetlbfs_fallocate() rounds the range end up by adding hpage_size - 1
> to offset + len. vfs_fallocate()'s existing overflow check only makes
> sure that offset + len does not overflow.
>=20
> Once we overflow for valid endpoints near LLONG_MAX, we can get a
> negative temporary result that is then converted to a very large
> huge page index.
>=20
> A one-byte allocation ending at LLONG_MAX can therefore consume all
> available huge pages. Pages added beyond LLONG_MAX are skipped during
> inode eviction, leaking them and triggering the BUG_ON() in clear_inode().
>=20
> To fix it, calculate the end index in a simpler way that cannot
> overflow. This also fixes the signed overflow reported by luojiajun in
> 2019.
> [ ... ]
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D1


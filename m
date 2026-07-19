Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFC192D97;
	Sun, 19 Jul 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466411; cv=none; b=cYmRto32G3wrr4w5UWALRQHS27Wn2aShfa9hhDcGXZwi6Mb+LZHPgwX/RhRjFMVkPlkbu+bP1gEm1gaKgRCOJtRs9tchdT/FJHb/0jOeWKvPWmoHI1cbl+HvVfV5dToxC10zicct+qP16xGy1FL4fRMnPeiIn5ctyKD0Z/PZ21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466411; c=relaxed/simple;
	bh=PudAoAOpX6kyAe8Yv0YNJJ+KFj0OgVrvan79L+Ecn8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNfhpbb53M3OMVqO4poKVzapckVIVwFz3r6yFzKpauNx9CRT4ybBfKMXysZNhaVkQOtPd6uR/LFllTzQ8MnxZWdps8qd8NI9U90o8FxLiyw5PXlTypwJ94FkDBnoG+VxxB61fEdXYVozxZMcGNmRMo0xbf3os6qb+CRQ/WYF05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbNezxCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbNezxCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178FE1F000E9;
	Sun, 19 Jul 2026 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784466409;
	bh=PudAoAOpX6kyAe8Yv0YNJJ+KFj0OgVrvan79L+Ecn8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbNezxCwAB7xffcI6Krw/IacYx2rpTsC2W96AEG70mc245ESuO/Thc6RCYrA+Mbh6
	 nLg5ZPyKg4C2iKkmboanDwGSww0KBOAccpaKcvJTCxCxCktgAXk873C1Cqp9TEzSEj
	 iHOlm0yzY60T8DzDyAzVNxtRrxR/Ib4cTYVrpNKVXtM7V6QWvRuI4dd4QJPkjkD9uo
	 ByveP5GKg/8lEsexk5wfhlnn/mxfGjUK2aoDxbLryGGQ0gJwi7sXSiupCQ71HFSeln
	 xLlLNnsp/wa/TB/FcQTCZAwxl/9AaQlViPvF5DlNo33RooqOF8hVfCCWHGRhZhpdD1
	 SsPEZXt1pm1eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] s390/mm: Use lock_mm_and_find_vma() in
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260719130006.3882764-4-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
 <20260719130006.3882764-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 13:06:48 +0000
Message-Id: <20260719130649.178FE1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719130006.3882=
764-1-hca@linux.ibm.com?part=3D3


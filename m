Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC03A0B36
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374177; cv=none; b=tOU5sf6PNnOyOEvDOKsyiSWjHp3bV6K40lYjwdBqEhfJikT4/U2zLIk0fi6kHLdXrrtco5Pjq9mPLStX43fBoPWWw95zPTqTtuVB9VXyguxaiXv3+GjI3VTg5vKFgp8O0X6V+gLw3GNJLqB+iovkKiIVDp0/214pN16+9QwuDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374177; c=relaxed/simple;
	bh=Xh+A++DOri+KGNVAn6xWQaa3tFmN+it5f6kUgnu7ALU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QJgfx2a62GEd2UeEN310WsZFIZ4l12ImbzT4WlQoizY5MZu/ApVtoNUIkmW2XE0jAPRmffGlU2JROPbsCd9tYgfpLSXf+zTv+kEgnztJptL0u0/yJ1Kf1DY5a+LQjhRZb655GUCZid/cnL6L1FVGK0moRyCjrDtE53HohDnSqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td15YSjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td15YSjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D711F0089B;
	Wed,  7 Oct 2026 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374166;
	bh=AtAyKzorK/XEKzo38k1OoWb43gxEPebBNNqiANMpPro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Td15YSjUXtaBoYAQIvtcsMNIT0cBDbQgBJ408ooYlzKvFRdYI3nkPqB0b1clrD5xZ
	 jFQvizQpHXSJ0jyVrlAvQa0Xj+wZ6nvlABIslQVfEafOuX1fLUJxEzk9GpObvoKH+M
	 6Vw4yoCiWo9lwSpWgigvu9wZyQj0+ysGOr9TJGXWoXDt/t/GGmu7yiR02QOweFWDcL
	 2vRylYVy2D+HdZ2mXQVMSp3XtIxeeFH/jZ7o9rRMnETefzlRi9w9V53D8eofPv6ofw
	 1aYN4U+8ApMJoAN1sQ3IqACM/eOX0mHwaAsLhfnfKq65X1o2XaJLP5t6g32a+AD9ym
	 2h1ybq52i7BPA==
Message-ID: <sashiko-outbox-162954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/15] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <e42d9f02ec1f8478a50fce424b95d0e7ff6a359f.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <e42d9f02ec1f8478a50fce424b95d0e7ff6a359f.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:56:06 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provide helpers that allow architectures implement
> illegitimate PTE direct accesses while the lazy MMU
> mode is enabled, such as:
>=20
> 	pte_t pte =3D *ptep;
> 	*ptep =3D pte;
>=20
> By contrast, these would have to be:
>=20
> 	pte_t pte =3D ptep_get(ptep);
> 	set_pte(ptep, pte);
>=20
> The direct PTE accesses pose a real issue on s390.
>=20
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D14


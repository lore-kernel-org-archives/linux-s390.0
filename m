Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997218;
	b=JNDT7IiPOx1rgptyIeraRhSWvQVKX7lb/RhZQT6GFf9sEBI7n+Wql5i0+9ctsoGYYMSW
	 po6bfJULntvkUYRFBeqi2kjSuG+8P+TLNfrVbBphXXZQSiN/vjd+fSaobbtwEk2ykzC+n
	 sprLwq4ZaLMZrH9RFRdNGaX09wnhP1HTlKdAG4jxJO34CVkVX9wVv32BeGiAjAN62TT8Q
	 Qo3PcXSO4bWMzuvqXhEsIhsQdhF78TyjNnhpivOg3SXSM3pfCNv4K4ALl0Q3GV3D1TaCu
	 VYqdOERHvKtpYKwvJl2sPNVMZazK2zBSOuAhl0VF+vgi6dGvktGPCsKg8y0y1QzQ2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mvXRbsC8zTsbW//X5mbxrszU5lhpTVM6GUbEcEYfIPY=;
	b=c4P2RL1z13n9shOCkX58OSX8znpuZB999IJELVdOL7+xFwxDhslCa3uJQejs8iAqYsSd
	 MY2CRD0Fpha5lsTOZkaX9FbFpMxHOXtB/tEyYZhDAhXfHt//tnLRGahBfRnSUNDQc2KOn
	 IiaPdVAVqKkBimX2U512JyT3RZ51EkYqkEcZ6YngUT1r4rDhRaOsXXFeReyZb8J2vAvWJ
	 BLAHW2T/51bbx+9M9Ze583o/Fp89awF0zgQs66we41i7NEuCHCqAJ/OnA1Xeqqib1G0Ze
	 vxwxbPAyUVUvH3i0pwvJ0/vZ74jvwImkezwn1OqPvKQyysEQ0s3DWVe40sykuBJhHpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQfGKi0g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63802606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQfGKi0g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B469D1F0089F;
	Fri,  6 Nov 2026 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997218;
	bh=mvXRbsC8zTsbW//X5mbxrszU5lhpTVM6GUbEcEYfIPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQfGKi0gBAJC6rZ56E28mMqD9F8aFFzjQcQAFqJPO8pjAx0ZZCQWAvJkXmX0YVG1S
	 7B/mCsRCl1lv6EJJZdR59VdJt0so/O7KFA7afyc0cdeh2+7n+DBvDXOiwiPCAssHA3
	 zySKvVVAwlZOjxYguNavu0iEAzR+vpKzfK1+Fmnlgjc1+CVeLHciA6hrha//nPS9pd
	 UdzSCqS8fTVu0rbLch9Oyua+JYDWZQ6mf1KY21s84mWb7f9U0inA1YRXsFTRvQAbF1
	 f+NEIncYHn8gc5jo56pb0fXVWkImi48wQ+FuCO9eePtxCGml+VErfmflzAXKHJ3WrG
	 Q1UAeWqWUVtjw==
Message-ID: <sashiko-outbox-202218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/15] sparc: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-5-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-5-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> The generated files are not exactly the same as before, but they have no
> functional changes:
>=20
>  - syscall_table_32.h would generated lines like the following
>    __SYSCALL_WITH_COMPAT(422, sys_futex, sys_futex), which is equivalent =
to
>    __SYSCALL(422, sys_futex)
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D5


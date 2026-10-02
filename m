Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576A47DD70
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938202; cv=none; b=NCpZ/8EKU4qKp7+dYL52HVEP4Id/+JvUu7XkQ86oopUk5oTQkJuWZGgXteQhQfJHq98QUURrPTHHPMzXBVcEegEeEUqd9u3EZi7Xjf8zXt+hE2nMsW69GPiMSDAFfDHIN6xfQuFyZt8heu0ngt6g4R/oAiojUn6ncuB3IByH0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938202; c=relaxed/simple;
	bh=EX572HNFejh7fA5oOhRGoBnadZBM/zdfk65pPXOsfZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SInh8Ou+T0tYrbCZCrz14twEG7Qu/o3UA9xWJZLyUIltx7UU+1OtvdodfeyABvSxyBKhRCpjIr+WmRlCkBvNPidTAy3b9qfyXsv+vkEUKWc4nAk0K9i4qPjHScNrrXSSeuUlom/Q5UJKNGVwAE9TO4+3Kz7x/qTqrFHNehqd0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjyUENV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjyUENV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D7B1F00893;
	Fri,  2 Oct 2026 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790938200;
	bh=EX572HNFejh7fA5oOhRGoBnadZBM/zdfk65pPXOsfZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjyUENV7wWTWHRgzmeZe2wTHt72o7QS0La+S7Vka7DDDOYKZeNZ3S02j2+Dt1qbxB
	 d05ruCPe+7Wecncwcw7D9SZKLg1oikhbyXdNLsgiUZuFSL3+MR7qahe69tNe6Zqyyd
	 hl8JvsKtFtlFXbGwF10scWpVSsmm8GU2F2j92f+sbSYyWALwZF7deWrk/UAxAU8F8a
	 Bi0L5tgsmEYtXJLrilITNCtMLYMKbAEMM3OPZk6ufZ6VDGOBIQM9QMnafjjWhQ+//j
	 bQj7aNAX3tmpVKwwTo8oDKzkBrvI0q/dIFCOJSTcFWCGSlQHFkGDS/4nOKUJiORAb2
	 9vklwrUddjR3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/dis: Mark non-NUL-terminated character arrays with
 __nonstring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261002104446.2077269-1-hca@linux.ibm.com>
References: <20261002104446.2077269-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:49:59 +0000
Message-Id: <20261002104959.A0D7B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With [1] the generated string initializers were changed to use an
> array instead of a non-NUL-terminated string. The reason was that GCC 15
> warns about string initializers that truncate the NUL terminator with
> -Wunterminated-string-initialization.
>=20
> The better solution is to use the __nonstring annotation, which exists
> to deal exactly with this problem. Therefore use it and basically
> revert [1] in order to generate more readable initializers:
>=20
> Before:
> [LONG_INSN_ALGHSIK] =3D { 'a', 'l', 'g', 'h', 's', 'i', 'k', },
>=20
> After:
> [LONG_INSN_ALGHSIK] =3D "alghsik",
>=20
> [1] commit 7cbae7ea3de5 ("s390/tools: Use array instead of string initial=
izer")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002104446.2077=
269-1-hca@linux.ibm.com?part=3D1


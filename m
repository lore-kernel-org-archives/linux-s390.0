Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60A1FF1DA
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763281; cv=none; b=uVO58pYEet5NJ7OtBBQR5WwV5yc9s0UJfgsRAQmXw5ccWOtVY64svw+vzJkuTw9ewA7wUjD254nySQzvZUjaC4/Xyq2tV/lmj+FONa5rkCTQOP3eDEDyaCSEfuXETk7HRljWnZom8zkDfGOprqOXf6O9BURkCclb3ZKaR9bLVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763281; c=relaxed/simple;
	bh=UwDlCq2XYvw3Hp5zxBkfhgMqJdFGRE4rI2R4VIq3nH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HL8FDeSsU2cdi6qpnnhLQ/+oYYmguEjFV8ZDtQDqibJirRiCyKTchO3F3sJcSZWFM2q9dZicEXE3wmdBjPaCzOVzBCCzYy0F/6rFMiGHTWp4AkGvwb6WMVZMb44gChisJDzYM4e4SeVsQ1O2haFxuqTR4nPElvMUoyLJvdUZwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj6Ny5Oj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj6Ny5Oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709121F00A3A;
	Mon,  7 Sep 2026 06:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763279;
	bh=DtyK2w/4tQc/mVGqHsWWJleL7L7tyMqTsK2WrxJuZ7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lj6Ny5OjwttnX5QSf+1DZpotcPvNri2F8sZ2qz7QFals3g3zVgb2oLzyM5Rqw+AyB
	 ASnzoJ/MfY7wI2BNMCKf3rk06buBCIrhijKwfVpq2kgiNKaDtr0Nw4ouxWp95nmK3l
	 DJZK2gJdLcyQYwnqKoyJuvmY6C94ndtM4WK2i+PCAFnBJ5mMklI1V4PqPKIqyEk1Kw
	 49SuBr4P05eIEh0PhExARQJkeNa2ZLb7ucXp2zDv5eTtte1mpHQLxoER3R+euQQn3s
	 7ZrAeLPNvsT9CHGlths97nxo1g7q8ZIq5nkuMxoALXfifPnmXD7MTQyf4iyhm8AKB3
	 xldbbQGP6Hnmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260907063856.27600-1-hemanth.selam@gmail.com>
References: <20260907063856.27600-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:41:18 +0000
Message-Id: <20260907064119.709121F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907063856.2760=
0-1-hemanth.selam@gmail.com?part=3D1


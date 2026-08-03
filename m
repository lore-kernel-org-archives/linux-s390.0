Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09032A3DA
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778195; cv=none; b=FylthA0p+2qZlZ2TCUC0/e1EopNfoupuOyKdwmT5eMawLF7zqKIBNwTF/39dGfR6/d/nPXXp23juBE1ZaxtbydtR0LHb36cPj6A/JBRJJiI/J9PZvGUobwioceytGVpYvLKkWGQEUj0NYcI6v2V9BSOJ07gGUS/9UT/a4qDoomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778195; c=relaxed/simple;
	bh=qokCnpDGtaJbTkUwmEUZNQdOIkgToGEauQMLKDI1lB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iN61iWkgb2vRaZLsieZm1pF+ek8r9eA+513zvHpL3R/xCG0pDkwj3yjO7VSS2kkXAJ/3FpDkHzKPgrS/AYfBbDhxqcdQQSZ6IvSryQwQ/YluTY23ZpRxgV1lz6tiX85HZNVYQTWJ+ZH4DLh2FmhesPU1Moaxnp4MfB6XZjuSP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo+zYO5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo+zYO5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0111F000E9;
	Mon,  3 Aug 2026 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778194;
	bh=qokCnpDGtaJbTkUwmEUZNQdOIkgToGEauQMLKDI1lB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bo+zYO5t0+xQ6rKYzib/+qZ9QfSuSH1CGZI56cirFfORI3uxKLVMiWVNwiTr9cBxg
	 w/3yDbc5SMSPfwmUSBG5QaQChpQrWxcoRWOHWzSotju7Clt1/geei/1KrDz6SW9B/c
	 asRbkzN37yq/ZMXsVn+cdF/Ycc7ixHowUgDsr94mRUixGy711AcM1L+dlQ2AJ7LZ4v
	 25LhuCYqfUi/js3gh8TOG8DmzmV7r67+KaNnDHpZLRc2kJhPqsGDca5zKXplnU5mCR
	 qNbrsblDVlK7GJWeI4cnBL5X38h8ybXiMcNI/mGK7QP/WYzNx/qqR+N57ULuhJBk/j
	 6ZLqvhepzfP3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] s390: Enable CONTEXT_ANALYSIS for various
 directories
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803172144.827049-5-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
 <20260803172144.827049-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:29:53 +0000
Message-Id: <20260803172953.BF0111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Enable CONTEXT_ANALYSIS for various directories which do not generate
> any warnings (anymore).
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803172144.8270=
49-1-hca@linux.ibm.com?part=3D4


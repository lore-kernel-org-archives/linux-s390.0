Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87513B7B8C
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168751; cv=none; b=X5Lds3RaMOq5vhbS264BTvpEmuimY/FjTV4zDu0Y6z3CwG2z6blliD11i1SBrZiW2AlNljEjEcHGc0rCpp6TAaB/+p0uSuYkWUmW8jj0B62ficOwZA7797hcyvwkQnp8gAhULm4RtpSnF2mFa/QOmB4jx7uMmNCruzXgm1bJw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168751; c=relaxed/simple;
	bh=BSpHVDo9wvdEpQUQsWuIp83yJjE8ZnfQwrcLAplens4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lP3y12EGlIgqF3ka411+JKWnhzTU71id63ymXW9GhkpHWZ23/kAM8H8+ULa7vDrxXuXE6jtp9VGm+gmlpFnwZHfwWJR/8gNEh4QuwfeTLWwSnOdmHpAysOyKiANSkCXRZ12RjSKmr8DPaan70AfNptt+GC4yfKOPdYfuIXWXrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzgxCe9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzgxCe9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245201F00A3E;
	Mon, 31 Aug 2026 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168750;
	bh=BSpHVDo9wvdEpQUQsWuIp83yJjE8ZnfQwrcLAplens4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OzgxCe9O2z6Bxkg31dvAcEBDYSurc0CgBP1L5f6ZU7TEuDffHcZ6kSOcWTgNLaSEG
	 WhHhhSDA8RYN3TTbCpxuDEQZyBreHRDD+x1QMG5M1wgJO3gFWEv4dDnO+WQIBFizu+
	 fej/RZq7mAhy5U8GtHocbi9pmNTEc8hbMT8aShiyZefTCUOCj145Igy0usONsqUbyH
	 JTYo6mELIXbAo0Wxg2gUsBl+XlNFtQAxdCixyX6e5MSR7zembjiaEIpNaV2HCE1vqo
	 ZvwRHQs5zMcgJ1afqTDWSK9HhWUYGZDPhpLRK/8y/DadTHL87uo6xDUmiFzR7uglcQ
	 rPsS/u2rVARvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] s390/crypto: Fix missing cra_flags in paes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831083838.3703-5-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:32:29 +0000
Message-Id: <20260831093230.245201F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The 4 algorithms implemented in paes_s390 never had any cra_flags
> set. So add code which sets the cra_flag to CRYPTO_ALG_ASYNC and
> CRYPTO_ALG_NO_FALLBACK.
>=20
> Fixes: 4ccd065a69df ("crypto: ahash - Add support for drivers with no fal=
lback")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D4


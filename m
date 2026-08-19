Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA5439357
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131383; cv=none; b=H3yQbe4Xt8tbguRqnbtorG2UFovEyEHnVDWlZ4yy2azKg3A5Dg+4etsu2B/2DfhSxsQMHUH4dGj2wPOigsiFUjpo3y2z7O3L1fOujqObf/1riENRRTjHk+gAcUOrwaltItoIboHWJGAEvqHhrkIlXKQ+hxmXgVutGMSy5dpt5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131383; c=relaxed/simple;
	bh=7JIvo/Sb/HpF1keyIU3/hLDuqdnbeOJInc1bPc0DAGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SSM3UHok8gdkD/LdM+r57C6aCHqgpwc0cAx+XvecEzYPCF3HxC/12DH8edfXAZB5isY+uHgnqT6kDkM9ecwNxI1KTpF0AwVOVUi4sswcc8FIel+XUjs6Bk4fdntYw2g5812VsVyD65v1mED6Cr8Qlj9+GlsNB91KuIgaxhy47VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkbG0ApV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkbG0ApV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B191F00A3A;
	Wed, 19 Aug 2026 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131375;
	bh=7JIvo/Sb/HpF1keyIU3/hLDuqdnbeOJInc1bPc0DAGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkbG0ApV7RI3qjbx/Sx+MVhYoDoY9i3a55nEqGZYi45ML+Cj8G8S2VmAmpWpBRXCm
	 KPrc63Y3DJ8LPKN8KoqQnQbysb+C6juMLQjUFQcmtOAtAxACFQsyTOLtHmHviddNZa
	 nNjY0U/1x0fYKxo67NHTu34ojHjdLyQhBZoUG+UFGHHUjqto2rr77m5f/UgRdVxUsb
	 iWwtTU7/BL4j+mL3/W4i0SQn5Ztx+AUJiSiE2bcR4ONtNyoF6lsfs8vr0gtqmiZUXU
	 hb6kvZXz/p6UFrGf2OoTKC8l8Y7N1a5i/bM7aFQMvW3TY02UcmIMLqdBmmGVdgoe47
	 22TSrZKraxF3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] s390/crypto: Fix missing cra_flags in paes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260819091734.7331-5-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:22:54 +0000
Message-Id: <20260819092254.C5B191F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091734.7331=
-1-freude@linux.ibm.com?part=3D4


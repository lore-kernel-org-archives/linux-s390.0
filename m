Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851381;
	b=Mvxcd7uKOWmYcRG62/eZiZ00gPMwwS+pa3Iv5H8PrZnQYvj0Zbx/pMeG3sWA7hTdG3xP
	 Sv5kK7HOLzboyI7/ZzCQdsZBJdx3ri09hSTKIEDMMC3tkqyDtUol9r2VeN3AGfPtdrE4s
	 ZPmjs3P4fS3xoIKgmhaX8hINVuU/Euc0P/IhudCe6P9l/vZrcxv3zxc+Tx+2HKDcZy/eb
	 KKL4xibylgDQg5yNUJJnMJHTWvMaE/NUxNMm/Tk0RAYU0v6DbB3XqY5TtqjMgK4Hbm6l7
	 p78QbHp0aJSfMpPabMqG4WxX6iqAKSPvm4F65daBpHOmEEvaRgV6d2oMwCnEMskJZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O2IUhQMhgviu7PtJROriW2TOoqfJg+v89q+wwmYr//U=;
	b=p5u/nYo0so7onZ4oNqoPxMDlHsO2m6507Lql6piEIt8/OuDYnk9P4FZKakQAp0FHnWj4
	 6wP4RUFTG3jbb3vlJe2zIF4HmrN57vLulsuPS5v3MRbRWRgPQgdHdDDu/HaPmQkaCqOX7
	 yheTpwVvuUBWe6VYWm9IY6NxwtuJoXfUMIuSBpINl4mDy/DQAKai3H/cfcKOzGeWyS9/i
	 bxrIBNKoqcJbq6yt5aFX3kzoMaFYJEhfhQOTBgn1qAGfssBnKKmPWN2DtzwgFq7mPvmlc
	 v1uBoYUgVqW0V9GsHdfkSFy+EzlUCq/msAq1XlFS/LCNcfPK+PhjfeK0whN9kfCaq5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGp2xLsB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A5606A32C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGp2xLsB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D3B1F000CA;
	Mon, 16 Nov 2026 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851380;
	bh=O2IUhQMhgviu7PtJROriW2TOoqfJg+v89q+wwmYr//U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGp2xLsB90SiRwJWBZMRu3uvS+ngxf/75GQIE3LhWkLrVXmMQW8AnDRgMga7nV+py
	 pdYLS8Vv4Jdu61eCbIGbDTg4GdzzmKvdsNPabqyDws45QEKk4Tsj3wKxUPx87bIq7h
	 t+MiOvqWcmMGT38hd0A0PSj/v9MkMvOZY1Pf4abUQ9DqTIKCotfn3dnfSx/r9HnZyy
	 4fH9bnhEQUo68kk31sDHdu8SHexef5y/nYAhGL9Oo8qN2gDEEi5S8lCVgdyVQSvRxy
	 +cd3zuIxro34piNUFb6sgWQvDmHX0YBKBWSJmNpxymLiTAxlP9VpzDqG9pw76KYty5
	 wjt16OKTAv1vw==
Message-ID: <sashiko-outbox-217441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] s390/cert_store: Fix keyring refcount handling in
 get_user_session_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-11-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:49:39 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> get_user_session_keyring() drops the reference of the looked up keyring
> before returning it. Callers therefore use the keyring without holding a
> reference.
>=20
> Return the keyring with the reference and let callers drop the reference.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D10


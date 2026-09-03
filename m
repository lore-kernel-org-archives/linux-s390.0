Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904D037C91A
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422206; cv=none; b=aQzbvficZmm/nh//c9M5t0bh+TjwKIOdbHMT0zqeMoRTSZZ7ktZB39BOR6Lw81Qe6bYreg1GT2LBx7aMYmyGKumXJCCwU1b6GvTn+zF7Il3+013oy+V0kHwqcVR1GH+aQQaEl9uPlV5yKXNK8e73/5CuCKZz+KCNtRyaF6GlixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422206; c=relaxed/simple;
	bh=xg4dkem8aVwwq77KlR9t6SgpF5e4aa+hZiXT+nfI18Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aWPEnfmth4TvdhCKCrNsx8r8GTMqTGJlgIvs5veBWiiwccrAN0LRnSxO1pIe8xKpYNx6pRJ+a9y92XQIgOs3AuhTSdTW5LSgkKXbgpzZrJtKQF0IhzP+mbQDljw41rdbG2gtm6epRgNNWQvdgsivKw8NoeOAtcA8VVrFpdj1xJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIk47naK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIk47naK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBE81F00A3D;
	Thu,  3 Sep 2026 07:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422205;
	bh=xg4dkem8aVwwq77KlR9t6SgpF5e4aa+hZiXT+nfI18Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIk47naKNK/+rMYKR0uJDiNDk6mUheOJpY/Ogq6odMPGPBxagAELuB6gu20+ybSvg
	 dcGBfqQmfKN3i85TYKZTua6KQv850gKyAjSKrNQqj5cXJZSniMiBlwYSHQvgs72APe
	 fnYjXsNXTRO9vq93PfqQUye1DiROnD2D1sHK6HGygFQwWJeAGHjo/1VlNPRjNPPAYa
	 3JUBYh8TcvB7DmbNhvsy5ucWZKEmetB+YWcB4tBMqqrLfXjITgYAnSltML85tiLs7h
	 gUSMmzcmKJ1U/XVR1MLyrIBy8nGvbCSgrarMc4SAkQFxPlZJKZOkTZ7cc6qKZ+t0R4
	 NHUn0WI2gG2WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] ARM: drop custom asm/auxvec.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260903-at-vector-size-arch-v2-4-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-4-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:56:44 +0000
Message-Id: <20260903075644.EFBE81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With the introduction of asm-generic/auxvec.h, this header unnecessary.
>=20
> Drop it.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D4


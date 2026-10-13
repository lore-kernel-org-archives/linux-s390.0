Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF851812D
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905939; cv=none; b=cTbcJfVs4Hhw9MkvXoxmszltuaWRCqJ5uZqfbEsFrOuULk8RTm43HITalsodE3Vlq7sRLrkLummbmJrP3jcocYDxjejRaOGXp0d0iPlmclaDVXB9MgLj90esb6jnc7nzw6Q7sawawViW85yvEy08x4VpEzVwvfqoFjmfkBj59l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905939; c=relaxed/simple;
	bh=YxG0axjZaCdHJuaEMZa2cZnIeqNGU0EQAQeJU76SGV0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Jsh46JZqGNiswnSKlhV/QU+lYTreVh8ob6nWSW0ESqjHGpm9MIHbVs9qTarsstilOJk28xbht55PTP4H2nEnMS9vqyK4MtghXaScKJCpIWp7GddKzMrId+t8RXuSJpapgeg9VmDT4vhLan8QIIEPfahUtdYc4CB+GPAqkymrJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCBKZVZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCBKZVZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DE11F0089B;
	Tue, 13 Oct 2026 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905938;
	bh=YxG0axjZaCdHJuaEMZa2cZnIeqNGU0EQAQeJU76SGV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RCBKZVZYK4h3GH1JEIoRWxoIZZY+AN2jAPC4dvh+cbX08EfD2IihMMqyY4F4axnS8
	 4yd04ufB6d+pdiuAaiQ80pV22N7WZUjM0r3sxsK0l5HWRI5qNdAWy25m/5ZU+J6uzL
	 dApAcjHxASJSv2dBUieCKEyI2Yp/ICoxI6j02u1lMOjbgooBiy/Btq0VXjQt2Jffzu
	 nM7qKvi6f0P1YV7aCrtXgaqwDDZwdRx+GvWAgM5i6kcHssF5RMweDrgTAhVMpMq7UI
	 yxURWoienubrla+IVvXTDs2N/3s2AUpYRSGaTuvy0ot7YuQKacZ4B4fOYJ2tY3qa1H
	 Q59zyhM35LMnQ==
Message-ID: <sashiko-outbox-170028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/15] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-2-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:38:57 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D1


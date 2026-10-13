Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFAA3FE34D
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903020; cv=none; b=rGqOuiEDM28uY2X5z38S8jSE28aCao23lhk0GzdPtOVe+wbq1TCMo8KX0mjYy9xK3O0+Zzm1TQeNJxnIWiI49W0hAB75kJgX1WueJqjcyScrwX0ipvB7RhgBTIkzRj9Oft2YeZkaCppWOyj0YT3GqLiM6AUUcdHBreWf12FGRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903020; c=relaxed/simple;
	bh=4FVWM4hBdkGU3/pL+va/kpribU0kSxJW81I9jYHLn8k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DXyDFM8YMJxd/5+z3twZ9cd6MDfGaMEyznAh0F36gGwmGnkpVvYCcMeMvEs/yyOYsGcK8qjfA4qfmkSps/9FV/Hb7OiJb0cjXp5P8FUPhodDgRJ0SEZeSO6ZiWGM6k6WBJ3DUiNXsVMOLiiTeygy3yKTi/S5Jgx86wnatkdVvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGdZ5m4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGdZ5m4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36361F00893;
	Tue, 13 Oct 2026 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903019;
	bh=4FVWM4hBdkGU3/pL+va/kpribU0kSxJW81I9jYHLn8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGdZ5m4dGDETO42pfOloEfSGeKNwH2tqKZApvxYIzkXbFIT8swPF5Bsi3EpdXl1vu
	 EYpO+gMiP1Yew7A9g9eoR5S+GEl0rFlmk3UXo7U/LiFolT3LcEZbLwwmgDakuWMGHK
	 AAWTzz33gcWTh3DilduxfTHpmB2eA7EeMRLrE3myzsPHVhGfJ02vzmNYE3QBKJ7N1w
	 ip1trxf/RW9gfQ/NeQjnlAfo5E6gqWwIr0uGV9hbz8zgDsDdIcu8koudL6OKlukW0V
	 Rju8lS28XPt/tGNOvOhOwQzPizgWQ8BFqwtpH5bOsns4rm+QrE9xAkWN494B3tmr9C
	 sSmigAD96FAfg==
Message-ID: <sashiko-outbox-169943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: s390: selftests: add ESSA migration mode
 PGM_ADDRESSING regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013144225.8885-3-ggala@linux.ibm.com>
References: <20261013144225.8885-1-ggala@linux.ibm.com>
 <20261013144225.8885-3-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:50:18 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Regression test for the bug where ESSA emulation in migration mode
> silently dropped addressing exceptions instead of injecting
> PGM_ADDRESSING into the guest.
>=20
> The test is integrated into cmma_test alongside the existing CMMA
> migration tests.
>=20
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013144225.8885=
-1-ggala@linux.ibm.com?part=3D2


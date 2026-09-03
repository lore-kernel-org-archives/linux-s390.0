Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96B42DA3D
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424440; cv=none; b=c7wdRKxr+okSfswJecfJKglokDvLfQVBL7g7gyeoLDd74j40gKOPpnLhxmJ/MeAHwytu2m9kIowYmUqy/+u1ECJ0G3B5Yn9bb4UJ6uoWvDmpbNFsh4cs2h552rxYmgaTzrwBbC2l/9B5Q5/QtImtJ3PYXdN2jsqCIkIXI/vpV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424440; c=relaxed/simple;
	bh=edos2CiDJ3CWC6fMtR/7plx7sjZ/hQNOECOLb5TNPO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V52LNtxVd2jqvUkgXTwmuaROZNlvAiprVF4TbwTbdiEy4JokUNCpfWEYW9mSSUOXR24magMEoe2fx66a5WCob0WVcVFzpmiAPQi0/FSY5kEfFWfq4Esoki7Sbp3WkH5MhP2ZJFZuDTOsijqA+/GtNxowGSwyhXWGwGoGJWnEKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arAofRl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arAofRl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB70C1F000E9;
	Thu,  3 Sep 2026 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424439;
	bh=edos2CiDJ3CWC6fMtR/7plx7sjZ/hQNOECOLb5TNPO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arAofRl9xwPfAK7F/EnoOhKdNj/ZZLTbyShB1c65q0rKhMH2TMMs+cxQTOXXBweZM
	 oSO8ceyq9Rd/MkgbEk54BCljI8HVBpZNXSmp9vnN502wDTophhLYQhYW+6+qWIQ8Lp
	 jvMZ1n6+aFQWvI1ywjlFjwtcrL3l7CGlD0vUlDWNmzAD6i2qdmQerLjqTLvpE8d++g
	 71Yb6m/XziyOvbdIwmEOH2rZsy/6CDjr3BBPKWr+B8xq0+bRH3zXKGMZtkhlAnOZT8
	 WfYEFdQg2dRBuL7x9KTW4nTfwWnDlAeCweC6QxD0cu5qLbhCt2cm2T8S4XFUatsJKC
	 lRWjMab9AwlAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/15] auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-15-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-15-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:33:58 +0000
Message-Id: <20260903083358.BB70C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All asm headers now define this constant.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D15


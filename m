Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBE426ED6
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421992; cv=none; b=MrANtJeRE9l9vYvkTvpehV1PUuP/SYDHwJCnRwSFBEIP34ysJ4+jcusQoqYks9uU95JC/FYRMcEzdNLm5Xb8mBVNujC7IeBllfJ1jMzjoEsy+HZbajrQ3IRsGHXTeVcU1zZEqJ0cxRgB3OHSSmalk1qNXxM8HJu000iX02QgxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421992; c=relaxed/simple;
	bh=1UMK8tlcM0KOkPGGD94G9LcVVxe2yn/M2C16W1KUn98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=giqRM6f5Rd34BPJlOJb6UEEr6/nKbhvC2sAfCPWMOH9VMfc/Z0rOk/3Py/3crZhtkIpFVOwNLclf3DHaabTSPHmqSeQ/fBua+riVC6xnQy7jT8i3gHJGgw8QAOaRzqwAeRuWj/YmrlMLB12R+ppvIJGmpi2Ww/0KFoCkLxP7Mik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU9Q2Peu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU9Q2Peu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB491F000E9;
	Thu,  3 Sep 2026 07:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421990;
	bh=1UMK8tlcM0KOkPGGD94G9LcVVxe2yn/M2C16W1KUn98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BU9Q2PeusG4l/vGyVFAAfM3OUM+RgTo46/jrOon/ywh4kKYlShds81WbOcZu783Xg
	 fAQBpkpC1Z+iAev7AFiBAv4lswJd+rzYUWL9N4Dd07tKgD56233sNW0OACFNP301ww
	 p5lzFkKAO2muQKdboyjO+7KN7h9NrY70MO9S9LbiPXGZZRVO7Y6kIV9mLCsnNl4VL0
	 BjCSQgrBCpxmqCeGEvCkXIPeW4hHi1OITp7QuvgD1B3xiP7I1pzigicFtWHNiyrhIs
	 nmrBf9Yp8TXOHhKhlxlopVfsvEFENDK0ZIfZB1KM5++U/2NO45gKuF9Pot2dc1feoS
	 zIih8bpmcKU2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] auxvec.h: Move AT_VECTOR_SIZE definitions to
 linux/auxvec.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-2-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-2-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:53:09 +0000
Message-Id: <20260903075310.2CB491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The auxvec.h header is a more fitting place for these definitions.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D2


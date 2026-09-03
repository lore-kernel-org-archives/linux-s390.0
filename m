Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9F372ECF
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423305; cv=none; b=cE/qXJtnRxD7x+vcZInNyPumsgsPtVd6Et/1KpztRV8uE5NnFrHLYre5Jc2Ya7HL+/Gl5Nn1LaibHfFopGQYX2kf3++gRoyidjatiNRN1DKOq6QyC5x//vlMDIPlGMyjd3+ILbawdmP8m2OZ4n3GXpmCH/O40ccAxCLuImqmHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423305; c=relaxed/simple;
	bh=6WC46GHTozZx6Vi7j+ejjOw9NOD6IwQ7y0KtQao9mpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CliJvJ4W9g5pbUhh++nrr30Pde60RXv7WnycTodnTvBN7mGt0hqq/gbk8iuNbw2qe3x1FWpUixjZr5NNm7GJVGSkrSRMasnzqX2SytFUggRquK6aNQ8neARwVdk8BIZB7kUcX6IACpQHW6l5DNC0V5/HEZZEuvEMjyFNnzxICf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoCMxiHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoCMxiHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5291F000E9;
	Thu,  3 Sep 2026 08:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423303;
	bh=6WC46GHTozZx6Vi7j+ejjOw9NOD6IwQ7y0KtQao9mpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IoCMxiHf0IZ9z9JPBbpTfytkfO+Tmoec5L3AHp+iM+ryJj7nYl494ZTyRuX+YyFA+
	 q3Rg1HOGrZS9MDrXey/3dDPj4qEtX3DYM7lkQ1+9Y2rr/tCqt+w1vy+qeSqP8SvEBm
	 yZ5rsbB0Cb3ePBtazYV4ulEDREWPzH0+QWkVipKmAnVZiIrYRycw9g7/hnkOt83ceD
	 /DeivmI760mDJBSKQa/Ym6YlFGnH8gJj+NQ+K931aAWg/sobC8r4M/aj0+I5worxw6
	 uqKnthOKCzG6Gh4fydiBmH/YLz1ucVN8wxFiQqtaT5y/Ux97zY3cTkBlz6RLz4sfn5
	 qdjrU7wB0iXRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/15] arm64: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-6-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-6-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:15:02 +0000
Message-Id: <20260903081503.5C5291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>=20
> Move the symbol to a kernel-internal header.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D6


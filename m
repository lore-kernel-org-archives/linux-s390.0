Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F944062C;
	Wed, 19 Aug 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163914; cv=none; b=VNlt/lItdT2Df7ot9u+CtqMZCjgmRVbtRroExk9SB/93zXuZIBpFjESJsqFdMJb19p+XRIkOKA6+n5mYTg8lAhhfvXBzH07ViWOtpAlD3svbjhhPES2+JMi5IPvEWSvY5uSzvCQSq7/75T8ltvhqkEM/0aqIgObL+o0WZ0zW094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163914; c=relaxed/simple;
	bh=mLcXq5+pMgMHPfPXvCuzFVVwDkAeHEeU0HreAH9vo0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BcFPbJSh5bKlDxWtR/MVKlDzmHYfL7kCAANDIgJQberkOHW5JTkwlGcVAK+LgaIb9TqX48QKpKqUHP+R0DwuGQR9eMgOXpNmIcal89fEiOts28ysGizY0kDp+zpOIlNIzIQ6E4JAqJlj3Ioj5gM74hBx1yH1OeVsa2WYrGScIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8EL306h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8EL306h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAC21F000E9;
	Wed, 19 Aug 2026 18:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163912;
	bh=mLcXq5+pMgMHPfPXvCuzFVVwDkAeHEeU0HreAH9vo0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8EL306hGz/jNcJ58VpjE9XiDAyD0xL92FcFo0ixnNO7+dlxOCTaPXdXgrI/XfPCJ
	 3zbICaMn4T2v5C9GDqpCM4B+ijioY5UXY0lclgVXfpUAgwTIsyd0xptMMOezh5uEs0
	 6E1xVO6U8moXiqskt30oate2E9CIIyAC9gECQjEamSw963cO+2iQxXEm6cOYDSnKIZ
	 5Lz/4kjavbKln4Tw09saM/j4pgTJG9uulXNDO2AAMZeuci4bP54n4yai3UOPqvVGsZ
	 ZfjIuV+YOd86Kca8ZMKjnwv9RYgOXgLYM8IDUKiLFLHNRdUsbjLAXD3PEkK5iYpF8y
	 dm6/xBaHv7Agw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 06/13] sysctl, net: add
 register_net_sysctl{_sz}() wrappers for MODULE_SYSCTL_TABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, mptcp@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-6-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-6-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:25:12 +0000
Message-Id: <20260819182512.5BAC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a MODULE_SYSCTL_TABLE call into register_net_sysctl{_sz}() for existi=
ng
> callers to automatically use it.
>=20
> Add optional 'template arguments' to support a dynamic table/path defined
> at run-time based on a 'template' available at build-time.
>=20
> Split the update of callers with template arguments into separate commits,
> disabling the macro for now.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D6


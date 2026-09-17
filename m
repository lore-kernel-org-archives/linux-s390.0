Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BC49D59F
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673453; cv=none; b=IKIZbKQ9E+QPUnO1Eq9cUILVV8dsF2J2Pjy7lIKNry9NHJfiGsrSLGBZZITSxcx94NSKKf1OBNMY2xX/EJnz21yoyBGLC3cWrChltrQ0EupmGJg/MDmW/r4o7FU1WMwMWimAnx4cd6VyN/Y805FqFVyO8uOyfdKSyHFurZCN4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673453; c=relaxed/simple;
	bh=RC0KiXDQRb6MLDwNs2FSQmh1hxenOUmNjjRQlU0FVTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p61kwayiMjFnd6TrhdJvYSpjFvdjVY7SpAWEmypeW1fvwXibqHVIxHhoWM14ukAKiuvM/h78drerdV8UA2D1hrfetzi2+BJZq79/Iq2zGt9OcLXu96XoVL6n4gvWzBEeuULDjHFdUuB/r/qL4QnLrqvuS54sa1jcMIsUpsuCVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcRhV3rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcRhV3rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA06B1F000FF;
	Thu, 17 Sep 2026 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673452;
	bh=RC0KiXDQRb6MLDwNs2FSQmh1hxenOUmNjjRQlU0FVTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcRhV3rn88g/hinbIKcu/hXUczO9fCaj3JZbcJ2DzVhG5kLSZQRVqY0sZrFiZTRaJ
	 8YOlIscs3EkidpO2S/LtH+0P8mojLJ6grKwJYVz3wgP8vbU8Q8JY6RopKyu0Vvu4dD
	 tKIUlHWj3x84GRrjUDU0FiynlBJNGKsusPXsuS887SCZL7uWomPpbgNduDeLNf7QeB
	 n+xqiIqis6954XS4SXWpFdEgkFA27CUhg/MqIpTK5keunKidConauuKZOGEiNbXyaJ
	 WM+g3WRU9nvflxP5MKeZ7T2GT4ZAaE8UTdI9JZ/OH2USzMYIk32gBvWCc+twmEjiS5
	 OObgNsvp+yY8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] s390/percpu: Use percpu code section for
 this_cpu_xchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917192237.638324-10-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:30:51 +0000
Message-Id: <20260917193051.BA06B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_xchg() to make use of percpu code section
> functionality in order to get rid of preempt_disable() and
> preempt_enable() calls.
>=20
> Consider only four and eight byte usages, since there are compare and
> swap instructions for one and two bytes available. For one and two
> byte use the previous simple implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D9


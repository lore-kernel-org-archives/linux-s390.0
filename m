Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117147CA73
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819603; cv=none; b=mO9I2mGVG6lxB35uEbFndFw9SS5oIi3UZmi8f7w91oFG6lzKDd1p0pwJagqrZyGdl9GybwLEO/nhbyPegTIBg2zQgyFUr3sI5wD9CXuXwHbPOlaCuD+35KmFmcYLxRq+7o/M/xs9GJX+d3EKs4i03KgFfITlqgagIV+9unaVmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819603; c=relaxed/simple;
	bh=R7DOvwE3m+8EZGQWFGK2RXmWm7GnCLpx8T1AOvD5tHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ckpbonrI8VMfdvZfRN3aYePcB6+P2pcoKo+A9cdXZkaa8YqoifGtvA6jD3/I9747w+bdTZFk1jBob5S+iAAdsA4S8H8swkwqkkoSzrOanXxYKeMzXFKN5dFzN2G1UNFHJ8oaZCMzc3jiJtvuIwg6rTCkT0NpyIpOBokVfHL04Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7rM1lx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7rM1lx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAE31F000E9;
	Thu, 23 Jul 2026 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784819602;
	bh=R7DOvwE3m+8EZGQWFGK2RXmWm7GnCLpx8T1AOvD5tHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R7rM1lx0jXibR3nCkzUiJ+5kQbzMOfwlxlx0o+tQvOwYE7B6xF4/8G/M0V0IQALwv
	 +/CNX0wzTjndn0TELZn2oiOROgVuQUaw0r0fnAvSRqgxT8i1PTExSZ610Z7VknU9GV
	 OrnvPdwwk7U3DvWnvxhPIS+wFE+hLDUIv+VJdCijkXGKZLBEYQUyrkZo+7mOJ5WGoV
	 s0xI7p8YVnDu9801fbEzyPl6KURyrsNrQjmzbkXVZI2xZd4Ll7ihJc1qi0J1PCmda4
	 IAmoeWM/5mcUnzkdtqlpj9vMyXbAA7pTMiIO7LnuKQAJtyI4C4KiW7mDbWQPf5mmqq
	 3Vudkcs9mvZeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/ap: Fix queue depth field length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Finn Callies" <fcallies@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723150038.93617-2-fcallies@linux.ibm.com>
References: <20260723150038.93617-1-fcallies@linux.ibm.com>
 <20260723150038.93617-2-fcallies@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 15:13:21 +0000
Message-Id: <20260723151322.2CAE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The queue depth field is defined as a 5 bit field in the Z architecture
> instead of a 4 bit field.
>=20
> The queue depth (qd) can be in range 0-31 and is reported in bits 59-63
> of the TAPQ response. Currently this has no effect as all CEX generations
> report a queue depth of 7, which fits into 4 bits. However, future CEX
> generations reporting a value >15 would not be properly reflected by the
> ap bus and therefore all user space applications relying on it.
>=20
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Finn Callies <fcallies@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723150038.9361=
7-2-fcallies@linux.ibm.com?part=3D1


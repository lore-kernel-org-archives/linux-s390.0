Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8411466B44
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038336; cv=none; b=TeGxBijCrVrFjcoRev6ayUukeI7g+b3GAR6DIm2dLNO6zvraKrrJD22022r1+iVQaQ/TOHO6z4PCuUpTb6wAjDu4riBpsbtIYiov3+HPtkW8kw0y5WLoVwn/OpE5fBDONsAkxwxNovYvslTwYPcFVELpf7nwvawKtGvwmD6GtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038336; c=relaxed/simple;
	bh=bSfeegS2rBZwbYj33pxN/+YMlvKFeyUR5GQQ6GMV+6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n4ayI6Vgy2q3M05SApT+M71vjr5XTK6+AEBANQlRe9CRetz+sNOve8FUBFOGn58gVj9B7SpqWiYVaGpgQhxoLQXG/RBO3IMQPgN7pfgiJor+fGpHpzkeCW5Wb8ndNNamnaIMLUBqjHhPNU7377ZS7ZitHaaYj2Uv6yxhYBMhGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJvbXMgS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJvbXMgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513C31F00893;
	Thu, 10 Sep 2026 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038335;
	bh=bSfeegS2rBZwbYj33pxN/+YMlvKFeyUR5GQQ6GMV+6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJvbXMgSSK6P0Xdy0fs4eh05Zt1RQZjpqoror6oEbHP8kN9ZM0gR8850rQXs3RKl0
	 uX+9E9et1Z6DTvRNwxFY95BdKoEHjLlyhWg5hEg8Dq+uXOOANxLJyUzK2SIGUlgvT3
	 oINx7lPbnvwPEAXJ7leFmm2BF6yT+gx/q6Vc/3i7+aPileF1UPrDIsRr/YsiTgMTCD
	 gIrv6aMyQlVoEKFpt8gcoFPcaV8cp/6R+1wo85xMgeVYnPS8ff1OCPoH9WucZnzb0Q
	 nAl2fImhTYGY0P0Z80qFdlHoHb1Xj63zBYzEOTD3XoSSeUZ0W5/jkyLvLRDBLDD4NV
	 5o8rXOHFkI1mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] s390/chsc_sch: Use __free(kfree) for
 synchronous CHSC requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-4-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-4-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:05:34 +0000
Message-Id: <20260910110535.513C31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use __free(kfree) for local buffers in the synchronous CHSC ioctl
> handlers and replace their cleanup labels with early returns.
>=20
> Keep the asynchronous and on-close handlers unchanged.
>=20
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D4


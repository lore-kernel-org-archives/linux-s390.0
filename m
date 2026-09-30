Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190C3BED69
	for <linux-s390@vger.kernel.org>; Wed, 30 Sep 2026 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752485; cv=none; b=ea5q4Fnj8mY7Wy7AvP3t61mey6dICNq/hTTSi7bJpkvQSx7q65izIJ14xLawosACEaadiPYg6WzHdjqbw7a+eTJpL8o8NYp+BQiy9IA4Pze/Ep1r2tNnROe3bpa4+KFiO8/axj3MC3d8oMips1WXc/yTmRLNaEmVKJOfZYh3O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752485; c=relaxed/simple;
	bh=OmDCllYGKYdTaYERHwSVz+iz34xj5ZEst6IhG05OZ1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H/p+6p4CkFiMm1jRQTSuTqeMw2tSOltAi7kZLYT1VktfhzCttglUKGgAaC9A0g+L29i/ElZDtkBe5NC1HdNJKgJ/YRkufo3lnJ6x/jsSQA+UoLb2gvD1WTEtzUhkHs3y0O8CV9H6frBdGUePgqjKEWb34JGw4x57xTsKHlEi6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPMJuIJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPMJuIJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE991F000FF;
	Wed, 30 Sep 2026 07:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752484;
	bh=OmDCllYGKYdTaYERHwSVz+iz34xj5ZEst6IhG05OZ1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPMJuIJEqXvZkmlnTGICZ9rKw1FJLW0a2S+5h+JThVvKG1PvMzv9xzQcpxg6Ejkaa
	 fjOHMdeimg+UIkCV11kN6/y/FZHUgWoXh2FO35Uk8ZGJ/TlIPVidoCwQltEIx1Cn2M
	 stlrbOahh3I/nhJ546ilFxFRd65g0/CzFN2fc9Kau6t8/E7moqWaYAzt+DA5NHjuS5
	 eVv/KdZWMUv0mR6A7a0BYEJPqilW3BBS9YeRD26rzeeBp+tD+bedNCXCMUfuZbmK2S
	 LTi60kwqkU2cQUsB3nPWVrkLVdwconrAbsE/62TCVNMp04OhGDKBTy7DjMd/c670rj
	 n2oagAMEZhqQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/2] s390/ctcm: Fix timer corruption in
 fsm_addtimer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260930070234.569500-2-nagamani@linux.ibm.com>
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
 <20260930070234.569500-2-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:14:43 +0000
Message-Id: <20260930071443.CAE991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> fsm_addtimer() calls timer_setup() unconditionally before add_timer().
> If called on an already-pending timer, timer_setup() re-initializes
> the timer's list_head fields while the timer is still enqueued in the
> wheel, corrupting the timer list.
>=20
> The timer is already initialized once by fsm_settimer() which calls
> timer_setup() correctly. Multiple callsites invoke fsm_addtimer()
> without a preceding fsm_deltimer(), including ctcm_main.c
> ctcmpc_send_sweep_req() and ctcm_mpc.c mpc_action_side_xid(), making the
> redundant timer_setup() in fsm_addtimer() a real corruption risk.
>=20
> Remove the redundant timer_setup() calls from fsm_addtimer() and
> fsm_modtimer(), and replace add_timer() with mod_timer() which safely
> handles both pending and non-pending timers atomically without
> corrupting the timer wheel.
>=20
> Fixes: e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@li=
nux.ibm.com?part=3D1
> Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
> Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930070234.5695=
00-1-nagamani@linux.ibm.com?part=3D1


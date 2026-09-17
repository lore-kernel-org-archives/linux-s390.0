Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22F5221C1
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651346; cv=none; b=hK+GMXmjjlNVSr65TYdb5J570k2igUxfEO76Jwq1exrX2t4F0kkmr9zbCw5S0Ewe7fbkrgNe0R6wWNKXetWb16JDBpTVKFa0D5w9ketjVnVlgBC7tpYFV44AxQcoI/Owfp4zRipwLmCc+jbasGpGOD8vYl69v5tcN4MbGchZzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651346; c=relaxed/simple;
	bh=hCIDNDmfISR3mC2KKaYti34bLcPpwkI1bKa3L6QhIM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Srtsoe97jTzt3GGvMlhdxFBegXNtbLPf/5hoTl6f8zVUMf5NxpgZZBG5310qZu009PXpxlvhbAd00W5oaFv2/hxsrpo9Svd2hHxz3/Sx+OSj9d9fR6AT2Bz1VawrY9I0ARyrQEeBXqzZIk+b9jOE/XX+SJl/MBb5DakzqzOVLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZpdrIgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZpdrIgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4E01F0089A;
	Thu, 17 Sep 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651344;
	bh=hCIDNDmfISR3mC2KKaYti34bLcPpwkI1bKa3L6QhIM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZpdrIgTXeQ4Gl4gh/uvTOo8fotu0GdSotyh77NhdQg2i+YV8ongjG7jwsJ6VVv4O
	 5nLsMXif/glAnfOFuDArIFyGRshUfBu4DIsEnGzsgl7B3u8z9HoJiUUYzf67ob9hPu
	 4rtEWMppir/49/cazIwbU4Xp+GrfKn2hdV/aYSwPi4aIkL+bMQMzfgDNp7GiRJ/MjX
	 ejENnxnaRG2h9gXMrbJK17LMeH/ozSw7HYZ4UxG2gBTmF9jPKonuS4QY9cjS7K4W++
	 ts8S5Y7LRnZ0RYR28NL6SJ8pG3mW3jm+6OCv86zORZxmCDGuHperZk1t1UfEgLESnj
	 NAyWanePQUVRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] s390/ctcm: Fix timer corruption in
 fsm_addtimer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260916132149.4185912-2-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
 <20260916132149.4185912-1-nagamani@linux.ibm.com>
 <20260916132149.4185912-2-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:22:24 +0000
Message-Id: <20260917132224.7A4E01F0089A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916132149.4185=
912-1-nagamani@linux.ibm.com?part=3D1


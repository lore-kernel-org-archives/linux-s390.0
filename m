Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD543711B
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158783; cv=none; b=Ylfoj52Y1AKF2kWOYLjc4Q1SElAkxhLQVywwkxymSjZdOnLwLLy0NGTyVzkpOUZI3bl5JK/kans9piHsH5+8ogyagTrS5mG1IUUP0fJVCYWBJ4GUr3cz6d68dUtiIzDeHEMCDBvJjpIukYwwwMKuGsK5fsaUZPOC64jt2fEpu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158783; c=relaxed/simple;
	bh=XS7ulJaiU1Ap5GGyXyQ/Cgl2tVrOskUSUSfLTSnG+fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwmE4NPOx8PHXv8tn9xF5IKxrSrFyuS05MmJjQBZK/T6cQiFwhg1gjsZsnLXYKUCJwl2sbDDSFh6UuYhTkYtKS0UW9NY57Zxcb0PPcFZMSEsZZ+pF81KQmUA4s7EQMPifVheDsUIGUhSIvLVSYpa27y4FwdA4+IurA4hedP6+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDfj8NZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDfj8NZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFEA1F00893;
	Wed, 23 Sep 2026 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158776;
	bh=XS7ulJaiU1Ap5GGyXyQ/Cgl2tVrOskUSUSfLTSnG+fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDfj8NZrCxpGBD6wJuPiN2bujRIXzisRDwkUTlouFJRjOgTG3MGOVJcvdkpaA1T9s
	 1GYo84dgPhlWs0rDRTMI7keVDvdkVc/EWoa8Z/s10sd3Or//9kqQ0KxxNHpiJFL62P
	 pq8puKN9YS6mjjOdD3KyRy5wleVIj6vtzm8PK1ZAlb9lIoegR15n+Fm/fUDyUBR0Sz
	 /SH0a8GC6GTBp8QAVpBxUBJy3+mVtZjY/jlopFY2JQK3vJ0lHJmtSU7fWdmqhuo4+A
	 sQM9UNXTAPyTATS/L6KBIJXq6A61y7OJPV+tPV72CpQBJ+bMhbOH+V4gZZS2eRlVbc
	 zpnHUjvBH9S1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] s390/ctcm: Fix timer corruption in
 fsm_addtimer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260922101913.239103-2-nagamani@linux.ibm.com>
References: <20260922101913.239103-1-nagamani@linux.ibm.com>
 <20260922101913.239103-2-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:19:35 +0000
Message-Id: <20260923101936.4CFEA1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922101913.2391=
03-1-nagamani@linux.ibm.com?part=3D1


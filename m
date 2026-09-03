Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB114A92D8
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441451; cv=none; b=dDspChAIvokrOicG+1ce6RMMcc9tMAGcH4avkfWV++bmnqx2APr15Ze7HRwjaUphJ8cFAMfEo5Qty8mmS/3naFtYbnrFpxFZ0sOVUx+WxFBFrcKgLO665WXRJWzA5wfABcotsCDpzVhrXFWIvjvwHiEiTXwsC6DS7ncyPtx7y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441451; c=relaxed/simple;
	bh=CNPo7RgHW9pjAgSH/+vMdxUMrzIFCZOBmJkTitNuHbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kOm8THqlLmK+tyB6MHz0z5sy8rUx7Mj+I1mOY9wl0RYHj0rBLDKSCxAE7fzu6R2vvZZZysEgwL05s+TBzhEURuPzfAqz/gQbdaQAz2BXOmxtu8TbC8WJZHzy2rpVTrB6QR6DOEx3WY+X4CQvEiNKqWcWpdu49TiaE6dZvEOY5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6RsmLbX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6RsmLbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0C91F00A3D;
	Thu,  3 Sep 2026 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441439;
	bh=RXDJBva9TWY3dmDHtiXTj3JJf0rpL41mvitO5Vevhyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e6RsmLbXD2HknHzNedr2tZQSIdyTEJetNOuiYo1dw0RgNjC8rUhBmCnob4Kxp0odL
	 O6VS+jQg+sEvWXnkm+xVrSvIQmLzUeIJeSGfZwnEPPj0l2szEgRsFWheKVvnWpPJQe
	 WjVz5taDRJiokv1Xnh/7U8PMP9JlRvfBfKPlmoTcUQdfM19m0iz69VEYH6ejtECSMz
	 kYEFAhjY5e6aIlTXh4FQYv1ZiOPR5mT1pi6WjdzD4Q8t9GmSmetCE4H/gP1rCEWGqR
	 oC/qe441vgLBWDApPu82JgTLfLAShHzXV04V/ZLDWr8LM7YDs4Ewd8wIZZVb8jFbM4
	 LwZ9zqt+kXDOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] s390/debug: Do not repeat parameter override
 notice on debug_set_level()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260903130733.709001-3-zaslonko@linux.ibm.com>
References: <20260903130733.709001-1-zaslonko@linux.ibm.com>
 <20260903130733.709001-3-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:17:19 +0000
Message-Id: <20260903131719.5C0C91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit a2cec6863709 ("s390/debug: Add s390dbf kernel parameter") calls
> debug_get_param() from both debug_info_create() and debug_set_level().
> Since debug_get_param() emits the override notice unconditionally, and
> drivers typically call debug_set_level() right after debug_register(),
> the same line is printed twice per debug area:
>=20
>   s390dbf: 0.0.1234: override level to 6
>   s390dbf: 0.0.1234: override level to 6
>=20
> For areas registered per device this is multiplied by the device count.
> With 's390dbf=3D0.0.*:6' a system with many DASDs emits a large number of
> redundant lines during boot.
>=20
> Add a quiet parameter to debug_get_param() and pass quiet=3Dtrue from
> debug_set_level(), where the override has already been announced during
> registration. The remaining callers keep printing the notice.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903130733.7090=
01-1-zaslonko@linux.ibm.com?part=3D2


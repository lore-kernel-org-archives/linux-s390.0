Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E3356749;
	Fri, 28 Aug 2026 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953958; cv=none; b=ZGE09oNL09cY/M/Ka1l4CkxKIx4CJNqnVvJ8YHzTACsgnKHCioxYc8Ok75BscH4L1z3qBOkDLjuPegekFu1wh7dwiuHwvOHsRjow7HK96cftElZQJCDH3AyAsfO/Gl3O+dnc88MYPy0On8dAWzCSnWhW9PFh4VcbABv/nMPSd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953958; c=relaxed/simple;
	bh=Vtz+9uUvbNJHMwB53+v9iJpYdJQy4+tOSuInQ2x1Auw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oVGZ6yoaVaMic7jI+h83VT0SgsLOHtjC+G7XD/DI2/mkmyK3X3reBeCwW34YiqHiX3nC6SJAC66adJuZ5FF1iHnf9bs9Io7zl8Fj8NO58rpGEhth88yTwmp0L/iY+6Kr4rNG3/LrHtbf/sf2phHH1wSd6JSHIy9d/jUckJTGWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR8SpJnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR8SpJnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59061F000E9;
	Fri, 28 Aug 2026 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787953957;
	bh=Vtz+9uUvbNJHMwB53+v9iJpYdJQy4+tOSuInQ2x1Auw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dR8SpJnzcUFp4q+hJc+xB6JbICgZ4Rc0LtIBdMhi1ZsqYTaRs8uBtn7V4DySw9mCp
	 ViyKLTVaHOOr7MasvLbCncbbk5+TdXJSSChyWcuZp0z4tLkwMswA21esiPhRda9M4q
	 rUSUIf1MxDIzkKV+qd1BXXKt4T3vOAhRYFQnL+Siee2MYgHOqbAVPoOsAU4lNnTfd1
	 CySXxwZZri+WNLeIWfXPV9K/gGe8RKPXXNtNo6imhEHGfqN8R0TiKVcdoeYRUnKFWb
	 tV+nPFX/quOWnaIE8mffUKTxwnxDfcNssAmSVFOCpPnrvSjjyxbia+BwTRovzhG8xP
	 mvzoyshZzOa4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260828214653.1087009-5-akrowiak@linux.ibm.com>
References: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
 <20260828214653.1087009-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:52:36 +0000
Message-Id: <20260828215236.B59061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Domain and control domain bitmaps are sized by the AP_DOMAINS constant, n=
ot
> AP_DEVICES. The two constants are both 256 today so there is no functional
> impact, but using the wrong constant is inconsistent with every operation
> on aqm/adm bitmaps.
>=20
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
>=20
> Note:
> This patch was submitted in response to a sashiko review comment pointing
> out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
> fixes included here for those also. The subject line was kept the same
> since this is in v2 of this patch.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828214653.1087=
009-1-akrowiak@linux.ibm.com?part=3D4


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924F320A37
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823690; cv=none; b=a7Tb1MmUpIj2mC+CceWaiooo5YBymQNP3lLNGmmhGwGN2WgMt8xqgqfpSpGiu9kSDgdiLvDXtixnUYJquLPbb7YAtusO7Q0BG5GB8Fi9taZ5xfwuskOQqS0cM1dUTDb8BpDO8ZIx8abAzmOO8WiJFHqa4DPtCpmqLCYPOwnc7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823690; c=relaxed/simple;
	bh=BgHH+xfi6n/lAF5HbOe7dXII88a00nrxWHtiQvDwrwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RsQCl1wZfElhJPauw1rp09pNhjrJW/rn0RYPTe9Mxi5F5vYcCJiVYosyr5y92FOuS3E3oHoGngKqAJGD3EI7eqZmneWjNuo+vByqH85QbPK73xr55GTBeD7Saax+5cExwSP6lAQTaHtfFr8wsXiBgtyudmSyr6h7pYQBMY6rjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLAszxBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLAszxBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2771F000FF;
	Sat, 19 Sep 2026 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789823688;
	bh=BgHH+xfi6n/lAF5HbOe7dXII88a00nrxWHtiQvDwrwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLAszxBcGVg+5ufn7+loy68Oy/bZF2TIwFM6qm7nKItck1fohb/sxJy3pj49Nh/sg
	 hzleN9XnDTixBYiBXd30/zGtOZfWhduLzIc3SbNtbwfJZcvdHvG41YKLRUnxTIhoL8
	 6tRwLWgMRG7etHzqJruqE8kXajjyM4mapTgaKMUCBZZjk/Q2Z3SWgsGTGu4k9ExxR9
	 KIaiT4ENLUsdqG0zkRfCM+5AMPI/AV+yqvSK14E7nxeL71FFj1IrLmgxFatvQoxoNe
	 UB0KzNzNV4evOwyYfjiVWqWBJiiVtLqLp5bQAmhToZysiq/kgiR8qb4vs50GSUCcOI
	 awUNQtjUyuUgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cio: use assign_bit() where applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260919130844.3041591-1-peng.fan@oss.nxp.com>
References: <20260919130844.3041591-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 13:14:47 +0000
Message-Id: <20260919131448.3E2771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919130844.3041=
591-1-peng.fan@oss.nxp.com?part=3D1


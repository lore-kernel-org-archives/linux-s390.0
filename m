Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDC30566C
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608561; cv=none; b=p7kZCpmsDX0S+u/tmGHHQbuhwTyHNGJm2LjTlkHAgFGRL7G7voqGzsVp7Huheul3Kp7UaUX5O5fZeki1SrXXnD7GUSqukqJ5frKCrTTFTTVK/eQLsGw0dv+iOyhvG1STwJl05cBV+BRRWHxbNRHiH9vCrRZM9RTtNDrEZZqTDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608561; c=relaxed/simple;
	bh=QKU/QXiqDHFiq/tq09rEkNxD5MRPCu0FQp9aC7HlfRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E7lPZzeGXqoTu3JmLviqaD0NLuwJjrivWYUdDIuPLxBpVLNkdOaVcyJtmuvg4xb+FXYwXeQuNBcemNbYnEBhM51pPeaYTsH6rRWw5r0s3QFfFAhqQuzRd1NqnycDP08LdPI41G7bsa4AcBMfhBhoiTj8FXblvd7OhLn9k15LfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWHe2m10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWHe2m10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411901F00AC4;
	Sat,  1 Aug 2026 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608560;
	bh=QKU/QXiqDHFiq/tq09rEkNxD5MRPCu0FQp9aC7HlfRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWHe2m10E3VAhsj+JwiK68RKoMAhddDFYevbwxJHyfK+jJ/VdsXIBUjYtcShgTpQP
	 llElienTZpCq2cPWPPriQrv4jN8PLriG4bdh6rQHHA0F4YsmPjG8oVUpfjEUdRg2N1
	 i8Klt6Q4ASWQhj8QMtJuFBNNMWqHt85t2+Pq0OmcKEU5zW+0bmN6Ihm5YTumIGupY4
	 PcgAYOZ52SAdFsQwwC+eNb8/U9pG8zRuLS0V4Xsauww/BzILbvgVvDAXU0RpqHeEEI
	 l7TeUwmPNGHsWXUZYYpId4d/pgXIvP1GSNci09GITF/NQ32McAt579BdEcGrkhWHn2
	 VZKoj6JaHNYmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/19] s390/dasd: Report ESE capability and format
 mode at device online
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-18-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-18-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:22:39 +0000
Message-Id: <20260801182240.411901F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Extend the device information line logged when a volume comes online with
> the ESE hardware capability and the on-disk format mode. The format mode
> (full or on demand) is derived from the on-disk format label alone, so a
> volume that is not backed by ESE hardware but was still formatted on
> demand is reported correctly.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D17


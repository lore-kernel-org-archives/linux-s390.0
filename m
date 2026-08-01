Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99C37DAD5
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583229; cv=none; b=hhSKpWjf3EmUQoIzL53ALN22WPyhdoYLevVJn9MmI96rw9Fum68mMtaEYIqDbXhSkFEo1+5WxgPHMVICAayQeDj8qf17dwJkWYtnkOXHFDa9yFyhTRg3xqsbnaMq8dpLzOD6sCLMaJ5Lv+p4d2lWjFLZWDJTLP1sZ06a/l3NDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583229; c=relaxed/simple;
	bh=++mq0qa3bYpqO8QaU/7/9rh84x4/GgqY2cHDebA1KHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dv63alNObNGDjrz1NIW4rmD5oLUyfi0an6ybKUHxNzy/m8mf09lx5X1UD2/un1Ku5OBZqOqwZoTfXPboTl1Pl1yoK3y/AykEKeU8mZd+TRPk2BV1lXLtpLTMqPHowudy9eKzp9GsIBqFJ0lImQd/DXGq3ezZsR92SZxR8d/GCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0BLzj4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0BLzj4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A371F00AC4;
	Sat,  1 Aug 2026 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583227;
	bh=++mq0qa3bYpqO8QaU/7/9rh84x4/GgqY2cHDebA1KHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0BLzj4KrE97x0xgvX/k0L9WbWlDbpZOikgkPIPZdedcum3DMFwmTRYuBj5C/EPsx
	 SCs8HrRa/28BvaceYbiEfl5ZXWFo1RyuxaKlSz4AT1GtcMxCsORzfqLoADQFsupTWL
	 sZKDNgyLSBs/N2/bBbqnCcRath3xfsqv0JHuDsVNjgdBX3qNfa+u7oU5i57ENIYW0C
	 HZsV5a6JfSqqP44Uauy9PswkPPHBhhjPfV7mMxixAf3/XJ/CBqGTfRoL1baQJ4Iflw
	 aSLFohHJILrfgzv/ly572hWPLYI7cGwLOegiJvFyuu7+uUvt+6JsgVTpwwseh61/mG
	 pEMH0cHtiI4Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/18] s390/dasd: Optimize max blocks per request for
 track alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-5-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-5-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:20:26 +0000
Message-Id: <20260801112027.55A371F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
> DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
> boundaries (15 full tracks); full-track I/O is more efficient than
> partial-track writes, and 190 had no alignment significance and could
> let a request cross a track boundary.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D4


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9543A7FF
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149943; cv=none; b=klhV+GQoRwPYl2VDNo8oABrQgcIGcXZsQu4zgHIg1Q4Gdiuw+uxLagZ79NBAqo+72i3oBB2nSF2mulbxT2BMdz9IVrT4KSt3XhmbSkiUjUxUYTE/H4yeMmItUiQG42uvX9S06UqfF7ObOMTDbpbmmwMBm39ehB8S7QI9S5a39EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149943; c=relaxed/simple;
	bh=J2c6QGm3zyU1l8kUbYVRTmXPm16hQfRhGtd4wDcJTcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a7dfEJQ7o3pjPOVFlnSULG8FzUpJ4BsUbOStfuC0xx0m7LuKoYUcqpLjxGdH6ZTAZNzNZiQS1VcXOGgadaNn8mAGoCoJ8e1IXrNltaCMZGc9MaTzUtgO0w3EQa0+hSscw8+UTsblGoESR5QvlAX8uw7c1+iMxtEVAMjmjXoCSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clv6SiCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clv6SiCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBCA1F00898;
	Wed, 23 Sep 2026 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149942;
	bh=Oecl+eBqCdmF0GphgASG8h3r8chs3+vjEEQXJXNzEYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Clv6SiCn6N0l0xffH23/GblAPHvxbqSQnqDgY4eeUsc7W9kqONb9g/FyuUrUZcoFK
	 oDYRvYO4dCoW4IynqUuOfFNJ+Z1H6Hxa5Nr2T8TfJL3TA3cjARzujtzVlFILnl1N3/
	 vZD81OnPnG9L6byVG4ysWutCtrOoLwILzyzThHx24s9VlJQR+02xJTocowaRVxcw+x
	 gXe7eBtl0MSDf+2WfjsgHulvqMw2XVi/k56ziRWGAd89i/oRVXKPVSM+GZn2uND1sB
	 cjRcFwGaFcsFk5vw0zlZZdshlW1kaYJ1LMelnf2s4qCJkL3QMkyAkGWRizcIg1oQ0H
	 7R/SwWbMEhc1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] s390/sclp: Introduce macro sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260923074006.3962077-3-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
 <20260923074006.3962077-3-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:52:21 +0000
Message-Id: <20260923075221.EDBCA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> sclp_find_gds_{sub}vector() does not deal well with malformed event buffe=
rs
> consisting of GDS {sub}vectors. This can result in an infinite loop or
> an out-of-bounds memory read. Therefore, abort with NULL if
> * the next GDS header would exceed the given end boundary
> * the length in a GDS header contains an invalid value.
>   A valid length value in a GDS header should be at least as large
>   as the size of the corresponding GDS header (2 or 4 bytes)
>   but also not lead to exceeding the given end boundary.
>=20
> Use the new macro in sclp_find_gds_{sub}vector() to iterate over entries
> of a GDS {sub}vector in a safe manner bailing out on the first invalid
> entry.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923074006.3962=
077-1-egorenar@linux.ibm.com?part=3D2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADD49B46A
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575407; cv=none; b=I0aVAMVTnZJi6XeSzVuM5dsELOvnEHIGX3xeCG61dkSGiZ2/Eooy/56mtUnhmiBpEzSeprXvcDqQg35bOJOqFkHMsDI6yr8TUa5KXA8n/OapIvaiPBaa9wz4vesphIkHw5byDFGadBV1DHD9Knk7HDEFv7ywPsUqiFatuLOasXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575407; c=relaxed/simple;
	bh=pGuS8RFSeLvwmchhifoYrSAak2/cyftjj/W+GtnOV8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GSZU1CVpz/beuzuZ5q+TxOaZ6MqDLKzLmdvwjpuJjpvbiQyIaPLE3xM1TNIthvR+0ya8QoXAB6xju6f+HYvipX5kNU2P894k/OHHaLJVMDe3err8u/ZBUs06YIsIYpWpKI306IZr51BiIaeRnCFUNI67OM1fBLLtqrFZxogLnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBSQY7qT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBSQY7qT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905971F000FF;
	Wed, 16 Sep 2026 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575402;
	bh=pGuS8RFSeLvwmchhifoYrSAak2/cyftjj/W+GtnOV8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBSQY7qTDql7sFTXAb2lFtoQ4dS72kyZMPWmVjaSHOqqKZj3yfqFXws/d1V++ScTP
	 vIdQ9O+H2DvMbZGo9ebiWPlTOggGFfVgwqnvKLj0p9acTtSQ8h+b3i3fzolYa02hoO
	 1C+m7KL3fm8dCftj0ghWbIZnmTnlyRJ1Y3XBCLaKwvmXGlXzOEwruT7BOXYKNqX50n
	 34FjMVNrSszIyReFlTG9OmBrM3ngl6LHbNlAyNwtslNTlOqA+tO7xX8ZVnhKNbk7dk
	 Iw/krOq/2kstgPhdKvo1TctVRS+ZOl1IaB+/Non8QFZmld2NX3XeGI1eihsn3z0Tro
	 cbErIoN0HAW/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/debug: Fix NULL pointer dereference in
 debug_info_copy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
References: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:16:42 +0000
Message-Id: <20260916161642.905971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When debug_register_static() fails, it clears areas, active_pages and
> active_entries but leaves the area bounds unchanged. Copying such an
> area, either by opening its view file or via debug_dump(), makes
> debug_info_copy() dereference the NULL pointers.
>=20
> Skip the copy loop when the source has no areas.
>=20
> Closes: https://lore.kernel.org/r/20260903132123.12F271F00A3F@smtp.kernel=
.org
> Fixes: d72541f94512 ("s390/debug: add early tracing support")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916160626.1988=
684-1-zaslonko@linux.ibm.com?part=3D1


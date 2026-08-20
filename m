Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CC46D0AF
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236161; cv=none; b=lS61fXS26di9W9HbnoFfUrHIX4/g6Y3aqVe9kpsOHDAr4mmSQfKQOUoId3CkzdnOi8GmtmlciEWmGlTJxef0C51f1FM/tUCqu2egOH4CmasP/wnJCrWxbGMZMnfFBqYb0OY9ltPfD9ViJ+T+pqGs7yK/3U5AlxqJN0C77+/7SmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236161; c=relaxed/simple;
	bh=fVyXXHB3Ot6+Fb2w5y5lgQ9OAk9lS2SPNu9IixPH0+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZVd6E9B7nWZw7Xnlo9Ki+dow+lkBJsYJXQZHPsagz/gmQ9UKHauwyK/0F99GPXWEKWv7QG2j6GKh3jHsXo9itO19HRpQFpBMNaOUS3lHWUJQHjt/jLUJu9A/wKDJf47p1fAOxVl2Qhn0kRnhHuf2E9uRhGdza/lxNzlHQ/wcOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhLyaMA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhLyaMA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B731F000E9;
	Thu, 20 Aug 2026 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236159;
	bh=fVyXXHB3Ot6+Fb2w5y5lgQ9OAk9lS2SPNu9IixPH0+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MhLyaMA8LYO1dYmS24Dbn5cp4ZH87hVstocB3KPHCizYE5gYlUlOl1RSWPCGzQS4v
	 Rt1TI45YgICB9U/DhXH1J1A8Rkx5+s6KRo0XKZ4ecNj3s33an6r9SF+Dy1i2YYBxlD
	 nIVv47FfCxZZbMe2dx+PklRtAqfQmLRDXVnZj9WdxZayGpPRiMSo+sI66hnXM9aAom
	 Zw8Kjz7oWBrjjgUSr7YHi00RT7hoJ46Aw5xkIctUVLNKu+qJyxvt8rZ596BG7Q0A8A
	 0qJ/k7q3VuE0xdSQwVyOBSVZo3U/6lgEXSpwMCWLrGZ6y6h0ltWiHbSPuGR5c1zQFR
	 b0PMdT4Xjj2JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260820141957.19091-3-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:29:18 +0000
Message-Id: <20260820142919.39B731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In function ctr_paes_do_crypt() there is a buffer used to process
> remaining bytes < AES_BLOCK_SIZE. This buffer was not scrubbed and
> thus could lead to expose of unwanted data. Rework the code to
> explicitly scrub the buffer at the end of the function to avoid
> exposure of maybe sensitive data.
>=20
> In function __xts_2keys_prep_param() change the existing scrub to
> clean the whole param block instead of just the key field.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BC367288
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006841; cv=none; b=nSJ0eWDlCuwvlKojuQbRA7T5mvpUTUsRCQO0yp1KlhRzBtBtJTZcrvhipyB/bmheBy14FXy13rrHmpPdpATDaAXihq0vOsMNCyqOgN8dLhh3hvXFcVO3So3c9zAFCjdLXKD7LIo8Jd7KQZCuwFw9sHdzc96Aeur3VzeG4ULJAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006841; c=relaxed/simple;
	bh=AAzG4kQZSjI/mMTrT91HR0oUV9m6OTUAz30mI3t9SZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LSRU8OUo0shvU76SPmKunQKIQqStoMVCBi2935M3W92L8r50baf2gylVTOgKOBcgaIep4+H7i8uLS9RTVK+/1jPDQQmrNWvW0kwe1LlQzM+U/7yryyXdML7v63kxdry92Em1l3JmrwjPN7GKPJ5I063G7gjMo70/YV/SSgSwrpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5gzf+ae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5gzf+ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5B11F000FF;
	Mon, 21 Sep 2026 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006839;
	bh=AAzG4kQZSjI/mMTrT91HR0oUV9m6OTUAz30mI3t9SZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5gzf+aeeMFmssgCLvjTnbSRolxVDAEGdYy/Ep6Wmc4CR+DahrGkjk4BJymFoozU9
	 ZJia4PiPs/u6Yg5Lqo1egRmvyUSUawxzxtPuGeuRsot903Zd3ksvFPwyqB4u0/sjF+
	 a4KHMLzgKa8FL0YpXu2EXcGgilYBQe1yl19RMvEk7MbrwwQTkxThWk8my6/JTaidvF
	 M8673Y9cYHUfbBWji4ASz25LuEj9pg6cK20dvCtTDFCkfh2pKTFhdIh5LsC+ffNDjP
	 CD/0BLvVZ+Fl6tuJPaeyAxRFl3Jnz6Omv3089VGqHO7du3pS1AgFpzKYW+5p57znSJ
	 BV3b0p/05pqrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/11] s390/lowcore: Remove _AC() from
 LOWCORE_ALT_ADDRESS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-4-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:07:18 +0000
Message-Id: <20260921160719.3F5B11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove the _AC() conversion from LOWCORE_ALT_ADDRESS. This changes the
> type of LOWCORE_ALT_ADDRESS from unsigned long to int in C code, however
> looking at the current users this should not cause any changes.
>=20
> This allows to use __stringify(LOWCORE_ALT_ADDRESS) for inline
> assemblies, which otherwise wouldn't work because of the UL suffix.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D3


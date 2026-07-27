Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79C383304
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171251; cv=none; b=SWJ+mFRC2hInJkmDDlw5FZadopvel+H82O2UXzpQik4jGHfHzpOd45fTblamQWinvnuXrEPfm+gtU3tfNDVU4Rny6Bdc1RCAVlXiWku2Pprln9HnnOqRHXQ+MOzWnUHUC5eTImn5+DKx5qH47Vnqlm/K6SJXhqP7Fp4Dcjp/3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171251; c=relaxed/simple;
	bh=og06xRG8/RA9syoCSDo6ys/ImzzFiMYxLExByMJSHLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yqq9xyXEnRg5kVeko6QQ18qgW0dNziCu05OP6VVTR3OQx8+BSYP6g7YyH1gJhsczamd1uoz+B0Q2Nig94xwX1fUSVZTZn413vhw6aYCLsHhCsNX4/nsZOeNn87HHXKlZEs8HxrbOhiyjX6JqNC1s3YMg7hbudAH06tTY0LcTWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4jWtzrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4jWtzrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0D61F000E9;
	Mon, 27 Jul 2026 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171249;
	bh=og06xRG8/RA9syoCSDo6ys/ImzzFiMYxLExByMJSHLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E4jWtzrphymCPpuNNqMsKH7mI2kmNtxHqnBmgHkPqk8PmKJ+mky5ZwX4LsWJ9OIiA
	 fKtlqCUnv76WefgJXPLZPh475H26OWzJ1yb16g+R0907UdRACkdx3jtOjU6gSec/BK
	 l1psnjqqi5sWXu1kLdH+xbO8D22PwTGA27i+iqgDpe47f3D51XKanjZzZeoCcFh7OC
	 PbU0WnOgD2ZRx4mP6jJrDIPUxdgeKUI+RffW7JOO9blvGqskkTDyJI6sLofgC7TfgT
	 vqx/Z9ELMlMoRGzV6sbG9eCX6ImuXwCT34+IWm0a92mqeCA1UeCoQe3tJJovCraSIU
	 ijB/2w8wCo2Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] s390/cio: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727162430.1599396-5-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:54:08 +0000
Message-Id: <20260727165409.3C0D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727162430.1599=
396-1-hca@linux.ibm.com?part=3D4


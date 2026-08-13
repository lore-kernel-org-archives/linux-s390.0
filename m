Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A8374A1A
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628890; cv=none; b=GbbTqXicep6QZWHVjhYXsB2v0kX3Wn69nUoDf+g7cH8xkX02tH9s6pBsIEi5TgYRgcUTcvAiNkTiOzfV5GuNvrxECMILXW+gNOAL+RzthCzR08m6xe793T+qos022uD7J/ssdGd1Ue+6OD36pKFQl56hEhXiDuTOr5DNxBEkk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628890; c=relaxed/simple;
	bh=jyiPav52hSqKI0dUoxE57AtHl7l1mGos02Umbt2U1Z0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LlxM8XV0Aly7cmt1DYNt4FTYYRaJ6qjZsT0++TleCyJxdL+REIjvicKhPPc0vCyWuWMW35A4lXn0D3wTPatojujHxoL1phb+Ttu/4g6DSJXX78Qw4iELHAyvTh0hv/5lK8NjnZ8X4abuzj84XTa14GQzXFqP04L9uWkQGswa4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnysesXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnysesXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC831F000E9;
	Thu, 13 Aug 2026 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628888;
	bh=aoORZw6sbYcRrf/okFcK6gclt0wzwsoj+UDdU0btWRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnysesXuAhn/YJgRb9YY+nPPdf3vKnllGJxW4xERHKJIYzPhTwwchH5YOdz29otG6
	 09wIez1YLv5j6zyo0/g4zaXP64KY7fl7XGhJVOYSs0BxdbNR2d6zctIxxhxF0tFtK2
	 2Zkuem3KDhXH4cW/RB0oon2GYctJWE+sgNRypuoaavtqDRTve05Cc7RwDVSiGJEliy
	 Fb+nfqsknXjXc1tGQ7Zq2gxZ28IMzNyTis78so3Glsj1uV3qJexqAq1XWvtYJUz89M
	 t2JZbeaifLRDgPD/v3w3wIRDWSImPLFeFOgjMXzWW/WU4IXjTFqezRPCMrVVC7eqZ3
	 qRXIQIIPHVS0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/time: Use jiffies instead of jiffies_64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260813132505.3691502-1-hca@linux.ibm.com>
References: <20260813132505.3691502-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:48:07 +0000
Message-Id: <20260813134808.6AC831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Christoph Schlameuss and Alexander Egorenkov reported a data-race
> reported by KCSAN when jiffies_64 is read:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in do_account_vtime / tick_do_update_jiffies64
>=20
> write to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 6:
>  tick_do_update_jiffies64+0x140/0x250
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> BUG: KCSAN: data-race in do_account_vtime / tick_do_update_ji>
>=20
> write to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 6:
>  tick_do_update_jiffies64+0x140/0x250
>  tick_nohz_handler+0x2e6/0x300
>  __run_hrtimer+0x156/0x4d0
> [ ... ]
>=20
> Fixes: f341b8dff982 ("s390/vtime: limit MT scaling value updates")
> Reported-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813132505.3691=
502-1-hca@linux.ibm.com?part=3D1


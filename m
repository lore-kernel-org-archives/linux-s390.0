Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403A43E483
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705900; cv=none; b=jTMB8iQccNt4gPLNhOpkZsFrGYn6lvcPzhyQE/7ZCFWfQRv8Qp2+R2+CldRquqarqi+sRm4ALtKxwFzKHpQqZs5Wgt9J2fQ1Ywbt4bqgX4rushVMw+T3ZY62LYxjfGpM0/qIxgaew2k75BiUq0JeHpt23Iu73CP4FNp2J6H9C+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705900; c=relaxed/simple;
	bh=WHIjWC5ozPZyVPh6RzHlV/WOMQlM+Vnvv7J0ZkBt8Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMEw5sA8lpz5e9c12xigsQzlKyxYDECtEkA/rAwkkRmN8QjKdOK5iWsaIhpSVPBBaz/ZE9ncb5/JeDdXaXhlQxngQh1x+UmX7gX+fHfBjXltQTFhtZcA6hEGOlU4qnP+klTEA0tKe1pmQKw0X3SxA11dgSlJCgip9qTVfPV1Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QQJs8zG4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QQJs8zG4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4624a44e152so877206f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781705896; x=1782310696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHIjWC5ozPZyVPh6RzHlV/WOMQlM+Vnvv7J0ZkBt8Gk=;
        b=QQJs8zG4Tt1Ie2XtxSgVOeEqDFj5LSLBYg3/BJHKh/dyNvnFFLHz/+niH+e2cVKv/u
         aolZEBenidIWDZIsatXDfQ94jydUjqwk6lnrjO4t67pSW9d8GeGatUKQuLwro2mbk61O
         6Ib9H/imGHacnI0V1upp1Esqg6InsfHKaT4KuE2VmhXnJQQYMiebw/T47qqJKQxj2ZHW
         slHYkqjZLtjImn4fRqC5Fda6vJCKyMVbZVzYoGeFGQOG//H6tWavgCzE/cYlwVz3/5WK
         cx0+btiRImfOY5Sb7rUwU/umMzbDRMRTZGUZ3eXp9EkgffyNFEKbFS8SukAM4X+sHRHD
         XI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705896; x=1782310696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHIjWC5ozPZyVPh6RzHlV/WOMQlM+Vnvv7J0ZkBt8Gk=;
        b=ed1ydo06QG+x7t+QSU8AJ2JSKQOcN8i5qd/UA8tTX4IhGj3uFZQ9/3dHPpXNL1KkRX
         ysw2Xbh7l4yl201FJxvM9xz5GNnznqNSIgVnQ0ou5ESLRqZ+3+r0il92T02gaDy4J/oG
         EAvhOI5yZcrPn1vULaFPGaqKItUyRB0T7TUxzJ8fD+gixVitQpnvHBSt2oUWhkvL294m
         f04QZ2y6rvW1KIb09VD3isKfP4T8UPuse9qDWMIClgftD8S4dWvs7Tlm0w1ZrqBia4XJ
         Duc0WK79oflo3lG9LqPhiX+HwgyxgYj5dflGWd80YcY+66AdR3OoHKaNvJUgnELudgB4
         Osug==
X-Forwarded-Encrypted: i=1; AFNElJ8PpF82Hp0MonPCrTGNeQFLbkcWZtfWSAv4kcygQze/xAEwdLgozt3eCMTo1TdLkhvgtgxw66ObjVVi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aehaEHsxaLizS1jc1gXAf4x/qTZr9dO+4HzvEn3F/dC4SgXy
	ac9Bsfg2Zbovhyu7w26u4BP9dr0SzKQM1R3I6wVX0kwie4OZpX4He3cGCfvtjgdywQg=
X-Gm-Gg: Acq92OFFP0B84/xcfAjTi/4ppyfL322bej9TOfFkvVBzd+MjQwaZSOaN9zRX5XV03g+
	TDAm9fWkx6glZgIp82TMKOXgQ4r+wH4+gxzA0L6uHSnsJefZB9X9sBYu2qVR8XsBfHLUxaaPF6W
	gbL6nBzVRM4V/yi/qb+l/ruPIEXqTyrrJERdP+jJkj3252mW1JKjkbk+zIlsTMioMWpCiGHt/8t
	pot0jrf/QFMRFgnandzjPa6waF9fPyRTIzFW5JTMNVqdebpRep8h/Mg36yu9c3RwNB/Lb74qVhv
	BCGReJv2/yynxSjt/wp+PEmTu+CSAx6E7pw9SaHhD8cENfPZtOUv04IR5ZUYgKUSKclkciDACh/
	2tyMWXLfZycpMFAQa05dV9Oy1GLhEwpItX912CNEviwRm1GG2Zwg7T+ehvZ31F+A5N+WmtBi7BA
	FjlZEA/DsjQ+Haus+32q1vrEj0qGl8wmy8tX0djFLjAntbbLqkI1brvcFtJ9/+JMkcCZff8isCE
	N6B0qpgvdJ5oKo=
X-Received: by 2002:a05:600c:a142:b0:490:b8d3:5dcc with SMTP id 5b1f17b1804b1-492333ca3b7mr55578185e9.19.1781705896184;
        Wed, 17 Jun 2026 07:18:16 -0700 (PDT)
Received: from localhost (p200300f65f47db043b42891e8adbe9a5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3b42:891e:8adb:e9a5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49230a4f8d7sm161306245e9.5.2026.06.17.07.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:18:15 -0700 (PDT)
Date: Wed, 17 Jun 2026 16:18:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/4] s390/idle: Provide arch specific
 kcpustat_field_idle()/kcpustat_field_iowait()
Message-ID: <ajKsG0JP6qTssQBX@monoceros>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
 <20260513140129.4100822-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zk3crrqd7auhigwn"
Content-Disposition: inline
In-Reply-To: <20260513140129.4100822-4-hca@linux.ibm.com>


--zk3crrqd7auhigwn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] s390/idle: Provide arch specific
 kcpustat_field_idle()/kcpustat_field_iowait()
MIME-Version: 1.0

Hello,

On Wed, May 13, 2026 at 04:01:28PM +0200, Heiko Carstens wrote:
> The former s390 specific arch_cpu_idle_time() implementation was
> removed, since its implementation was racy and reported idle time
> could go backwards [1].
>=20
> However this removal was not necessary, since independently of the s390
> architecture specific races there exists the iowait counter update race,
> which can also lead to reported idle time going backwards [2].
>=20
> With Frederic Weisbecker's recent cpu idle time accounting refactoring
> kernel_cpustat got a sequence counter. Use this to implement s390 specific
> variants of kcpustat_field_idle() and kcpustat_field_iowait(). This is
> logically a revert of [1] and moves cpu idle time accounting back into s3=
90
> architecture code, which is also more precise than the dyntick idle time
> accounting by nohz/scheduler.
>=20
> For comparing cross cpu time stamps it is necessary to use the stcke
> instead of the stckf instruction in irq entry path. Furthermore this
> open-codes a sequence lock in assembler and C code, which is required to
> update the irq entry time stamp to the per cpu idle_data structure in a
> race free manner.
>=20
> [1] commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time() and corr=
esponding code")
> [2] commit ead70b752373 ("timers/nohz: Add a comment about broken iowait =
counter update race")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

This patch became 670e057744e0cc8047bf96d15d18c46e16ae2e93 and is
included in next-20260616.

s390 allmodconfig fails to build with:

ERROR: modpost: "arch_kcpustat_field_idle" [drivers/leds/trigger/ledtrig-ac=
tivity.ko] undefined!
ERROR: modpost: "arch_kcpustat_field_iowait" [drivers/leds/trigger/ledtrig-=
activity.ko] undefined!

Best regards
Uwe

--zk3crrqd7auhigwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyrKMACgkQj4D7WH0S
/k43bwf/QzXmrb/duiKGtFmbklmC98PTRIaw7K7Y5X1bV8n8FAn1ePG8mSd8/Pum
YUlXK2v7C2RmWoAmQo71tlu+6hpAaflWmHAsx0LRcMomfh5lB4A/0Xi/5EMbnow9
EnV82YxGFjys12dkxNvnHWkHNmbLzJ9aB+z+V3WReL1m2BW5kuf2nwJeZK1Unzgy
NXNNT/KfkXGGrIkKSXC4ksqfVQynI+1HU8C4U3+pJGhiO5pSKcqswdWyEMs0Zosq
KUC7UnB0eKhczrmKRteTc3SH1794+FjJW+VFwesspt+plQ1Gw+1XVJzR3RchZ/IX
4mZxe1/1C/dW0xI4oIMYYAngpcFZoQ==
=QK6n
-----END PGP SIGNATURE-----

--zk3crrqd7auhigwn--

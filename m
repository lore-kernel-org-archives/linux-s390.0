Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CC4BA1DF
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689600; cv=none; b=iqZfdfT3Wxhg3RjExlGw/wT4+xbBvsjkHoDtMTAOH4N7dB++l5Z5V/00b8VucUhqZwilp6gwIgo2aA0rwuRW/XiZFGMVy0RkidXjdIY+6LFy3fcInV2ga5jkr0VUnHJlARrxVspts4AgtVHYYk9LhEqlcQ3BkQ0cIB3ChoCtxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689600; c=relaxed/simple;
	bh=DsSV14kmVt1QbwUWbYyg59Vho2Pqgp1jK/65qTpCzTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lswVVurip4DVUBGfmfIw9Utc7wqtFiDAz+uw2YaiURu2r4VPxZNxkkbFKSF/2wGZNSJefe4m/O91tgrjiDy5EZbo9YBy/eUcQQOkF861XISs2C2oSH4XoSW7981RNgrtEzsZv+npkBj1LlWOup74GJuiwbLN2lii5rXZiYjQfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTqsyyuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTqsyyuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8001F000FF;
	Thu, 17 Sep 2026 23:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689593;
	bh=DsSV14kmVt1QbwUWbYyg59Vho2Pqgp1jK/65qTpCzTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTqsyyuL10Y4wTVzbJiaO41N0m0sgKSzK/mpHC+jgazHuUEMC7tdegY9zORwJYcPW
	 wpHjRRBM10ZpOIa8Dl6Oy1o5e9yDsIAGq0WhxwZ7OqsDiI4u3WdxAHu5vmRlzSX00W
	 J4QE1Vei3B0H090nRyPfSjhEi9xG1qRI77UC8Fy34FrqEVBjFPIyq9FKBzZiLqLl1h
	 0fVAeolhB/kAftjCU6WITMlGz+Ez4eN/RPdmpzKH5pW3E+bFKT2GRWxsHOI2l9jiXZ
	 yYWU4yGaKVjEu/saOUxhnWptqz/epCefGN5+1vD4Y7uBFCSWWZqOS7uaKuK78pzBYV
	 zThcGwBCybyLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/13] alpha: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-13-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-13-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:59:52 +0000
Message-Id: <20260917235953.1E8001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D13


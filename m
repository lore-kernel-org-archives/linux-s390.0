Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9A384CC2
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557028; cv=none; b=g2qXz7DqWhs2b5idCQ428ZPMVHteR2AE36Ef4zbDBEfby46ZfryTJc9IfnadE/MN3F2cikO3gNeVI2LIe0hzqI0BdC+EQUCB56zbfbhNWc/aE7tzaoWfHeV451eg8/kHkp7gbxCAtNYYwP27wE5LVMMsFMZ1s6hEW2rpELQice8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557028; c=relaxed/simple;
	bh=/aXKUDaEhMDOj9bfwSTPRIJqkneglLL6F2UVtvYQrFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glK9qlzDHraS4rYeQK6T4qjRiaujPSGJOGtlN7rLokswzC8mXs4/99d8eglDhGkSb70Y+d8ZoI5bLeDgzYTpI4vC33fQfVSrA1bNP6WvbCZMhbwUzLCkZlrsBT52mYrtiuL64mXKvIor5H8vq3oJbRAJbJofWG04LYJRyhIxFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDnJvL4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDnJvL4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E316C1F000E9;
	Wed, 12 Aug 2026 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557027;
	bh=1EaO84iY5mhHY+2nOYgeNtzcD377Xu2w2eRK/Cf5NIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDnJvL4VDE32tpma/8vu7RRDtKUZL5xjG3zakMBBjDglUuiqg5VEQqVBNzp+RACx2
	 wFccsh880dc19T6/AhkcU2ZuTO0LJUGnWJHBRoMwtxDYFOcBQHlU+T+cf0UhWbBvGy
	 Apj36k4UgjVrF/3wNth8imGEXfwAkzmq84WejsCBTS2fB2ATZOlckEEYsbofbpWRg0
	 68ZH/Rc6LsqU3spqzzpkg4g62mLQ+fnct/hnu940sGjPRp/7tSYL3+Fhj4MBIXMY9J
	 Wksds0fRMW2vKBCdz4coowmQGv/hy7MvU0nOvgOam+5I0lFOoYB29/zNosE8eS5ybM
	 1FgFuZnmsgRtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/13] syscalls: Make --abis parsing more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-tonyk-syscall_table-v5-1-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-1-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:50:26 +0000
Message-Id: <20260812175026.E316C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Some archs Makefile have something like this as the rule for making the
> syscall files:
>=20
>   cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
>=20
> The $* symbol is evaluated to the variable found at $(uapi)/unistd-%.h,
> where % is 32 or 64, resulting in e.g. `--abis common,32`. Sometimes the
> rule for the file won't have a %, resulting in a trailing comma e.g.
> `--abis common,`.
>=20
> Currently this input is transformed into (common|). This is problematic
> because grep will then match any ABI because of the trailing `|`. Make the
> syscalls scripts more robust by removing any trailing comma.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D1


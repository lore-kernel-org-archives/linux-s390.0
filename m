Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14F1397
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959947; cv=none; b=qB50DQxUeQZ33NLnRE9jonyJsnJRKY8P8AUnccPfyhJrA/ikIMiycJ9vvOBFv7DbrvmaXOqsFmXgMTEGGr51mbec20PSnc7f9sIbaQ9zSv2StguTE3Cuwh2yuDSaJH0F2kIHqoB+ZgVLsEUuMrnl3yq2dp9rVH1PTvFZiPJNQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959947; c=relaxed/simple;
	bh=nmi9B+haumqd6ZXA0MhvqWs/Ofi2Ye/yghcBtnkqGro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/iTLeDIfJMM/rw7WENWmqz2cZdUsIC0ySbNASGD1MdXGB7meytUDRacj1X6PPMG60VQwkdampBlbUXX1aans3jyLqP32EZhO5XH7ifvd0VZYyZVFdDiGqwW9l3HS8YsceNZ7yo4AA27Ao7PgVEnwoFStO8NJOfAY14WSEmkiRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duTcoSV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duTcoSV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA621F000E9;
	Fri, 28 Aug 2026 23:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959945;
	bh=TtDfs/68vhu5ib0+KLy7SvgCzjeqPOqcTJ7Dl8XKimk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duTcoSV+TDG8AiUaAU5NHGE30fqLor+YodCmIT6w5IYs2RaqaJZHYsSRPjoDnpyPt
	 s0JagHJUG4plIgvqMSjS/6Ea6nFbKQg6+gi2fuNN5y34jwNmUElMP0AGJEv9Y6MEaB
	 dOJqsrINOZ7mHm+Gf1lbq3Hv3V7VVJclr5t6Mz6rXBUKI2phFX0tYkGxIgxolFGH31
	 soa6UTinDlOuTm11+L41m5++bRVk8Mn2kxaACt9q4Lyf3HOqjF2jP5jb7l1CSqhQXL
	 U54oEbrz5Go3sGlB/GAw9MJSmxh6XSB6gxreyqJHaKPbVTImUqK+5xRWh/dUZL8TYO
	 ftfeIk4zNNQlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] syscalls: Make --abis parsing more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260828-tonyk-syscall_table-v6-1-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-1-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:32:24 +0000
Message-Id: <20260828233225.3FA621F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D1


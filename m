Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997220;
	b=vZMOMaCiIjk+TQUz0YwGTS+3h3BcEtyuPfHolOXivjhHWy6AOgPTXWLk+BS3ya5OaHJd
	 cZjP5FTJOGU2voo/lrZk+s7IlmB49/Mva5B+LE2KDM++L1CdJG242s57Y1Xt2Xa5azqgN
	 MAh7KXQx+lzmlW3hBrNjHjas9PPR2Fu9XwbpeDgDqsvzo+1HMWfUT77JUy6cQ76kMHOUU
	 qu8AIDYo8n+7Oe9Xvq9XTGqR4oZiNHiX6jAQq5VsfOajlJiRoL6qw75O3sUrMB7ITPzpa
	 sLsW+HcPytc9xv9nTzicsOVAy2cJxlD3tsuguQv78Wew9TojRe83eKkeNA0siA+4Z3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=97CsXCcghL4nDx0dXWoMCvGVXXNqaL9oSUO5weKHTWo=;
	b=T7g5RNAg+qyYis0y4YxHZJKi855lkPXSjBhs0pmrmmoWqcjQbS5SP7FHG3CBxOI4kqnt
	 b0abmD5ut4ATY8irIcrJRtTUQks0xcy6pCclKzjMCI8uefZAqeaoq0qiCx5LO27xyptuI
	 U9UrmWKVL5xYUKNeUFqfiPtAej2U+h5StPsHPnByH/eHMTlQ6n5xSj7QETUa8are/BjFw
	 SJKaAp46N9kpXLxvDwEqroZydhq9yCZ8R2rXDxl0G5G6Armrl2WnSLveQqcK2WyUcP7/m
	 zxOPsOvB3a8JrBz4iS6nZxvFshexdRGSRASbU3/jeclfKzcDBP3CXpwU4ONRO+dJmtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QX+X0ABV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81572606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QX+X0ABV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199281F008A1;
	Fri,  6 Nov 2026 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997220;
	bh=97CsXCcghL4nDx0dXWoMCvGVXXNqaL9oSUO5weKHTWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QX+X0ABV+nx6h4RCNJ1pf+6RwpymcXOFBk2gLUcqkoj79+cAn0jNFWg0ijhLmS/dH
	 oeneWOA3O/DVl94KmdoaSVi/hsbg/QQS52K1ZU6eBYgsiE+FX940yIdrOqDvr/BLZ/
	 OKbsrICmC5K2thDcLmYw64YEJRbdpwy+QR68EqEhEV4iegfu+j+nV7qpe8Uq4/4cnS
	 EHUZ2DMNKXmFe3pEh6246RszYxySTfb1jfnz4ayuz0cr4sB1nsM3od4LDpfbPO0FTb
	 EIWCJyYrb0nZpb9RFstWtiWWH1VjwE2ahHtcqWtVsefrRnh2CBInnvOzi1pbNevkRv
	 I4WS5ih4uRxFw==
Message-ID: <sashiko-outbox-202221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/15] mips: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-8-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-8-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:39 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Syscall numbers from 403 are shared with all architectures, so move the
> toolchain to use the common syscall table and remove duplicated code.
>=20
> The generated files are not exactly the same as before, but they have no
> functional changes:
>=20
>  - For O32 ABI, the syscall table would have entries like
>  __SYSCALL_WITH_COMPAT(403, sys_clock_gettime, sys_clock_gettime)
>  which is equivalent to the new entry __SYSCALL(403, sys_clock_gettime)
>=20
>  - For N32 ABI, the syscall table would have entries like
>  __SYSCALL(413, compat_sys_pselect6_time64), which is equivalent to
>  __SYSCALL_WITH_COMPAT(413, sys_pselect6, compat_sys_pselect6_time64)
>  given the new __SYSCALL_WITH_COMPAT() definition for N32.
>=20
>  - The above applies for N64 ABI as well.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D8


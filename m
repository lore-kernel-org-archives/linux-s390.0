Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A844062F;
	Wed, 19 Aug 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163891; cv=none; b=k/YlCdHSl95Cgc+710KZKEQ+UzGgZvrUK9CzSAEELzuQUZiYzVuOuTNQn5l9d2bx0URfgzzJIzqdxokYEwFtWH37KNg8yLqjd6sKyoccQNfpyEB+PGDbeDIEsOrZMhsTYc0HB9m56o/TDiALxDZ5yQ6q2omgPnEbWJpWIPOzABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163891; c=relaxed/simple;
	bh=t1uBKKl8vvMsvRYjNhgLpmi3UZRNJgopa+3cRMUij/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=krWSL3t9izCJyNDpUnqa0PDpql/kGTkvOCfguxHSuKHA63/AaAu01PEX0kCzhHe2lWCfqK+bj7mmYK+D0FP2DWV8JVZnz76gID/hsH7mqZ+3TL1k302Cjm2IVJpeoPAON436lDHsrBN7pXSDjc8Nom+ikPEoEnEprJCjOoa+vPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txoim748; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txoim748"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286D11F000E9;
	Wed, 19 Aug 2026 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163890;
	bh=t1uBKKl8vvMsvRYjNhgLpmi3UZRNJgopa+3cRMUij/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Txoim7482ouOvR2LqaXQQpNog3cClUX9/m6SPRv0KJaLcBP11re++R1ogypHMOBZq
	 QS3TpXK1VQg7fAQz7cLAMhubAWCkFHM0jiStsofRoPrGPhWtJHW8q3zqQhtT2/cwqK
	 4M9T6j8XZZLoP2LmjLDGVJkiSuIFyqAd5tfKkjmatnaTRw/MxMAml0jMOGrTHalqjU
	 3cek4Az41hPl8eSi5sJbfMDagj8KBpmspQqFoV+9P2zljN9960B0yoZ8tEY5/Uak5R
	 NFfLN1pCLejr2oOcp71hHxC/T+XOPtrRow1g1d3sg+WTJtdDNmWvC3Eu6s6oasb5vi
	 gBRDiwkd1E0DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 10/13] sysctl, net: update
 register_net_sysctl_sz() edge case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: mptcp@lists.linux.dev, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-10-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-10-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:24:49 +0000
Message-Id: <20260819182450.286D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Handle the last (edge) case:
> - nf_log.c: ignore sysctl table with template set at run-time.
>=20
> And re-enable the macro.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D10


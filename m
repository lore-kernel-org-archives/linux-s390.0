Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69983B38B8
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555337; cv=none; b=EsrkcRt0iJ99Ffbgi+z8/hPR7EUpz4LyqDfA82LABK0n9zdgReDptd1Hk8U4o0RA+N3nMJsXwuDRc+uCKOgirLho08FRbdBpG1ooLmlLB5O+qSneiFLzO16IRhOKyeCzFhTaEOO0Eqpqv590tHPYiY1oeu5epjECmQtWy8Oye08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555337; c=relaxed/simple;
	bh=qXuKO8hTqiUVyF+AzOwE57uJZ//78ck+m+w8OM54p1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HolaCS37Qfzq319rKJg+YJRQsbwW+06rd4wBiFb+nlDEov0BXGBf2vack2d/QgToEWZZ+jtSjd6eB9kKY35rKY6RxvO/UYhIppz91F68jrAzyRplmEL9j5kLDJQV//KPMQUVF+lPvzpoJdlBVzdcjjPmy49z9FwPNpUkGdOTU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIPosWtZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIPosWtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93241F000E9;
	Mon, 24 Aug 2026 07:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555336;
	bh=nRFzg8gwDJxi388J1gidvx8dO59xaUzkUdf8Ln2Wvhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GIPosWtZVaFjPiAXOaQ12e4TZ6PZNYBRq31JNsuC/vMmMs9M0G4IQl9/Vfs5sKoWH
	 /t+pSdXDO+JKQu6vVh9mQusRImGxSOFohEA8oFX0JJvYAiNEIoZC44xjknzRD4y0kU
	 5nJ4Cbf56uenK+MAMVPs2a7WXrpBb9GoJ/mjPWazO3tmTLrLsAG5CKXVZ1UKmIBZ+z
	 PITjCTI/m5HzpzRScQtTFUfVP3FnBR/LK7TGFJSuCCMWOrYQKjgtocbkHpyhcJfZ6+
	 Yi7nMRzLbBsKO0say/4MwCQ4EsJua5odqrM9a4r713g6i7nLP1am2AVK45woJT49vq
	 VDbcamFLT4cfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: serialize clcsock teardown in
 smc_accept_dequeue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260824065851.1070988-1-mjambigi@linux.ibm.com>
References: <20260824065851.1070988-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:08:55 +0000
Message-Id: <20260824070855.D93241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> smc_accept_dequeue() open-codes clcsock teardown for SMC_CLOSED child soc=
kets
> without taking clcsock_release_lock:
>=20
>   new_sk->sk_prot->unhash(new_sk);
>   if (isk->clcsock) {
>       sock_release(isk->clcsock);
>       isk->clcsock =3D NULL;
>   }
>=20
> This bypasses the clcsock_release_lock discipline used elsewhere in SMC c=
lcsock
> lifetime handling. In particular, other paths serialize clcsock access and
> updates with clcsock_release_lock, but this local teardown path does not.
>=20
> Fix it by taking clcsock_release_lock around the local teardown and by st=
oring
> NULL before sock_release(), matching the established ordering used by oth=
er
> clcsock teardown paths.
>=20
> Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
> Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824065851.1070=
988-1-mjambigi@linux.ibm.com?part=3D1


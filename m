Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473D1E5B70
	for <linux-s390@vger.kernel.org>; Sat, 22 Aug 2026 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787384419; cv=none; b=osVSmoUmlC6Krqru8fGzatvbTOBtyKc5k2jqkd05VzD8TMbqX3QDmjXdvoAqEE1pF+ITIw5mAJprfny+Zi6Nd8dGKpwIuOLxbw+P9PdP2ui9B05M/h0UmQ1RaLah2w8p9TJvyZoYQkaHzhaWL9MT+Y5mRG4u/aSQnzfx1WS9XwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787384419; c=relaxed/simple;
	bh=+Q97B9u4E3msflCEps/QICMVyZIU6zIJkraKyIaU/VI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPrlfcW+qmxHH2EGleVIqg38FFJNAslcuK7A1tg8JwTl23knp2xj/5vIorL76w9XpvPMOdjPOq1qKv8GNO1rJaCg4Uh43DM6S6e0F0pHMtHokaTviJqVSsM/IvEYhaR8aHu4xySqxGnmWnYewO4lyxKikLlENAXyD0/pVmtXP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3udSV8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3udSV8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8501F000E9;
	Sat, 22 Aug 2026 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787384418;
	bh=gU4U+HHpj+BgXuDyBtYBTRkGhHTxFvUQ0GnDjTaDciY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3udSV8TfT6yYiIemnz8JYa+V7U+6b1IUKss548u1gELIVHXuokAc5I+rO9/qr3xV
	 DVtsH6xm5QgYvBUotbMk2WjntFip5IqWhpuqh7yrD25GIJigdu3AnYo8JFrqypN6Mv
	 oHF4bAPEZlHKnJZMcy23WAsVhthaeMdQ3GhjLSebgoc5jqCNUi7NowVRPjE5S5tqDC
	 r+IhPedXhxfcJK1oVZyK92LPrgHem+7qahaXsLxg1RvwhU0vi0a3fzAHaWMU3InkHE
	 jbTu8Jk4rN1svNOsrorpKwAlbfGEQmp6WWmpZZPXrH68NfgqrvgGcp0aVKtndLw6Rg
	 uaWkPFRph8dDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] net/smc: release the internal TCP sock on
 IPPROTO_SMC socket creation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Chuyf26 <Chuyf26@linux.alibaba.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <178729790329.223882.15209084993558811810@linux.alibaba.com>
References: <20260813060456.b48HqF9m6NTfFXvq_PL9w_Ih493OogqAqxfAHAfU74A@z>
 <20260820111229.153086-1-pabeni@redhat.com>
 <178729790329.223882.15209084993558811810@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 07:40:17 +0000
Message-Id: <20260822074018.0B8501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A preexisting race condition in `smc_close_active_abort` and `smc_=
close_passive_work` can cause a Use-After-Free or NULL pointer dereference =
when racing with a concurrent `smc_diag` dump.
--

--- Patch [1]: [PATCH v3] net/smc: release the internal TCP sock on IPPROTO=
_SMC socket creation failure ---
commit e59fabfdc9a39ca0071e05ed30e01dc2a6a78c65
Author: Chuyf26 <Chuyf26@linux.alibaba.com>

net/smc: release the internal TCP sock on IPPROTO_SMC socket creation failu=
re

This commit adds a .destroy hook to SMC protocols to release the internal T=
CP
clcsock when socket creation fails. It specifically unhashes the socket bef=
ore
releasing the clcsock to prevent concurrent smc_diag dumps from dereferenci=
ng
a freed socket.

> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> index a94084b4a498e..520b666fdd8fa 100644
> --- a/net/smc/smc_inet.c
> +++ b/net/smc/smc_inet.c

[ ... ]

> @@ -116,6 +120,18 @@ static int smc_inet_init_sock(struct sock *sk)
>  	return smc_create_clcsk(net, sk, sk->sk_family);
>  }
> =20
> +static void smc_inet_destroy_sock(struct sock *sk)
> +{
> +	/* The sock is hashed and smc_diag dumps dereference smc->clcsock
> +	 * without clcsock_release_lock, while sk_common_release() calls
> +	 * .destroy before .unhash. Unhash first, as __smc_release() does,
> +	 * so no dump can observe the clcsock being released; the second
> +	 * unhash is a no-op.
> +	 */
> +	sk->sk_prot->unhash(sk);
> +	smc_clcsock_release(smc_sk(sk));
> +}
> +

[Severity: High]
This is a pre-existing issue, but since the comments mention that smc_diag
dumps dereference smc->clcsock without locks, could this same race occur
in smc_close_active_abort() and smc_close_passive_work()?

In net/smc/smc_close.c:smc_close_active_abort(), clcsock is released:

    if (release_clcsock) {
        release_sock(sk);
        smc_clcsock_release(smc);
        lock_sock(sk);
    }

And similarly in net/smc/smc_close.c:smc_close_passive_work():

    release_sock(sk);
    if (release_clcsock)
        smc_clcsock_release(smc);
    sock_put(sk);

In these paths, smc_clcsock_release() is called, but it appears the socket
is still in the hash table as unhashing typically happens later.

Concurrently, a dump in net/smc/smc_diag.c:smc_diag_msg_common_fill() does:

    if (!smc->clcsock)
        return;
    r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);

Could a concurrent smc_diag dump hit a use-after-free or NULL pointer
dereference here if a link group failure or peer disconnect triggers socket
closure while the dump iterates the hash table?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178729790329.223882=
.15209084993558811810@linux.alibaba.com?part=3D1

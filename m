Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F273A7193
	for <linux-s390@vger.kernel.org>; Sun,  9 Aug 2026 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260092; cv=none; b=MxQhy6u3yeSEtfIwgJSi4S6o261eBEQApfc63bgFDFgtiR1EM8LYj9PXuEcaka3wAs8RbNwK4oGchFrVPWZcTOMDitgPlhecMBPwu6nTRqn4RNUJMBJhtLjYQIWjmDa18c5gcynWlJ6t57ruiuDW2XuvyIuzyLqhLxR0rYWO9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260092; c=relaxed/simple;
	bh=XrwqOD7iRSmzTGqQ730nCJm+TJWsGkjw4mmKJOn6KFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rynbtITfaMLrLlABnqngh73CWmeiVyup9uP6ZU3AdJe2Ob+8L1/YMrgoQhu/hpWFbrlMuqlhiXchaWCu1OHXFMLJ+CnPPntrT9fD916H0qrlLoeqxMdTSxB2YPos62co1kQ7nht67pDqsG+KgCqhAEW0Hje+Y4pxDAFC4kbnLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHsc0hOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHsc0hOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3C41F00A3A;
	Sun,  9 Aug 2026 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786260090;
	bh=G3DaSWbSvbGh1UF28BHO1oHAwC+hH6VUtjthVFb/nkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHsc0hOdgRdggT40kMoj9d/GRV+rDcU0GB6AHpXHQDrRgNybC45t0B25OrC6UUiZx
	 YW+TIDOGe4UdmpQk/KD44H3Q5Y5QivyCKBDk0RMQ4cZpE90p0EAUhuGZkh9Dwv7i37
	 YuXATGtGxF+nI7qhKhO4Rn+78FDoFnjskXBBqf8juXnKKasuAMHc1O42c0tztLM5vs
	 eeUivfkpBlyjgkYiYqLZRWPWZM7SNH6lbKYOZyTREhgTHtrqYaSdrIxYNDEirTfuke
	 7kDYVi4sKtMC49kmb1lyNY68RnmJy9L8/OXyva6E/aBKIYfqkiyoCAOasiIp20V5Zk
	 F126gV0GTGsBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] net/smc: do not dereference an unset send
 buffer on the SMC-D teardown path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260808-b4-disp-22f119e6-v2-2-61647601a6f3@proton.me>
References: <20260808-b4-disp-22f119e6-v2-0-61647601a6f3@proton.me>
 <20260808-b4-disp-22f119e6-v2-2-61647601a6f3@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 07:21:29 +0000
Message-Id: <20260809072130.4A3C41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents a NULL pointer dereference but leaves a Use-Aft=
er-Free (UAF) vulnerability in `smc_tx_prepared_sends()` by locklessly dere=
ferencing `sndbuf_desc->len` without object lifetime protection.
--

--- Patch [2]: [PATCH net v2 2/2] net/smc: do not dereference an unset send=
 buffer on the SMC-D teardown path ---
commit 08550d7abeeecb4d3f4b5d472d83dee49a54e0ba
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: do not dereference an unset send buffer on the SMC-D teardown path

This patch addresses a NULL pointer dereference during SMC-D teardown by
using READ_ONCE to cache the send buffer descriptor and checking it for
NULL. It ensures that lockless evaluations inside sk_wait_event() do not
fault when the descriptor is cleared concurrently.

> diff --git a/net/smc/smc_tx.h b/net/smc/smc_tx.h
> index a59f370b8b432..610a945aefd69 100644
> --- a/net/smc/smc_tx.h
> +++ b/net/smc/smc_tx.h
> @@ -20,11 +20,15 @@
> =20
>  static inline int smc_tx_prepared_sends(struct smc_connection *conn)
>  {
> +	struct smc_buf_desc *sndbuf_desc =3D READ_ONCE(conn->sndbuf_desc);
>  	union smc_host_cursor sent, prep;
> =20
> +	if (!sndbuf_desc)
> +		return 0;
> +
>  	smc_curs_copy(&sent, &conn->tx_curs_sent, conn);
>  	smc_curs_copy(&prep, &conn->tx_curs_prep, conn);
> -	return smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);

[Severity: High]
This is a pre-existing issue, but does this lockless dereference leave a
use-after-free vulnerability?

If CPU1 evaluates this condition via sk_wait_event() in
smc_close_stream_wait(), it explicitly drops the socket lock. CPU1 might
cache the pointer here:

CPU1:
smc_tx_prepared_sends()
    struct smc_buf_desc *sndbuf_desc =3D READ_ONCE(conn->sndbuf_desc);
    if (!sndbuf_desc)
        // bypasses this check

If CPU1 is preempted and CPU2 concurrently terminates the connection, it
acquires the socket lock and could call smcd_buf_detach() to free the buffe=
r:

CPU2:
net/smc/smc_core.c:smcd_buf_detach()
    buf_desc =3D conn->sndbuf_desc;
    conn->sndbuf_desc =3D NULL;
    kfree(buf_desc);

Wouldn't CPU1 then dereference the freed descriptor without any object
lifetime protection when it eventually resumes, calls smc_curs_diff(), and
accesses sndbuf_desc->len?

> +	return smc_curs_diff(sndbuf_desc->len, &sent, &prep);
>  }
> =20
>  void smc_tx_pending(struct smc_connection *conn);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-b4-disp-22=
f119e6-v2-0-61647601a6f3@proton.me?part=3D2

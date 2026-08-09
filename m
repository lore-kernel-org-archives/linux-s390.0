Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7F37CD42
	for <linux-s390@vger.kernel.org>; Sun,  9 Aug 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260091; cv=none; b=hPrbEmRQRqMEyQqCMuyRGRVKjKsXjSMM4KLKDA5ji5ZNLoHQHkTnbrZUB6iVuTBgHbj9c6esRh8690k+zfRep2Di/tMOLIxvIPtcyWgvdq7R6KZL4bckgKyDb+J7N9+WdVjGjg+eF8fRvcZtBlmY2rQCvSuXWeKjai7OIxMe5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260091; c=relaxed/simple;
	bh=tGZVIe3QDF03Ej26bYqUIHFIWGrSwdSGfTkt32wcM+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oEOtRE89Tq/DVpygonOpHjs/WPz8YF4Q8ZB6bT0dzhv2ZR7Ws4B1qPdub5sJ0OcewmtodjIn7Vjm3wT9R4pyaf7KU3Nc6D7JmtGY9qfk6QMIVCOUg16bjIo77qrPp9Lw6NKrNeWgQL6gnTo8C724JP7Y3zXNMtZrweJiNnUeIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYgNBqd0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYgNBqd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739871F000E9;
	Sun,  9 Aug 2026 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786260089;
	bh=x1iVPp64WGLu2dOp8WzPvmIGaqKh64DvVOIoR/wdlAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RYgNBqd0pYIX2fEWTcui7gZnAEdul/IOeNHFys14Hxepe4vqllZenUS1CADx9dn8Y
	 4ej72GyPp0J0yzIkvQ5EUl6I0Vkomo3yy+UHjhXfZ3SstTEVShjg964IbmPeTVZaE4
	 JqsUHSa0Z7kNSiEHT4fLaEwoEE1n+j7XOm94rU5AN8iCnsHf0XJXKO70VkENPTJJCB
	 JEtmFQGviTmko29JmE5QvAiGvm9HmmoYdlGLni5H7xui6kCFJkvmswpXiU246QkOuE
	 a3JzKuGTwQfOG9LZ2J9Ai1pUIgwA08GIuoujZ43AQ9zwbWChxlySqy7KgysBo0h6Jq
	 TRuXvotL3HNyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] net/smc: unregister the connection before
 draining the rx tasklet
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260808-b4-disp-22f119e6-v2-1-61647601a6f3@proton.me>
References: <20260808-b4-disp-22f119e6-v2-0-61647601a6f3@proton.me>
 <20260808-b4-disp-22f119e6-v2-1-61647601a6f3@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 07:21:28 +0000
Message-Id: <20260809072129.739871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to prevent concurrent readers from accessing a =
freed `sndbuf_desc` by setting the pointer to `NULL` before `kfree()`. Howe=
ver, this is insufficient to protect lockless readers like the Netlink diag=
nostic dump (`__smc_diag_dump`), leaving a Time-of-Check to Time-of-Use (TO=
CTOU) NULL pointer dereference or Use-After-Free vulnerability.
--

--- Patch [1]: [PATCH net v2 1/2] net/smc: unregister the connection before=
 draining the rx tasklet ---
commit 776266687d64ab630969455645f01d4387577460
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: unregister the connection before draining the rx tasklet

This commit modifies the teardown path to unregister the connection and
drain the receive tasklet before detaching the buffers. It also clears
conn->sndbuf_desc before freeing it to prevent readers from getting a
freed pointer.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index b4208cb186c5e..181647982490b 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1209,14 +1209,16 @@ static void smcd_buf_detach(struct smc_connection=
 *conn)
>  {
>  	struct smcd_dev *smcd =3D conn->lgr->smcd;
>  	u64 peer_token =3D conn->peer_token;
> +	struct smc_buf_desc *buf_desc;
> =20
>  	if (!conn->sndbuf_desc)
>  		return;
> =20
>  	smc_ism_detach_dmb(smcd, peer_token);
> =20
> -	kfree(conn->sndbuf_desc);
> +	buf_desc =3D conn->sndbuf_desc;
>  	conn->sndbuf_desc =3D NULL;
> +	kfree(buf_desc);

[Severity: High]
This is a pre-existing issue, but is setting the pointer to NULL before
kfree() sufficient to protect concurrent lockless readers?

Looking at __smc_diag_dump() in net/smc/smc_diag.c, which executes without
holding the socket lock, it evaluates the pointer like this:

    .sndbuf_size =3D conn->sndbuf_desc ?
                   conn->sndbuf_desc->len : 0,

Since it doesn't use READ_ONCE(), couldn't the compiler generate two fetche=
s?

If the first fetch passes the NULL check but the second fetch gets NULL aft=
er
the pointer is cleared here, would it lead to a NULL pointer dereference?

Alternatively, if it only fetches once, couldn't it dereference memory that
was just synchronously freed via kfree(), causing a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-b4-disp-22=
f119e6-v2-0-61647601a6f3@proton.me?part=3D1

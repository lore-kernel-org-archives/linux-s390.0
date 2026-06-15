Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20B3BFACF
	for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511822; cv=none; b=jGxjTsodh2g+huXXqnYhnJeOmEbP/U8x7xals4TI9iYUJuI1alcXe05LJzah7sqaOjofmylYdzj/rrLsRegPVI9GGhZNFxmS3UoTzts4N07LJURS+/U2zdoyhuhca0g7SZYkKEOvfyBbdB2yHZYEkELaKwyzin0ta1FrLh8WSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511822; c=relaxed/simple;
	bh=aZxphCUNBzZ4s/I0+DmjQ3hZEd5HzLBqpyJsCYUEtAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NvziGlRboiKu5w3lEmOokE3/p4ETntDaoaQKfMEBNxdhaDumzFKWlRvUk77mw2RdD7nwGeOZV6vm59RUgu0ih9bn5cctLJbeG5ezCRGlm+fEQ27pMeyxRHKLblqzsslLMDFqGQXE5leQPULokz3VV4YCnCRR7noZ+pmRXBKQ6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfmxOKoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfmxOKoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3336B1F000E9;
	Mon, 15 Jun 2026 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781511821;
	bh=GeWGHry4nJAFI6LI/LOVgnfWmVpCP0S0J+50P5+6T2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfmxOKoy660oaIyNjxSaCwoh2LPB99Zx9eD3c3wSI6Q43XyqDZARHpyoeY4ia/9lV
	 bsKFaY2UTFB78/toTeU5E7zhmCwcXSbiE720eGmbMvzIk/keWBug6Lv06UJwjeNtrb
	 mpBYAvqGxqxY5fZ5jKM7Y5Vq10VAuVA6pphwT1I1hQBudliVMtfS5N/GgEQZylvgI4
	 e0fyI+l6da+ONgJzuEvuCV0A9dLfxoYBVFF6+d4sTY1shkJ8xQC/vkLaCmWVLWZzVt
	 FR/ZZDvQlmpiW/Vm4e4eQEALd/aCCCJIL0NPJB2OapTPBiiTiJ1yU6N9K7m9ES0Or/
	 ABAtaEY2zrvgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260614-b4-disp-edd64be9-v3-1-551fa514257e@proton.me>
References: <20260614-b4-disp-edd64be9-v3-1-551fa514257e@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 08:23:40 +0000
Message-Id: <20260615082341.3336B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in connection lookup when receiving CDC messages.
- [High] Data Race on cursor `tx_curs_fin` leading to cursor corruption dur=
ing link failover.
--

commit 0a889a6cc8b55d508b84bd0b15d47a8711c29162
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the wire-controlled producer cursor to the RMB

This commit bounds the wire-controlled producer cursor count to rmb_desc->l=
en
to prevent out-of-bounds reads in the receive tasklet. It applies this bound
only to the producer cursor to avoid under-crediting peer space.

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303b..ca76ef6303566 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
[ ... ]
> @@ -260,6 +275,12 @@ static inline void smcd_cdc_msg_to_host(struct smc_h=
ost_cdc_msg *local,
> =20
>  	temp.wrap =3D peer->prod.wrap;
>  	temp.count =3D peer->prod.count;
> +	/* the peer producer cursor is wire-controlled and is used as a raw
> +	 * index into our RMB by the urgent path; bound it to the RMB.  The
> +	 * consumer cursor below indexes the peer's RMB and is left unbounded.
> +	 */
> +	if (temp.count > conn->rmb_desc->len)
> +		temp.count =3D conn->rmb_desc->len;
>  	smc_curs_copy(&local->prod, &temp, conn);
> =20
>  	temp.wrap =3D peer->cons.wrap;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a
use-after-free to occur in smc_cdc_rx_handler() during connection lookup?

Looking at net/smc/smc_cdc.c:smc_cdc_rx_handler(), the connection pointer is
retrieved under the read lock but accessed after the lock is dropped:

	read_lock_bh(&lgr->conns_lock);
	conn =3D smc_lgr_find_conn(ntohl(cdc->token), lgr);
	read_unlock_bh(&lgr->conns_lock);
	if (!conn || conn->out_of_sync)
		return;

It seems a reference to the socket is not acquired before releasing the read
lock.

Could smc_conn_free() concurrently remove the connection and drop the final
socket reference, freeing the memory before the receive tasklet dereferences
conn->out_of_sync and calls smc_cdc_msg_recv() (which then performs
sock_hold() on freed memory)?

[Severity: High]
This is a pre-existing issue, but does the cursor tx_curs_fin suffer from a
data race during link failover?

In net/smc/smc_core.c:smc_switch_cursor(), the cursor is modified under
send_lock without the socket lock:

		smc_curs_add(conn->sndbuf_desc->len,
			     &conn->tx_curs_fin, diff);

Concurrently, net/smc/smc_cdc.c:smc_cdc_tx_handler() overwrites the same
cursor under the socket lock without send_lock:

		smc_curs_copy(&conn->tx_curs_fin, &cdcpend->cursor, conn);

Since smc_curs_add() performs non-atomic field updates on the 64-bit cursor
and they do not share a lock, could this concurrent read-modify-write and
store operation corrupt the cursor's wrap and count fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-disp-ed=
d64be9-v3-0-551fa514257e@proton.me?part=3D1

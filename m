Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476753CFF4A
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324465; cv=none; b=ViZOoiSbaKuq9DYGSvy+GVRBVKDDHLeY0mnptxNZZruKbhqmphfoHKzHdyQkmi9JDs6v0mCoZVBD/uzeTOhBFJhoRNIDD9SgiUUf56pdIBVDEvJV6FjpptqNY6eqgLMVKLbf24EAr8hdxMkLCnaCRPfMAh1TMNc2l6NRl5hTQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324465; c=relaxed/simple;
	bh=5/9Fv8qpd64SKg+VgM3cRNahWKOyWlVCo+7/xnHpWK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OwmemRHMm0fTjbnt4XOIup8HmPkSHcu/fxj9641bhT7swtXXo2/g/9hPXNRPHInFwaML9K1m04lYXsHDC9XQr5hv9PnlitD1iQrGKKLI1TLj4hFFw9jrGhzaBk0KyB4VSnX2x3lTP2/u0EpRvPuQeEVEjvDC0617AfIT0fyY0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhYA/WWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhYA/WWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A03E1F00A3D;
	Mon,  6 Jul 2026 07:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783324457;
	bh=i/CvEWD2GQBPAwXadqu+/5FAU82eUViZ01vUnBvYu1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IhYA/WWKqlEDazzmiVPxIMe3HKqZCxbXBXDhcc2SbniEvrOMPKn225pjGQQ5d3X9p
	 FiB/oxauyx7A54VfZmkkDKHaaWGXPLKCFtd6yrMEdsTe0zsHSkALpa/i3EUna2dR8T
	 2PYOwUINnB52aKeoUt7p+5xnWUbughr05isX8+YifVnDKCRmHorgP4Ss1iPODMezrD
	 5gpv7XUEmH6MC/dZYdzHKAhKVgE/fk1vTqU5gWzJRUrwnR4LvEla34SzA6nqPZEDDR
	 Lvn2HeiAVWNhgL/D/BMoM0oVBHvG4poYmb3rx6fieML76cPU50ATd2rRcknUJiumg6
	 MQ/lRvXcjcsiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260705-b4-disp-28a1bbca-v4-1-be089b98acc6@proton.me>
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
 <20260705-b4-disp-28a1bbca-v4-1-be089b98acc6@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:54:16 +0000
Message-Id: <20260706075417.5A03E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The SMC connection creation path publishes the connection to t=
he link group tree before allocating its receive buffer (`rmb_desc`), creat=
ing a race condition where an incoming CDC message can cause a NULL pointer=
 dereference (kernel panic) when accessing `conn->rmb_desc->len`.
- [Critical] The SMC-R asynchronous CDC receive handler looks up a connecti=
on from the link group tree but drops the lock without taking a reference, =
leading to a Use-After-Free if the socket is closed concurrently.
--

commit 16f4df4f224b2fdaeabbac3f231259cdff8766a6
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the wire-controlled producer cursor to the RMB

This commit bounds the producer cursor count to the receive buffer length
at the wire-to-host conversion for SMC-R and SMC-D. This prevents
out-of-bounds reads during urgent data handling.

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303b..ca76ef6303566 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h

[ ... ]

> @@ -246,8 +256,13 @@ static inline void smcr_cdc_msg_to_host(struct smc_h=
ost_cdc_msg *local,
>  	local->len =3D peer->len;
>  	local->seqno =3D ntohs(peer->seqno);
>  	local->token =3D ntohl(peer->token);
> -	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
> -	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
> +	/* bound the wire-controlled producer cursor to our RMB (used as a raw
> +	 * index by the urgent path); leave the consumer cursor unbounded -- it
> +	 * indexes the peer's RMB and is bounded by peer_rmbe_size.
> +	 */
> +	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
> +			       conn->rmb_desc->len);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this create a risk of a
NULL pointer dereference if the connection receives a CDC message before the
buffer is allocated?

Looking at the connection creation path, the connection is published to the
link group tree before allocating its receive buffer:

net/smc/smc_core.c:smc_conn_create() {
    ...
    rc =3D smc_lgr_register_conn(conn, true);
    ...
}

If a remote peer sends a CDC message to this connection's token before
smc_buf_create() completes, could the asynchronous handler process it and
dereference conn->rmb_desc->len while conn->rmb_desc is still NULL?

The pre-existing code also unconditionally dereferences this in
smc_cdc_msg_recv_action() via:

    diff_prod =3D smc_curs_diff(conn->rmb_desc->len, &prod_old, ...);

Could we safely ensure rmb_desc is allocated before it gets accessed in
these paths?

> +	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn, 0);
>  	local->prod_flags =3D peer->prod_flags;
>  	local->conn_state_flags =3D peer->conn_state_flags;
>  }

[Severity: Critical]
This is a pre-existing issue, but looking at the surrounding CDC receive
path, is there a potential use-after-free when handling asynchronous
messages?

In the receive handler, the connection is retrieved using smc_lgr_find_conn=
()
under a read lock, but the lock is dropped without taking a reference on
the socket:

net/smc/smc_cdc.c:smc_cdc_rx_handler() {
    ...
    read_unlock_bh(&lgr->conns_lock);
    if (!conn || conn->out_of_sync)
        return;
    smc =3D container_of(conn, struct smc_sock, conn);
    ...
    smc_cdc_msg_recv(smc, cdc);
}

If a local process concurrently closes the socket via smc_conn_free(), which
removes the connection and drops the final reference, could the socket be
freed before smc_cdc_msg_recv() executes and calls sock_hold()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-b4-disp-28=
a1bbca-v4-0-be089b98acc6@proton.me?part=3D1

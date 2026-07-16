Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7EC19E7F7
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176487; cv=none; b=CBixHzKmaJKAyBhZMxLcGcJZoGXHuUlrFKJcuaI4IGxciulMknWkXYJFJ7lVbDb9Ih9JvFgYxjdO3U0k+p718X5G3iODUnbOY7KJon8g35lM5eZ7an2aaue9LIrKtVZEW0tT0dZc7ICNSKdq26IAK1S1VK79v2Dz6MXBL3X6f6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176487; c=relaxed/simple;
	bh=PHitiJ1h5dL3DXMs1ZSJiuaNj5cw9cu1jBuHL9BSrHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IK/K1kqInmv74u0JvY+BtuIHyZK4L/lG1oZJsnR9Y/90JXjQFQBwYxDQNycibX3ye6xbHuInXf81P1HWlLcy8kkBNcLQonNabTIqzbZ3gyDpANeQPbQvELHH2fhWf/V7w+rFVV9yO2/+mUrtL0Di/pnj0c4JhB2k5v23yHmR89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2FZKQoo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2FZKQoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CF61F000E9;
	Thu, 16 Jul 2026 04:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784176485;
	bh=7wfLO20qqWzNmFwffjWIi99saV6fylFIMeGvMiTlIA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2FZKQooncf+0N2LPwLCwUyjC9kY+p7l2WpvE/2Y95mkm72d3TZziu403HgoEEiR6
	 lhc/MYsDftg2s3RI9TDXM4Hn+i2To4Dod1RUb5XlCbLfXsVZQGTJrU6uyDGYa2pvF4
	 Mdgz6Y7ebnb/95rBwxrBhlXonRg4z5LJPgN45j3oNvRNHG4btzQQGJV93HJtpCWvqV
	 l8pO8gtS8cIazAh++jT6FgyRXIZ30WNSAjiTpuLvbn1h/TfuTEwX7186ZZBmv6qwJr
	 7fm57bmz6CHJB/4iNjizV98cfsxJlpsVYlbzxpbOtrejQkIFpJy65LIp6hao7VU7Rn
	 GsMYWKRKYc7jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: order the CDC receive path against
 buffer publication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260714-b4-disp-835288a6-v2-1-581555ef2145@proton.me>
References: <20260714-b4-disp-835288a6-v2-1-581555ef2145@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:34:44 +0000
Message-Id: <20260716043445.17CF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature publication of buffer descriptors (`rmb_desc` and `sndbu=
f_desc`) via `smp_store_release()` before the completion of their associate=
d connection state initialization leaves a race window where concurrent sta=
te updates from CDC handlers can be silently overwritten.
- [High] The patch attempts to fix a NULL pointer dereference of `conn->snd=
buf_desc` in `smc_cdc_msg_recv_action()` for the SMC-D DMB-nocopy path but =
misses a secondary dereference path in the same function, leaving an exploi=
table kernel panic.
--

--- Patch [1]: [PATCH net v2] net/smc: order the CDC receive path against b=
uffer publication ---
commit 9b6f28a01319410a969a198788b79eb249671b6c
Author: Bryam Vargas <hexlabsecurity@proton.me>
Subject: net/smc: order the CDC receive path against buffer publication

This commit introduces acquire/release pairs for publishing rmb_desc and
sndbuf_desc to prevent NULL dereferences and stale reads. By ensuring
CDC handlers only see fully initialized buffers, it prevents crashes=20
during the connection setup window.

Closes: https://sashiko.dev/#/patchset/20260711-b4-disp-c36a9798-v1-1-340b0=
c6053fb@proton.me?part=3D1

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..2cd0ee7b51c22 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -353,12 +354,20 @@ static void smc_cdc_msg_recv_action(struct smc_sock=
 *smc,
>  		 * peer RMB, then update tx_curs_fin and sndbuf_space
>  		 * here since peer has already consumed the data.
>  		 */
> +		/* Pair with smp_store_release() in smcd_buf_attach(): the ghost
> +		 * sndbuf_desc is attached after the connection is reachable to
> +		 * the ISM device, so acquire it and skip the update while it is
> +		 * unset -- avoids a NULL deref and a load of an uninitialised
> +		 * buffer.
> +		 */
> +		sndbuf_desc =3D smp_load_acquire(&conn->sndbuf_desc);
>  		if (conn->lgr->is_smcd &&
> -		    smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
> +		    smc_ism_support_dmb_nocopy(conn->lgr->smcd) &&
> +		    sndbuf_desc) {
>  			/* Calculate consumed data and
>  			 * increment free send buffer space.
>  			 */
> -			diff_tx =3D smc_curs_diff(conn->sndbuf_desc->len,
> +			diff_tx =3D smc_curs_diff(sndbuf_desc->len,
>  						&conn->tx_curs_fin,
>  						&conn->local_rx_ctrl.cons);

[Severity: High]
This isn't a bug introduced by this patch, but does this function have a
secondary NULL pointer dereference path?

While this patch adds a guard for sndbuf_desc here, further down in this
same function (smc_cdc_msg_recv_action), if an early CDC message arrives
with an advanced cons cursor, diff_cons will be > 0.

This triggers the following code block:

    if ((diff_cons && smc_tx_prepared_sends(conn)) || ...

Looking at smc_tx_prepared_sends() in net/smc/smc_tx.h, it unconditionally
dereferences sndbuf_desc:

static inline int smc_tx_prepared_sends(struct smc_connection *conn)
{
    ...
    return smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
}

Could this cause a panic if conn->sndbuf_desc is still NULL during the race
window?

[ ... ]

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index cf6b620fef05f..d94b728c0d68c 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2499,7 +2499,13 @@ static int __smc_buf_create(struct smc_sock *smc, =
bool is_smcd, bool is_rmb)
>  	}
> =20
>  	if (is_rmb) {
> -		conn->rmb_desc =3D buf_desc;
> +		/* Publish with release semantics: the connection is already in
> +		 * the link group's token tree, so a concurrent CDC receive
> +		 * handler must observe a fully initialised buffer once it sees
> +		 * a non-NULL rmb_desc.  Pairs with the smp_load_acquire() in
> +		 * the CDC receive path.
> +		 */
> +		smp_store_release(&conn->rmb_desc, buf_desc);
>  		conn->rmbe_size_comp =3D bufsize_comp;
>  		smc->sk.sk_rcvbuf =3D bufsize * 2;
>  		atomic_set(&conn->bytes_to_rcv, 0);

[Severity: High]
This is a pre-existing issue, but could this ordering cause concurrent
handler updates to be silently clobbered?

By publishing rmb_desc via smp_store_release() before bytes_to_rcv is
initialized, could a CDC receive handler observe the non-NULL descriptor,
process a message, and update bytes_to_rcv via atomic_add(), only for this
thread to immediately overwrite it with atomic_set(&conn->bytes_to_rcv, 0)?

[ ... ]

> @@ -2599,7 +2605,13 @@ int smcd_buf_attach(struct smc_sock *smc)
>  	buf_desc->cpu_addr =3D
>  		(u8 *)buf_desc->cpu_addr + sizeof(struct smcd_cdc_msg);
>  	buf_desc->len -=3D sizeof(struct smcd_cdc_msg);
> -	conn->sndbuf_desc =3D buf_desc;
> +	/* Publish with release semantics: the connection is already reachable
> +	 * to the ISM device (smc_ism_set_conn() ran in __smc_buf_create()), so
> +	 * the CDC receive tasklet must observe a fully initialised ghost buffer
> +	 * once it sees a non-NULL sndbuf_desc.  Pairs with smp_load_acquire()
> +	 * in smc_cdc_msg_recv_action().
> +	 */
> +	smp_store_release(&conn->sndbuf_desc, buf_desc);
>  	conn->sndbuf_desc->used =3D 1;
>  	atomic_set(&conn->sndbuf_space, conn->sndbuf_desc->len);
>  	return 0;

[Severity: High]
This is also a pre-existing issue, but does this have the same clobbering
risk as the rmb_desc publication above?

If a CDC handler observes the published sndbuf_desc and updates sndbuf_space
via atomic_add(), wouldn't the atomic_set(&conn->sndbuf_space, ...) here
unconditionally overwrite the handler's update, leading to corrupted space
accounting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-b4-disp-83=
5288a6-v2-1-581555ef2145@proton.me?part=3D1

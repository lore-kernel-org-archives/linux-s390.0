Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AF2D5432
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211706; cv=none; b=fQy6LIHiOaR12f6RZAevUSOh1isrkxqZbJd4Bd2o+qQc7NKCw5Hs5jACT6ZDf5sJNV3iEKyrhLsK+TMQKdm5eQLX6cn8I1qX56/QvERopIjxh8NXyaV9I4cmyBPyBYpUBMVng/67Q4IduxmQWYtnVKJOOegYL9kasRv7rIvC3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211706; c=relaxed/simple;
	bh=9tXKL4whEC0JshPPjNi4xv6JiKmAbYBhzcxBLJtPh0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nkzAcpKk3cqqT0QN4jFaZlU0t0ukvSctj9gUhYSYojijPy+g6Cs7Fph+vN2SK4FjZok3heoi0C03g/Njfy50wdZU7Y3OrG44UPhjCDUYCK2VFLSAjN7FLFA2YnUJEoD8a7orZPdoIkIqTzinjS0ZxxbrD/ZLSq5kph7+4Qj0eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1nn3iAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1nn3iAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA731F000E9;
	Tue, 28 Jul 2026 04:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211705;
	bh=j1KMmOO/p1+aNq2t7ohyJGoB4KL9iXsJ63+aiHUqhj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1nn3iAiM/ZgxV7uXXxfQI1NeLicHyeRput+zD4BhSoLege9m8rW4PZJRfYQKcIxw
	 /v5TV+5hp8pA4+87K2JyjwMC78lz4JbQj8KYlXxp1P/Cnj36GuuNbxW+uYuwgJdiDB
	 Nri6fL8kU45z9vuWDWkhTK5ClSoUSolSyJqSw4RuAX6xCp4hqgvELEGBp18OGmoBgv
	 e9vfZXe6BC8YG1KUUCyoXn2YCF0xkrdnhFxHQbM9WbqqW+7cDk51Eoznok2c+8OeT1
	 BW8d3esMAHbM+NaQRApdHQklgSRaauLqBoDnoEYDMNwpR94p0CK9VajIOMfO0J0OBc
	 RzYUvoVHI339A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: clamp peer supplied CDC cursors to the
 buffer size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Le Thanh Tung" <nguyenlethanhtung555@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727040806.1911118-1-nguyenlethanhtung555@gmail.com>
References: <20260727040806.1911118-1-nguyenlethanhtung555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:08:24 +0000
Message-Id: <20260728040825.0DA731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Remote Denial of Service via WARN_ON_ONCE on unvalidated peer inpu=
t.

Pre-existing issues:
- [Critical] Incomplete bounds fix allowing massive Out-of-Bounds (OOB) mem=
ory corruption via inflated cursor differences.
- [High] NULL pointer dereference when processing CDC messages before buffe=
r allocation.
- [High] Use-After-Free in SMC-D receive tasklet due to incorrect teardown =
sequence.
- [High] Use-After-Free in SMC-R receive handler due to premature buffer re=
lease.
--

--- Patch [1]: [PATCH net] net/smc: clamp peer supplied CDC cursors to the =
buffer size ---
commit f873ac03443b750c458d1c1371904e2822a0b300
Author: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
Subject: net/smc: clamp peer supplied CDC cursors to the buffer size

This commit clamps the peer-supplied CDC cursor count to the size of the
buffer it indexes. The intent is to prevent out-of-bounds accesses by
ensuring everything derived from the cursor stays inside the buffer. Both
SMC-R and SMC-D paths are updated to perform this validation.

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
[ ... ]
> @@ -219,16 +219,34 @@ static inline void smc_host_msg_to_cdc(struct smc_c=
dc_msg *peer,
>  	peer->conn_state_flags =3D local->conn_state_flags;
>  }
> =20
> +/* Bound a peer supplied cursor count to the size of the buffer it index=
es.
> + * A conforming peer never sends count >=3D size (see smc_curs_add()), a=
nd every
> + * user of the cursor - the byte accounting in smc_cdc_msg_recv_action()=
 and
> + * the direct RMB dereference in smc_cdc_handle_urg_data_arrival() - rel=
ies on
> + * that. Nothing validates it, so do it here, once, where the value ente=
rs the
> + * connection state.
> + */
> +static inline u32 smc_cdc_clamp_count(u32 count, unsigned int size)
> +{
> +	if (WARN_ON_ONCE(size && count >=3D size))
> +		count =3D size - 1;

[Severity: High]
Does this WARN_ON_ONCE() in smc_cdc_clamp_count() evaluate peer-controlled
network input?

If a remote peer sends a crafted SMC CDC message with a cursor count field
greater than or equal to the buffer size, the condition is met.  On systems
with panic_on_warn=3D1, would this result in a kernel panic and a remote
denial of service?

[Severity: Critical]
This is a pre-existing issue, but does this clamp completely prevent the
out-of-bounds memory access?

While this clamps the count field, it doesn't restrict the total computed
difference or validate the wrap counter.  A peer can repeatedly send CDC
messages to artificially advance the wrap counter.  Because smc_curs_diff()
in net/smc/smc_cdc.c computes differences on wrap changes, this can inflate
conn->bytes_to_rcv well beyond the physical buffer sizes.

When the receive path reads chunks:

net/smc/smc_rx.c:smc_rx_recvmsg() {
    ...
    copylen =3D min_t(size_t, read_remaining, readable);
    ...
    rc =3D memcpy_to_msg(msg, rcvbuf_base + chunk_off, chunk_len);
    ...
}

It trusts the inflated bytes_to_rcv (readable).  Would this allow chunk_len
to exceed the actual buffer size, resulting in a massive out-of-bounds read
from rcvbuf_base?

> +	return count;
> +}
[ ... ]
> @@ -246,8 +264,10 @@ static inline void smcr_cdc_msg_to_host(struct smc_h=
ost_cdc_msg *local,
>  	local->len =3D peer->len;
>  	local->seqno =3D ntohs(peer->seqno);
>  	local->token =3D ntohl(peer->token);
> -	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
> -	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
> +	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
> +			       conn->rmb_desc->len);

[Severity: High]
This is a pre-existing issue, but by explicitly moving the dereference of
conn->rmb_desc->len here, does this open up a NULL pointer dereference?

During connection setup, smc_conn_create() in net/smc/smc_core.c registers
the connection in the link group's RB tree with a sequential alert_token.
This happens before smc_buf_create() allocates memory for conn->rmb_desc.

If a remote peer sends a targeted CDC message to the link group with the
predicted token, the RX softirq handler would look up the uninitialized
connection and call smcr_cdc_msg_to_host().  Would this unconditionally
dereference conn->rmb_desc->len when it is still NULL?

> +	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn,
> +			       conn->peer_rmbe_size);
>  	local->prod_flags =3D peer->prod_flags;
>  	local->conn_state_flags =3D peer->conn_state_flags;
>  }

While reviewing the connection teardown paths, a couple of other pre-existi=
ng
issues were noticed:

[Severity: High]
This isn't a bug introduced by this patch, but does the SMC-D connection
teardown sequence allow a use-after-free?

net/smc/smc_core.c:smc_conn_free() {
    ...
    if (smc_ism_support_dmb_nocopy(lgr->smcd))
        smcd_buf_detach(conn);
    tasklet_kill(&conn->rx_tsklet);
    ...
}

This frees conn->sndbuf_desc and sets it to NULL before halting the RX
tasklet. If the smcd_cdc_rx_tsklet executes concurrently via an ISM hardware
interrupt, it calls smc_cdc_msg_recv_action() which unconditionally
dereferences conn->sndbuf_desc->len.  Would this access freed memory?

[Severity: High]
This is another pre-existing issue, but does the premature release of buffe=
rs
create a race with the network RX softirq?

net/smc/smc_core.c:smc_conn_free() {
    ...
    smc_buf_unuse(conn, lgr);
    smc_lgr_unregister_conn(conn);
    ...
}

If a buffer encountered a registration error, smc_buf_unuse() synchronously
frees conn->rmb_desc.  Since the connection hasn't been removed from the
link group's RB tree yet, it is still visible.  Could a concurrent softirq
find the connection and pass it to smcr_cdc_msg_to_host(), resulting in a
dereference of the freed conn->rmb_desc->len?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727040806.1911=
118-1-nguyenlethanhtung555@gmail.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF84398FD
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447693; cv=none; b=UPJBcYueouNT9/czL5jaSbSVCdfOyqpvYEF5dlVPk/rGTP24bFkeNKo6eKTDKmMyrM2vQOtgeJX2PfeTgN2QxAztK9B62vCnO7kf0mIbBAJID2o9d5DBBPs5Y+fBhooANLX+e7tbpuO/1LxhLfvvsJl/ejAQ9oqDVJm51fglamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447693; c=relaxed/simple;
	bh=V690myhRgYL+Z5Ny7FZJVI6kHiAzvO0gOMGh4lG0wvI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Qp78A0xnPbGDSMAYcxh2Qxx6lHNWJZtXonYLcYTRGsXwmTKaAeEcgq3hWR1GvzuHoXqXBQbhed6HoYTgkrxq6xIikyyw6mUB2So4wNnGHcK0aD0BsQXPPT+seI9yBB7VHul4VJnrv09l4WlUhlJO4P/nIEYOVuUzIvgmP+Sn53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCYrijOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCYrijOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9981D1F000FF;
	Thu,  8 Oct 2026 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447691;
	bh=YeZ5qDnN2cYdfUPKX/cpfzjnc+im3+NookbwS3SUzQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCYrijOcU4D5IfbURNPvYG6TCuI1mOPOuxRkkPwqINMPbD33kystgQamlUFgr9Y0c
	 9tV81DEh9qB5dyDhoqtOT0ME5Jj0GfYHsn69LGLZ1+qwri+MJOITHS136qYm4e5dFi
	 53hOkt4XPOD1GJN9yYSsItJWZZIQrtnKXolnTyjfQZThv1dbWN3+Qp6MMXsS4U1TxB
	 EpsTl0MXq+C/4YdiTPpNCR8qIpl6l/bmDnVZ3EMuKwW9eP9J9uw9KkxAXJTy0fNmRk
	 5dY1p6McAbXtJWqdkquejepyPmJlJGDY9HALRepEGxFHf0qiwxFLJOhxeut9lkaiPg
	 Sd8nl7G/18eQQ==
Message-ID: <sashiko-outbox-163826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dibs: introduce ring-buffer send/receive API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Ruess" <julianr@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-1-636b11ebf191@linux.ibm.com>
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-1-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:21:31 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] dibs: integer underflow in __dibs_ring_space_to_end() bypasses=
 bounds checks
- [High] dibs: data race on ring pointers during peer resynchronization
- [High] dibs: missing peer resynchronization check in dibs_ring_send() and=
 dibs_ring_space_to_end()
- [High] dibs: torn read of peer metadata in dibs_ring_peer_meta() enables =
out-of-bounds writes
- [High] dibs: transient header send failure in dibs_ring_sync_peer() cause=
s infinite message replay
- [High] dibs: dibs_ring_unregister() lacks state validation causing NULL p=
ointer dereference
- [High] dibs: TOCTOU race in dibs_ring_ack() allows remote peer to block a=
cknowledgments
- [High] dibs: missing memory barrier in dibs_ring_ack() before publishing =
tail
- [High] dibs: unsafe DMA buffer allocation for wr_ring_meta due to cache-l=
ine sharing
- [Medium] dibs: dibs_ring_unregister() masks payload DMB unregistration fa=
ilure
--

commit c70d1b4a787d1f8149e96425815df0aabbcfd89f
Author: Tobias Schumacher <ts@linux.ibm.com>
Subject: dibs: introduce ring-buffer send/receive API

This commit introduces a centralized API for sending and receiving data bet=
ween
dibs peers via ring buffers. It manages DMB tokens and read/write pointers,
allowing drivers to use dibs_ring_send(), dibs_ring_recv(), and dibs_ring_a=
ck().

> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index 20c50997a7cf2..e3a33bc42fe88 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c

[ ... ]

> @@ -245,6 +249,491 @@ void dibs_dev_del(struct dibs_dev *dibs)
> +static void dibs_ring_peer_meta(struct dibs_ring_buffer *rb,
> +				struct dibs_ring_meta *peer)
> +{
> +	peer->meta_dmb_tok =3D READ_ONCE(rb->rd_ring_meta->meta_dmb_tok);
> +	peer->buff_dmb_tok =3D READ_ONCE(rb->rd_ring_meta->buff_dmb_tok);
> +	peer->size =3D READ_ONCE(rb->rd_ring_meta->size);
> +	peer->head =3D READ_ONCE(rb->rd_ring_meta->head);
> +	peer->tail =3D READ_ONCE(rb->rd_ring_meta->tail);

[Severity: High]
Does this lockless reading of fields allow torn reads?

If the remote peer updates this structure concurrently via DMA, the CPU can
observe a torn state.

For example, it could observe a newly allocated buff_dmb_tok but an old, la=
rger
size.

This allows __dibs_ring_space_to_end() to compute an overly large available
space, which enables dibs_ring_send() to write past the end of the new remo=
te
buffer.

> +	peer->reserved =3D 0;
> +}
> +
> +static int dibs_ring_send_hdr(struct dibs_ring_buffer *rb, u64 meta_dmb_=
tok)
> +{
> +	int res;
> +
> +	if (!meta_dmb_tok)
> +		return 0;
> +
> +	res =3D rb->dibs->ops->move_data(rb->dibs, meta_dmb_tok, 0, true, 0,
> +				       &rb->wr_ring_meta,
> +				       sizeof(struct dibs_ring_meta));

[Severity: High]
Is it safe to pass the embedded wr_ring_meta struct to the device layer as a
DMA data buffer?

Because struct dibs_ring_meta wr_ring_meta is embedded directly within
struct dibs_ring_buffer without ____cacheline_aligned, it shares cache lines
with frequently modified fields.

When move_data() maps it for DMA, the required cache invalidation or flushi=
ng
operations could corrupt the adjacent fields or lose concurrent CPU writes.

[ ... ]

> +int dibs_ring_unregister(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +	int ret;
> +
> +	rb->wr_ring_meta.meta_dmb_tok =3D 0;
> +	rb->wr_ring_meta.buff_dmb_tok =3D 0;
> +	rb->wr_ring_meta.size =3D 0;
> +	rb->wr_ring_meta.head =3D 0;
> +	rb->wr_ring_meta.tail =3D 0;
> +
> +	dibs_ring_peer_meta(rb, &peer);

[Severity: High]
Does this code trigger a NULL pointer dereference if the ring buffer was not
successfully registered?

The function dibs_ring_peer_meta() unconditionally executes
READ_ONCE(rb->rd_ring_meta->meta_dmb_tok).

If dibs_ring_register() previously failed during its first register_dmb() c=
all,
rb->rd_ring_meta will remain NULL.

> +	if (peer.meta_dmb_tok) {
> +		ret =3D dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
> +		if (ret)
> +			pr_warn("%s: failed to send header update: %d\n",
> +				__func__, ret);
> +	}
> +
> +	ret =3D rb->dibs->ops->unregister_dmb(rb->dibs, &rb->dmb);
> +	if (ret)
> +		pr_warn("%s: failed to unregister payload dmb: %d\n", __func__,
> +			ret);
> +
> +	ret =3D rb->dibs->ops->unregister_dmb(rb->dibs, &rb->rd_meta_dmb);

[Severity: Medium]
Does this unintentionally mask a failure to unregister the payload DMB?

The error code in 'ret' from the first unregister_dmb() operation is
immediately clobbered by the second unregister_dmb() call.

If the payload DMB fails to unregister, the function will still return 0.

[ ... ]

> +static void dibs_ring_sync_peer(struct dibs_ring_buffer *rb,
> +				const struct dibs_ring_meta *peer)
> +{
> +	if (!peer->buff_dmb_tok) {
> +		rb->wr_ring_meta.tail =3D 0;
> +		rb->peer_buff_dmb_tok =3D 0;
> +		rb->hdr_sent =3D false;
> +		return;
> +	}
> +
> +	rb->wr_ring_meta.head =3D 0;
> +	rb->wr_ring_meta.tail =3D 0;
> +
> +	if (dibs_ring_send_hdr(rb, peer->meta_dmb_tok)) {
> +		pr_warn("%s(%s): failed to send header after peer restart\n",
> +			__func__, rb->name);
> +		return;
> +	}

[Severity: High]
Can a transient header send failure here trap the receiver in an infinite
message replay loop?

If dibs_ring_send_hdr() fails, it returns early without updating
rb->peer_buff_dmb_tok, but the local tail pointer is already zeroed.

The caller (dibs_ring_recv) proceeds to evaluate data with the zeroed tail.

On the next call to dibs_ring_recv(), dibs_ring_peer_replaced() evaluates to
true again, zeroing the tail again and repeatedly processing the exact same
message.

[ ... ]

> +static size_t __dibs_ring_space_to_end(struct dibs_ring_buffer *rb,
> +				       const struct dibs_ring_meta *peer)
> +{
> +	if (!dibs_ring_peer_ready(peer))
> +		return 0;
> +
> +	return CIRC_SPACE_TO_END(rb->wr_ring_meta.head, peer->tail, peer->size);

[Severity: Critical]
Does this code suffer from an integer underflow that bypasses bounds checks?

The macro performs signed integer math.

If a remote peer maliciously shrinks its size parameter while the local head
pointer is at a large offset, the macro yields a negative integer result.

When cast to the function's size_t return type, this underflows into an
enormous unsigned integer, silently defeating the space check in
dibs_ring_send() and allowing massive out-of-bounds remote memory writes.

[ ... ]

> +size_t dibs_ring_space(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (dibs_ring_peer_replaced(rb, &peer))
> +		dibs_ring_sync_peer(rb, &peer);

[Severity: High]
Is there a data race on the ring pointers here?

If a remote peer replaces its ring buffer, both the sender thread calling
dibs_ring_space() and the receiver thread calling dibs_ring_cnt() will dete=
ct
this and simultaneously call dibs_ring_sync_peer().

Both threads will then concurrently zero out rb->wr_ring_meta.head and tail,
issuing conflicting dibs_ring_send_hdr() DMA operations.

[ ... ]

> +size_t dibs_ring_space_to_end(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	return __dibs_ring_space_to_end(rb, &peer);

[Severity: High]
Does this function miss a check for a replaced peer ring buffer?

Unlike dibs_ring_space(), this exported capacity checker silently operates =
on a
stale local head against a newly replaced peer buffer because it omits chec=
king
dibs_ring_peer_replaced().

[ ... ]

> +u32 dibs_ring_cnt(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (dibs_ring_peer_replaced(rb, &peer))
> +		dibs_ring_sync_peer(rb, &peer);

[Severity: High]
As mentioned earlier, does this concurrently trigger the exact same
state-mutating synchronization as dibs_ring_space(), leading to a data race?

[ ... ]

> +int dibs_ring_send(struct dibs_ring_buffer *rb, void *msg, u16 size,
> +		   bool notify)
> +{
> +	struct dibs_ring_meta peer;
> +	u32 old_head;
> +	int ret;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (!dibs_ring_peer_ready(&peer))
> +		return -EAGAIN;

[Severity: High]
Does this function also miss a check to synchronize the local head pointer?

Similar to dibs_ring_space_to_end(), this code reads the peer metadata but
fails to check dibs_ring_peer_replaced() before proceeding to write.

It will write payload data into the newly allocated remote buffer at an
incorrect offset using the stale, un-reset local head pointer.

[ ... ]

> +int dibs_ring_ack(struct dibs_ring_buffer *rb, size_t size)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (size > __dibs_ring_cnt(rb, &peer)) {
> +		pr_warn("%s(%s, %lx): error: tail would overtake head\n",
> +			__func__, rb->name, size);
> +		return -EINVAL;
> +	}

[Severity: High]
Is there a Time-Of-Check to Time-Of-Use vulnerability here?

Dynamically re-evaluating the volatile remote head pointer to gate advancing
the local tail pointer allows a remote peer to block acknowledgments.

A remote peer can manipulate its head pointer to equal the local tail, forc=
ing
__dibs_ring_cnt to 0.

The check fails without advancing the tail, trapping the local receiver in =
an
infinite loop repeatedly reading the same stale message.

> +
> +	rb->wr_ring_meta.tail =3D (rb->wr_ring_meta.tail + size) &
> +				(rb->wr_ring_meta.size - 1);
> +
> +	return dibs_ring_send_hdr(rb, peer.meta_dmb_tok);

[Severity: High]
Does this code miss a memory barrier before publishing the tail?

The tail pointer is updated and transmitted to the remote peer without a
preceding smp_mb() or dma_rmb() to enforce ordering against the CPU's paylo=
ad
reads.

The CPU can reorder the payload memory reads to occur after the tail update=
 is
visible to the remote peer, causing data corruption if the remote peer
overwrites the payload buffer before the reads execute.

> diff --git a/include/linux/dibs.h b/include/linux/dibs.h
> index 0c10c224bccad..30ae03484b58a 100644
> --- a/include/linux/dibs.h
> +++ b/include/linux/dibs.h

[ ... ]

> @@ -67,6 +67,83 @@ struct dibs_dmb {
>  	dma_addr_t dma_addr;
>  };
> =20

[ ... ]

> +struct dibs_ring_buffer {
> +	char name[256];
> +	struct dibs_dev *dibs;
> +	int dmb_registered;
> +	bool hdr_sent;
> +	struct dibs_dmb dmb;
> +	/* dmb for the ring metadata this side can read, peer can write */
> +	struct dibs_dmb rd_meta_dmb;
> +	/* ring metadata this side can write, peer can read */
> +	struct dibs_ring_meta wr_ring_meta;

[Severity: High]
As mentioned earlier, does embedding this struct without cacheline alignment
make it unsafe for DMA mapping in dibs_ring_send_hdr()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-console_se=
rver-v1-0-636b11ebf191@linux.ibm.com?part=3D1

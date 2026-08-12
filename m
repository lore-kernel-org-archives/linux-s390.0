Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371123ABB9
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576840; cv=none; b=RVCyV5u7DKY+1xo6FKHLX2fiTDMI6tywtXFszsYZacS9Yti6Ol+c+chSS5AkSINsGDAchPVyW1+3tQszS02Nl81X+HZlQpdaoN2/5sMxTrE8/tQYW3HyyrzH4Z63pCGkLzBVSKM8BVok92vYszi/Y4QA7e1G8blWQRFXlp65Q/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576840; c=relaxed/simple;
	bh=tmqh3LFgkNMXZalZ2VZ1XUw8LMz5iUchP0gJfbVsIic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HStOxh6Q9fFBbw0vODYXUSCJsmkUAcwq6Sb0x7bJBgo7O/L5ABfaEgJXyF6A1Xuc2uKn5BTAVsmhj5mMCTxN3mfLFLu755jF/VxyDG/rLweIWqeJReyffJiKSvTnmckQO1VxGCOEEzDBX93+dFZNjCLBmjXviIEsTb/IcHt9HP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSr51A37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSr51A37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245F61F000E9;
	Wed, 12 Aug 2026 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576838;
	bh=KmonGLq5pWtJMl0ogxksqcCtyJbuNqxwNc7Xxat/6Nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fSr51A37bFwmZ1dABWThWpf+HfBK6kDD3kmuqLbLSsgKP0Op2NrkVH8i6ZD1ZYfcL
	 N2efr7BdVnpX1HttqSc21uXVdvJ3mib3tfMdFo9+Ce6qrsAGu2luuGCJ+F/c9hIkOp
	 aztJel24F2j23wf3YWwtxw8wUlRWKRWyCN1yZShhRxs3ycvXO02+gN9ksJZnBNdjjz
	 VDnm17AqQrmay6I2jP3V7pYiJ5Vw0rawCZq4RgF/cz0JjLgv/Cp6VdK3VSJFIucREj
	 a9EQMmFsJxKkjx6tW5rWdE2oOSUbh2zy9WNPLVrsO1ZCAoi00jgVFhz/SI4UfGj/Xc
	 QOOUkEelZzURw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 2/3] net/smc: bound the peer rkey counts in
 SMC-Rv2 LLC messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260811231902.47089-3-yhlee@isslab.korea.ac.kr>
References: <20260811231902.47089-1-yhlee@isslab.korea.ac.kr>
 <20260811231902.47089-3-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:20:37 +0000
Message-Id: <20260812232038.245F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch prevents an out-of-bounds read by skipping or clamping t=
he parsing of SMC-Rv2 LLC message extensions when `max_recv_sge =3D=3D 1`, =
but this severely breaks the SMC-Rv2 protocol.

Pre-existing issues:
- [High] Hardware overwrite and unprotected mutation of shared SMC-Rv2 LLC =
receive buffer `lgr->wr_rx_buf_v2` causes data corruption for concurrent or=
 subsequent messages.
- [High] The actual hardware payload length (`wc->byte_len`) is discarded, =
allowing short packets to trigger parsing of uninitialized or stale data in=
 the V2 extension buffer.
- [High] Missing memory barriers in `smc_rtoken_delete()` when clearing rto=
kens allows data races with `smc_rtoken_add()`.
--

--- Patch [2]: [PATCH net v6 2/3] net/smc: bound the peer rkey counts in SM=
C-Rv2 LLC messages ---
commit bfe2c3983098dc0afd1d51be57a1a079c74df3f7
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages

This commit addresses an out-of-bounds read in SMC-Rv2 LLC messages when
operating on a link with max_recv_sge =3D=3D 1. It prevents reading past the
allocated 44-byte inline message by skipping the extension parsing when
there is no shared v2 receive buffer and bounding the read loops.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 7282f8ad7593d..f04e0392ec96c 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -1000,13 +1000,21 @@ static void smc_llc_save_add_link_rkeys(struct sm=
c_link *link,
>  					struct smc_link *link_new,
>  					u8 *llc_msg)
>  {
> +	const u32 rt_off =3D offsetof(struct smc_llc_msg_add_link_v2_ext, rt);
>  	struct smc_llc_msg_add_link_v2_ext *ext;
>  	struct smc_link_group *lgr =3D link->lgr;
>  	int max, i;
> =20
> +	/* Without a shared v2 receive buffer the extension is not copied
> +	 * into the queue entry, so not even ext->num_rkeys is there.
> +	 */
> +	if (!smc_link_shared_v2_rxbuf(link))
> +		return;

[Severity: High]
Does skipping the extension completely when max_recv_sge =3D=3D 1 break the
SMC-Rv2 protocol?

Since smc_llc_enqueue() only copies 44 bytes into qentry->msg, any V2
extension received when there is no shared receive buffer is discarded. By
returning early here, it seems we completely skip saving the peer's rkeys,
which would cause RDMA operations over the new link to fail.

>  	ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
>  						     SMC_WR_TX_SIZE);

[Severity: High]
This is a pre-existing issue, but does reading this extension from the
shared receive buffer cause data corruption for subsequent messages?

When max_recv_sge =3D=3D 2, the completion tasklet smc_wr_rx_process_cqes()
processes the CQE, copies only the first 44 bytes into the event queue,
and immediately re-posts the receive WQE via smc_wr_rx_post().

This hands ownership of lgr->wr_rx_buf_v2 back to the hardware before the
workqueue smc_llc_event_work() processes the extension. If a subsequent
message arrives, the hardware could silently overwrite the extension in
lgr->wr_rx_buf_v2 while the worker thread is reading it here.

>  	max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);

[Severity: High]
This is a pre-existing issue, but can this parse uninitialized or stale data
if the packet was short?

In smc_llc_rx_handler(), the code only verifies that the 44-byte base header
was received:

    if (wc->byte_len < sizeof(*llc))
        return; /* short message */

The actual hardware payload length (wc->byte_len) is discarded because
smc_llc_enqueue() only copies the 44-byte structure into the event queue.
When the worker thread runs, it unconditionally parses the V2 extension from
lgr->wr_rx_buf_v2. If the peer sent a message that was exactly 44 bytes but
specified a longer length_v2 in the header, wouldn't the hardware leave
lgr->wr_rx_buf_v2 uninitialized or stale?

> +	max =3D min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
> +			      sizeof(ext->rt[0]));
>  	down_write(&lgr->rmbs_lock);
>  	for (i =3D 0; i < max; i++) {
>  		smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,

[ ... ]

> @@ -1811,17 +1819,25 @@ static void smc_llc_rmt_delete_rkey(struct smc_li=
nk_group *lgr)
>  	link =3D qentry->link;
> =20
>  	if (lgr->smc_version =3D=3D SMC_V2) {
> +		const u32 rkey_off =3D
> +			offsetof(struct smc_llc_msg_delete_rkey_v2, rkey);
>  		struct smc_llc_msg_delete_rkey_v2 *llcv2;
> +		u32 buf_len;
> =20
>  		if (smc_link_shared_v2_rxbuf(link)) {
>  			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
>  			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;

[Severity: High]
This is a pre-existing issue, but does mutating the shared hardware receive
buffer cause data corruption?

By using memcpy to write to lgr->wr_rx_buf_v2 without any synchronization,
the code modifies memory that is actively mapped for DMA RX. If the hardware
concurrently writes a new message into this shared buffer, could this corru=
pt
the incoming LLC messages?

> +			buf_len =3D SMC_WR_BUF_V2_SIZE;
>  		} else {
>  			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)llc;
> +			buf_len =3D sizeof(qentry->msg);
>  		}
>  		llcv2->num_inval_rkeys =3D 0;
> =20
>  		max =3D min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
> +		/* bound by the buffer llcv2 points at */
> +		max =3D min_t(u32, max, (buf_len - rkey_off) /
> +				      sizeof(llcv2->rkey[0]));

[Severity: High]
When max_recv_sge =3D=3D 1, buf_len is clamped to sizeof(qentry->msg) which=
 is
44 bytes. Does this artificially limit the number of deleted rkeys to 9?

The peer might have sent up to 255 rkeys to delete, but any remaining rkeys
would be silently ignored, causing a state mismatch with the peer.

>  		for (i =3D 0; i < max; i++) {
>  			if (smc_rtoken_delete(link, llcv2->rkey[i]))

[Severity: High]
This is a pre-existing issue, but does smc_rtoken_delete() lack memory
barriers, causing data races with smc_rtoken_add()?

In smc_rtoken_delete(), the rtoken fields are cleared and then clear_bit()
is called:

    lgr->rtokens[i][j].rkey =3D 0;
    lgr->rtokens[i][j].dma_addr =3D 0;
    clear_bit(i, lgr->rtokens_used_mask);

Because clear_bit() does not imply a memory barrier, the CPU can reorder the
bit clear before the zeroing stores.

If another thread concurrently executes smc_rtoken_add() (for example, while
processing a CLC accept/confirm message), it might observe the cleared bit,
reserve the slot, and initialize it:

    i =3D smc_rmb_reserve_rtoken_idx(lgr);
    lgr->rtokens[i][lnk->link_idx].rkey =3D rkey;

Could the delayed zeroing stores from smc_rtoken_delete() then silently
overwrite these newly initialized fields?

>  				llcv2->num_inval_rkeys++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811231902.4708=
9-1-yhlee@isslab.korea.ac.kr?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596B314D05
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567950; cv=none; b=pw88unVHfBj3h4DiyibBxn/uP2pmy8v6kxvDpZQ+CAvweQvtfnZDaaheUMA93vFZ5SnJXW3BBmVJbWcHLkTCPe5yGwwJS51oPAKme+UWuMqSy7fIAw7tz0BVPExxDmpWM8Bad9KKUTQp/EM/ae7fAEi+6SX8DFlhFvaBNm4d/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567950; c=relaxed/simple;
	bh=br7QodaXJNpzFiVteTLKOpVphh8Nj5WXj8ln+on2xmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3HARxONBLlWfH6OMl63iLopsC/RSGrETQIq3MfHjSJ74h1dY39JRJdJQX2TzIYTn/7YzUglSVS6LNa89iH8weKC7HoVPWvlH5COgRfn/qwc27NRZvyIaz2xB9V2ytRWDEc12jhOAhPtL4Ra2DWSuonBpt5pfYZbYE43rh7ogyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1YW/A9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1YW/A9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365231F00AC4;
	Sat,  1 Aug 2026 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785567948;
	bh=tNGbp7+HrvrnTWJlvOOcs5LFrcBvIB2DyJ2iuWESeo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1YW/A9citOUpJYFfexG/L4nlf5sV8t4ojySkNcO3MP2hw7Vl5vJygf+mreeO4DJq
	 E2a5xp+QW5bmk9GqPtEQZqw27vVEe93SEwbky5kGEMXW9+1gHC2D0EI4z7GmK+p0+a
	 +OzUYIH7su4Of15oaonzNH+v9lOHgzvS+JI38h9M4cw+8VhV80BeIb/a+OzkJAcOa1
	 ulcJi4gaVeR6APWlcdprQ1G3MMiU9sQpUoc0JfFOAzdn00pYYnl3ukH7M8w13023yG
	 ZH9kIG9emIWqs2U8/CXIQqad2DWTV9/X9HYya3M9pZoQFJguxAowVBgozjYz8dGJDV
	 OFzGYrQxFvOxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/3] net/smc: bound the peer rkey counts in
 SMC-Rv2 LLC messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731070509.1818665-3-yhlee@isslab.korea.ac.kr>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
 <20260731070509.1818665-3-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 07:05:47 +0000
Message-Id: <20260801070548.365231F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch breaks SMC-R V2 connection setups and rkey deletions for=
 devices with `max_recv_sge =3D=3D 1` by intentionally discarding valid ext=
ension data under a false assumption.

Pre-existing issues:
- [High] The parsing loops process uninitialized or stale memory because th=
ey validate against buffer capacity rather than actual received network len=
gth.
- [High] Lockless modification of shared `lgr->rtokens` array and bitmap by=
 `smc_rtoken_delete` and `smc_rtoken_add`.
- [High] CPU writes to a buffer mapped for DMA_FROM_DEVICE that is actively=
 exposed to the hardware receive queue.
--

--- Patch [2]: [PATCH net v4 2/3] net/smc: bound the peer rkey counts in SM=
C-Rv2 LLC messages ---
commit 3af7503159894578c914029204c5f338ebbaaf3d
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages

This patch bounds the rkey extraction loops in SMC-Rv2 LLC messages to
the buffer size to prevent slab-out-of-bounds reads. It also skips the
extension processing entirely for devices without a shared v2 receive
buffer, under the assumption that nothing beyond the 44 inline bytes
was received.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 90746cd1e29a3..606d2dc8c7ece 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -1000,13 +1000,22 @@ static void smc_llc_save_add_link_rkeys(struct sm=
c_link *link,
>  					struct smc_link *link_new,
>  					u8 *llc_msg)
>  {
> +	const u32 rt_off =3D offsetof(struct smc_llc_msg_add_link_v2_ext, rt);
>  	struct smc_llc_msg_add_link_v2_ext *ext;
>  	struct smc_link_group *lgr =3D link->lgr;
>  	int max, i;
> =20
> +	/* The extension follows the 44 bytes of the LLC message.  Without a
> +	 * shared v2 receive buffer nothing beyond those 44 bytes was received,
> +	 * so not even ext->num_rkeys is there to be read.
> +	 */
> +	if (!smc_link_shared_v2_rxbuf(link))
> +		return;

[Severity: High]
Does this early return cause a permanent protocol failure for devices with a
single receive SGE?

It appears that when max_recv_sge =3D=3D 1, lnk->wr_rx_buflen is configured=
 to
8192 bytes, meaning the single SGE actually does receive the full extension
data from the hardware.=20

By dropping the data here under the assumption that it wasn't received, does
this silently break the protocol and cause peers to get Remote Access Errors
during RDMA writes because the rkeys are never registered?

>  	ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
>  						     SMC_WR_TX_SIZE);
>  	max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
> +	max =3D min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
> +			      sizeof(ext->rt[0]));
>  	down_write(&lgr->rmbs_lock);
>  	for (i =3D 0; i < max; i++) {
>  		smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,

[Severity: High]
This isn't a bug introduced by this patch, but could this loop read
uninitialized or stale memory if a peer sends a truncated packet?

The loop in smc_llc_save_add_link_rkeys() calculates max based on the buffer
capacity (SMC_WR_BUF_V2_SIZE) instead of the actual received network length=
.=20

If a peer sends a short packet (e.g., 44 bytes) but specifies a large
num_rkeys in the header, could this read beyond the received data into stale
buffer memory, resulting in the host registering arbitrary memory regions?

[ ... ]

> @@ -1813,17 +1822,27 @@ static void smc_llc_rmt_delete_rkey(struct smc_li=
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

[Severity: High]
This is a pre-existing issue, but does this memcpy() write to a buffer that
is actively mapped and exposed to the hardware?

Writing to lgr->wr_rx_buf_v2 (a DMA_FROM_DEVICE buffer) without unmapping or
syncing violates the DMA API. On non-cache-coherent architectures, dirtying
the cacheline here can cause conflicts when the cache is later invalidated =
to
read the hardware's data, which might destroy either the CPU's write or the
incoming hardware data.

>  			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
> +			buf_len =3D SMC_WR_BUF_V2_SIZE;
>  		} else {
>  			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)llc;
> +			buf_len =3D sizeof(qentry->msg);
>  		}

[Severity: High]
Similar to the issue above, bounding buf_len to sizeof(qentry->msg) for
devices without a shared v2 receive buffer forces a limit of 44 bytes. Does
this silently truncate and ignore valid deletion requests from the sender w=
hen
the underlying single SGE actually received the full payload?

>  		llcv2->num_inval_rkeys =3D 0;
> =20
>  		max =3D min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
> +		/* the rkeys live in the buffer llcv2 points at, and nothing
> +		 * beyond it was received
> +		 */
> +		max =3D min_t(u32, max, (buf_len - rkey_off) /
> +				      sizeof(llcv2->rkey[0]));
>  		for (i =3D 0; i < max; i++) {
>  			if (smc_rtoken_delete(link, llcv2->rkey[i]))
>  				llcv2->num_inval_rkeys++;

[Severity: High]
This is a pre-existing issue, but can this call to smc_rtoken_delete() cause
a data race?

It appears smc_llc_rmt_delete_rkey() calls smc_rtoken_delete() inside this
loop without holding lgr->rmbs_lock. Because smc_rtoken_delete() locklessly
modifies the shared lgr->rtokens array and the rtokens_used_mask bitmap,
could this race with concurrent modifications in smc_rtoken_add() and lead =
to
leaked rtokens or corrupted memory registrations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731070509.1818=
665-1-yhlee@isslab.korea.ac.kr?part=3D2

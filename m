Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204D344DB7
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193229; cv=none; b=rpk0bHq+EHiKgoN8xWRKxMplvF19HscZNZVYH/2eURnmY0EpJBrXZRQ1q41LvaxJ3HD8zfVVgXE5iUPnppmaE7hmDkGS0DGvLG9FlCpR+/FwAF5ZCvbg5Z1PZ9txFPKQ0z0/0GuzGxGfdeEHMdxt8xHAzyI2rkZ09VXE25FKN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193229; c=relaxed/simple;
	bh=Quc8OYINf/BbzBom4Fxb2PtCCTbKLpkyiQBpjydWk9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SpPzU/oXiWbKsM2Uhj9YZA1t0fDA0oAnH/fDBoABMIkW1ozUqYYpM2+6P2fsMdQPZkdTvwH7gbY+bSDgXIseXpRpzRIGLqm2lpuv+AsD2t5YDHMiQW852zScDt6P4YA1+Xr/Lx4uMQDyxXDAgHIp0v+Vfaul1NSkKUOAppmMMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH3oV8nv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH3oV8nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5461F00A3D;
	Thu, 20 Aug 2026 02:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787193228;
	bh=cAaRv2dZYTVPX7VMvfDkVkUWU7pki6XXQ6YLlY+tfeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IH3oV8nvjVX2uVt7K3Obd5OhlkMIXpa6hZ+m+CoN/owkqb/QMf9bz/oi9MuEjwMMf
	 8a8LabYyVjw5gjXQaOOO5xG6vddMnz1c7xVltag/eRXIhRomiSev9Ox5/HXH4tOXxy
	 /XvOGw55PrWC/bgvclIMm1uCwdFAbzLHO5Gb7c1vpvND8NK/HcmB/l6BBi80d+EnlT
	 e+UcZHX9VockgquGKjyuzmTlQCyDZe+SuKmIp9LOsEZEYWuA06PVFN4I65VoW/fxjl
	 yBEbQsDBYy4IHcSrbjwhElUjTFCgn4X3MH+WnRVnZV7Mh5SZZxnk3finohHvQr2AT2
	 Xksitw+K8xDPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 2/3] net/smc: bound the peer rkey counts in
 SMC-Rv2 LLC messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260819023306.644849-3-yhlee@isslab.korea.ac.kr>
References: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr>
 <20260819023306.644849-3-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 02:33:47 +0000
Message-Id: <20260820023347.9D5461F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Data Race and DMA Buffer Overwrite in Shared Rx Buffer
- [High] Incomplete Bounds Check allows Stale Data Read
- [High] Functional Protocol Breakage and Silent Truncation for max_recv_sg=
e =3D=3D 1
- [High] Concurrent modification of lgr->rtokens without holding rmbs_lock
- [High] DMA Cache Coherency and API Violation
--

--- Patch [2]: [PATCH net v7 2/3] net/smc: bound the peer rkey counts in SM=
C-Rv2 LLC messages ---
commit d101a926b1d8bf4e6a72617cd433aee546b7917f
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages

This commit bounds the remote key count loops in SMC-Rv2 LLC message
processing by the size of the buffer being read. It also prevents reading
past the inline message bytes when there is no shared v2 receive buffer.

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
This isn't a bug introduced by this patch, but does this early return cause=
 a
silent protocol failure?

By skipping the processing of the peer's new remote memory region keys, it
seems this could lead to persistent connection failures for SMC-Rv2 links w=
hen
max_recv_sge =3D=3D 1. The underlying issue appears to be that smc_llc_enqu=
eue()
only copies the 44-byte inline header and discards the extension.

>  	ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
>  						     SMC_WR_TX_SIZE);

[Severity: Critical]
This is a pre-existing issue, but can reading from the asynchronously modif=
ied
shared receive buffer cause memory corruption?

If a peer sends multiple LLC messages with extensions back-to-back, the
hardware might DMA a new incoming extension over the existing one before it=
 is
processed in llc_event_work. Could this lead to reading overwritten state?

>  	max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
> +	max =3D min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
> +			      sizeof(ext->rt[0]));

[Severity: High]
This isn't a bug introduced by this patch, but does using the statically
allocated maximum buffer size here, rather than the dynamically received
message length, permit stale data reads?

If a peer sends a short packet but specifies a large num_rkeys, the bounds
check might allow the loop to iterate through stale data left over from
previous messages.

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

[Severity: High]
This isn't a bug introduced by this patch, but does this explicit memcpy to=
 a
DMA_FROM_DEVICE mapped buffer violate the DMA API?

Writing directly to this buffer could dirty the cache line shared with the
hardware's concurrent DMA of the message extension, which might cause the C=
PU
cache writeback to clobber the incoming hardware DMA.

>  			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;

[Severity: Critical]
This is a pre-existing issue, but similar to the addition flow above, can
reading directly from the shared receive buffer here result in data races
if the hardware performs a DMA overwrite before the extension is fully
processed?

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
This is a pre-existing issue, but could bounding against the static buffer
capacity rather than the actual packet length cause stale data to be proces=
sed
if the packet length is smaller than the capacity?

>  		for (i =3D 0; i < max; i++) {
>  			if (smc_rtoken_delete(link, llcv2->rkey[i]))

[Severity: High]
This is a pre-existing issue, but does calling smc_rtoken_delete() here
modify the shared token structures without holding the required rmbs_lock?

In smc_llc_save_add_link_rkeys(), modifications to the tokens are protected=
 by
down_write(&lgr->rmbs_lock). Modifying them concurrently without the lock c=
ould
potentially corrupt the rtokens list.

>  				llcv2->num_inval_rkeys++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819023306.6448=
49-1-yhlee@isslab.korea.ac.kr?part=3D2

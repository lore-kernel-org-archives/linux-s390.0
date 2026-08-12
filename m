Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C940B0F9
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576841; cv=none; b=uAwBGmBxwRSdbf4woKwDFMST4Wb+3Aeetn7anidQtxv/8fcSLIUIIzuh2vKRhjW+cgpHDJEPh+Hc7/T3aunxS9uCRmLJlEAys96HDGwgUgaK/eYzYK3+iVoQL7Lcrx2D9aEJfCkyulHJ2BgtqOfm58C7MlZAithjIbXxw+20T9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576841; c=relaxed/simple;
	bh=wHNCLPreskhAfLLQOAvmZQb8Qp03Tomh3S3/7RbzYhg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gBbQeNaxedntSTl6cIUjTCCRosZTc9QbVJVKJvqF5l9riI38qZKW2k4ZwEow26wztQT4jrnp64g7k6ZXlDxw/ZIJo0G+ZqgIcFe1A9ZvFFkYZgnOzgnSh+W8/NdKaoUM0E6LNCpVSAtmmRU8NzL0zOnAWzTtMvUZ3nbYukQaWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLhQxL4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLhQxL4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B361F00A3D;
	Wed, 12 Aug 2026 23:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576840;
	bh=Em8EtCcS3fOlgofsNFCCJbr33wlqS8ysZsL+cD8f58c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TLhQxL4xS/mxHg5X8vdYZ9nBHSy1GDjFz/eb/VHnjNETBQRZwSUppxsPobpBfO9Jl
	 mC0tedWIxeZ7rA+SEGx/KMVDAqyWg9mS2C9Qht8PJqvH9A05Q4ba6lA2Gku8AAK1c0
	 AGc7MQ8N59dp1H7EZ+jX0lYsqOvOe6kAOiTcsSl/jBXDpXqdMuOEVH/7SjqSquwdhm
	 7n69C8THo0BFC2qwoqrvRPsYg5g1mApTByF5PEdMop/IRxX+xwoNGq250SLztQEmaR
	 kOGRpeuMJMOlVV2d/kwmEE5yb37Z89xwubjAOqVXvtAsFZgZf7Fty2DkemLaFz037R
	 LhYtXEtaLJx3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 3/3] net/smc: carry oversized SMC-Rv2 LLC
 messages in the queue entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260811231902.47089-4-yhlee@isslab.korea.ac.kr>
References: <20260811231902.47089-1-yhlee@isslab.korea.ac.kr>
 <20260811231902.47089-4-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:20:39 +0000
Message-Id: <20260812232039.C8B361F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race due to lockless modifications of rtoken state in the rem=
ote LLC flow.
- [High] Hardware-level data corruption due to sharing a single DMA spillov=
er buffer across all receive WQEs.
--

--- Patch [3]: [PATCH net v6 3/3] net/smc: carry oversized SMC-Rv2 LLC mess=
ages in the queue entry ---
commit 189076dfcd2735a0769a31ecfff64742ead50fcf
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

This commit updates SMC-Rv2 to copy the tail of oversized LLC messages
into the queue entry itself instead of relying on a shared receive buffer
bound by the arrival time. This allows operations like ADD_LINK and
DELETE_RKEY_V2 to process all declared rkeys correctly without being limited
by the buffer size.

Cc: stable@vger.kernel.org

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -1819,27 +1835,28 @@ static void smc_llc_rmt_delete_rkey(struct smc_li=
nk_group *lgr)
>  		max =3D min_t(u32, max, SMC_LLC_DEL_RKEY_V2_INLINE +
>  				      qentry->body_len / sizeof(__be32));
>  		for (i =3D 0; i < max; i++) {
> -			if (smc_rtoken_delete(link, llcv2->rkey[i]))
> +			__be32 rkey;
> +
> +			if (i < SMC_LLC_DEL_RKEY_V2_INLINE)
> +				rkey =3D llcv2->rkey[i];
> +			else
> +				memcpy(&rkey, qentry->body +
> +					      (i - SMC_LLC_DEL_RKEY_V2_INLINE) *
> +					      sizeof(rkey), sizeof(rkey));
> +			if (smc_rtoken_delete(link, rkey))

[Severity: High]
This isn't a bug introduced by this patch, but does calling
smc_rtoken_delete() here introduce a data race?

Looking at smc_rtoken_delete() in net/smc/smc_core.c, it zeroes the
lgr->rtokens array and calls clear_bit() on lgr->rtokens_used_mask without
holding the lgr->rmbs_lock.

Concurrently, another thread executing the local flow like
smc_llc_srv_add_link() -> smc_rtoken_set() will acquire
down_write(&lgr->rmbs_lock) to modify these exact same structures.

Could this lack of locking in the remote flow lead to rtoken state
corruption?

>  				llcv2->num_inval_rkeys++;
>  		}

[ ... ]

> @@ -2081,18 +2098,52 @@ static void smc_llc_rx_response(struct smc_link *=
link,
>  	qentry->link =3D link;
>  	INIT_LIST_HEAD(&qentry->list);
>  	memcpy(&qentry->msg, llc, sizeof(union smc_llc_msg));
> +	if (body_len) {
> +		u8 *src =3D smc_link_shared_v2_rxbuf(link) ?
> +			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)llc;
> +
> +		memcpy(qentry->body, src + SMC_WR_TX_SIZE, body_len);
> +	}

[Severity: High]
This is a pre-existing issue, but is it safe to copy from this shared buffer
if multiple oversized messages arrive back-to-back?

In smc_wr_init_sge() (in net/smc/smc_wr.c), every receive WQE has its second
SGE mapped to the exact same shared DMA address (lnk->wr_rx_v2_dma_addr +
SMC_WR_TX_SIZE).

Because the hardware HCA processes incoming packets at wire speed
independently of CPU polling, if a remote peer sends multiple oversized LLC
messages (like back-to-back DELETE_RKEY_V2 messages), won't the hardware DMA
the tails of both messages into this exact same shared spillover buffer?

Could this cause the earlier message's tail to be overwritten before this
memcpy executes, leading to state corruption from reading incorrect body da=
ta?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811231902.4708=
9-1-yhlee@isslab.korea.ac.kr?part=3D3

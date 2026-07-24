Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C541F353
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886066; cv=none; b=JFLM8qQAyZJNUDrVm9TJiY5TqzmQzp4ph0O3u7ERVDXjCIMF5uPwQTZh9CbjajHwqyrh6i0SX+yi8dRxukxDV3eBjhtXNq7gjCiUHI46Pe6y2tzvj4NNxC+pyJK8VYpy7FaG3I0m2mit0GDOcsPAsqXtmg7Wb2pWBEwmgEPtfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886066; c=relaxed/simple;
	bh=UduHHva7fNb6ExA0U0dW31KyA/yV+MHB4THPHvGcxrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rW1Rp5Fa0n/LkZs4xfKfVQ3puCkJsIU6/WUVHfeEjzWSIKMQdiMpFIM1IkoxnSlNcN5RWfNLxYKa/2KwlQOOR2nvbTC4RkbrV3WTmFo/MXufmWEwvHdu9KdGED1cYimqXaXZf324XMtIGMWzXQ4VHbC5d0GuK0f0NmisGrPpLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac1Dm1PZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac1Dm1PZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0561F00A3A;
	Fri, 24 Jul 2026 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784886063;
	bh=RbMAEeR0943lZAOh1LLISAKUlPtX5NvYP2lWsrcbivo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ac1Dm1PZE5NUt/S7VWzEd15R6acDhuy2WCKYUD6EQVD2HWJ2xQxR3FLbEnr3lbXe3
	 +cAk+V45f2YLZ1IMFvdZVCmK3GZymj8j7oLp2B+T6Xd3aY8ujHxAtsSYxnZBYAsNSD
	 D8Q1gIkvO1WFohgO+1MoTeFzTE4uI1fq5qG1zkujXgEWaQCixRRP35rqtWxCzV4RLb
	 06Mqe9WbNExuq7niUrLecBXxu7hjmg5ZqZWmV8wLFahf54OxD2i0UaXoyJa7z4Q9KW
	 2QwwVe/KZr/f9koK5Jw+Oc7IOYJxjpjv5NrLGrQMhfQ3N0SD0LXj18R85MEzy4cWBQ
	 8zV6sEF64fIdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: fix out-of-bounds read of rkey array in
 SMC-Rv2 LLC processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723094027.391199-1-yhlee@isslab.korea.ac.kr>
References: <20260723094027.391199-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:41:02 +0000
Message-Id: <20260724094103.7C0561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Remote NULL pointer dereference in `smc_llc_rx_handler` when r=
eceiving an SMC-Rv2 packet on an SMC-Rv1 link group.
- [High] Data race and payload corruption due to lockless shared buffer ove=
rwrite in tasklet context.
- [High] Processing uninitialized or stale memory for V1 messages on V2 lin=
k groups.

Pre-existing issues:
- [High] Incomplete fix for out-of-bounds read translates the vulnerability=
 into stale memory processing.
--

--- Patch [1]: [PATCH net] net/smc: fix out-of-bounds read of rkey array in=
 SMC-Rv2 LLC processing ---
commit aefbf14dc11357a5a9793f782a4910a8949cde03
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: fix out-of-bounds read of rkey array in SMC-Rv2 LLC processing

This commit addresses an out-of-bounds read in SMC-Rv2 LLC processing by
copying the full message to wr_rx_buf_v2 for the non-shared layout. The
subsequent processing functions are then updated to read the rkey array
from this buffer, bounding the reads to SMC_WR_BUF_V2_SIZE.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 954b2ff1815c2..1c32bf9700989 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -1812,12 +1810,15 @@ static void smc_llc_rmt_delete_rkey(struct smc_li=
nk_group *lgr)
>  	if (lgr->smc_version =3D=3D SMC_V2) {
>  		struct smc_llc_msg_delete_rkey_v2 *llcv2;
> =20
> -		if (smc_link_shared_v2_rxbuf(link)) {
> +		if (smc_link_shared_v2_rxbuf(link))
>  			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
> -			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
> -		} else {
> -			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)llc;
> -		}
> +		/* The full message, including the rkey array, has been placed in
> +		 * wr_rx_buf_v2 for both rxbuf layouts (shared: header copy above
> +		 * + spillover DMA; non-shared: full copy in smc_llc_rx_handler()).
> +		 * Reading it from the fixed-size qentry copy would run past its
> +		 * end.
> +		 */
> +		llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;

[Severity: High]
If a peer sends a V1 message (llc_version =3D=3D 0) over a V2 link, the mem=
cpy
in smc_llc_rx_handler() is bypassed. However, since the link group version
(lgr->smc_version) is SMC_V2, we reach this point and read from
lgr->wr_rx_buf_v2.

Doesn't this mean we are reading and processing stale memory left over from
a previous V2 message, rather than the V1 message just received?

[Severity: High]
Since smc_llc_rx_handler() unconditionally overwrites lgr->wr_rx_buf_v2
from a tasklet without restoring the header from the queued llc copy for
the non-shared layout, what happens if concurrent LLC messages are received?

If a large message (like DELETE_RKEY_V2) is quickly followed by a short
message (like TEST_LINK), couldn't the short message overwrite the first
few bytes of lgr->wr_rx_buf_v2 before the worker thread runs? This would
cause the worker thread to parse corrupted headers for the first message.

>  		llcv2->num_inval_rkeys =3D 0;
> =20
>  		max =3D min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);

[Severity: High]
This is a pre-existing issue, but this loop relies on the untrusted
num_rkeys without verifying if the received packet is actually large enough
to contain them.

If a truncated message is received with a large num_rkeys,
smc_llc_rx_handler() only copies up to wc->byte_len bytes into
lgr->wr_rx_buf_v2.

Doesn't this loop then read past the newly copied bytes into stale memory
from previous messages left in the buffer?

[ ... ]

> @@ -2104,6 +2105,16 @@ static void smc_llc_rx_handler(struct ib_wc *wc, v=
oid *buf)
>  	} else {
>  		if (llc->raw.hdr.length_v2 < sizeof(*llc))
>  			return; /* invalid message */
> +		/* For the non-shared v2 rxbuf layout the received message lives
> +		 * only in the per-WR receive buffer, which is reposted as soon as
> +		 * this handler returns.  The LLC event handlers run later from a
> +		 * work item and read the message from wr_rx_buf_v2, so the whole
> +		 * message must be preserved there now, mirroring the shared-rxbuf
> +		 * layout where the body arrives in wr_rx_buf_v2 via spillover DMA.
> +		 */
> +		if (!smc_link_shared_v2_rxbuf(link))
> +			memcpy(link->lgr->wr_rx_buf_v2, llc,
> +			       min_t(u32, wc->byte_len, SMC_WR_BUF_V2_SIZE));

[Severity: Critical]
If a remote peer sends an LLC message with a non-zero llc_version on an
SMC-Rv1 link group, we enter this else block.

For V1 links, smc_link_shared_v2_rxbuf(link) evaluates to false because
lnk->wr_rx_sge_cnt is 1, so we execute this memcpy. However,
lgr->wr_rx_buf_v2 is only allocated for V2 link groups and will be NULL
for V1 links.

Could this result in a NULL pointer dereference in the tasklet context if
an attacker sends such a packet on a V1 link?

>  	}
> =20
>  	smc_llc_enqueue(link, llc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723094027.3911=
99-1-yhlee@isslab.korea.ac.kr?part=3D1

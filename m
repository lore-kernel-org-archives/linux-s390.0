Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7C3126B9
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784955223; cv=none; b=NtApUv4DSICUwJE2mYetNlMIWyxLaKWMAiFlbj+sdY28RrLA8uUjHnUU52QhofMzFIZo5LorNSbnkJgvETm9gWmfScCNtopPVG+T1WKh6w2/0osxKBQA3G0ssqEz9MTpjSYCDWDWmZgW2QP7BNEt0nl32vyvowZmm3KCXC64emM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784955223; c=relaxed/simple;
	bh=I4dKDsUctMO0G6bk9SDXMkcjAhyavFXKtcO62C+khS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=txA6pCoo8TY3gm2wekP6xSBN5rCpIehUB2h2BM002Yc+oQnApsm4SexAUObMPTOiUbtWg36RlZviqEVq0+K72iNNJddCL2aRj56kJ2HT3TWEzUYRN+xgj2By7E7ZATDI1ZTaDF3asLQ6L+sA+YiH5MoSSk6OfyKzmfBawMkD4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDgskbvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDgskbvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B131F000E9;
	Sat, 25 Jul 2026 04:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784955221;
	bh=WKfEb4M6QHVTo/w9cjpDeg5Jhk84BWwIEUdtIPsV3Y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDgskbvCaimoVPzfyf6WpuZTdRWsQeLwzWIQX9VDQZn7hbCmP7l8Tv+l6SCSxCvZG
	 dPO1bWsyynJz7UwKXLaH33LeOHWzQc8IW+lehJi37U6eUcWNXmgS9WYgkX+DHL2D1l
	 xQqkt0Q9Vj1lJVcA1QH7mNvaIQ7muhO5NbkNUR88YDc3hbJOCh8pmQOS6GbfggYaaA
	 dKXHIKIr5LaDNQiZSJ95sxgK1UImVYyH0VS9qvGQimMaM189RFLgbrGVMwMgj//qZX
	 i5OHhvGTzm/DhdbuRF0SyE+UtF4dOz3AIc+zuOLOyWi9iBKdkSpFfmHSlqrGRXlg8t
	 /GBGDNCCAflyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: fix out-of-bounds read of rkey array in
 SMC-Rv2 LLC processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724045310.430202-1-yhlee@isslab.korea.ac.kr>
References: <20260723094027.391199-1-yhlee@isslab.korea.ac.kr>
 <20260724045310.430202-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 04:53:40 +0000
Message-Id: <20260725045341.26B131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race and silent data corruption of the shared LLC receive buf=
fer (`wr_rx_buf_v2`)
--

--- Patch [1]: [PATCH net v2] net/smc: fix out-of-bounds read of rkey array=
 in SMC-Rv2 LLC processing ---
commit 60a54b5c8c2f6d12513324a22935be7ae509adaa
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: fix out-of-bounds read of rkey array in SMC-Rv2 LLC processing

This commit fixes an out-of-bounds read in SMC-Rv2 LLC processing for devic=
es
with max_recv_sge =3D=3D 1 by preserving the message body in the link-group=
's
shared wr_rx_buf_v2 buffer, mirroring the behavior of the shared layout.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 954b2ff1815c2..84d8d9024efa3 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -2104,6 +2105,26 @@ static void smc_llc_rx_handler(struct ib_wc *wc, v=
oid *buf)
>  	} else {
>  		if (llc->raw.hdr.length_v2 < sizeof(*llc))
>  			return; /* invalid message */
> +		/* For the non-shared v2 rxbuf layout the message body beyond
> +		 * SMC_WR_TX_SIZE lives only in the per-WR receive buffer, which
> +		 * is reposted as soon as this handler returns.  The LLC event
> +		 * handlers run later from a work item and read the body from
> +		 * wr_rx_buf_v2, so copy it there now - only the body, mirroring
> +		 * the shared-rxbuf layout where the spillover SGE DMAs the body
> +		 * into wr_rx_buf_v2 + SMC_WR_TX_SIZE.  The header is left to the
> +		 * handlers, which restore it from the per-qentry copy, so a later
> +		 * message reaching wr_rx_buf_v2 cannot clobber it.  wr_rx_buf_v2
> +		 * only exists for SMC_V2 link groups, so the link-group version
> +		 * is checked (not just the wire llc_version) to avoid a NULL
> +		 * dereference on a v1 link group.
> +		 */
> +		if (link->lgr->smc_version =3D=3D SMC_V2 &&
> +		    !smc_link_shared_v2_rxbuf(link) &&
> +		    wc->byte_len > SMC_WR_TX_SIZE)
> +			memcpy((u8 *)link->lgr->wr_rx_buf_v2 + SMC_WR_TX_SIZE,
> +			       (u8 *)llc + SMC_WR_TX_SIZE,
> +			       min_t(u32, wc->byte_len, SMC_WR_BUF_V2_SIZE) -
> +			       SMC_WR_TX_SIZE);

[Severity: High]
This is a pre-existing issue, but does this pattern lead to silent data
corruption if multiple LLC messages arrive concurrently or back-to-back?

If local and remote DELETE_RKEY flows occur concurrently, the NIC might
receive multiple messages in quick succession. Since this memcpy (and the
equivalent hardware DMA in the shared layout) unconditionally writes to the
same link-group shared lgr->wr_rx_buf_v2, a second message will overwrite
the payload of the first.

When the background worker thread later processes the first message:

smc_llc_event_work()
  -> smc_llc_event_handler()
    -> smc_llc_rmt_delete_rkey() {
       llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
       ...
       if (smc_rtoken_delete(link, llcv2->rkey[i]))
    }
   =20
Will it end up reading the clobbered payload of the second message from
wr_rx_buf_v2, potentially deleting the wrong rkeys?

>  	}
> =20
>  	smc_llc_enqueue(link, llc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724045310.4302=
02-1-yhlee@isslab.korea.ac.kr?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA40489882
	for <linux-s390@vger.kernel.org>; Sun,  2 Aug 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663782; cv=none; b=nvYoI71vH2fzm6wppf2GFpM0JBNPuSao7BrFOLJG/MSIlIZ4TiMGY8jtsJp5rmjiqg1uaqoXy5dkeljVoIvXeMBpxRiBBb/05aZL2kxo3x4e0nvQt1qAttLOoDtVFWDIe4GcT3C8YPN8wrVyhltpdebCCYmn+kdSPzw88U+z2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663782; c=relaxed/simple;
	bh=TxDb+7AeFDc4fP3MeRRvmHhRgxAj9I+3W3sQ4KSkYmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XTKzwn7EcGJdDG/htujDrRtx0OE9wnqN0X8g7gv8PspmyFFn4VsEVPkYa+IK9cc8BNZM/1tJCbg5tT8030+jLv2Qf1bi+I4v7+qpb/iyNTJy5kBP0iKcee0xkWmnxBmYzUoGMjbf6snI6+/pP3Z25p8yx4DVT+eJgIBMKDW81OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV7QV6Uv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV7QV6Uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620D11F000E9;
	Sun,  2 Aug 2026 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785663780;
	bh=qXgbyQ3rqxW3I7pVOBTtMNOwdYOUHLSiuA3czQR6mxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iV7QV6UvACCT9x91mG5wAk3VdQenb3/i9xf1sDY5YecrodqvWlYO5OCWmWo6YPsLT
	 PeX6FCRd0TRyU8TkK1bw52YawcIx7DDnQdEgLXd85NeRzHIo2mOXe0gtDBR8zj5R5h
	 LGqognEMDOUSqdTx+UFXA3puUqAoQ8aXtGKqtJQz8FlcqglHzezHH/My1yz86d/mXc
	 1wvgzIEI27kTChqeUgN1ixe6ctEuQB/ULIF9ZiLFACc8wPrK95CB1m81wR5z1SjkmZ
	 mQ/Af7HXDCux9/9FEfgGbq8tI6LMeDWGpib0sJ/CuIExoCgIDlq2TI+DO4hFmmYDvP
	 Bw0UKLwEf9bBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/3] net/smc: fix use-after-free of the LLC
 qentry in smc_llc_srv_add_link()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260801094208.1937951-2-yhlee@isslab.korea.ac.kr>
References: <20260801094208.1937951-1-yhlee@isslab.korea.ac.kr>
 <20260801094208.1937951-2-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 09:42:59 +0000
Message-Id: <20260802094300.620D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read of `qentry` in `smc_llc_save_add_link_rkeys`
- [High] Data race on `flow->qentry` leading to memory leak
--

--- Patch [1]: [PATCH net v5 1/3] net/smc: fix use-after-free of the LLC qe=
ntry in smc_llc_srv_add_link() ---
commit c4dc330595782777736f487939ffd4cc82b7c859
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()

This patch resolves a use-after-free vulnerability by changing the code to
detach the LLC queue entry instead of freeing it early. It explicitly
frees the entry on all exit paths to ensure safe memory handling.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index aa6d83af55eda..36c254f257350 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -1481,7 +1481,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
>  	}
>  	add_llc =3D &qentry->msg.add_link;
>  	if (add_llc->hd.flags & SMC_LLC_FLAG_ADD_LNK_REJ) {
> -		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
> +		smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);

[Severity: High]
This is a pre-existing issue, but does calling smc_llc_flow_qentry_clr() he=
re
without holding llc_flow_lock create a data race that can leak memory?

If a remote peer sends an unexpected or duplicate LLC response,
smc_llc_rx_response() running in softirq context could assign a newly
allocated qentry:

net/smc/smc_llc.c:smc_llc_rx_response() {
    ...
    smc_llc_flow_qentry_set(&link->lgr->llc_flow_lcl, qentry);
    ...
}

Concurrently, the process context calls smc_llc_flow_qentry_clr(), which
clears the pointer without holding the lock:

net/smc/smc_llc.c:smc_llc_flow_qentry_clr() {
    ...
    flow->qentry =3D NULL;
    ...
}

Could this allow the softirq to assign a new qentry right after the process
context clears it? If so, when process context later calls
smc_llc_flow_stop() and overwrites the flow state via
memset(flow, 0, sizeof(*flow)), wouldn't that leak the newly allocated
72-byte qentry object?

>  		rc =3D -ENOLINK;
>  		goto out_err;
>  	}

[ ... ]

> @@ -1512,6 +1513,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
>  	rc =3D smc_llc_srv_conf_link(link, link_new, lgr_new_t);
>  	if (rc)
>  		goto out_err;
> +	kfree(qentry);

[Severity: High]
This isn't a bug introduced by this patch, but does the processing of
this qentry allocation cause an out-of-bounds read?

When an SMC V2 ADD LINK message is received and the link does not have a
shared v2 receive buffer, the pointer passed to smc_llc_save_add_link_rkeys=
()
points into the 72-byte qentry slab allocation.

Inside smc_llc_save_add_link_rkeys(), does this result in dereferencing
memory past the allocation?

net/smc/smc_llc.c:smc_llc_save_add_link_rkeys() {
    ...
    ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg + SMC_WR_TX_SIZE=
);
    max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
    ...
}

Since ext->num_rkeys is read from an offset past the end of the slab object,
could this allow a remote attacker to manipulate the kernel into accepting
random slab data or adjacent heap data as RDMA tokens?

>  	kfree(ini);
>  	return 0;
>  out_err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801094208.1937=
951-1-yhlee@isslab.korea.ac.kr?part=3D1

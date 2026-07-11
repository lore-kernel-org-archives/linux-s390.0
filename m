Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442261A268
	for <linux-s390@vger.kernel.org>; Sat, 11 Jul 2026 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783740856; cv=none; b=toyE19bg33UDCWcE+aqUXR1USETsqYi5+MjsIshe8mO1q/88cGzKQ7wIX6yogmrhhIKDTAGQ8eIjqj+Ue7/BUDHTkjHroXsm5FnoT9uKgQxWBMyPDGW7SccIXgZdRwehnx3o0BvB1K7UGuFx72MpFr6QiPIABlwxXzbzUX2Udo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783740856; c=relaxed/simple;
	bh=CCkIJE/B50ZLm198X83jXlyy8DHatsFhmpvyVmwuSR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/unglme+9CYd9l2JNKQPXTUgO97aqoKddPXlreHaqsZEpuE1+pXel3HVs+dtptr/9xJDJOFfG4TqB3ySuev+LGrD4MnNbYdHzHd/yI1Nd3I5oQRJn7GgzUh+xmRpMtPGs4KLt+mp5e4rs1qaXZYaST1bOCRx6bfmD7dssJ0rJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWtca8sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWtca8sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF711F000E9;
	Sat, 11 Jul 2026 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783740854;
	bh=PTaxy2UXzbxKdvry5ZLSwXBIdU62NhNiASH4hKWPxPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWtca8sgXW8k5Q61k6bWru1u5ThdwRYuJfXLOlZ1G8wHwpa+uaE6BVMJRPHeguXCC
	 HaZKepW3Nz5HWp3JUVUjiiMQiVGS0DjR+g6pfmoYJCQzXFAgUYknUMwtptMAomE7TK
	 aW3KbHc3RhdOBkeaiQsqx7c4b+fao8yGh9aGwfNF3LDtLasAkDh/rO+JZPdYH/O097
	 N7H7S2WUGwwGGCUN8dLguZXY2XXRsxqeulsXlrauUDjJii6iUSu4Sq4oBLsxyEiHKB
	 xvOPAU0HubR8/wH8iDRVkLSvqvrszQmVB+fR9tBnypPswxr5CH7TLWiXXS2py/pobL
	 1C3kk6/Ihur8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/3] net/smc: transition to RDMA core CQ
 pooling
Reply-To: sashiko-reviews@lists.linux.dev
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260710033356.16460-3-alibuda@linux.alibaba.com>
References: <20260710033356.16460-1-alibuda@linux.alibaba.com>
 <20260710033356.16460-3-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:34:13 +0000
Message-Id: <20260711033414.4AF711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Race condition in `smc_wr_reg_send` causes a Use-After-Free when p=
osting a work request to a terminating link.
- [High] Link teardown stall/deadlock due to inverted QP destruction sequen=
ce.
--

--- Patch [2]: [PATCH net-next v3 2/3] net/smc: transition to RDMA core CQ =
pooling ---
commit 7cb20cb1fe260499ce1bc5f3d7c63d07feedaebd
Author: D. Wythe <alibuda@linux.alibaba.com>
Subject: net/smc: transition to RDMA core CQ pooling

Refactors completion handling to use the ib_cqe API and standard RDMA core=
=20
CQ pooling. This parallelizes completion processing across multiple CPU cor=
es=20
and removes redundant manual CQ management logic.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index cf6b620fef05f..5073af92e0868 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1373,7 +1368,8 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
>  	smc_llc_link_clear(lnk, log);
>  	smcr_buf_unmap_lgr(lnk);
>  	smcr_rtoken_clear_link(lnk);
> -	smc_ib_modify_qp_error(lnk);
> +	smc_wr_stop_link(lnk);
> +	smc_wr_drain_qp(lnk);

[Severity: High]
Will this order of operations cause a multi-second stall during link teardo=
wn?

In smc_wr_stop_link, the teardown thread blocks on wait_for_completion
for the sender refcounts to drop. However, the queue pair is no longer put=
=20
into an error state before this wait, as that now happens in smc_wr_drain_q=
p=20
after the wait completes.

Without the queue pair in an error state, completion queue events are not=20
generated. The quick wakeups in smc_wr_stop_link like smc_wr_wakeup_reg_wai=
t=20
appear ineffective because the condition check (such as=20
link->wr_reg_state !=3D POSTED) will remain false.

Could this cause the teardown thread to stall until the senders hit their=20
timeout?

>  	smc_wr_free_link(lnk);
>  	smc_ib_destroy_queue_pair(lnk);
>  	smc_ib_dealloc_protection_domain(lnk);
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 6b5add9229937..675bfe633e395 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> [ ... ]
> @@ -367,17 +306,16 @@ int smc_wr_reg_send(struct smc_link *link, struct i=
b_mr *mr)
>  {
>  	int rc;
> =20
> -	ib_req_notify_cq(link->smcibdev->roce_cq_send,
> -			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
>  	link->wr_reg_state =3D POSTED;
> -	link->wr_reg.wr.wr_id =3D (u64)(uintptr_t)mr;
>  	link->wr_reg.mr =3D mr;
>  	link->wr_reg.key =3D mr->rkey;
>  	rc =3D ib_post_send(link->roce_qp, &link->wr_reg.wr, NULL);
>  	if (rc)
>  		return rc;
> =20
> -	percpu_ref_get(&link->wr_reg_refs);
> +	if (!percpu_ref_tryget_live(&link->wr_reg_refs))
> +		return -EPIPE;
> +

[Severity: High]
Can this lead to a use-after-free if the link is being torn down concurrent=
ly?

If percpu_ref_tryget_live fails, the function returns -EPIPE immediately=20
and the caller may proceed to free the link memory. However, the work reque=
st=20
has already been posted to the hardware queue via ib_post_send on the=20
previous lines.

When the completion event eventually arrives, the completion handler=20
smc_wr_reg_process_cqe executes:

smc_wr_reg_process_cqe()
        ...
        if (wc->status)
                link->wr_reg_state =3D FAILED;

If the link memory was already freed, won't writing to link->wr_reg_state=20
corrupt memory?

>  	rc =3D wait_event_interruptible_timeout(link->wr_reg_wait,
>  					      (link->wr_reg_state !=3D POSTED),
>  					      SMC_WR_REG_MR_WAIT_TIME);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710033356.1646=
0-1-alibuda@linux.alibaba.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF93DD50F
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124703; cv=none; b=qcwYakvKtUv3b7/dnXyUm/SCw+fNetmfLkJhCcVTwdqzsNtDWNdExTCE6Y54g4xLwy9xEUHTzRY0emTfpQ9tNicohTbxv2HPVeFV437WZ6AfzZZkxBVOyl41i8Q/fo7EnfyEnjrHeKgzlfoDUsAnLzNBUI+SgKblwz793fp1Vk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124703; c=relaxed/simple;
	bh=k5fNcTq+MjqIy4x3b0Omx0EU0vXQqEdj4EU6LnsdXbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bvu3mY5vKYcrKvFc6JKLyKodZm0/0/CKtND2iTmUgk6YRw0MJFeCEg8FepIY2MCO6zAPXnaLjqEOoUUQ7VmUAolLRRfqMLerfHS6fE7UFwXFhlk0oKsSD3LU9LnS6q3yKOL1hmvId0uPq+pZl8BqlFA7Vm31PB4K7hWUhPVwviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwSwH/bX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwSwH/bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5FB1F00A3E;
	Wed, 19 Aug 2026 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787124700;
	bh=qQMoIXO3fRIACN6RPpqf224zND4ljYci0HijwDxhxuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nwSwH/bXl7yrowUHisNRfoE5oH0pi8Uy66E9kMXtAC4fDQOaJIO5k/2YQfNZvCosG
	 NA+yl5uxR3spZJMwPi+qUDV08HF/lD3Lf1Txv7EpUxLOpXnkmVEu7WnolNhJIyJKqj
	 uC/sU38frw/mcuHy1hiK6AxZdwCESgKKouPqQLc5mNBQZM3T7NtSfFN9ZFNIA1gkuW
	 +w/B+8njsWp2bcMrqJAGRyyCCFhStdGMm6dpzN/Rbv5NCt+emzMaJF1GZ/UVOmNEyA
	 1r2C1AGycKzye5PBjKa0arDZvOgAi3U05/3oyz4m0u7bN7Z9CC0ql64sH63XcltY35
	 eqE6U4p/ID3zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: free stashed qentry before overwrite in
 REQ_ADD_LINK to ADD_LINK transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260818073107.466506-1-mjambigi@linux.ibm.com>
References: <20260818073107.466506-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 07:31:39 +0000
Message-Id: <20260819073140.3A5FB1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free and Out-of-Bounds Read in `smc_llc_srv_add_link=
()` when accessing the `add_llc` payload.
- [High] `smc_llc_flow_stop()` overwrites `flow->qentry` with `memset`, unc=
onditionally leaking any stashed LLC message.
- [High] Unsynchronized access to `lgr->llc_flow_lcl` across workqueue and =
tasklet contexts causes data races, leading to memory leaks and NULL pointe=
r dereferences.
--

--- Patch [1]: [PATCH net] net/smc: free stashed qentry before overwrite in=
 REQ_ADD_LINK to ADD_LINK transition ---
commit 5dc4ee5e350906dce47b3e2165e175388d750d51
Author: Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: net/smc: free stashed qentry before overwrite in REQ_ADD_LINK to A=
DD_LINK transition

When an ADD_LINK request arrives while the flow is in REQ_ADD_LINK state,
the event handler overwrites flow->qentry without freeing any stashed entry.
This leak is fixed by unconditionally calling smc_llc_flow_qentry_del()
before overwriting the qentry pointer.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index aa6d83af55eda..c7f0222aff8d0 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
[ ... ]
> @@ -1911,6 +1911,8 @@ static void smc_llc_event_handler(struct smc_llc_qe=
ntry *qentry)
>  			if (lgr->llc_flow_lcl.type =3D=3D
>  					SMC_LLC_FLOW_REQ_ADD_LINK) {
>  				/* server started add_link processing */
> +				/* free any qentry stashed in REQ_ADD_LINK state */
> +				smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this unsynchronized
access to lgr->llc_flow_lcl create a data race between workqueue and tasklet
contexts?

In smc_llc_event_handler() (workqueue context), we modify the flow type and
qentry without holding lgr->llc_flow_lock:

	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
	lgr->llc_flow_lcl.type =3D SMC_LLC_FLOW_ADD_LINK;
	smc_llc_flow_qentry_set(&lgr->llc_flow_lcl, qentry);

If a softirq preempts this immediately after we zero qentry and set the typ=
e,
smc_llc_rx_response() could locklessly read the type and assign a new respo=
nse
to the flow:

smc_llc_rx_response() {
    ...
    /* assign responses to the local flow, we requested them */
    smc_llc_flow_qentry_set(&link->lgr->llc_flow_lcl, qentry);
    ...
}

When the workqueue resumes, it would unconditionally overwrite qentry with =
its
own message, leaking the softirq's qentry. Also, if the type is changed
concurrently, smc_llc_add_link_work() might falsely trigger
smc_llc_flow_stop() mid-flow, zeroing the state and leading to a subsequent
NULL pointer dereference. Could this be prevented by holding the appropriate
locks?

>  				lgr->llc_flow_lcl.type =3D SMC_LLC_FLOW_ADD_LINK;
>  				smc_llc_flow_qentry_set(&lgr->llc_flow_lcl,
>  							qentry);

[Severity: High]
This is a pre-existing issue, but while we are looking at memory leaks
related to flow->qentry, does smc_llc_flow_stop() also unconditionally leak
any stashed message?

If an incoming message is stashed into lgr->llc_flow_lcl.qentry while the l=
ink
group is in the SMC_LLC_FLOW_REQ_ADD_LINK state, and then the remote peer
sends an SMC_LLC_REQ_ADD_LINK response, smc_llc_event_handler() handles it =
by
calling smc_llc_flow_stop():

smc_llc_event_handler() {
    ...
    case SMC_LLC_REQ_ADD_LINK:
        if (lgr->role =3D=3D SMC_CLNT &&
            lgr->llc_flow_lcl.type =3D=3D SMC_LLC_FLOW_REQ_ADD_LINK &&
            (llc->raw.hdr.flags & SMC_LLC_FLAG_RESP)) {
            smc_llc_flow_stop(link->lgr, &lgr->llc_flow_lcl);
    ...
}

smc_llc_flow_stop() then uses memset to clear the flow state:

smc_llc_flow_stop() {
    ...
    memset(flow, 0, sizeof(*flow));
    flow->type =3D SMC_LLC_FLOW_NONE;
    ...
}

This zero-initializes the struct, silently wiping the flow->qentry pointer
without freeing its dynamically allocated memory. Could this allow a remote
peer to cause memory exhaustion by sending a CONFIRM_LINK message followed
immediately by a REQ_ADD_LINK response?

[Severity: Critical]
This is another pre-existing issue, but does smc_llc_srv_add_link() have a
use-after-free and out-of-bounds read when accessing the add_llc payload?

In smc_llc_srv_add_link(), qentry is retrieved and explicitly freed via
smc_llc_flow_qentry_del():

smc_llc_srv_add_link() {
    ...
    smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
    ...
}

Later in the same function, if the connection uses SMC_V2 and the rxbuf is
not shared, add_llc is used as the llc_msg argument:

smc_llc_srv_add_link() {
    ...
    u8 *llc_msg =3D smc_link_shared_v2_rxbuf(link) ?
        (u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;
    smc_llc_save_add_link_rkeys(link, link_new, llc_msg);
    ...
}

Since add_llc is a pointer inside the previously freed qentry, doesn't this
result in reading from a freed memory allocation? Also, because qentry is
allocated with a fixed size of sizeof(*qentry) and does not hold the extend=
ed
V2 rkeys, wouldn't this also cause a heap out-of-bounds read past the slab
chunk boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818073107.4665=
06-1-mjambigi@linux.ibm.com?part=3D1

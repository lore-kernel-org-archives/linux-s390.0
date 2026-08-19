Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C73C0A10
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125211; cv=none; b=tBFsiqJ+d1WTzL6bElwyQfqOdOyDZFXBVIXjBRz1VOyDD7p1/8CZLN5+7hsHYaBajvsD8c2XOJDA4qYPULfHJLJ3Emk4Lx1pq1OrtguHKZESa1EtlLLEzNL6YskJxtIjNHzNweVdTbTtDOcz3B92lS+1VihkGiU913c3N/NcAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125211; c=relaxed/simple;
	bh=aUqXkR6yt3M6CuepX09GcL6OTwnTKeImzVdG6kJ2dAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZMR64ozEejt2ZlndRQ9fbK+GHQkAloR3cvqHg7CR3eSBWrx8XhpYeOPR+QiduoQLGURXSiojAKjXFKq5GDq/SwatOuYUOCVigmJU/f/B2f5xqvQOw962vvcJqtlapBDbZ3Wn5VI3MrzkzQnBy7cCuDn8XCM1lKIQ/A4Eil25PN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiB/kvGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiB/kvGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E7E1F000E9;
	Wed, 19 Aug 2026 07:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787125210;
	bh=C7WVWeIPHL8lnUDSeCE/64gePsMgH+0QpdEH39KK3Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AiB/kvGNCgVje/psPzO+r+SSRNCNoVc8oQHIR6GUCg7DzoAU+CDs3LOg44wHiKkdv
	 jbsCMJorZ06pGAQQ/RfLks/epGvplPSnE1slkJr0GDf26lW2jg2xn4/hhaoGk6jH9I
	 iIoJcmECq3/099mifZ5JQyHuTG4Pvm6ZLUXRpYzkzU0J/76K0yNXMPp65KGDU4kvEc
	 3wzOHCStcLJcreXKQnHvRwljOMLIasSwe4MKIioPNQzk57WfKtPk+fc35ee3x7//Wq
	 abjPaNDeoGAte0WMlUMwJaTnrMtI07LUd3aWogd7I9n+GhOWs6ybFSXfsqswRm4ua7
	 qNtuL66pRjyxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: free pending qentry in smc_llc_flow_stop()
 before memset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818073943.1108383-1-mjambigi@linux.ibm.com>
References: <20260818073943.1108383-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 07:40:09 +0000
Message-Id: <20260819074009.B8E7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for memory leak of late-arriving LLC messages due t=
o a TOCTOU data race.
- [High] Preexisting memory leak in `smc_llc_lgr_clear()` where canceled as=
ynchronous flow tasks leak dynamically allocated `qentry` objects.
--

--- Patch [1]: [PATCH net] net/smc: free pending qentry in smc_llc_flow_sto=
p() before memset ---
commit 4bed80c54874ec213bfc62c4cef2f581d5c51aa6
Author: Mahanta Jambigi <mjambigi@linux.ibm.com>

net/smc: free pending qentry in smc_llc_flow_stop() before memset

This commit addresses a memory leak by freeing the flow->qentry pointer ins=
ide
smc_llc_flow_stop() before the flow structure is cleared with memset.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -320,6 +320,7 @@ int smc_llc_flow_initiate(struct smc_link_group *lgr,
>  void smc_llc_flow_stop(struct smc_link_group *lgr, struct smc_llc_flow *=
flow)
>  {
>  	spin_lock_bh(&lgr->llc_flow_lock);
> +	smc_llc_flow_qentry_del(flow);
>  	memset(flow, 0, sizeof(*flow));

[Severity: High]
This isn't a bug introduced by this patch, but does this fix fully resolve
the leak?

Looking at smc_llc_rx_response() and smc_llc_event_handler(), they appear
to read flow->type and write to flow->qentry locklessly:

net/smc/smc_llc.c:smc_llc_rx_response() {
    ...
    /* assign responses to the local flow, we requested them */
    smc_llc_flow_qentry_set(&link->lgr->llc_flow_lcl, qentry);
    ...
}

Could a remote peer sending duplicate or late-arriving messages cause
smc_llc_rx_response() on one CPU to locklessly assign a new qentry to
flow->qentry either during or immediately after the memset() executes here?

If that happens, wouldn't the newly assigned qentry either be zeroed out
or left dangling and overwritten when the next flow starts, resulting in
another leak?

>  	flow->type =3D SMC_LLC_FLOW_NONE;
>  	spin_unlock_bh(&lgr->llc_flow_lock);

[Severity: High]
This is a pre-existing issue, but does smc_llc_lgr_clear() also leak these
dynamically allocated qentry objects?

When an LLC flow starts, a qentry is stored in lgr->llc_flow_lcl.qentry or
lgr->llc_flow_rmt.qentry. If the link group is suddenly terminated,
smc_llc_lgr_clear() cancels the background tasks:

net/smc/smc_llc.c:smc_llc_lgr_clear() {
    ...
    cancel_work_sync(&lgr->llc_event_work);
    cancel_work_sync(&lgr->llc_add_link_work);
    cancel_work_sync(&lgr->llc_del_link_work);
    if (lgr->delayed_event) {
        kfree(lgr->delayed_event);
        lgr->delayed_event =3D NULL;
    }
    ...
}

Since these canceled works never process or free the stored qentries, and
smc_llc_lgr_clear() only frees lgr->delayed_event, will
lgr->llc_flow_lcl.qentry and lgr->llc_flow_rmt.qentry be permanently leaked
when the link group is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818073943.1108=
383-1-mjambigi@linux.ibm.com?part=3D1

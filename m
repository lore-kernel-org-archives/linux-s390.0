Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55330EF63
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416572; cv=none; b=YB7yNq/ss23joIsu4y5bc+02wZsVxyFc17+gnczwT2Xx4DA6rLS09IZl4APaNAaJZ/wYSL2pne5yS24V8IyGMEjlUjSMb1a6Z24+eVk1yq3mmON+VyGbk21gO2Djymb7nnKOfGSMlYziDdZTpRBIjhYxw0zm01fY6U7ny2gWIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416572; c=relaxed/simple;
	bh=XfyFoSNE5K/iBcACG1NOVpcnl/nhC62vFc0GLntOZfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PLMUL/j8EkKR9IIDcVgZra4qIIIMuXz2BnmBlN/fx0XP7PhRTNQtMwX/oN2+XVDtwpGjLZ2sO+sISRv81cOVEk5PwM+PpIml/h/KV+rCN24FzwPBr/dgHg+UCyWWDd0KGJqha/TY7vwaEc5fmH5ZnDq575RXRM4t5EtoXDzpCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6kXgi//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6kXgi//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B91F000E9;
	Thu, 30 Jul 2026 13:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785416571;
	bh=nF/ilul0g3kixE9i1J5asJySQOIQO+EkO7EQRH8XJlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6kXgi//fGlWH3pugyeeCjrSTmYPjvQ1Hgb6iQAuzFfKmFz2SeOVcHIaMNJv2fi9F
	 s657GTwsWDwfLljkx0pp4yMfdcbLtFoswM/3W5oNKpW06tG+YMtMnEZR0NhmxqKA2V
	 +0/ZmvIcgP83hfYvT6TVpIOgUsmjtcC3bIk/RkX+o9KBNr1H4y+xe+Y95QH+A19+8z
	 9hzeCvZTSLDiKxekHzv5rkaI02rmuIEAjeIeBqogIrCh/ix9pQFO8Qv1JZvEA2Bn1k
	 KW/OD3RhcWMPDqksFj6CBXxW3QGYl19exeUYZeWdtTu1YFdgZ7uyp5oT7z1RolGtYw
	 QqbruA7jJ/P7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: fix qentry overwrite for CONFIRM_LINK and
 ADD_LINK_CONT in smc_llc_event_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729130153.970800-1-mjambigi@linux.ibm.com>
References: <20260729130153.970800-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:02:50 +0000
Message-Id: <20260730130250.F08B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Spurious messages stashed in `qentry` during the `SMC_LLC_FLOW_REQ=
_ADD_LINK` state are deterministically leaked when transitioning to `ADD_LI=
NK` or stopping the flow.
- [High] Lockless TOCTOU race in `qentry` validation allows concurrent soft=
irq and workqueue to overwrite the pointer and leak memory.
- [High] Late duplicate messages bypass the `!qentry` guard and are subsequ=
ently leaked by `smc_llc_flow_stop()`.
--

--- Patch [1]: [PATCH net] net/smc: fix qentry overwrite for CONFIRM_LINK a=
nd ADD_LINK_CONT in smc_llc_event_handler() ---
commit 708ba737c6e1123f6d2c6447d7060356d5db40c0
Author: Mahanta Jambigi <mjambigi@linux.ibm.com>

net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc=
_event_handler()

This commit fixes a memory leak in the SMC LLC event handler by adding a
guard to check if flow->qentry is already set before storing a new message.
It targets the CONFIRM_LINK and ADD_LINK_CONT messages to prevent duplicate
messages from overwriting an existing qentry allocation.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 954b2ff1815c2..aa6d83af55eda 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -1927,7 +1927,8 @@ static void smc_llc_event_handler(struct smc_llc_qe=
ntry *qentry)
>  		return;
>  	case SMC_LLC_CONFIRM_LINK:
>  	case SMC_LLC_ADD_LINK_CONT:
> -		if (lgr->llc_flow_lcl.type !=3D SMC_LLC_FLOW_NONE) {
> +		if (lgr->llc_flow_lcl.type !=3D SMC_LLC_FLOW_NONE &&
> +		    !lgr->llc_flow_lcl.qentry) {

[Severity: High]
This isn't a bug introduced by this patch, but can spurious messages stashed
during the SMC_LLC_FLOW_REQ_ADD_LINK state still leak?

If a peer sends an unexpected CONFIRM_LINK message while the client is in t=
he
REQ_ADD_LINK state, the event handler stashes it here because the type is n=
ot
NONE and qentry is NULL. When the legitimate ADD_LINK request arrives,
smc_llc_event_handler() processes it and overwrites this stashed qentry via
smc_llc_flow_qentry_set() without freeing the previous one.

Alternatively, if an ADD_LINK response arrives, it calls smc_llc_flow_stop()
directly, which does a memset on the flow:

smc_llc_flow_stop() {
    ...
    memset(flow, 0, sizeof(*flow));
    ...
}

Could this sequence leak the kmalloc-96 allocation?

[Severity: High]
This is a pre-existing issue, but does this lockless check introduce a TOCT=
OU
race if a duplicate packet arrives concurrently?

If a peer sends two duplicate CONFIRM_LINK messages concurrently, one with
the RESP flag clear (processed via smc_llc_event_handler in a workqueue)
and one with the RESP flag set (processed via smc_llc_rx_response in
softirq context), both contexts could locklessly evaluate !flow->qentry
as true.

They would then both call smc_llc_flow_qentry_set(), overwriting one of the
pointers and leaking the allocation.

[Severity: High]
This is a pre-existing issue, but does this guard fail to protect against
late duplicate messages?

When a legitimate CONFIRM_LINK is processed, the flow handler (for example,
smc_llc_cli_conf_link) calls smc_llc_flow_qentry_del(), which resets
flow->qentry to NULL and frees it. However, the flow->type remains active
while remaining hardware setup is performed.

If a duplicate CONFIRM_LINK arrives during this window, this check sees
type !=3D NONE and !qentry, and erroneously stashes the duplicate. When the
flow eventually completes, smc_llc_flow_stop() unconditionally clears the
flow via memset(), leaking the newly stashed late-duplicate qentry.

>  			/* a flow is waiting for this message */
>  			smc_llc_flow_qentry_set(&lgr->llc_flow_lcl, qentry);
>  			wake_up(&lgr->llc_msg_waiter);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729130153.9708=
00-1-mjambigi@linux.ibm.com?part=3D1

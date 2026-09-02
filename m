Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6C3AA1BA
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339968; cv=none; b=Rb28xdxlAV/0GgeHuXwk1RNyzbuqCc5SoeuQed3BZrXdaEeD1tPPtRQ1Mz9MF26on1+QZ65/KQrqEmaZFRqGGCP+vgPCWSQ2ILuE/hQetmGdfgmuH3w97a6RRzP4NXZRjrICJ47ZeNyT0uj8GC6LnHB8ClaaHW1mG6zmXaf3yRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339968; c=relaxed/simple;
	bh=I7DVO9qK2RxFoA0jnwVT2AxwpPimMBxl9Z8FPqdU85I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWF91P8++f+rMgSq/YsSJ+cO6d0aRhel7oL7g3Qbd6jVcr5gGuNFpD/OeDGH5JKEtX51JRWly5gt6dzDgkiplx5A8wm2veFUUeGeu5NGcR14h1Dkl0Y0OJbeCo5pyOD+raPRFP8RxQYTO9vRUUB8GqdOUC/Flea6RMO62vRxmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmqNIkSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmqNIkSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0756F1F000E9;
	Wed,  2 Sep 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788339966;
	bh=Roc++sWh5DO/pmN4bxMmQ8rrLsbzaVvxpTi9HFLJENU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kmqNIkSkC7vIT25RoKazb2N/UwOmZhSC+7fBcPAZ8WtoO4erW2FRmJ0BcWSjZaWQn
	 oXjjKkPIOiVJjClihx9oCVexSHxFXEKfn3jPR2uC+HK3psueROnaJNWrRddFwxw2vh
	 0WGCNG78bW9YQFqX5/pA6oocNI/CIsszgqV+V18duoqFiV9FlxiJHDc3ibIlmVe3Kb
	 qZ/xGWiTDiSCH1sZ9Vgt+4E/vbMeFF4jxYba5TeXJcuLztS2LUKQni2yFSKzaCkuMq
	 0r6XFgf3d1nFbyV4jhz08PG5Bgr8BI4cJ58GdOUE1DiqKJjJruQGFhQFBE2rimTN1b
	 Zz1Cd+5bFfJ6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10] net/smc: fix potential panic dues to unprotected
 smc_llc_srv_add_link()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Arefev" <arefev@swemel.ru>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260901090545.10419-1-arefev@swemel.ru>
References: <20260901090545.10419-1-arefev@swemel.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:06:05 +0000
Message-Id: <20260902090606.0756F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `llc_conf_mutex` lock around `smc_llc_cli_add_link()` on t=
he client side.
- [High] Missing cancelation of `link_down_wrk` before clearing or freeing =
the link memory causes workqueue corruption and Use-After-Free.
--

commit 95b1079562e96ef6213155f37083256de0a0c01b
Author: D. Wythe <alibuda@linux.alibaba.com>

net/smc: fix potential panic dues to unprotected smc_llc_srv_add_link()

This commit fixes a potential panic when an SMC server creates a second
link. It adds llc_conf_mutex locking around smc_llc_srv_add_link() to
protect the link group from concurrent modifications.

Link: https://nvd.nist.gov/vuln/detail/CVE-2023-54237

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 5dd4faaf7d6e5..fe6fb719a9a5f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1268,8 +1268,10 @@ static int smcr_serv_conf_first_link(struct smc_so=
ck *smc)
>  	smc_llc_link_active(link);
>  	smcr_lgr_set_type(link->lgr, SMC_LGR_SINGLE);
> =20
> +	mutex_lock(&link->lgr->llc_conf_mutex);
>  	/* initial contact - try to establish second link */
>  	smc_llc_srv_add_link(link);
> +	mutex_unlock(&link->lgr->llc_conf_mutex);

[Severity: High]
This isn't a bug introduced by this patch, but does the client side need
this same locking?

Looking at smcr_clnt_conf_first_link() in the same file:

net/smc/af_smc.c:smcr_clnt_conf_first_link() {
    ...
        smc_llc_flow_qentry_clr(&link->lgr->llc_flow_lcl);
        smc_llc_cli_add_link(link, qentry);
        return 0;
}

It appears smc_llc_cli_add_link() modifies the link array without holding
llc_conf_mutex. Could this lead to the same panic if an asynchronous event
like smc_link_down_work() runs concurrently and operates on a partially
initialized link array?

>  	return 0;
>  }

[Severity: High]
This is another pre-existing issue, but I am wondering about the
cancelation of link_down_wrk when clearing a link.

In net/smc/smc_core.c:smcr_link_clear():

net/smc/smc_core.c:smcr_link_clear() {
    ...
        smcibdev =3D lnk->smcibdev;
        memset(lnk, 0, sizeof(struct smc_link));
        lnk->state =3D SMC_LNK_UNUSED;
    ...
}

If a device error triggers smcr_link_down_cond_sched() to queue
lnk->link_down_wrk, and the link group is terminated before the work
executes, could the memset() corrupt the workqueue by zeroing out its
linked list pointers?

If the link group is subsequently freed via smc_lgr_free(), could the
pending work then execute on freed memory? Should there be a
cancel_work_sync() for link_down_wrk before clearing the link memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901090545.1041=
9-1-arefev@swemel.ru?part=3D1

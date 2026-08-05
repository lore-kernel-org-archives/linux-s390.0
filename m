Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70C3E120B
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965979; cv=none; b=K0+8y/yKVrXpPr4LTJO7e9rNoz6Qu5ozdLNWRHDSBJwuryzHh1kdINMYNtv+yYyFny/qTT+2UmpVrQTfq7bd4s3x77OGs5uQ/asTLAxySuknn4AVxxAHVyDGamvjUN52JtQ5zaL/Fg5e8NpSEjY88Hkggpz0N/+HlHA6+PMxxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965979; c=relaxed/simple;
	bh=MioUaueiKkT94wG2Dg3vvZoo9kFDkQBQ/eJZnAox3+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rgiM9q2Ug3yugtGdSpJITXKidtkW7ADSECv5LbrVFvT6c2SrNh/OGcLSJ6NE0Um7QX729GwYby1xZvJudLZfcrTC/lqcU93jEbvhGf5I8OUT84g5LTXqxAeayKPYUv3K8iPyDi1wShHe07Y2akhgLQpvRORtydVHKYXI4X3drUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrYuyX04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrYuyX04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4CF1F000E9;
	Wed,  5 Aug 2026 21:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965977;
	bh=zbZfDMPH75ZJU6wnF8Eq6h595HEXwKSfXjJlKV4dIUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrYuyX04jPTjvlMz8+6toLbdQfk2m5CTH2WiqQtbrv8ySczbqXtXWDYNvTXENdTyG
	 bhiYOL+RnIdxFIy1qxOWt1YKHDtLB5miq0SO60wosmRfvmTW5xafWVvT1imIhxR5SV
	 pIg4lGqZEg+YMxvsFSrhaW9Zq5JV4HbyDc0unRz2NPR/IHB5ckp46TRakYCOi0iFZY
	 pMLDXZ+1JnnNg+j8XW+86Ot4dRWv11BlOw3D2hat0vKh4EE9CofbFjRkPzmrddQimz
	 hBgbWzyZIjrFoiA6UxVLQzYDSF3rVg1Zii+ZGGHcAO27l/W9u7Y9eju/awIoz2PAIe
	 JDGBme/BxYn5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net/smc: fix sock refcount leak in smc_switch_conns()
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifei Gao" <gyf161023@gmail.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260804213917.3413525-1-gyf161023@gmail.com>
References: <20260804213917.3413525-1-gyf161023@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:39:36 +0000
Message-Id: <20260805213937.5B4CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A concurrent connection abort during failover causes the healthy b=
ackup link to be erroneously torn down, failing the entire link group failo=
ver.
--

--- Patch [1]: [PATCH] net/smc: fix sock refcount leak in smc_switch_conns(=
) error path ---
commit 1858eaf3cce20ce7bd2bd6af774eda2e7fe87f8d
Author: Yifei Gao <gyf161023@gmail.com>

net/smc: fix sock refcount leak in smc_switch_conns() error path

This commit resolves a socket reference count leak in smc_switch_conns()
by ensuring sock_put() is called when smc_cdc_get_free_slot() fails.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index b4208cb186c5e..c0027d2fe4e8c 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c

[ ... ]

> @@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_link_=
group *lgr,
>  		read_unlock_bh(&lgr->conns_lock);
>  		/* pre-fetch buffer outside of send_lock, might sleep */
>  		rc =3D smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
> -		if (rc)
> +		if (rc) {
> +			sock_put(&smc->sk);
>  			goto err_out;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but this modified error path
appears to have a pre-existing logic issue during a concurrent abort.

If a concurrent abort event occurs (for example, if smc_cdc_msg_validate()
detects an invalid CDC sequence number) and sets conn->killed =3D 1,
smc_cdc_get_free_slot() will observe this and return -EPIPE.

Since smc_switch_conns() does not distinguish this connection-specific
error from a link-level error, it will jump directly to err_out and call
smcr_link_down_cond_sched(to_lnk).

Does this inadvertently tear down the healthy backup link and disrupt all
other connections in the link group that were successfully failing over,
just because a single connection was killed?

>  		/* avoid race with smcr_tx_sndbuf_nonempty() */
>  		spin_lock_bh(&conn->send_lock);
>  		smc_switch_link_and_count(conn, to_lnk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804213917.3413=
525-1-gyf161023@gmail.com?part=3D1

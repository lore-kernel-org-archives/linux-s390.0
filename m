Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670C2FD1AA
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193228; cv=none; b=Hdbf1d2j9n2K2y1FhglsObYIS9yeWz0oZ9zEbcg2hI3uQW+OMbFCNpFfjC8jBfIAXpKnL9Pu5u6pOpX2D9aV1B7vpIcowoKRUtjem+4Q+zZKQEgJiNF+3TC1rlWpE31AWsDT/SV+8Ns3APIgPpgWv6p5mMEiPdIpq2ni0npZa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193228; c=relaxed/simple;
	bh=0jqq/oER4MCv5P2KflF9//SSkraKzNZVhf6IAxvpCC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tnNoqRBhiKgRpre5IKP+0LUKx0YczRuGqyBmCvYnN6umMZ73hehBXrBZFSGShRNxrCg93D0EMWshgf16sS0v2L00tAgHlck7qJTZvzYZMM8UgMz1Efu6pBJmEWN+Jrfv8R37pNH5xfd0HLI0Qlzu3Ww2KU6CIYxVu7tRSoC4xJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6iqAFrX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6iqAFrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15131F000E9;
	Thu, 20 Aug 2026 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787193226;
	bh=/CxYjS/SvHKqzBez7goepdz04FG2xb387JwKvbPs/Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6iqAFrXwV7G8ZY+QmybERO1o8r78MlW4uAnXpQZST46wFJFDI6eocmWdDethK3KW
	 QFkC9IEa3cqfDXn53DGE4F9Ur3+GdwkB36SPwar84eKEKsr2e6a5r28Sxak8y88ine
	 SGvycNAdDrgpdY02TidspJLP0qOwIKTw8wiIq4oYxh4mU/uli+lnQftVdaKpja3nuq
	 WbxofkaFjjpqXQDg0SOt5I2RUy5rh7cO22LfuNwoZMUXnwhff3LxAH9wCXf9WlLuMT
	 vEbEqQKatwMvhgu1qjSWWV1HzMas4x29wSzsmjgY3qNi+4q4MW6MEdNWZcXsOW+bP2
	 qOHK3lZ5rT9bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 1/3] net/smc: fix use-after-free of the LLC
 qentry in smc_llc_srv_add_link()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260819023306.644849-2-yhlee@isslab.korea.ac.kr>
References: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr>
 <20260819023306.644849-2-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 02:33:45 +0000
Message-Id: <20260820023345.E15131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read of flexible array `body` in `smc_llc_save_add_l=
ink_rkeys()` because `qentry` is allocated without space for the LLC messag=
e extension.
--

--- Patch [1]: [PATCH net v7 1/3] net/smc: fix use-after-free of the LLC qe=
ntry in smc_llc_srv_add_link() ---
commit 97e6f986183048b52faebfd70a6a129b35a4ad20
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()

This commit fixes a use-after-free of the LLC queue entry by detaching the
entry instead of freeing it early. The free is moved to the exit label.

Cc: stable@vger.kernel.org

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index aa6d83af55eda..7282f8ad7593d 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
[ ... ]
> @@ -1492,7 +1492,8 @@ int smc_llc_srv_add_link(struct smc_link *link,
>  		lgr_new_t =3D SMC_LGR_ASYMMETRIC_PEER;
>  	}
>  	smc_llc_save_add_link_info(link_new, add_llc);
> -	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
> +	/* add_llc still points into qentry, so only detach it here */
> +	smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);

[Severity: High]
This isn't a bug introduced by this patch, but does this allocation
and usage pattern result in an out-of-bounds read?

The commit message mentions an out-of-bounds read is fixed by a later
patch, but since it is present here, could this allocation in
smc_llc_enqueue() truncate the message?

net/smc/smc_llc.c:smc_llc_enqueue()
    qentry =3D kmalloc_obj(*qentry, GFP_ATOMIC);

This allocates the base size without space for the flexible array body.
Later in smc_llc_srv_add_link() when max_recv_sge =3D=3D 1, it passes this
truncated queue entry downward:

net/smc/smc_llc.c:smc_llc_srv_add_link()
    u8 *llc_msg =3D smc_link_shared_v2_rxbuf(link) ?
        (u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;
    smc_llc_save_add_link_rkeys(link, link_new, llc_msg);

When smc_link_shared_v2_rxbuf is false, add_llc is used. Inside
smc_llc_save_add_link_rkeys(), it appears to calculate the extension past
the truncated bounds to access the number of routing keys:

net/smc/smc_llc.c:smc_llc_save_add_link_rkeys()
    ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg + SMC_WR_TX_SIZE=
);
    max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);

Can this lead to reading uninitialized or adjacent slab memory, resulting
in KASAN crashes or the registration of garbage memory as RDMA keys?

> =20
>  	rc =3D smc_ib_ready_link(link_new);
>  	if (rc)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819023306.6448=
49-1-yhlee@isslab.korea.ac.kr?part=3D1

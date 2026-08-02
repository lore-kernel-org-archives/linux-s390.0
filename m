Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486D304BCB
	for <linux-s390@vger.kernel.org>; Sun,  2 Aug 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663781; cv=none; b=TuQwLEbdo9QE69f7jQaUytr3vlqhxJqNc/xfhFtIPyrz8cIIS12oVRdJ4vjvTVY5vrLnD2P+vXOJcJ//rlWCMbjlJi9oWWXkrrhQ8li3gEjfR/HPaL/0k3CUHKIGB/Yn4r4DZQ+5mKPVlABEu85GOl83oD4btRnpPrADmgFqnks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663781; c=relaxed/simple;
	bh=cx3aJ5Gp4VeL4HnTVMB6WuGrACpAeuZ7RcEmsxaV704=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R5xrlcuWZpDsQ0aINbvX6fC1nhMXLiKiRHFFSwlRpS+7paUWBXtaRrGJ9FqC8Zo8vQuUUrXwLhZygBUnBrNCAAtHwOA/lciwwgKcWVio099NtW0YreomNPd6NQtlrcWQCFjDzztvOy63OYX1FT0yl3yli3r7Rz4WVd6LhcT9f90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llasQl89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llasQl89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034AB1F00A3A;
	Sun,  2 Aug 2026 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785663779;
	bh=je+wfyWooWzaoii/BN0gFHoc1VARNhVwrFVuZjD+uf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llasQl89XhomC0xqaEhAZrJ1MxgeLOenHRCw4T8eeFRXtMZhGTh8zmhJw+BADdsZd
	 FtOwQYdqFQ+17Bpwr7mdlcoCEXF0dE7mgdotwdna1u/K3oYoGkHAwJVpxw4ro/7MT4
	 5HQByBYdabYN72Pl2j+NtCAFA34doPStOPutT9mNoa700/CCHWEgIH3PPZGFCTuay3
	 mLOXhHAz90cd1S4BFLaC7kICg9wS7pKuUHJsuvGuwpH5Q7ZBcjivFgh9+77H6df0M8
	 cbfh+ClracrHkibX80aICqr3/UeyczBEWECShOdjJ/zaBlw2r9I1hOSpyfpsqPaQJu
	 Hpd8Vb2D5BM8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/3] net/smc: carry oversized SMC-Rv2 LLC
 messages in the queue entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801094208.1937951-4-yhlee@isslab.korea.ac.kr>
References: <20260801094208.1937951-1-yhlee@isslab.korea.ac.kr>
 <20260801094208.1937951-4-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 09:42:57 +0000
Message-Id: <20260802094259.034AB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Remote DoS via memory leak of dynamically allocated `qentry` durin=
g LLC flow termination
--

--- Patch [3]: [PATCH net v5 3/3] net/smc: carry oversized SMC-Rv2 LLC mess=
ages in the queue entry ---
commit 55107205f45488de7fb2933646d94dc31343b612
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

This commit modifies how oversized SMC-Rv2 LLC messages are handled by
copying the tail of the message directly into the queue entry. It avoids
rebuilding the message layout in multiple consumers and bounds the
DELETE_RKEY_V2 processing by the actual message length that arrived.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index c9bf938f1ee2a..ba60cc0f1690b 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -2083,18 +2098,35 @@ static void smc_llc_rx_response(struct smc_link *=
link,
>  	wake_up(&link->lgr->llc_msg_waiter);
>  }

[Severity: High]
This is a pre-existing issue, but can this leak dynamically allocated qentry
objects?

If a peer sends a duplicate or delayed LLC response (like SMC_LLC_ADD_LINK)
while the local LLC flow is still active but after the local node has alrea=
dy
cleared flow->qentry, smc_llc_rx_response() will assign the newly allocated
qentry to flow->qentry via smc_llc_flow_qentry_set() without taking a lock:

net/smc/smc_llc.c:smc_llc_rx_response() {
    ...
assign:
    /* assign responses to the local flow, we requested them */
    smc_llc_flow_qentry_set(&link->lgr->llc_flow_lcl, qentry);
    wake_up(&link->lgr->llc_msg_waiter);
}

When the flow eventually terminates, smc_llc_flow_stop() clears the flow:

net/smc/smc_llc.c:smc_llc_flow_stop() {
    ...
    spin_lock_bh(&lgr->llc_flow_lock);
    memset(flow, 0, sizeof(*flow));
    ...
}

This memset() erases the flow->qentry pointer without calling kfree(),
permanently leaking the buffer. Could this allow a remote peer to cause OOM
by intentionally sending delayed or duplicate responses?

> -static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *ll=
c)
> +static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *ll=
c,
> +			    u32 byte_len)
>  {
>  	struct smc_link_group *lgr =3D link->lgr;
>  	struct smc_llc_qentry *qentry;
>  	unsigned long flags;
> +	u16 body_len =3D 0;
> =20
> -	qentry =3D kmalloc_obj(*qentry, GFP_ATOMIC);
> +	/* V2 messages can be longer than the inline union smc_llc_msg. Carry
> +	 * the remainder in the qentry itself, so that its lifetime and its
> +	 * length match the message the peer actually sent.
> +	 */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801094208.1937=
951-1-yhlee@isslab.korea.ac.kr?part=3D3

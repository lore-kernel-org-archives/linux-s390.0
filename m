Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695833936B
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576840; cv=none; b=AUL5lsKeXipbl3pgsb3O5mOApzbdOf1uQLSqJNd0I5yt2gROcPePhZVrf3wqLmI8zH0pKlxP+HsR2FQCgd5M2MTtbXfACWi+6GuqgZiwutAmGKvpSlY0tCtV31h2Dez5YT0zSanadnmv0JZNWyrnvkK2VfGC4i7v1fcbD06F0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576840; c=relaxed/simple;
	bh=Iy7W7t4yMc4e9IpcH/GmfsTwJvuki4y9jAXJj269w2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VvMb2Pz97xAY5MA+qf4Dx0H7oiLiOum12v/JlPnT/U8G+tknRaMxj6rFlWmmTFAdOhxeyOcTDTnRp1iuRMe+Jo7k/UNmeFQTkLhZ5/dqm7l0pzMq6d1u24qSl4yCRPn92udLm2BdfWQRZcA5nhefmb4+EayaSE7N+45+ZFMUmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T28Ea6wK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T28Ea6wK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CAA1F00A3A;
	Wed, 12 Aug 2026 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576839;
	bh=zH3nJmrSfPkWfYUxQDhy9Qdulpf31C2ZYAD1a/KYqcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T28Ea6wKlM7YBcSHRLNnXELuOPBnzh9QzV8f15/glV0emre2A9bUFfeXF7M2pXt2n
	 mDL+izIkKmeY4unRUj7QQ0TSlAaKPafFyblrKrtLF52eMgFdoULzlxwvTeORi6Gt+P
	 pqeO/Pre7fSroIbtXjwOCOYdR/Yw1x4riR4qi/HNtKBXV+5eJ/M+6htt0PN8fKotHW
	 3V2k9dK2DG3WlB8altN9ZZouR28zBLN+kEI0KNRVP7xwQfi4V+PWaWUQ8pvq3yhWnl
	 u+RONdu83k8LLUXOUtKtcUr3fXu/YsCFh+RjldK5D9QM3xDKRGRrBNjjNaq/sWb5Ph
	 CXzGj6ELH8rbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 1/3] net/smc: fix use-after-free of the LLC
 qentry in smc_llc_srv_add_link()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260811231902.47089-2-yhlee@isslab.korea.ac.kr>
References: <20260811231902.47089-1-yhlee@isslab.korea.ac.kr>
 <20260811231902.47089-2-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:20:38 +0000
Message-Id: <20260812232038.F0CAA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds memory read occurs when processing SMC-R V2 ADD_LINK=
 messages on interfaces with max_recv_sge =3D=3D 1, accessing V2 extension =
fields beyond the allocated size of the queue entry.
--

--- Patch [1]: [PATCH net v6 1/3] net/smc: fix use-after-free of the LLC qe=
ntry in smc_llc_srv_add_link() ---
commit b6d39643c17322840e48f9be07db4e2efaa719d8
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()

smc_llc_srv_add_link() keeps add_llc pointing into the queue entry:

  add_llc =3D &qentry->msg.add_link;                      smc_llc.c:1482
  ...
  smc_llc_save_add_link_info(link_new, add_llc);        smc_llc.c:1494
  smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);          smc_llc.c:1495
  ...
  u8 *llc_msg =3D smc_link_shared_v2_rxbuf(link) ?
        (u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;        smc_llc.c:1504
  smc_llc_save_add_link_rkeys(link, link_new, llc_msg); smc_llc.c:1506

smc_llc_flow_qentry_del() kfree()s the entry, so on a link without a shared
v2 receive buffer the pointer handed to smc_llc_save_add_link_rkeys() is
already freed.  Before the Fixes: commit that branch always used
lgr->wr_rx_buf_v2 and add_llc was not used after the free.

[ ... ]

The offset is past the 72-byte queue entry because the out-of-bounds read
fixed by the next patch is on the same line; what this patch removes is the
free at smc_llc_srv_add_link+0x9a8 happening before the read at +0xaa2.

Detach the entry instead of freeing it there, and free it at the single
exit label.  The reject path has to detach as well, otherwise it would be
freed twice.

This changes only the lifetime of the entry.  The same read still runs past
its end until the next two patches bound it, so a backport wants all three.

Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max_r=
ecv_sge equals to 1")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

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
This is a pre-existing issue, but does reading the V2 extension payload from
qentry result in an out-of-bounds read?

As noted in the commit message, this patch fixes a use-after-free on this
struct but explicitly leaves an out-of-bounds read to be fixed in subsequent
patches.

When a peer sends an SMC-R V2 ADD_LINK message with a V2 extension to an
interface where max_recv_sge =3D=3D 1, smc_llc_srv_add_link() (and its clie=
nt
equivalent smc_llc_cli_add_link()) does not use a shared V2 receive buffer.
Instead, it computes llc_msg + SMC_WR_TX_SIZE:

net/smc/smc_llc.c:smc_llc_save_add_link_rkeys() {
    ...
    ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
                                                 SMC_WR_TX_SIZE);
    max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
    ...
}

However, smc_llc_enqueue() allocates only enough space for the base structu=
re
(including the 44-byte msg union):

net/smc/smc_llc.c:smc_llc_enqueue() {
    ...
    qentry =3D kmalloc_obj(*qentry, GFP_ATOMIC);
    ...
    memcpy(&qentry->msg, llc, sizeof(union smc_llc_msg));
    ...
}

This truncates any received V2 extension payload during copying. Since
SMC_WR_TX_SIZE is 44 bytes, the ext pointer is placed out of bounds of the
qentry structure, causing ext->num_rkeys to read uninitialized slab memory =
or
KASAN redzones.

Since this can be triggered remotely by a network peer over the RoCE fabric,
is there a concern that applying this patch without the subsequent fixes
leaves a remotely reachable out-of-bounds read?

> =20
>  	rc =3D smc_ib_ready_link(link_new);
>  	if (rc)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811231902.4708=
9-1-yhlee@isslab.korea.ac.kr?part=3D1

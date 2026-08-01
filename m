Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B3314D05
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567951; cv=none; b=Q0eh32YuymaMc8Go/Z2f3EEjjETYP8imoEbFGONpouhiuO/aNahPIZtPMv7LMhwbGoE6U9OVI8ZHVHNagKbhR9jkLu5kiZwIFC1cWndn2MISKjxxUXnSpl12lTvIsdpE6C+G2whZ7ZsBR+xAVGZEfXtVP1Lk9gc6r44V+kwlSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567951; c=relaxed/simple;
	bh=FLcRL+aqjqxylEEkTy60JGWbnDatOMew/jAx7FecR/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZTraxLCSyLeOBJV4oepcMPn/BqtdS4IuJkx2Uqiep6P+1IPdkS9PraY9VP1X8FU5Tgvtx8yju2lj8d/CSbG7TEFTN/sFnCseeFbbHtcbvTzn1Q0k3oMMZmPZojiDeqph8a8/yFmmf45qZbswCcMNJY9exaXKqIrmvVQeHs3dPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEnVk/Lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEnVk/Lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D621A1F00ACF;
	Sat,  1 Aug 2026 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785567950;
	bh=hGeMrgKiyvxohHdmo7YvYFp88+8sKcN82HM2ATqVFeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oEnVk/LqheQk7gPTq7aM1z/zRIivg6k4WeeLgimNPv/dJJsiSrf3gL8J7u0/pg+qy
	 8pIEQTi69nx0FIHt9MvjpbCXsQu3GDefbZwQ7a/VQrTT/htxTRO3nK7cZvHRGG42F+
	 9OVquo8CUzZRi2w0VvNyNblpYly78i0zNz87FAendT33K70ZoBuVypLLezbA/axNSV
	 SMo7nCOXV+GeCoEmXlXth2Lqdf3A/MRfIHnTM6i4zk6b/Dzojh/cd3ngyJYMperUAq
	 4yjKcV0DIvjrpWkCki7wS2UimXHQa5RjS2d4lXmAKmA3exx1OHU64hQNJZWPSGMuVr
	 Gr3NEbnIhMa7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/3] net/smc: fix use-after-free of the LLC
 qentry in smc_llc_srv_add_link()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731070509.1818665-2-yhlee@isslab.korea.ac.kr>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
 <20260731070509.1818665-2-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 07:05:49 +0000
Message-Id: <20260801070549.D621A1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> smc_llc_srv_add_link() keeps add_llc pointing into the queue entry:
>=20
>   add_llc =3D &qentry->msg.add_link;			smc_llc.c:1482
>   ...
>   smc_llc_save_add_link_info(link_new, add_llc);	smc_llc.c:1494
>   smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);		smc_llc.c:1495
>   ...
>   u8 *llc_msg =3D smc_link_shared_v2_rxbuf(link) ?
> 	(u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;	smc_llc.c:1504
>   smc_llc_save_add_link_rkeys(link, link_new, llc_msg);	smc_llc.c:1506
>=20
> smc_llc_flow_qentry_del() kfree()s the entry, so on a link without a shar=
ed
> v2 receive buffer the pointer handed to smc_llc_save_add_link_rkeys() is
> already freed.  Before the Fixes: commit that branch always used
> lgr->wr_rx_buf_v2 and add_llc was not used after the free.
>=20
> Detach the entry instead of freeing it there, and free it explicitly on
> both exit paths.  The reject path has to detach as well, otherwise it wou=
ld
> be freed twice.
>=20
> Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max=
_recv_sge equals to 1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731070509.1818=
665-1-yhlee@isslab.korea.ac.kr?part=3D1


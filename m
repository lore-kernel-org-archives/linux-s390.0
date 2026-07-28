Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6512F585
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232745; cv=none; b=f84OMwd7iKT5w8lvxOqrXkJO9Nz634raMi2ECPEC2QqvWgTIoKZKKZBtu3OsoS6zg/q+5hxRBQI6KQkMgMsNPLJduPRG2Cinmxx0N6yxgcqWj+N8H7/0vlijqOGRQcxYTfZFdRW5p2dNTbG+9SCUPy3wUNL76ibUNm7+cMWvNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232745; c=relaxed/simple;
	bh=gJDIRS8gK3H/n1DKy1tgxVQvl68QWgrga3wWNqCC3RU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRVELCcoMCBDhGDSpgHsl2PkxpkdnyshkwByL+gble87xrUx0afxp3Q1oOuYgBzXvolO5FIBpL2kncGf3AYXy9PT4xtzF1hezwm1GW1n1pAKf2tXeaRwhjZ+N5Lb2rpb28adDU2iqCH/d0A5B1znGW7nLQ+PwKgrOND0vtEVQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw4lzFDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw4lzFDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A321F000E9;
	Tue, 28 Jul 2026 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785232744;
	bh=nw3DJGVnxmtxXMOC4XCnLDyG0gUam/9+90eel2Vmt4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw4lzFDt2WarX0Zwp8ziDUXu9QwEZ7mhUvHNBOZbNXCYcx3IOKYExZDOZ0rNknFFY
	 2d3lTX/Mr8LfjmBT9+RF/9VA4cPPdcXIM3Pi/3TMoOHIZzTtbdP0SBGSvChJswVfdm
	 rva5NRgCbtznqjvO2nxkpAFUkFkld9jmMzxl3La7Jcyd3k5tAI8fls8cSK+u4M+MgU
	 ihJ8+pV+s/8qRCrJZQS4b8OhIDMnaj3cN5n60UaPXV7D5ASDo9vKpqWcB+kbS93WSk
	 /nXvQZuLXyhjmSX+56iqJ4Q3EF5cI67ix3QCVhZQ7OAIbOuULkCxjUG5gknbgBDn8f
	 vC9BANxkiLyeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/smc: fix out-of-bounds read of rkey array in
 SMC-Rv2 LLC processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727095833.1079618-1-yhlee@isslab.korea.ac.kr>
References: <20260727095833.1079618-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:59:03 +0000
Message-Id: <20260728095903.B9A321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Accessing the flexible array member `rkey` in `smc_llc_rmt_delete_=
rkey` crosses the statically known boundary of the `msg` union into the `bo=
dy` flexible array, triggering a compiler array-bounds panic.

Pre-existing issues:
- [High] The function `smc_rtoken_delete` modifies shared rtoken state with=
out holding the appropriate lock, leading to a race condition.
--

--- Patch [1]: [PATCH net v3] net/smc: fix out-of-bounds read of rkey array=
 in SMC-Rv2 LLC processing ---
commit bc4e86ac0d674a2bb992c13bb4936670fa839d8d
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: fix out-of-bounds read of rkey array in SMC-Rv2 LLC processing

This commit fixes an out-of-bounds read when processing SMC-Rv2 messages
in non-shared link scenarios. It changes smc_llc_qentry to carry the
message body in a flexible array rather than relying on a separate buffer.
Loop bounds are also clamped to the received byte length.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 954b2ff1815c2..997664bbe4f2a 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -1811,16 +1819,15 @@ static void smc_llc_rmt_delete_rkey(struct smc_li=
nk_group *lgr)
> =20
>  	if (lgr->smc_version =3D=3D SMC_V2) {
>  		struct smc_llc_msg_delete_rkey_v2 *llcv2;
> +		const u32 rkey_off =3D
> +			offsetof(struct smc_llc_msg_delete_rkey_v2, rkey);
> =20
> -		if (smc_link_shared_v2_rxbuf(link)) {
> -			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
> -			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
> -		} else {
> -			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)llc;
> -		}
> +		llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)llc;
>  		llcv2->num_inval_rkeys =3D 0;
> =20
>  		max =3D min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
> +		max =3D min_t(u32, max, (sizeof(qentry->msg) + qentry->body_len -
> +				       rkey_off) / sizeof(llcv2->rkey[0]));
>  		for (i =3D 0; i < max; i++) {
>  			if (smc_rtoken_delete(link, llcv2->rkey[i]))

[Severity: High]
Will this trigger a UBSAN array-bounds panic for large messages?

Since llcv2 is cast from the 44-byte msg union, but the rkeys actually
extend into the adjacent qentry->body flexible array, doesn't reading
llcv2->rkey[i] for i >=3D 9 cross the statically known boundaries of the
union?

Even though the memory is physically contiguous, accessing beyond the union
size violates strict intra-object bounds checking.

[Severity: High]
This is a pre-existing issue, but does this loop need locking to protect
against concurrent modifications to the rtoken structures?

When smc_llc_rmt_delete_rkey() calls smc_rtoken_delete() to modify
lgr->rtokens and lgr->rtokens_used_mask, neither lgr->rmbs_lock nor
lgr->llc_conf_mutex is held.

Since smc_llc_save_add_link_rkeys() and smcr_rtoken_clear_link() can run
concurrently and modify these same structures, could this result in data
corruption of the RDMA memory access keys?

>  				llcv2->num_inval_rkeys++;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095833.1079=
618-1-yhlee@isslab.korea.ac.kr?part=3D1

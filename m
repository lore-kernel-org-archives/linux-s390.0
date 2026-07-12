Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92C372B51
	for <linux-s390@vger.kernel.org>; Sun, 12 Jul 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783842316; cv=none; b=ZuJO6sm6coC7HkBIWVLUR+n50u/Xp/vSQnivhJI/amKnUt57W+3qG9S52EKuaCmSFJKUP2Gc52348fhvbX886kZNFVsHJ20Typ2dUpl0au/dg1LA8FDMBAHVhMafrqV7MNEptrw4yvOIC7EaE38jFrbxmfoNjkG8ulJm4o49dhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783842316; c=relaxed/simple;
	bh=QSgHW/8tokW3zVnI25bOJZL8PaziMTsdirgnFa0ni6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EeuRoAlcckgb+PaD9BglAlHMQ1Dl3Ux0QAdxMGZ8LvbUjiS6Wn6J98fQUiGKXrVMD11okhvvENDv59B2KQlvvt5GfkjgGVqmQfLmjBQyKfg2J/Q79/nTbhySHPMjrimJe6CadfLhUQlNpHllVBVmzAxmuPaid3Ms+dxEC5PRwyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcL0C74P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcL0C74P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2F41F000E9;
	Sun, 12 Jul 2026 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783842314;
	bh=HjD3AYRnDtIyLD7ecMGWRNQ+VPs89BNB99cFkJ5SW6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RcL0C74Pl5DUG2P3s1gfDLW3bOu2ZO7cCr5nnZtv4HtFQ+5gKV83hI67Q380djSC3
	 azxt/8M2uwsaP+v1M5KpnzHAU17whw+EGc+KV9v9s1ngt1YeuqsalRqDmYR09ZEwKh
	 o1myzDM17ZAOIFGH1bAUbL0HPpktw78AuU+uvPrsmiP21LuocDTn4JW267/ZUL7xcJ
	 hMlP1df2b3DdkqNmiMYOlh6J6RFqFb3JupEgEiNAjLLm7Q96/kxioq7iqRBi0QXAKX
	 OQPBGcsaEHRcEV2EW851JcsK0+1iG/+hLp4Ww1AUH5aW1LJ/D8gxgY+aHPpoap/eDt
	 IhHq2dwyYNT1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: guard the CDC receive path against an
 unset RMB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260711-b4-disp-c36a9798-v1-1-340b0c6053fb@proton.me>
References: <20260711-b4-disp-c36a9798-v1-1-340b0c6053fb@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 07:45:14 +0000
Message-Id: <20260712074514.8E2F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added check for `!conn->rmb_desc` lacks memory barriers,=
 resulting in a data race. The writer (`__smc_buf_create()`) assigns `conn-=
>rmb_desc =3D buf_desc` without a write barrier (e.g., `smp_store_release()=
`) and outside of any lock shared with the reader. Concurrently, the reader=
s (`smc_cdc_rx_handler()` and `smcd_cdc_rx_tsklet()`) perform a plain load =
of `conn->rmb_desc` without a read barrier (e.g., `smp_load_acquire()` or `=
READ_ONCE()`). On weakly-ordered architectures, the reader can observe a no=
n-NULL pointer but see uninitialized contents of `buf_desc` (like `cpu_addr=
` and `len`), causing memory corruption or a NULL pointer dereference.
--

--- Patch [1]: [PATCH net] net/smc: guard the CDC receive path against an u=
nset RMB ---
commit d9db6cbb0ec5bacaa514e8123311e01c799a00da
Author: Bryam Vargas <hexlabsecurity@proton.me>
Subject: net/smc: guard the CDC receive path against an unset RMB

This commit guards against a NULL pointer dereference in SMC CDC receive
handlers when a connection's RMB is not yet allocated. It bails out of
the handlers if conn->rmb_desc is NULL.

Link: https://sashiko.dev/#/patchset/20260705-b4-disp-28a1bbca-v4-1-be089b9=
8acc6@proton.me?part=3D1

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..d60f68facbc34 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -446,7 +446,7 @@ static void smcd_cdc_rx_tsklet(struct tasklet_struct =
*t)
>  	struct smcd_cdc_msg cdc;
>  	struct smc_sock *smc;
> =20
> -	if (!conn || conn->killed)
> +	if (!conn || conn->killed || !conn->rmb_desc)

[Severity: High]
Is there a potential data race with __smc_buf_create() here?

The writer __smc_buf_create() assigns conn->rmb_desc =3D buf_desc without a
write barrier (e.g., smp_store_release()), and outside of any lock shared
with this reader.

If this plain load observes a non-NULL pointer, could weakly-ordered
architectures see uninitialized contents of buf_desc (like cpu_addr and len=
)?

Would it be safer to use smp_load_acquire() here and smp_store_release() on
the writer side?

>  		return;
> =20
>  	data_cdc =3D (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;

[ ... ]

> @@ -483,7 +483,7 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void=
 *buf)
>  	lgr =3D smc_get_lgr(link);
>  	read_lock_bh(&lgr->conns_lock);
>  	conn =3D smc_lgr_find_conn(ntohl(cdc->token), lgr);
> -	if (!conn || conn->out_of_sync) {
> +	if (!conn || conn->out_of_sync || !conn->rmb_desc) {

[Severity: High]
Does this check need the same read barrier protection?

Even though this is inside read_lock_bh(&lgr->conns_lock), the writer
__smc_buf_create() does not hold this lock when assigning the descriptor.

>  		read_unlock_bh(&lgr->conns_lock);
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-b4-disp-c3=
6a9798-v1-1-340b0c6053fb@proton.me?part=3D1

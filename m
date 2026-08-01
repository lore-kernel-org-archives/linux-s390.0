Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0933F8C2
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567951; cv=none; b=n1pam+3xHXgfsfZogk/kzy1JxywQ2rfca5ZCoCptqF95zHV2SFdgUPT9JsagEul5kr7nkA+/3B/R9MUxx9IpeX7AqbgFp91buvY2W1MVjXAC+IMUdHoZgUtvpmGIkVGQRQ7Futpx6KWl9fN88Te409JsFbkSlXHCEVriYV2kkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567951; c=relaxed/simple;
	bh=gBjP4EuOJdQgyUu1gQmgkXYtbeTvjd2Uvrh3JyRYkqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sXEQHUjHLEe2/KF6DoyrCikJyDObry2mQ3I4/YQcl9ddMDY1cY916P1rj2OeDRfAFL+nU5aYb9g7xtKWG+nQDKAf232N4MVr1nfddiuC+pcAg2vPQsBvwNnI4Qe5mXychkc9nWYlI8iThZLJF+pWG4vCEu0VgFPsylfWksoxScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqFx8zXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqFx8zXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1E21F00ACA;
	Sat,  1 Aug 2026 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785567949;
	bh=loMBsqbG89+gCkD3Rgq0+DInlRIS3O6Pn+sM7OsLqh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqFx8zXRwoP/5bJnO0i3Zbq69EvXlyl/UR81XJvc7K0Ci3JT1dzKKC7DlmAPTp1pD
	 xLRE6DWUIFsfdZnnldwQG9HrDMy9/6a29PEKzFFDti1YM00rAixh2ii2dKBAZcAVNo
	 C9+TQIuwbIPICvy3/2supEz3Gpbnkga1fvucw3YlqKsR4UNbJO0spSsNS9Zzf1xiOh
	 BvRmUnYvestAzc7gMtqVdS03H/K/9G+AWCvzaZhxruOieTP3tsAHTAkXijtN6vqiiL
	 RadeUGa6FQ00WCRx50x7WDpL1daijcyPWAkRQjEQMpsOC/WeZsAkMsZH6ckYL9nFeB
	 LeYvJD25UCaKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/3] net/smc: carry oversized SMC-Rv2 LLC
 messages in the queue entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731070509.1818665-4-yhlee@isslab.korea.ac.kr>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
 <20260731070509.1818665-4-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 07:05:48 +0000
Message-Id: <20260801070549.0D1E21F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `num_rkeys` in `struct smc_llc_msg_add_link_v2_ext` is treated as =
a host-byte-order `u16`, causing interoperability failures between hosts of=
 different endianness.
--

--- Patch [3]: [PATCH net v4 3/3] net/smc: carry oversized SMC-Rv2 LLC mess=
ages in the queue entry ---
commit 1b827af4505d8f9b89fd072971668e1eccaf6204
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

This commit copies the tail of an oversized SMC-Rv2 LLC message into the qu=
eue
entry instead of relying on the receiver to reconstruct it from the shared =
v2
buffer. It bounds DELETE_RKEY_V2 processing based on the arrived message le=
ngth
instead of the buffer size.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 606d2dc8c7ece..1b153173dd516 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -998,23 +1017,19 @@ static int smc_llc_cli_conf_link(struct smc_link *=
link,
> =20
>  static void smc_llc_save_add_link_rkeys(struct smc_link *link,
>  					struct smc_link *link_new,
> -					u8 *llc_msg)
> +					struct smc_llc_qentry *qentry)
>  {
>  	const u32 rt_off =3D offsetof(struct smc_llc_msg_add_link_v2_ext, rt);
>  	struct smc_llc_msg_add_link_v2_ext *ext;
>  	struct smc_link_group *lgr =3D link->lgr;
>  	int max, i;
> =20
> -	/* The extension follows the 44 bytes of the LLC message.  Without a
> -	 * shared v2 receive buffer nothing beyond those 44 bytes was received,
> -	 * so not even ext->num_rkeys is there to be read.
> -	 */
> -	if (!smc_link_shared_v2_rxbuf(link))
> +	/* the rkey count itself is only there if enough bytes arrived */
> +	if (qentry->body_len < rt_off)
>  		return;
> -	ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
> -						     SMC_WR_TX_SIZE);
> +	ext =3D (struct smc_llc_msg_add_link_v2_ext *)qentry->body;
>  	max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);

[Severity: High]
This is a pre-existing issue, but since this code is being modified, is it
safe to treat ext->num_rkeys as a host-byte-order u16 here?

If an x86 machine communicates with an s390x machine, smc_llc_fill_ext_v2()
writes lgr->conns_num into ext->num_rkeys in host byte order. A big-endian
receiver would read a value like 256.

When min_t() casts 256 to u8, wouldn't this truncate it to 0 and cause the
rkey exchange to fail on cross-endian links?

> -	max =3D min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
> +	max =3D min_t(u32, max, (qentry->body_len - rt_off) /
>  			      sizeof(ext->rt[0]));
>  	down_write(&lgr->rmbs_lock);
>  	for (i =3D 0; i < max; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731070509.1818=
665-1-yhlee@isslab.korea.ac.kr?part=3D3

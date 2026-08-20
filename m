Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1632720C
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193228; cv=none; b=abx7LP8raOetsBez5zqxUkvSSRyAX4N7OqSOHlyKNEF/biFbL6MTE4Zw4dy72zSL9iQp+Ojt0puqvQcD1QO3mVEVBxttVciplBXvli10LyD8Hcc1yh3p8ZzP9rS/4cbld5eSMCJsbhuNmurImSWWzMNrRZtogT6ehpNC4EbMRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193228; c=relaxed/simple;
	bh=BaE2djgXFr7XBAp2+s4IcJksWarJn3jFwGb4JdZ+LWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hncm7PrkZh0pf9izSfsiS8kOPl7+rW9qTJU3R8nQisxL1N39l3u9KFuD5aYMYuAtrxhExLe/AllLXhdMkWpdcN9vGM0BCA+/I1P+1fhHSJGvK7Q5pGHnrXTl7+Gl55J01QylWPuhoaX1uX8d8pzqCjTqi7WAJBADTXa9qoICX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axOqSOhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axOqSOhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2B71F00A3A;
	Thu, 20 Aug 2026 02:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787193227;
	bh=rIUtnkNzbuQ1c1XuEf1SvZhEGMwUtnpNMSnZ32hntvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=axOqSOhQzcIJxbqovdJ/2cx/O4fLOAImcIaB/IC8Mu6DBjKoOx1wsZEa5AMvHiGrV
	 Iyxn6XdZV97i6ymEm1zkX1R7HK33eSjhZSb7QqSL8lD+7azdj5QXlJzNjIzzZPtDwu
	 Dj9JCX+iQMDVGZdR/eWGwrVAnSC1wpBvOZJIjbTjWiIob0d/NeyIm2KlXQ2ePzioy8
	 Ec51eAjfVS2cb+So5MV2IgNB//eW7Rc1yKH48R9HvEmu2qM2j+smLwnXfaFgPgbpR4
	 3IyWHM5HZPahlnEtThScnPYWv6Qyge8h1JP2apmo5cpQ0XZm2qn45pKoyynWUjSJzV
	 ITfHN3d31piTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 3/3] net/smc: carry oversized SMC-Rv2 LLC
 messages in the queue entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260819023306.644849-4-yhlee@isslab.korea.ac.kr>
References: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr>
 <20260819023306.644849-4-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 02:33:46 +0000
Message-Id: <20260820023346.BF2B71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `num_rkeys` field in `struct smc_llc_msg_add_link_v2_ext` is t=
ransmitted in native byte order without endianness conversion, breaking cro=
ss-architecture SMC-Rv2 connections.
--

--- Patch [3]: [PATCH net v7 3/3] net/smc: carry oversized SMC-Rv2 LLC mess=
ages in the queue entry ---
commit 411251064d6efa68e4e9521d534e61850c251cba
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

This patch modifies SMC-Rv2 LLC message handling to store oversized
messages in the queue entry instead of relying on shared receive buffers.
It dynamically allocates the qentry to carry the remainder of the message
tail.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index f04e0392ec96c..481b0495b0d31 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -998,22 +1019,19 @@ static int smc_llc_cli_conf_link(struct smc_link *=
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
> -	/* Without a shared v2 receive buffer the extension is not copied
> -	 * into the queue entry, so not even ext->num_rkeys is there.
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
This is a pre-existing issue, but does this code handle endianness
correctly across different architectures?

In smc_llc_save_add_link_rkeys(), ext->num_rkeys is read from the wire.
If an SMC connection is established between a big-endian (like s390x) and
a little-endian (like x86) host, a value of 1 could be interpreted as 256.

When passed to min_t(u8, ...), the cast to u8 truncates 256 to 0, which
would cause the receiver to skip processing any rkeys and silently drop
them.

Should there be an ntohs() conversion here to ensure the number of rkeys
is safely parsed on cross-architecture setups?

> -	max =3D min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
> +	max =3D min_t(u32, max, (qentry->body_len - rt_off) /
>  			      sizeof(ext->rt[0]));
>  	down_write(&lgr->rmbs_lock);
>  	for (i =3D 0; i < max; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819023306.6448=
49-1-yhlee@isslab.korea.ac.kr?part=3D3

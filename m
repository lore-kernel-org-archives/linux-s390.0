Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDC397699
	for <linux-s390@vger.kernel.org>; Sun,  2 Aug 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663779; cv=none; b=lNFQHPYglyA9f8H3vkr3QShxGio/DStyYDDHyYMoeE7IVCUljaoJeRyVEqtGQjso3fnBcQJr2sm0lYAU47FkzKz1nyh2rWfhSRDuX3BDaUNjBL0d/NgUXt39lY2g8711e8B1H1vNoNimGr53Z8I352+ep/lqSau/r1kHduegRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663779; c=relaxed/simple;
	bh=sk0DtgtpLKNMSWXqc1IlGFf9TlnASTSLxqXkrRsRZSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TbiBrZ1hEuLlaMykGzw7qE/DVYO/0m5d9SgGLpWhgcnHJGd1RQ8cKrQh5fknMtTXgXV+64+S6VKQKgdYzmocemplc7O5QBDtKRSbejiRx5CSk3gi2Hj2OcbyM+9QyjM4qKFIDRl7jp2lQbhHxLwqtOGA/sbBDrVY3gqVxiPZCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es4gi2b8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es4gi2b8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383071F000E9;
	Sun,  2 Aug 2026 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785663777;
	bh=+PRwlhcUwBRdnBP1zgjttWR5z+MWRXLAGt3++yayE9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=es4gi2b8SDhkbuje9wkWp9stUBCdEjKEU9GalgD0nJZ0vy1251G8wgBjXXiFJ6hZi
	 F/QhgXa52GjVP84StMhxhSaNawx/QbPpJtqJs/WnYeoWxpBhxxbDDMHPyMZI3qNt4n
	 aSImLwORky1BNSsJGkvNnSd7mHv6ZrZDaeEsQZWIzxNH2+ESkA5AD2B/6SKdIo7iWl
	 ZAe7zr3/s5Ovf1fDzzH7SfULg4c86gSAsyY2euyG066g1oDzp6QLYrt4D5XGCo3R3U
	 xWsvhE8K60bnMfYlb547kwTC7quFHZ63U0WE9Sagh5WY4D1O8OhVfeViGYmP55ycZt
	 eMZgrQxDKOhCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/3] net/smc: bound the peer rkey counts in
 SMC-Rv2 LLC messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801094208.1937951-3-yhlee@isslab.korea.ac.kr>
References: <20260801094208.1937951-1-yhlee@isslab.korea.ac.kr>
 <20260801094208.1937951-3-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 09:42:56 +0000
Message-Id: <20260802094257.383071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Processing of stale memory due to incorrect bounds checking based =
on maximum buffer capacity.

Pre-existing issues:
- [Critical] Hardware DMA race condition overwrites shared receive spillove=
r buffers.
- [High] Data race corrupting rtokens due to missing rmbs_lock in remote fl=
ow handlers.
--

--- Patch [2]: [PATCH net v5 2/3] net/smc: bound the peer rkey counts in SM=
C-Rv2 LLC messages ---
commit b119f15f6831509347ac2042d2fc186b18c74eae
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages

On a link whose device has max_recv_sge =3D=3D 1 there is no shared v2 rece=
ive
buffer, and smc_llc_save_add_link_rkeys() takes the v2 extension from 44
bytes past the start of the queue entry's inline message.

[ ... ]

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 36c254f257350..c9bf938f1ee2a 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -1000,13 +1000,21 @@ static void smc_llc_save_add_link_rkeys(struct sm=
c_link *link,
>  					struct smc_link *link_new,
>  					u8 *llc_msg)
>  {
> +	const u32 rt_off =3D offsetof(struct smc_llc_msg_add_link_v2_ext, rt);
>  	struct smc_llc_msg_add_link_v2_ext *ext;
>  	struct smc_link_group *lgr =3D link->lgr;
>  	int max, i;
> =20
> +	/* Without a shared v2 receive buffer the extension is not copied
> +	 * into the queue entry, so not even ext->num_rkeys is there.
> +	 */
> +	if (!smc_link_shared_v2_rxbuf(link))
> +		return;
>  	ext =3D (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
>  						     SMC_WR_TX_SIZE);

[Severity: Critical]
This is a pre-existing issue, but does reading from this shared spillover b=
uffer
expose us to a hardware DMA race condition?

All receive work requests are initialized with their second SGE pointing to=
 the
exact same shared physical memory address:

net/smc/smc_wr.c:smc_wr_init_sge() {
    ...
    lnk->wr_rx_sges[x + 1].addr =3D lnk->wr_rx_v2_dma_addr + SMC_WR_TX_SIZE;
    ...
}

Because hardware DMA operates independently of the CPU, if two packets larg=
er
than 44 bytes arrive back-to-back, won't the network card silently overwrit=
e the
first packet's spillover data with the second packet's spillover data?

When the deferred workqueue finally reads the first packet's extension from
lgr->wr_rx_buf_v2 here in smc_llc_save_add_link_rkeys(), it seems it could =
read
corrupted or overwritten data from the second packet, allowing a remote pee=
r to
induce cross-message fragment mixing.

>  	max =3D min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
> +	max =3D min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
> +			      sizeof(ext->rt[0]));

[Severity: High]
Does this bounds check allow processing of stale memory?

The bounds check uses the maximum buffer capacity (SMC_WR_BUF_V2_SIZE) rath=
er
than the actual message length received by the hardware. Because the shared
spillover buffer lgr->wr_rx_buf_v2 is not zeroed between receives, could a
remote attacker send a short packet with a maliciously large num_rkeys valu=
e?

If so, the bounds check would allow the loop to run past the end of the new=
ly
received data, reading and processing stale memory contents left over from
previous messages as valid rkeys.

>  	down_write(&lgr->rmbs_lock);
>  	for (i =3D 0; i < max; i++) {
>  		smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,

[ ... ]

> @@ -1813,17 +1821,25 @@ static void smc_llc_rmt_delete_rkey(struct smc_li=
nk_group *lgr)
>  	link =3D qentry->link;
> =20
>  	if (lgr->smc_version =3D=3D SMC_V2) {
> +		const u32 rkey_off =3D
> +			offsetof(struct smc_llc_msg_delete_rkey_v2, rkey);
>  		struct smc_llc_msg_delete_rkey_v2 *llcv2;
> +		u32 buf_len;
> =20
>  		if (smc_link_shared_v2_rxbuf(link)) {
>  			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
>  			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
> +			buf_len =3D SMC_WR_BUF_V2_SIZE;
>  		} else {
>  			llcv2 =3D (struct smc_llc_msg_delete_rkey_v2 *)llc;
> +			buf_len =3D sizeof(qentry->msg);
>  		}
>  		llcv2->num_inval_rkeys =3D 0;
> =20
>  		max =3D min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
> +		/* bound by the buffer llcv2 points at */
> +		max =3D min_t(u32, max, (buf_len - rkey_off) /
> +				      sizeof(llcv2->rkey[0]));

[Severity: High]
Is it safe to bound this by buf_len instead of the actual received length?

Similar to smc_llc_save_add_link_rkeys(), this uses the maximum capacity
(SMC_WR_BUF_V2_SIZE or sizeof(qentry->msg)) rather than the actual message
length. A short packet with a large num_rkeys could cause this loop to
process stale data left in the buffer from previous messages.

>  		for (i =3D 0; i < max; i++) {
>  			if (smc_rtoken_delete(link, llcv2->rkey[i]))

[Severity: High]
This is a pre-existing issue, but is there a data race here that could corr=
upt
rtokens?

The remote flow handlers like smc_llc_rmt_delete_rkey() execute in the cont=
ext
of smc_llc_event_work. They call smc_rtoken_delete() and smc_rtoken_add(),
modifying the shared lgr->rtokens array and rtokens_used_mask without acqui=
ring
down_write(&lgr->rmbs_lock).

Because local flow handlers (like smc_llc_add_link_work) can run concurrent=
ly
on another CPU and do take rmbs_lock to modify the same structures, won't t=
his
result in a data race that can corrupt the token arrays and mask?

>  				llcv2->num_inval_rkeys++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801094208.1937=
951-1-yhlee@isslab.korea.ac.kr?part=3D2

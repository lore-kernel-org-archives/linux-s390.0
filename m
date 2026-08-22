Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6D2C21E8
	for <linux-s390@vger.kernel.org>; Sat, 22 Aug 2026 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390249; cv=none; b=uSS0leinZ2FGYqsxbxyO5HlNi4J+TAk7Z1sWxYcYvGgQaEw30ku/cYzSAHJdP91hNIdqhMwb/Ad+S2LujvwZ08DywIWEkdgIwZROKK3fuHo+po1T4aPAOMenqhVEAmSOvo7If1GpVomI1dzXwDF0FGSS1rYDONZ/fbukDBBtk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390249; c=relaxed/simple;
	bh=sMPOkL3U+DbY/R6CUxFRQgoeJa6/WA0aW6e5iiHECXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lmvh/nPQ9kpF8dZ/1n+Whp7JD7kBWXdStbeepSRIsBpyJ4Ozu0qq+Adlixt0LyheFLsnJm4qdKbgXqSLjIVODd0IIXxdKOMWzQYtfvC87iIbyBy6mbasPe1A3uE72mLWEWa6MglyjWqZNBkNg6zZFfSMTihPdJUqy8l3E1Vgdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWqs72WC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWqs72WC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A961F00A3A;
	Sat, 22 Aug 2026 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787390248;
	bh=n48I+gKV5/TMkD2I/HSD+ihvUiDWIVbI/TsVfwLROx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWqs72WCSdb/+6hll3eqFvJ5VbvtFrAxs0maD8N7nn128IPVc3E/a9ZMW4em1RGOG
	 H1qr2KoeQG/7Pww9MuWZTONNEOpoxBiN4mubuV0NNfKNRayhoNrcgaDA4CpcQzzxFY
	 m//j/eu4PtIO/LwkmYGvD7tMeN4PSzwfxIOdbzi43zFUR3pYRhOjf8e76YQls3X5sB
	 /+/VR5wGtV22wkhAjLUVZukgSw9CHng9E2XvoRHR0568lY4buncRNBTxohF72r2zYR
	 L0fvMGIYbO7BDbmB6oCLuCfUCMVZKcdJ5GJoiTrGSneuwnfX9DpYE3vIfQQs5d0mtW
	 RXaTUv+MOk+Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/smc: clear the correct v2 slot and
 buffer in smc_wr_tx_put_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260821091702.21458-2-alibuda@linux.alibaba.com>
References: <20260821091702.21458-1-alibuda@linux.alibaba.com>
 <20260821091702.21458-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:17:27 +0000
Message-Id: <20260822091728.26A961F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] smc_wr_tx_wait_no_pending_sends() fails to wait for pending v2 WQE=
s, leading to premature link teardown and UAF in the CQE handler.
- [High] Blind zeroing of V2 pending slot in CQE error path causes corrupti=
on of normal TX slot 0.
--

--- Patch [1]: [PATCH net-next v2 1/2] net/smc: clear the correct v2 slot a=
nd buffer in smc_wr_tx_put_slot() ---
commit c70c362b54a94b8914b4d46aec29581eca109cd3
Author: D. Wythe <alibuda@linux.alibaba.com>

net/smc: clear the correct v2 slot and buffer in smc_wr_tx_put_slot()

This patch fixes an issue where smc_wr_tx_put_slot() incorrectly zeroes
the pointer variable itself rather than the intended v2 pending slot and
buffer structures. It achieves this by passing the pointers directly and
using sizeof(*pointer).

> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 59c92b46945c5..6b5add9229937 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -288,10 +288,10 @@ int smc_wr_tx_put_slot(struct smc_link *link,
>  	} else if (link->lgr->smc_version =3D=3D SMC_V2 &&
>  		   pend->idx =3D=3D link->wr_tx_cnt) {
>  		/* Large v2 buffer */
> -		memset(&link->wr_tx_v2_pend, 0,
> -		       sizeof(link->wr_tx_v2_pend));
> -		memset(&link->lgr->wr_tx_buf_v2, 0,
> -		       sizeof(link->lgr->wr_tx_buf_v2));
> +		memset(link->wr_tx_v2_pend, 0,
> +		       sizeof(*link->wr_tx_v2_pend));

[Severity: High]
This is a pre-existing issue, but does changing this memset from zeroing
the pointer to zeroing the structure transform a previous NULL-pointer
dereference into a silent data corruption regression?

In smc_wr_tx_process_cqe(), if any CQE completes with an error, it
indiscriminately zeroes the link->wr_tx_v2_pend structure.

If a V2 slot operation is concurrently in progress, zeroing its structure
changes its internal idx from link->wr_tx_cnt to 0.

If the concurrent V2 operation then fails to post and calls
smc_wr_tx_put_slot(), pend->idx < link->wr_tx_cnt evaluates to true.

This targets normal slot 0, improperly clearing bit 0 in link->wr_tx_mask
and freeing a slot that might be actively used by another thread.

[Severity: High]
This isn't a bug introduced by this patch, but does the link teardown
process fail to wait for these V2 slots?

smc_wr_tx_wait_no_pending_sends() waits by calling smc_wr_is_tx_pend(),
which only checks if link->wr_tx_mask is empty:

    return !bitmap_empty(link->wr_tx_mask, link->wr_tx_cnt);

However, the V2 TX slot is tracked separately and does not set a bit
in wr_tx_mask. If a V2 WQE is in flight during link teardown, the wait
condition will instantly return and the teardown process frees
link->wr_tx_v2_pend.

When the completion queue event (CQE) for the V2 WQE eventually fires,
smc_wr_tx_process_cqe() dereferences the freed link->wr_tx_v2_pend to
check the wr_id, resulting in a Use-After-Free regression.

> +		memset(link->lgr->wr_tx_buf_v2, 0,
> +		       sizeof(*link->lgr->wr_tx_buf_v2));
>  		return 1;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821091702.2145=
8-1-alibuda@linux.alibaba.com?part=3D1

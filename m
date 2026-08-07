Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DF448BB6
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085000; cv=none; b=fasRXTxhsNznoetkgyNVsZG18iSqIsBcYV4dprgOpYAFBu5jfRrzAgIlrHydfmfHvelfc2IKXfgJADpHIpxN0nD0qg18RFiyvbTPTP98z5dsg1PKs1y2HdO0Ke8gftb1eyG86KKMNPGOH7tVnahyVsWpT735v+hXQ8D918w9sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085000; c=relaxed/simple;
	bh=Ec9Xgakz9yYmHVLSQjFREKk+7VjuF3kMSb+fonGX94Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UjHpyGU5D4j63LCl+IBk0ViloKLGeI/5AMd47o5ypRJRxlsQurJOAd9ELUhnPP4/ycUF8AnpGh1sV0xxwvmiQgD1hmf5gtRttAuhe52zqdROsUjqSoijTMfWF0rMXrRV8Ap+OcAA9bszGvQLrvO1yGDFZFA9TyEEWryIV5R944c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpxROdyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpxROdyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3941F00A3A;
	Fri,  7 Aug 2026 06:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786084997;
	bh=v3kV/dwyJhz2aJ9HWM+1J65wPLnqeA4MD3ZNYCxjylg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hpxROdyFkyBxTSxNcFl95MOP1oijtkGTdwkZODbpHGqYso1exneXCqYBIB5hEj8x8
	 jnzCI9cPNPy+VGcqZHB6NLLCDbQF+FQghUz4fuPR5/J5QW/FyjjlwHpcyWJFZ9Nes/
	 G1ycfcSWGscj5n8VaTahHiIdqUkhB1EeedlEmghzVQ6s1gOZ6G1Wro2F9BXQJFUZ0m
	 pyiP/cdmP58gXJxdZgZatChxqAad7NTE19HS7q2xsxMaUMt8YfiMTmWZgkuWOwKcZN
	 VEKd0cSgBYsDjmgiTv3BMS7MvPhCCwHHPPaBKbZD8sCAFu+5ZM5Du8YzjQ1nz836Gi
	 oZiHM5C1eZaUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 1/2] net/smc: clear the correct v2 slot and
 buffer in smc_wr_tx_put_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260806064252.39180-2-alibuda@linux.alibaba.com>
References: <20260806064252.39180-1-alibuda@linux.alibaba.com>
 <20260806064252.39180-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 06:43:16 +0000
Message-Id: <20260807064317.3C3941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-atomic clearing of `wr_tx_v2_pend` before `wr_tx_buf_v2` creat=
es a TOCTOU race that prematurely signals slot availability, corrupting con=
current V2 messages and control data.
- [High] An error completion for a V1 work request unconditionally zeroes o=
ut the link group-wide V2 buffer, corrupting concurrent V2 messages on othe=
r links.
--

--- Patch [1]: [PATCH net-next v1 1/2] net/smc: clear the correct v2 slot a=
nd buffer in smc_wr_tx_put_slot() ---
commit 4fe2881d4ba7f681ee22c596087bf040cfe5c6f0
Author: D. Wythe <alibuda@linux.alibaba.com>

net/smc: clear the correct v2 slot and buffer in smc_wr_tx_put_slot()

This patch fixes an issue where 8-byte pointer variables were being zeroed
instead of the structures they point to. It passes the pointers directly
and uses sizeof(*pointer) to properly clear the intended structures.

> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
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
> +		memset(link->lgr->wr_tx_buf_v2, 0,
> +		       sizeof(*link->lgr->wr_tx_buf_v2));

[Severity: High]
This isn't a bug introduced by this patch, but it looks like this lockless
synchronization pattern might have a race condition.

Because memset() is not atomic, could this zero out the state tracking stru=
ct
(which contains idx) before the data buffer is fully cleared?

If a concurrent thread calls smc_wr_tx_get_v2_slot():

    if (link->wr_tx_v2_pend->idx =3D=3D link->wr_tx_cnt)
        return -EBUSY;

It checks the idx to locklessly determine slot availability. If idx gets
zeroed early by the first memset(), could the concurrent thread claim the
slot and write new data, only for it to be destroyed by the remainder of
the memset() operations?

For V1 buffers, this appears to be safely handled using a dedicated
link->wr_tx_mask bitmask that is cleared only after the memsets.

[Severity: High]
This is another pre-existing issue in the same file, but could the error
logic in smc_wr_tx_process_cqe() corrupt shared V2 payloads?

smc_wr_tx_process_cqe() {
    ...
    if (wc->status) {
        ...
        if (link->lgr->smc_version =3D=3D SMC_V2) {
            memset(link->wr_tx_v2_pend, 0,
                   sizeof(*link->wr_tx_v2_pend));
            memset(link->lgr->wr_tx_buf_v2, 0,
                   sizeof(*link->lgr->wr_tx_buf_v2));
        }
    ...
}

If a V1 work request completes with an error, the error path unconditionally
zeroes out link->lgr->wr_tx_buf_v2 just because the link group version is
SMC_V2.

Since this buffer is shared across all links within the link group, wouldn't
zeroing it out from a failing link silently corrupt the payload of any
concurrent V2 message on healthy, surviving links in the same group?

>  		return 1;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806064252.3918=
0-1-alibuda@linux.alibaba.com?part=3D1

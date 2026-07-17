Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218F3B6C1D
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288293; cv=none; b=Rzj+e9MXxaQqBvuXi1W2ECbG/TOIuXRhAKuECWchZBcbv4an7O2rkI+IOS13+lQosc6lh8A3nLmtiPl2vppKKt0MBGjuOOML/Wqfjb3q3XXyrfTcevwxKjRDBXl5pMGIk3iHyJXtL1FIXzvb4iuH1jeWkgPtgo+crplwkRAMVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288293; c=relaxed/simple;
	bh=ukTjwdM235dt1zLSHz+ujAu7eZhkNIZoahOp5cZfgCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FhZe8IRAPW0cJ/brI9rlrrMFQqIeZ0Thqi15WBKxUuh8Q3FOIpOZm+lNaERwvyyAiA7cTE8gH6icNeQeotcKj8L59X6Vkfx0VrctkIhszfbRdx91W3nk0DxLUQtCxj7nSNUup53Di8s8ifKZXgYZnC9YuInJnblDOF5e5JA/jK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByORUsJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByORUsJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E8C1F000E9;
	Fri, 17 Jul 2026 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784288291;
	bh=sm+gPky/tB/pf86p8fzTRenjSe1NdrUj5LPcBgEf5yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ByORUsJjlDgJcleNdaKM5DqdiyMQrDqwDDI+mIPMaErnM40DmNZvLlXDFveknkeC+
	 VPXWNPP6oLeHelQ+dRq/fKZw3vuH0y9d2m/b4i/KYSkzl1qIi17dJg3sDYZzfVzht7
	 n7NLF3VfmNb6mhN3GhsazbpU5q1Tdm5I5T0gjovIqmg5VJo6c5phKr2kONslq7zfp/
	 vOpwFy1VlRyLtgnA9QNMzD7M731ytxji6QJGEXezYtaxyMr6rM7rtkS4Wr4M5paawf
	 7rmpED8ZVpwx+2tFOKwGdiFQ0IkfihQwrYlFOFgL0psZj7vSa1sbXjTsMD2Q5Ngudv
	 +XA8iS40aaGcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 1/3] net/smc: clear the correct v2 slot and
 buffer in smc_wr_tx_put_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260716113745.65234-2-alibuda@linux.alibaba.com>
References: <20260716113745.65234-1-alibuda@linux.alibaba.com>
 <20260716113745.65234-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:38:10 +0000
Message-Id: <20260717113811.49E8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race in V2 slot cleanup allowing a concurrent sender's data t=
o be overwritten.
- [High] Unconditional zeroing of the shared `lgr->wr_tx_buf_v2` in `smc_wr=
_tx_process_cqe()` on any link error corrupts in-progress LLC messages on o=
ther links.
--

--- Patch [1]: [PATCH net-next v4 1/3] net/smc: clear the correct v2 slot a=
nd buffer in smc_wr_tx_put_slot() ---
commit eb37bf5f30fd47da384e2535c48a0ad5576aa908
Author: D. Wythe <alibuda@linux.alibaba.com>

net/smc: clear the correct v2 slot and buffer in smc_wr_tx_put_slot()

smc_wr_tx_put_slot() tries to reset the v2 pending slot and buffer with
memset(&link->wr_tx_v2_pend, 0, sizeof(link->wr_tx_v2_pend)) and the
equivalent for wr_tx_buf_v2. Both are pointers, so this zeroes the 8-byte
pointer variable instead of the structure it points to. The pending slot
and buffer are therefore never actually cleared, and the pointers get
overwritten with NULL.

Pass the pointers directly and use sizeof(*pointer) so the intended
structures are cleared.

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
> +		memset(link->wr_tx_v2_pend, 0,
> +		       sizeof(*link->wr_tx_v2_pend));

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the control
structure before the data buffer create a race window?

If a thread sends an LLC message and waits for a response, the Rx tasklet=20
might process the Rx CQE first, waking up the LLC flow thread which proceeds
to send the next message by calling smc_wr_tx_get_v2_slot().

Concurrently, the Tx tasklet could process the Tx CQE and clear the slot
control structure here. The zeroed idx immediately publishes the slot as
free, so the LLC thread could acquire it and begin formatting its message in
link->lgr->wr_tx_buf_v2.

The same sequence appears to occur in smc_wr_tx_process_cqe().

Would the following memset then wipe out the newly written message?

> -		memset(&link->lgr->wr_tx_buf_v2, 0,
> -		       sizeof(link->lgr->wr_tx_buf_v2));
> +		memset(link->lgr->wr_tx_buf_v2, 0,
> +		       sizeof(*link->lgr->wr_tx_buf_v2));

[Severity: High]
This is a pre-existing issue, but could unconditionally zeroing the shared
link->lgr->wr_tx_buf_v2 cause issues for other links in the LGR?

It looks like the same zeroing pattern happens in the error path of
smc_wr_tx_process_cqe():

net/smc/smc_wr.c:smc_wr_tx_process_cqe() {
    ...
    if (unlikely(wc->status)) {
        ...
        if (link->lgr->smc_version =3D=3D SMC_V2) {
            memset(link->wr_tx_v2_pend, 0, sizeof(*link->wr_tx_v2_pend));
            memset(link->lgr->wr_tx_buf_v2, 0, sizeof(*link->lgr->wr_tx_buf=
_v2));
        }
    }
}

If Link B is actively formatting an LLC message in this shared LGR buffer,
and a normal data work request concurrently fails on Link A, would Link A's
tasklet incorrectly wipe out Link B's in-progress LLC message?

>  		return 1;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716113745.6523=
4-1-alibuda@linux.alibaba.com?part=3D1

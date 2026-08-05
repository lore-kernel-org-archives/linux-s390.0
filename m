Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06D3E315E
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918513; cv=none; b=U05nRO3QzxNIICWGwD7M6nBy4MG3m9XAi5N/krht0rjHZZelKKVkP87kRHibhYYuCm4FRmw1r8iIgCwfWxROq/0OXEUc8xh0tOKKflVUDkZA9xeqAKbri8JYx1lc7u40ZXJT6KUwdRMqvO8nFYL93NTSkVNvLqQRKdHkMSm+5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918513; c=relaxed/simple;
	bh=VH0ngCSCkQ+U0mHosxEpo+8f+0dVj7UAks/H+dnpTDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XXnTo5Cv+J3ZjeSWyxNOi55glVX0m4GXr3Xx3+ien+nVMuvzxzs333Oy7Dc8X1QQ8IbtGj2zVtovgOI664AdSXzevt/CnwelroQYt7ooAX0gMhNizkql8ElEyVlccn1B0S2vjFUNIMaG2AIka4C3tLpuCehmg9DEHNk3Wa1DEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSSgRQP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSSgRQP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D443A1F000E9;
	Wed,  5 Aug 2026 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785918512;
	bh=W4//Zq7WHDK0NjuXKddM7i8kVTxA6bjP4joL4okpyRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSSgRQP4lXm7uS0gKoOpmUl3kjYVXmC21/A1CoeYQfZqIwkXAQJaUwPYibohVil88
	 Sqim29Yl0TWgFtZGgak5/LXFmeaqaoR9KE8aiLZcp94BDeg+A5lthO2QenfbIMkiwt
	 iqXTl6uA4vNhhJIjsquXvjmSMGWf96ld+P4qJXeqyPfch4Q7CtnU/74S10bv0p/HSp
	 ors8EaJe9genA+S3QxlYa+pDOo2m/PRbMcCVBV5NpeE8WIsiH6w8rgqu66EzNfl7CE
	 Z8oavyAimic/B+mp1l3igSgP9cngCOosLEesJNIWOHnncYoarKSL8n3PPgYD02FT6g
	 BiEpm9h9c6V3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: fix socket refcount leak in
 smc_switch_conns()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804082800.498672-1-hidayath@linux.ibm.com>
References: <20260804082800.498672-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:28:31 +0000
Message-Id: <20260805082831.D443A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failover is aborted and the backup link is unnecessarily torn down=
 if a single connection is closed or aborted during the process.
--

--- Patch [1]: [PATCH net] net/smc: fix socket refcount leak in smc_switch_=
conns() ---
commit 92ea50109006ec40a22d7ea0ca6e43139666208a
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/smc: fix socket refcount leak in smc_switch_conns()

This commit fixes a socket refcount leak in smc_switch_conns(). It adds a
missing sock_put() call on an early error exit path where
smc_cdc_get_free_slot() fails.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_link_=
group *lgr,
>  		read_unlock_bh(&lgr->conns_lock);
>  		/* pre-fetch buffer outside of send_lock, might sleep */
>  		rc =3D smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
> -		if (rc)
> +		if (rc) {
> +			sock_put(&smc->sk);
>  			goto err_out;
> +		}

[Severity: High]
This is a pre-existing issue, but could this early exit path unintentionally
disrupt all other active connections on the link group?

In smc_switch_conns(), the code iterates through connections to migrate them
to the backup link. If a single connection is aborted concurrently (e.g.,
by remote input causing smc_conn_abort_work to run), smc_cdc_get_free_slot()
detects that the connection was killed and returns -EPIPE.

By jumping directly to err_out, the code calls smcr_link_down_cond_sched()
and tears down the entire backup link. Shouldn't the loop skip the single
dead connection and continue migrating the remaining healthy connections,
rather than aborting the failover for the whole link group?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804082800.4986=
72-1-hidayath@linux.ibm.com?part=3D1

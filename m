Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562119C54E;
	Tue,  4 Aug 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834418; cv=none; b=LeC3WiVwIuvDdtUFpJ0dKmDr6hqEaB66nsIaHjGFwSiwNtMK4dZsvQgcvuHVLDTQf4PNdZwGeBfbrXbOd4Cbd2SkQHuDF/4N/FSOWbiMBH6nb2xaspIsMuTMdx0D//hrvt0IYZ9WstgGJdzPmO9THv1A73Wd1Y705k3B6yMuQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834418; c=relaxed/simple;
	bh=df+DOL0/9v4TwWJ1M6w1vmdVop1R5r/pkY6mwFdjfa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0DbVAvujKnRB6K5o12f2YozvYeWjS68/pSAA4iEtYm06EhdedbnQ+BWOA52k9SnsV+A78IvUGUzv3POVK6qHl5C2NdO5y0eyGGjSHPbtc9aBbDdeazzfgcY5HeDu96NlN8sCo4N4rReCpK+hqwl00kE3xlcaE7pLzdvQ5X7R+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=n8yGjivz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="n8yGjivz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4vIzy7HGPsfFjjZzDsRgRTYSfhAGUKbY42f9YiF8ZKo=; b=n8yGjivzu0lrlMCERRIZ9Jl2me
	sbwyxwAFQLZiULIyoXCWRKdWka2XOOsU5beLa87DHVb29mWuLvxecfYtopejch5oW/qhjjDS61xpD
	wQt8KTTKQx2LGumGHp9tO5yqrR29JKo9aTbM9MRtrC/0+GJUyFdywz/MD8jMT8iRknu+tP4kKKDwz
	Udye2NrBcv56NU7dUARE5QWGqJ6fwTDOaMU4yL2jlPRkvlasFhlr5jrx3/VuoBWVZbvBP6TnUCp87
	T4WmWZBxNCrYKZr47IlhBlhtFysLe6UiwmPx+oSo+HOqJom+vWGWYFe32BBIhW2spw49Cmq+pe7Dg
	dCCSM37Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrB6e-00D1xN-01;
	Tue, 04 Aug 2026 09:06:40 +0000
Date: Tue, 4 Aug 2026 02:06:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Hidayath Khan <hidayath@linux.ibm.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	pasic@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix socket refcount leak in
 smc_switch_conns()
Message-ID: <anGqEX1JOYlTczQ6@gmail.com>
References: <20260804082800.498672-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804082800.498672-1-hidayath@linux.ibm.com>
X-Debian-User: leitao

On Tue, Aug 04, 2026 at 10:28:00AM +0200, Hidayath Khan wrote:
> smc_switch_conns() takes a reference on the SMC socket before dropping
> lgr->conns_lock, so the connection stays alive while the CDC slot is
> fetched:
> 
>         sock_hold(&smc->sk);
>         read_unlock_bh(&lgr->conns_lock);
>         /* pre-fetch buffer outside of send_lock, might sleep */
>         rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
>         if (rc)
>                 goto err_out;
> 
> The err_out label only drops the wr_tx link reference, so this early exit
> returns without the matching sock_put().  The second error exit is not
> affected because sock_put() has already run by then:
> 
>         rc = smc_switch_cursor(smc, pend, wr_buf);
>         spin_unlock_bh(&conn->send_lock);
>         sock_put(&smc->sk);
>         if (rc)
>                 goto err_out;
> 
> A leaked sk_refcnt means the smc_sock is never destroyed.  Its send and
> receive buffers stay allocated, and for a user socket the reference held
> on the network namespace is never released, so the netns can no longer be
> torn down.
> 
> smc_cdc_get_free_slot() fails when the target link goes down or when the
> connection has been killed while the switch is in progress.  Both are
> reachable during the link failover this function implements, so the leak
> is triggered by the same hardware events that make smc_switch_conns() run
> in the first place.
> 
> Drop the reference on the early error path.
> 
> Fixes: 95f7f3e7dc6b ("net/smc: improved fix wait on already cleared link")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

> ---
>  net/smc/smc_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index b4208cb186c5..c0027d2fe4e8 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
>  		read_unlock_bh(&lgr->conns_lock);
>  		/* pre-fetch buffer outside of send_lock, might sleep */
>  		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);

Do you need sock_hold(smc->sk) to call smc_cdc_get_free_slot ? Otherwise
you can move the sock_hold() after the exit.

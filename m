Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED620435EEC;
	Tue,  4 Aug 2026 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830575; cv=none; b=LzG/NfkukMvKpgJVQVDNXJIWFWhywK8Ru7usnXYHPDozPSZ2+eHiWV2OWI9efmAnQebmQ7NO0udMkX4ZUCSUoHzdOH+9MFBFLUD60a6ZFM1X5zeMDtu0iyBxzTlc00+mgSliXEmuQgGCd4IGVaEzY91EuIyS8K6qM4nH/B4SvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830575; c=relaxed/simple;
	bh=0eUymY74CT1v7y60NK/l/HWKk/ejJQBud/7a6M+avh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibFNplqfHnLJpPXTU/c4RkEsGdVlfvXrqiwLQTVdp8/Ju+e/wAUNIuvKhOmaZUvVqRzsfQ4bY4CHKcrhGqYTNqG+6c+OvtZrLsr6rUJw/y6VJ23VCgjIB3NHkC//T/azd4WPdbZfyq856cZC7Rmf040j3GSAbXGOH2uurCy5At4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iRZA6pXh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iRZA6pXh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gGHl823a0STAPKow6K4Qh+Y4iP0l4O50pJSyvjeHidQ=; b=iRZA6pXhdo2wVMkozIY46Aj2gP
	j9ygTCya8cJ5qh8uJ099UkOnIX1MVkcjR4tJdygIhP8wufRHI5bdGbXG2xFVrcfP178zvMPoSAa10
	EEO9pKH7nsS8YyP+tjUmNSWdJ4BveoLp4cGajHAjcfjemavXGNmI7hpanlvR3WEHBR9nzDexiY37D
	hhk6Uof1vfFgN+rUHRQi/lGfraj7CD7xpkiMk+l+EIkSpYtDi8oo3V19a8CaTnzjSdfyePeT90NWH
	3S42cNqgfHNjVy6fXS7Vms+bs4M8DUGQET3/28RHYDZ56Djaggalxiz34+P3FCPNF0VtdcZfWhFN0
	tcrGtEPA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrA6f-00CzrO-0N;
	Tue, 04 Aug 2026 08:02:37 +0000
Date: Tue, 4 Aug 2026 01:02:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	horms@kernel.org, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, hidayath@linux.ibm.com, pasic@linux.ibm.com, 
	netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out()
 and listener close
Message-ID: <anGciOvYt4wCmNep@gmail.com>
References: <20260803070701.126339-1-sidraya@linux.ibm.com>
 <anCPZl_Rvqj2B7vI@gmail.com>
 <4157b86a-e2cb-470b-a526-137a650b9d5a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4157b86a-e2cb-470b-a526-137a650b9d5a@linux.ibm.com>
X-Debian-User: leitao

On Tue, Aug 04, 2026 at 12:52:12PM +0530, Sidraya Jayagond wrote:
> 
> 
> On 03/08/26 6:24 pm, Breno Leitao wrote:
> >> @@ -1931,11 +1931,12 @@ static void smc_listen_out(struct smc_sock *new_smc)
> >>  		atomic_dec(&lsmc->queued_smc_hs);
> >>  
> >>  	release_sock(newsmcsk); /* lock in smc_listen_work() */
> >> +	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
> >>  	if (lsmc->sk.sk_state == SMC_LISTEN) {
> >> -		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
> >>  		smc_accept_enqueue(&lsmc->sk, newsmcsk);
> >>  		release_sock(&lsmc->sk);
> >>  	} else { /* no longer listening */
> >> +		release_sock(&lsmc->sk);
> >>  		smc_close_non_accepted(newsmcsk);
> >>  	}
> > 
> > Do you need to call smc_close_non_accepted() without the lock? otherwise
> > you can have the lock around the whole if/else clause.
> 
> Yes, smc_close_non_accepted() calls __smc_release() in turn calls
> smc_close_active(), which in the SMC_ACTIVE case hits
> smc_close_stream_wait() a blocking wait that can sleep up to
> SMC_MAX_STREAM_WAIT_TIMEOUT (2 minutes). Holding the listener lock
> across that would stall any concurrent smc_accept(), smc_listen_out(),
> or smc_release() on the listener for the same duration.
> 
> The release_sock() is intentionally placed before
> smc_close_non_accepted() to keep the critical section minimal:
> lock
>   check state
>     enqueue or not
>       unlock
>         then do the slow close work without the listener lock held.

That makes sense.

Reviewed-by: Breno Leitao <leitao@debian.org>

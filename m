Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169739FCE;
	Tue,  6 Aug 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957997; cv=none; b=PwMFIURUiI6lxXuLrXfNWvyD2dR2clwT8DFxwIIRfjU5itEChYCw5zkhse8rvYmHUPASvClWTubAlwSVVjL0szT15c2GfpjSCaaUtSqe6zm9LrP28Chvna9MvV2rXiGTDENWxnMDcDtvPoMTJ+/rlJSwmbYbItloHMlKA57yImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957997; c=relaxed/simple;
	bh=eYNEHkpnc1DOyVbkXkvSD/EYoY5Vx7JFHx/8sgmZens=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG/7qsf0y5eaBGc5Y8EargAzlNweMQ6OWlPPjgSmxNB2KJJr9hIPdBd+LN81fhr2Nmtw4aLX8hpW3+/gBDu2mzSqszmCq6xObMqM/Q2bg5WGiWhV0GO0RXXLah2QT+acE+67an8WvntIBIEwHOTfKy/dazAbA2JcCi7xc7ZvJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKGOvgR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKGOvgR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CADC4AF0E;
	Tue,  6 Aug 2024 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957997;
	bh=eYNEHkpnc1DOyVbkXkvSD/EYoY5Vx7JFHx/8sgmZens=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKGOvgR0BGP7NZay0kAMHzYsgs7lGjaqJaW8u6ABZncK78vbA73WepR48ZYBMA+ov
	 THIVTyTK6/qWtpGpBP1csqXG8GkpGBoUZ32g3WPFUyw/CamfqKtvH7ASqHjchLuFet
	 UUbczaQiW57dVFNAMtJh6gJfQfls09dlXeB4TEy9whOo+PCH5tBw63qg6i9IGceVqE
	 iqzLGV7IH3xRgi7lhb9oyrYJrczzrf+81Xh7SoQaBJZZktb1wWTa+JmS3dneI7OTOK
	 quYx3rg8+lSxztYomi/OblydUzmILhluT+u/F5ZWa/cKkfUMslSXlS8SZ2u1OaL5yG
	 l0Vnk4boaNoGg==
Date: Tue, 6 Aug 2024 16:26:32 +0100
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net/smc: introduce statistics for ringbufs
 usage of net namespace
Message-ID: <20240806152632.GB2636630@kernel.org>
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
 <20240805090551.80786-3-guwen@linux.alibaba.com>
 <20240806104941.GT2636630@kernel.org>
 <9fbf960d-f279-4e31-90f0-0243eeb7298f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fbf960d-f279-4e31-90f0-0243eeb7298f@linux.alibaba.com>

On Tue, Aug 06, 2024 at 09:07:40PM +0800, Wen Gu wrote:
> 
> 
> On 2024/8/6 18:49, Simon Horman wrote:
> > On Mon, Aug 05, 2024 at 05:05:51PM +0800, Wen Gu wrote:
> > > The buffer size histograms in smc_stats, namely rx/tx_rmbsize, record
> > > the sizes of ringbufs for all connections that have ever appeared in
> > > the net namespace. They are incremental and we cannot know the actual
> > > ringbufs usage from these. So here introduces statistics for current
> > > ringbufs usage of existing smc connections in the net namespace into
> > > smc_stats, it will be incremented when new connection uses a ringbuf
> > > and decremented when the ringbuf is unused.
> > > 
> > > Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> > 
> > ...
> > 
> > > diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
> > 
> > ...
> > 
> > > @@ -135,38 +137,45 @@ do { \
> > >   } \
> > >   while (0)
> > > -#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _len) \
> > > +#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _is_add, _len) \
> > >   do { \
> > > +	typeof(_is_add) is_a = (_is_add); \
> > >   	typeof(_len) _l = (_len); \
> > >   	typeof(_tech) t = (_tech); \
> > >   	int _pos; \
> > >   	int m = SMC_BUF_MAX - 1; \
> > >   	if (_l <= 0) \
> > >   		break; \
> > > -	_pos = fls((_l - 1) >> 13); \
> > > -	_pos = (_pos <= m) ? _pos : m; \
> > > -	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
> > > +	if (is_a) { \
> > > +		_pos = fls((_l - 1) >> 13); \
> > > +		_pos = (_pos <= m) ? _pos : m; \
> > > +		this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
> > > +		this_cpu_add((*(_smc_stats)).smc[t].k ## _rmbuse, _l); \
> > 
> > Nit:
> > 
> > I see that due to the construction of the caller, SMC_STAT_RMB_SIZE(),
> > it will not occur. But checkpatch warns of possible side effects
> > from reuse of _smc_stats.
> > 
> > As great care seems to have been taken in these macros to avoid such
> > problems, even if theoretical, perhaps it is worth doing so here too.
> > 
> > f.e. A macro-local variable could store (*(_smc_stats)).smc[t] which
> >       I think would both resolve the problem mentioned, and make some
> >       lines shorter (and maybe easier to read).
> > 
> 
> It makes sense. I will use a macro-local variable of smc_stats. Thank you!

Great, thanks.

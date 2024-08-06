Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08B1C0DC9;
	Tue,  6 Aug 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941386; cv=none; b=B2Nnn4z81ZVtMH1IqWC0985xJuJTZEOUuD+Gl8HsHImLN2wigVRhr85837woVInzv7h90yk16kZwvarQa7rjTrnTur1aCRcl2SNfngqUOeY9ivXcmwNLZr17HeCB7Udw+/JZLfuF0gjA5aBQAOs5ly6WynrDaib6O8cKNLKzSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941386; c=relaxed/simple;
	bh=PbsfPVn4g/JoIo4ioWUql/ZrNIkCK1TZ+msVS9B+B24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoJlMYbtrVSQWj9FAU9CWg49mT50n3DeeLymOJiQmiejoTIJOE1ugtubwHR6FCYN7a8mUUw2pIGLetMww8izQtgw5EpvfTcnPdX+WqRz/nvM9ZdTM1uAnHWQIwTFBZns2xalc5M847Ourao//cYLyfP572k5bG+jjaSU2FInfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrVHiATj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrVHiATj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC738C32786;
	Tue,  6 Aug 2024 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722941386;
	bh=PbsfPVn4g/JoIo4ioWUql/ZrNIkCK1TZ+msVS9B+B24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrVHiATjtOMHhnPshKkk8Jvkecu6E1LUnEvIaiQpT1i6q2BYquCpDsDKXrcqFUgg4
	 +l16ynRMYJV6iRaQkcyedOQ+dDTeduCS0MSY9DujQOiAWpNOULtLKBjcKimrRYd7n9
	 eSEHgW7pDXeQcGltzUmeuxqQGSlTfcqNh2d9rj6ZTXchUZFU2hxJHHnZXHXo2QMorD
	 q74Mnowh0qJP/eMicRQ9aRyh/L86VFoplaEu3wDRXgUaeRDWbook0FhdVAUNQPhw8m
	 /LOkGiKW9jfRzWQjCI1SR/qg2HdHl0Wbf0i1XUnw2tLeuuSuiSmto6TmCIO566ZVUm
	 6VW7u7rmtxKNQ==
Date: Tue, 6 Aug 2024 11:49:41 +0100
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net/smc: introduce statistics for ringbufs
 usage of net namespace
Message-ID: <20240806104941.GT2636630@kernel.org>
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
 <20240805090551.80786-3-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805090551.80786-3-guwen@linux.alibaba.com>

On Mon, Aug 05, 2024 at 05:05:51PM +0800, Wen Gu wrote:
> The buffer size histograms in smc_stats, namely rx/tx_rmbsize, record
> the sizes of ringbufs for all connections that have ever appeared in
> the net namespace. They are incremental and we cannot know the actual
> ringbufs usage from these. So here introduces statistics for current
> ringbufs usage of existing smc connections in the net namespace into
> smc_stats, it will be incremented when new connection uses a ringbuf
> and decremented when the ringbuf is unused.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

...

> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h

...

> @@ -135,38 +137,45 @@ do { \
>  } \
>  while (0)
>  
> -#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _len) \
> +#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _is_add, _len) \
>  do { \
> +	typeof(_is_add) is_a = (_is_add); \
>  	typeof(_len) _l = (_len); \
>  	typeof(_tech) t = (_tech); \
>  	int _pos; \
>  	int m = SMC_BUF_MAX - 1; \
>  	if (_l <= 0) \
>  		break; \
> -	_pos = fls((_l - 1) >> 13); \
> -	_pos = (_pos <= m) ? _pos : m; \
> -	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
> +	if (is_a) { \
> +		_pos = fls((_l - 1) >> 13); \
> +		_pos = (_pos <= m) ? _pos : m; \
> +		this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
> +		this_cpu_add((*(_smc_stats)).smc[t].k ## _rmbuse, _l); \

Nit:

I see that due to the construction of the caller, SMC_STAT_RMB_SIZE(),
it will not occur. But checkpatch warns of possible side effects
from reuse of _smc_stats.

As great care seems to have been taken in these macros to avoid such
problems, even if theoretical, perhaps it is worth doing so here too.

f.e. A macro-local variable could store (*(_smc_stats)).smc[t] which
     I think would both resolve the problem mentioned, and make some
     lines shorter (and maybe easier to read).

> +	} else { \
> +		this_cpu_sub((*(_smc_stats)).smc[t].k ## _rmbuse, _l); \
> +	} \
>  } \
>  while (0)
>  
>  #define SMC_STAT_RMB_SUB(_smc_stats, type, t, key) \
>  	this_cpu_inc((*(_smc_stats)).smc[t].rmb ## _ ## key.type ## _cnt)
>  
> -#define SMC_STAT_RMB_SIZE(_smc, _is_smcd, _is_rx, _len) \
> +#define SMC_STAT_RMB_SIZE(_smc, _is_smcd, _is_rx, _is_add, _len) \
>  do { \
>  	struct net *_net = sock_net(&(_smc)->sk); \
>  	struct smc_stats __percpu *_smc_stats = _net->smc.smc_stats; \
> +	typeof(_is_add) is_add = (_is_add); \
>  	typeof(_is_smcd) is_d = (_is_smcd); \
>  	typeof(_is_rx) is_r = (_is_rx); \
>  	typeof(_len) l = (_len); \
>  	if ((is_d) && (is_r)) \
> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, rx, l); \
> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, rx, is_add, l); \
>  	if ((is_d) && !(is_r)) \
> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, tx, l); \
> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, tx, is_add, l); \
>  	if (!(is_d) && (is_r)) \
> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, rx, l); \
> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, rx, is_add, l); \
>  	if (!(is_d) && !(is_r)) \
> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, tx, l); \
> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, tx, is_add, l); \
>  } \
>  while (0)
>  
> -- 
> 2.32.0.3.g01195cf9f
> 
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263251C0DC4;
	Tue,  6 Aug 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941370; cv=none; b=DWYnNGGOfPItKnMN7hJofsswR6nZLWNSTkOIGNS7YI5zOEoBrj//vDxwQKCVL8IVp6hpxUb+60PGr6XJZc7d16d0uXJhN01P65zdDKYdHe0Jf87xI/2pArCJ/3FN6PfQ1PBG+I2z8rBzraAZXPIgj95lmu6sJ9hYAjXd37+SIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941370; c=relaxed/simple;
	bh=eeflND3p0sty9SnVOq0BHiPjiXkx3ZzDdI3gZhlpwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGlM7IsKLs0c0YfeGpSFytISjlBBFbzz4APnKet+E5rREq5qgmFxkYo3H7Pc1edcs790vyw8mKsl0fKx1rMfTdSzZCxwNLy5CCrXeC/MAknFeOMXh8NPyFgqRNKyTdEQi/n8+deuAglCjkoW+evs3AhAqC+0jVsehHvhMnalEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y18ktaza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y18ktaza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E634C32786;
	Tue,  6 Aug 2024 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722941369;
	bh=eeflND3p0sty9SnVOq0BHiPjiXkx3ZzDdI3gZhlpwWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y18ktaza8IQu0paXRuZ2pzyUh8AnVzt21QQ3IecXBfS+pJs4uaziftuEVrQSwQWTo
	 YmADrqQyONg7LDsd0KPGUp6+fAJYNLNkN7M5mAK+W4TYEk7nxtYnINbYHmMd3jynI5
	 Dy9BV9yYAdKoOjXCieipmwoMRasdyhOK8q5hXV3KQMkTCSd/FA2bBmg8ivkUmOKUW/
	 NDk5V3/vmCIkyzom8o8FNxatjJgWnC+Bgdug9dRdkQaaXJnL3Bnn+eFmIISY3ibvvl
	 NAFZeZ2mF2GLti+CAGmv+7297umrrGxxa8Q850AuTb39frSmCyioupBRnErWw/u3l2
	 zS0xOiDDXgW7Q==
Date: Tue, 6 Aug 2024 11:49:25 +0100
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/smc: introduce statistics for allocated
 ringbufs of link group
Message-ID: <20240806104925.GS2636630@kernel.org>
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
 <20240805090551.80786-2-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805090551.80786-2-guwen@linux.alibaba.com>

On Mon, Aug 05, 2024 at 05:05:50PM +0800, Wen Gu wrote:
> Currently we have the statistics on sndbuf/RMB sizes of all connections
> that have ever been on the link group, namely smc_stats_memsize. However
> these statistics are incremental and since the ringbufs of link group
> are allowed to be reused, we cannot know the actual allocated buffers
> through these. So here introduces the statistic on actual allocated
> ringbufs of the link group, it will be incremented when a new ringbuf is
> added into buf_list and decremented when it is deleted from buf_list.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  include/uapi/linux/smc.h |  4 ++++
>  net/smc/smc_core.c       | 52 ++++++++++++++++++++++++++++++++++++----
>  net/smc/smc_core.h       |  2 ++
>  3 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
> index b531e3ef011a..d27b8dc50f90 100644
> --- a/include/uapi/linux/smc.h
> +++ b/include/uapi/linux/smc.h
> @@ -127,6 +127,8 @@ enum {
>  	SMC_NLA_LGR_R_NET_COOKIE,	/* u64 */
>  	SMC_NLA_LGR_R_PAD,		/* flag */
>  	SMC_NLA_LGR_R_BUF_TYPE,		/* u8 */
> +	SMC_NLA_LGR_R_SNDBUF_ALLOC,	/* u64 */
> +	SMC_NLA_LGR_R_RMB_ALLOC,	/* u64 */
>  	__SMC_NLA_LGR_R_MAX,
>  	SMC_NLA_LGR_R_MAX = __SMC_NLA_LGR_R_MAX - 1
>  };
> @@ -162,6 +164,8 @@ enum {
>  	SMC_NLA_LGR_D_V2_COMMON,	/* nest */
>  	SMC_NLA_LGR_D_EXT_GID,		/* u64 */
>  	SMC_NLA_LGR_D_PEER_EXT_GID,	/* u64 */
> +	SMC_NLA_LGR_D_SNDBUF_ALLOC,	/* u64 */
> +	SMC_NLA_LGR_D_DMB_ALLOC,	/* u64 */
>  	__SMC_NLA_LGR_D_MAX,
>  	SMC_NLA_LGR_D_MAX = __SMC_NLA_LGR_D_MAX - 1
>  };
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 71fb334d8234..73c7999fc74f 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -221,6 +221,37 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
>  	write_unlock_bh(&lgr->conns_lock);
>  }
>  
> +/* must be called under lgr->{sndbufs|rmbs} lock */
> +static inline void smc_lgr_buf_list_add(struct smc_link_group *lgr,
> +					bool is_rmb,
> +					struct list_head *buf_list,
> +					struct smc_buf_desc *buf_desc)

Please do not use the inline keyword in .c files unless there is a
demonstrable reason to do so, e.g. performance. Rather, please allow
the compiler to inline functions as it sees fit.

The inline keyword in .h files is, of course, fine.

> +{
> +	list_add(&buf_desc->list, buf_list);
> +	if (is_rmb) {
> +		lgr->alloc_rmbs += buf_desc->len;
> +		lgr->alloc_rmbs +=
> +			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
> +	} else {
> +		lgr->alloc_sndbufs += buf_desc->len;
> +	}
> +}
> +
> +/* must be called under lgr->{sndbufs|rmbs} lock */
> +static inline void smc_lgr_buf_list_del(struct smc_link_group *lgr,
> +					bool is_rmb,
> +					struct smc_buf_desc *buf_desc)

Ditto.

> +{
> +	list_del(&buf_desc->list);
> +	if (is_rmb) {
> +		lgr->alloc_rmbs -= buf_desc->len;
> +		lgr->alloc_rmbs -=
> +			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
> +	} else {
> +		lgr->alloc_sndbufs -= buf_desc->len;
> +	}
> +}
> +

...

-- 
pw-bot: changes-requested

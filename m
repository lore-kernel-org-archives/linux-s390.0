Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8218E038;
	Wed,  9 Oct 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478952; cv=none; b=p3hMMd/AgB1IazFqRBP/loguLMr1iFGRHpaLgDnKAdYy3I7p8u5clyIopT/XR8oM8r4FteGGaCJh8wLRGYNCza1BQu+fZ9vjIxFhoz8oQdlliwuAI27wrNcXBC9mckxMVyOJznLqLv7AycZ3XiYUpmyhd1PAFdO5rr7GIZpsatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478952; c=relaxed/simple;
	bh=6jfgjtG53RSMP1IWcGQFVut+4sA8wCXZ9Ber8vftB/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYgB7zE0AwNjpMJQifhGqfBrII0BKFBI+foMFDV/CUK457pRyauYoa1vn4JP/CgK/ny+lsqGTBNbjtBi1s/yrzf/FkieYC6PCyEDBggOSKyffiD+CH5dZQE3AVxtzRHoyd+ZNFIsuebiUbn/uR8ehlg9t2NYVc7Q5UYl2GqCEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SbGy+v32; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SbGy+v32"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728478941; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4DfXJQrk0KOHxCBycuEU10Zxg7Y2vXiwsgBxn0Lgu5o=;
	b=SbGy+v32y76kyPqhmt9gsrqvgzq3GF04gHPgbLEElJ34gGb1o5+sWX71xC0mqe9LVt1XdNG43iGrrOiyHXklKL8b+rtREgR4g853XU2QOkfMmTtkhmYACfSLpPhsTPdtYSVl0V/kHEawOZap0isYx8mlK2cr+NSBHj10AntWHVg=
Received: from 30.221.100.29(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WGiq8XA_1728478939)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 21:02:21 +0800
Message-ID: <e1abb0e5-2da1-49e6-8af0-2cd2531eb6ec@linux.alibaba.com>
Date: Wed, 9 Oct 2024 21:02:19 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: Address spelling errors
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/10/9 18:05, Simon Horman wrote:
> Address spelling errors flagged by codespell.
> 
> This patch is intended to cover all files under drivers/smc
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  net/smc/smc.h      | 2 +-
>  net/smc/smc_clc.h  | 2 +-
>  net/smc/smc_core.c | 2 +-
>  net/smc/smc_core.h | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index ad77d6b6b8d3..78ae10d06ed2 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -278,7 +278,7 @@ struct smc_connection {
>  						 */
>  	u64			peer_token;	/* SMC-D token of peer */
>  	u8			killed : 1;	/* abnormal termination */
> -	u8			freed : 1;	/* normal termiation */
> +	u8			freed : 1;	/* normal termination */
>  	u8			out_of_sync : 1; /* out of sync with peer */
>  };
>  
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 5625fda2960b..5fd6f5b8ef03 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -156,7 +156,7 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
>  } __aligned(4);
>  
>  struct smc_clc_msg_smcd {	/* SMC-D GID information */
> -	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
> +	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requester */
>  	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
>  	u8 vendor_oui[3];	/* vendor organizationally unique identifier */
>  	u8 vendor_exp_options[5];
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 4e694860ece4..500952c2e67b 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2321,7 +2321,7 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
>  		}
>  		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
>  			goto out;
> -		fallthrough;	// try virtually continguous buf
> +		fallthrough;	// try virtually contiguous buf
>  	case SMCR_VIRT_CONT_BUFS:
>  		buf_desc->order = get_order(bufsize);
>  		buf_desc->cpu_addr = vzalloc(PAGE_SIZE << buf_desc->order);
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 0db4e5f79ac4..69b54ecd6503 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -30,7 +30,7 @@
>  					 */
>  #define SMC_CONN_PER_LGR_PREFER	255	/* Preferred connections per link group used for
>  					 * SMC-R v2.1 and later negotiation, vendors or
> -					 * distrubutions may modify it to a value between
> +					 * distributions may modify it to a value between
>  					 * 16-255 as needed.
>  					 */
>  
> @@ -181,7 +181,7 @@ struct smc_link {
>  					 */
>  #define SMC_LINKS_PER_LGR_MAX_PREFER	2	/* Preferred max links per link group used for
>  						 * SMC-R v2.1 and later negotiation, vendors or
> -						 * distrubutions may modify it to a value between
> +						 * distributions may modify it to a value between
>  						 * 1-2 as needed.
>  						 */
>  
> 

LGTM.

Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Thanks,
Guangguan Wang.

Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25C145B16;
	Sat, 12 Oct 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719413; cv=none; b=s45jsqG4xAHfjLKBQC3blBGaH4iV+tq+T7UzJLDTNheuRZ/t+MFC3mQF6F1nLKVpEwOCD0V1JWQ1L1kUw9w3mhhK+JNX1qTIcoMVGvdvOBtZIVihKfyDoDjPO/s1tFFDdVOTces0w6VeMIbMzsj4UbevbbRzIWMO4Y2DvZdnA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719413; c=relaxed/simple;
	bh=uXo3sKkCo8hiSYfi+PCchO07SV4REoIbWMRrxNWlhpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qMjil1z260R6v+C3he/OIPt7Dolt07foQYUwb6LmeOLg5EReM3WFZniOfYHq3f1mx+IfR6ZHEFQpQ88EYmN+8tAOT8/xpu+CYJbP2r20Mbo7Ib7xYTNNGPu5GF6UICvo8U6E23+PBWHgZGcZ2pdo8McQj83waR3pAp4UlpYNYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TGJjdhI/; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TGJjdhI/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728719401; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r9jBBd2nA9buoUYhfQRl7FFBh/oQuZ9YxlPz8kmeDzU=;
	b=TGJjdhI/MbPRnSSn7FkLjhn4gBFA6eyl7iWON0J/j65b6yM5NzmLD8xETl58ehpCtvyt0UI+dgsLLZF0piOB/g2AtqDcvvk39cCTvvpzMEUrfiaBo+99IroLeujm9rso77f2HLeLCxtoA08ypRkt0BhsEfndGKK1fqTUi29TntU=
Received: from 30.221.130.132(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WGv5mN-_1728719400 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 15:50:01 +0800
Message-ID: <41ba8de4-5c3f-4028-954a-286da85ca595@linux.alibaba.com>
Date: Sat, 12 Oct 2024 15:49:59 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: fix wrong comparation in smc_pnet_add_pnetid
To: Li RongQing <lirongqing@baidu.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20241011061916.26310-1-lirongqing@baidu.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20241011061916.26310-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/11 14:19, Li RongQing wrote:
> pnetid of pi (not newly allocated pe) should be compared
> 
> Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for Ethernet devices")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   net/smc/smc_pnet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 1dd3623..a04aa0e 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -753,7 +753,7 @@ static int smc_pnet_add_pnetid(struct net *net, u8 *pnetid)
>   
>   	write_lock(&sn->pnetids_ndev.lock);
>   	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
> -		if (smc_pnet_match(pnetid, pe->pnetid)) {
> +		if (smc_pnet_match(pnetid, pi->pnetid)) {
>   			refcount_inc(&pi->refcnt);
>   			kfree(pe);
>   			goto unlock;

Good catch, thanks!

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

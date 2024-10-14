Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC633998;
	Mon, 14 Oct 2024 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728884527; cv=none; b=NYs4k0eKpgnhsLYnd/k6XdpKKKaRwGF+zIFMpRXEDMP/ohCWADqo8+j2cl2sILK1mLTkbmvwQGSM6fNkQvdFu9G1dhjey0kMr4wvgyuj/xBr9c2HFDQIPuyScK4afGAurghCf3AYUN/yJ0XTVb4Th8xoBSwmQl6Fhbmh13zwIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728884527; c=relaxed/simple;
	bh=kYzzfSVoDHBr8Tp5TdaXFCO/DUqmZh370Wct9i2IwgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ux9z8kp5iMRah/8I+uACFr+k2wHPeTQGJBjjJhuXhw/RWkmK5kUuWUzZRGla6/OHmUHfmkzUSjwAd91BFzLpMd01G315ipiYTefQIm+ZSg8ZslxoUWk+ppBNgel4IsWtw2ox4FvZMbGT6Dtc+XNghCCtDrN6taUwxQFynmXyvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NK5kYmgd; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NK5kYmgd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728884522; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UZFLdc/wCny+aKVwWKUjs1ScNSW66zWnusFqPKMIqHk=;
	b=NK5kYmgdHW5qeFKOgul1++69/wlxFU2/Xm0BvqqS57/EZrX8rPwbUBkpPpArx0zWYIgTiypYKe7BCF1UZLc+NAwbuJMozavcSWa5BIvteUgq05BudCFf3pMrac2zL1Vh0jgtdSGeFJJvwsT6frJ0X+BbidVavjg5RS7Q8uw/6n4=
Received: from 30.32.80.190(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WH0c.1S_1728884520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 13:42:01 +0800
Message-ID: <39dfed0f-f7c8-47b8-8022-c4c2dc9a73dd@linux.alibaba.com>
Date: Mon, 14 Oct 2024 13:41:58 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: fix wrong comparation in smc_pnet_add_pnetid
To: Li RongQing <lirongqing@baidu.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20241011061916.26310-1-lirongqing@baidu.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20241011061916.26310-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/24 2:19 PM, Li RongQing wrote:
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

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>

Thanks,
D. Wythe

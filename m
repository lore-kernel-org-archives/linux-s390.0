Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC81BD035;
	Fri, 13 Sep 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213390; cv=none; b=mFSXYNtW2S6KukmSXuF2RYUnOAJzV8mvh+fP+DrGQq/AMLKNT0AmbvKnR0qGd5eQBLM2dSPV7bLvFBRuwE1gOeTQjlxn7NXxgVzpu5mj1TUMpuSIVjKE5Wvia6BPZZG8fzLZ80x+qCYnBoj6x8ztkWhH5ECgvpCo7OyJXLBncN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213390; c=relaxed/simple;
	bh=4v2GYJPDqs2EwUQ2RwE8GM0dcIKe+BxOP7TxEnwkS10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XooDsOpr25gCEk2EPUjcX7D+Urc6BETT3FRFEa/zBGyejHJCUIjpzSx3qZR+lBX86BngP4lkUvEstWWFhFlCBEwDg6fL/X/EryF3A4jekhksUyfNcyD64nM7OTa4tvE2Xb/D9AkkSIBvxqjTFEng+4NahC9i1AW6PKBNujvj9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pP3UUDs1; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pP3UUDs1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726213384; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SJA/5UbBQU4AuHpnS0gnlxTjlMfgXkXvuk7FDilpNMc=;
	b=pP3UUDs1gCAZQW3KGqazgMcIKjOj+GLv72vR52p+r7HdAXkz5Rnc5iFtMB08jN2f2YjVpNR2b/nQEibzxPxXQCxZ4Sl8DN31Q8FkV5gpHRJiI/UfemXEXae/g333vvAIBsxuWoLTcYUDAqBj9ozTkYKcgP6Uq9LBgoKh+0mN5yg=
Received: from 30.221.149.237(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WEtyDAR_1726213382)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 15:43:03 +0800
Message-ID: <e13f417e-278a-4273-a5a6-f7a1197094cb@linux.alibaba.com>
Date: Fri, 13 Sep 2024 15:43:02 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: remove useless macros in smc_close.h
To: Zhengchao Shao <shaozhengchao@163.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com
References: <20240912144240.8635-1-shaozhengchao@163.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240912144240.8635-1-shaozhengchao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/24 10:42 PM, Zhengchao Shao wrote:
> After commit 51f1de79ad8e("net/smc: replace sock_put worker by
> socket refcounting") is merged, SMC-COSES_SOCK_PUT_DELAY is no
> longer used. So, remove it.

SMC_CLOSE_SOCK_PUT_DELAY

> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@163.com>
> ---
>   net/smc/smc_close.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
> index 634fea2b7c95..9baee2eafc3b 100644
> --- a/net/smc/smc_close.h
> +++ b/net/smc/smc_close.h
> @@ -17,7 +17,6 @@
>   #include "smc.h"
>   
>   #define SMC_MAX_STREAM_WAIT_TIMEOUT		(2 * HZ)
> -#define SMC_CLOSE_SOCK_PUT_DELAY		HZ
>   
>   void smc_close_wake_tx_prepared(struct smc_sock *smc);
>   int smc_close_active(struct smc_sock *smc);


Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21359256D;
	Fri,  2 Aug 2024 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722566291; cv=none; b=WreWsrbZEEpx6mDM87UdnKnMUNIhiBJ1COmePhILD1+C3fSCVyC32cjDE6qN+yl/V6YwpNAXsWBeXSK8eZwTDm2g/o7pcclyw2ZAazbFD0TN5XanE4kMR/WPvMRbcJb+y7GDG8z/tUZJlafg2OUow56Egg/z2PlPVJbTYCzXNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722566291; c=relaxed/simple;
	bh=qsERdodKVvGHkmLwF7ZiXQoVYz+Du1NbfybhRREWwr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZyCk4olz9KWVm8I7InVeTZrj9CPCl4ZX8la65xzPw6ZbDjJKmlA/tlwsVM+z6zIomES2hElj4FWQ7L8UDMdsKMtFJew0U+qVZHXxVaG4qYb1ytXAQktM6+to34YbDPzvoggJRd16YC8yvfZ7bka/0bswRgIJaH8K4o2DCIDEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AJcNKghG; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AJcNKghG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722566286; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aWAgTe3/d2vuRvpihukkRtHTKAqcY/yAFBxhWx6czPY=;
	b=AJcNKghGoiUO+XYPR2LMWS8yLLLJEgjFI7w4ST2Lw59ZwrvXlpyX/W+dR2PVEyZnf08HATnnHGEFmXt2hejC/t+Xh1RAtKwMwtXdEtDfN0O4pUSSfKUOaPkdacV5uR9H03GA70y34UvgUhRkyvBexX8Sdjd1CY0xUM9A1+otvA0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBvdzkc_1722566283;
Received: from 30.221.149.103(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WBvdzkc_1722566283)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 10:38:05 +0800
Message-ID: <a69bfb91-3cfa-4e98-b655-e8f0d462c55d@linux.alibaba.com>
Date: Fri, 2 Aug 2024 10:38:03 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add the max value of fallback reason
 count
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240801113549.98301-1-shaozhengchao@huawei.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240801113549.98301-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/1/24 7:35 PM, Zhengchao Shao wrote:
> The number of fallback reasons defined in the smc_clc.h file has reached
> 36. For historical reasons, some are no longer quoted, and there's 33
> actually in use. So, add the max value of fallback reason count to 50.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   net/smc/smc_stats.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
> index 9d32058db2b5..ab5aafc6f44c 100644
> --- a/net/smc/smc_stats.h
> +++ b/net/smc/smc_stats.h
> @@ -19,7 +19,7 @@
>   
>   #include "smc_clc.h"
>   
> -#define SMC_MAX_FBACK_RSN_CNT 30
> +#define SMC_MAX_FBACK_RSN_CNT 50
>   
It feels more like a fix ？

>   enum {
>   	SMC_BUF_8K,


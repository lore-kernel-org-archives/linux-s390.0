Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABEA14A627;
	Mon,  5 Aug 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844781; cv=none; b=SQodXOg8UGKA6Q03ckTz3+cLaBUT5rnTQYse28tvZY4+ibHMEGt1IdpFQ6Uqlz1nAlfX8vM4xPPlmDK6WWhXniUIVwAtc54V4HtZBptatnDaknhUkRFT6YN60rtNQeXAD4JYuQn7V0J4wITiQCQA8Rz74VvBEvwbYFID3596jAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844781; c=relaxed/simple;
	bh=G/7GKeW/a9gvQUbdK0ZlhrRNopI0Ox1HhI8VRWW+b5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9PVHWyZY3xgBwCm2DVnXONHt49gN+7MGQXztDC/zANNPrEdopcA6rPT2CuXcbw3rrw/KxeeeZvuGpNRC145Lfqz3E9dV3Vh5Z5SWCNc2A/roNGoA8F7aYokI+FxSgglcHvyoP3Ku/Oepv2k5UGEo6ABsobaBG+Spopx+XATPP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QAxn4MQI; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QAxn4MQI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722844770; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lsS3/VdZarRA/HYjtPyv30MlkV9cKIPL5EkOy1T9cqE=;
	b=QAxn4MQISXov9qcSCsEVMpfYuqgGv/kbibMBvOrCInQzNO0WeYFlC1ZUCgQmhocoJj4CPVk/ljFREP1jjhjfWREHzQsyI4RQ8Ui+rjHkWHRtyoEVzkO6nL+D6fZF9uEv3O+f24rrLqim9UsjFSJDOR32jTbqBvkFs0I+5pJOreQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WC64Dwn_1722844768;
Received: from 30.221.149.101(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WC64Dwn_1722844768)
          by smtp.aliyun-inc.com;
          Mon, 05 Aug 2024 15:59:29 +0800
Message-ID: <e2d5be52-9cf9-4093-9053-82d2676645fe@linux.alibaba.com>
Date: Mon, 5 Aug 2024 15:59:27 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2] net/smc: add the max value of fallback reason
 count
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, guangguan.wang@linux.alibaba.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240805043856.565677-1-shaozhengchao@huawei.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240805043856.565677-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/5/24 12:38 PM, Zhengchao Shao wrote:
> The number of fallback reasons defined in the smc_clc.h file has reached
> 36. For historical reasons, some are no longer quoted, and there's 33
> actually in use. So, add the max value of fallback reason count to 36.
>
> Fixes: 6ac1e6563f59 ("net/smc: support smc v2.x features validate")
> Fixes: 7f0620b9940b ("net/smc: support max connections per lgr negotiation")
> Fixes: 69b888e3bb4b ("net/smc: support max links per lgr negotiation in clc handshake")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: add fix tag and change max value to 36
> ---
>   net/smc/smc_stats.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
> index 9d32058db2b5..e19177ce4092 100644
> --- a/net/smc/smc_stats.h
> +++ b/net/smc/smc_stats.h
> @@ -19,7 +19,7 @@
>   
>   #include "smc_clc.h"
>   
> -#define SMC_MAX_FBACK_RSN_CNT 30
> +#define SMC_MAX_FBACK_RSN_CNT 36
>   
>   enum {
>   	SMC_BUF_8K,

LGTM. Thanks

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>



Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B81EEF9;
	Fri,  2 Aug 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607570; cv=none; b=FoXlIGXaLC2NXwRYavKPFSr1Djxq7QxIrZ9AFiXDL65lPHMGgbY1qtqWT4n9kCb3OdFCijc4qC2eUWOYwv8J+wkUPEJnX7OaUqSKA2fEzj1l3blAPsZiODTLUoPu/vsCWYT9Gvgr1SxnJuTmJ9PvdH2UN0TlF8hWt4PIuniZyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607570; c=relaxed/simple;
	bh=8zF24GN2W5KBBWa63gtA37RA2md7NaZA0+s4mCi4yqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO2bfyCpAFF96dw4rgCO8VRnbA5zM8mVwNd31nJbRvVgWSYGupGTW5sUVSIRHrx0wJ4fA3OHJ0qTjeA36YDdjkVtaSVgkLxXkKdlhccngIpP3uWrc1SYuRJYgH0U2KIkJDDe0pVvv7RvwIkUZlgNSWO5kpo9+aHtnly95WAJJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IGim6D6D; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IGim6D6D"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722607559; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v+0fUo/IafSdIF9EhnGJlHTdcHZLiaYxtFmsr78Hdmc=;
	b=IGim6D6DVFOsEjBl0Fx0A37tTBTmD6jnD6l3dnqItxGGCWOB8DQdViEwoCCb/lxqUlWGCJiLAVYMtQzVdSjjoqPxhuhiLx25C4emeVk5f3AkDxKGqjTXHkbA+YSjL6FRISpQ69RUooJyDlTvqcynH0PhcrBIAcWfszZHpLOOtH0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBxlBR3_1722607557;
Received: from 30.120.147.143(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WBxlBR3_1722607557)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 22:05:58 +0800
Message-ID: <439a499a-13ae-47e7-af54-3d9f064766af@linux.alibaba.com>
Date: Fri, 2 Aug 2024 22:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add the max value of fallback reason
 count
To: Wenjia Zhang <wenjia@linux.ibm.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Zhengchao Shao <shaozhengchao@huawei.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: jaka@linux.ibm.com, tonylu@linux.alibaba.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com
References: <20240801113549.98301-1-shaozhengchao@huawei.com>
 <a69bfb91-3cfa-4e98-b655-e8f0d462c55d@linux.alibaba.com>
 <4213b756-a92f-4be9-951d-893f4a6590b4@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <4213b756-a92f-4be9-951d-893f4a6590b4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/2 19:17, Wenjia Zhang wrote:
> 
> 
> On 02.08.24 04:38, D. Wythe wrote:
>>
>>
>> On 8/1/24 7:35 PM, Zhengchao Shao wrote:
>>> The number of fallback reasons defined in the smc_clc.h file has reached
>>> 36. For historical reasons, some are no longer quoted, and there's 33
>>> actually in use. So, add the max value of fallback reason count to 50.
>>>
>>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>>> ---
>>>   net/smc/smc_stats.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
>>> index 9d32058db2b5..ab5aafc6f44c 100644
>>> --- a/net/smc/smc_stats.h
>>> +++ b/net/smc/smc_stats.h
>>> @@ -19,7 +19,7 @@
>>>   #include "smc_clc.h"
>>> -#define SMC_MAX_FBACK_RSN_CNT 30
>>> +#define SMC_MAX_FBACK_RSN_CNT 50
>> It feels more like a fix ？
>>
>>>   enum {
>>>       SMC_BUF_8K,
>>
> 
> Hi Zhengchao,
> 
> IMO It should be 36 instead of 50 because of unnecessary smc_stats_fback element and  unnecessary scanning e.g. in smc_stat_inc_fback_rsn_cnt(). If there is any new reason code coming later, the one who are introducing the new reason code should update the the value correspondingly.

I wonder if it is really necessary to expand to 50, since generally
the reasons for fallback in a machine will be concentrated into a few,
normally less than 10, so there is almost no case of using up all 30
reason slots.

Thanks!

> Btw, I also it is a bug fix other than feature.
> 
> Thanks,
> Wenjia

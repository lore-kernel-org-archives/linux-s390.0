Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59FD53B;
	Mon,  5 Aug 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722819420; cv=none; b=vDOc+FwvhLh1qrELP+I872UELkvhC0/cLcLWhHAlkMlLPM2mEpXqCx+Yardxwr+v9P22YbTg4vyN3n2aHyTi+womxlfUK2uQRFS80cX60NXIUIs7OzYPdw6IUEPnI8Fa9Zh46NMAAdU9364rn9aIEw10FniuNQXaYnV/KPBZEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722819420; c=relaxed/simple;
	bh=/Bu5vvVJrkQ5m+U11rKwuSTgdqBZvYO0/N/fbgg+pDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZR7L9CvTA0ETOvHV5aRF0baXEX8X3I5726RYLrtmak97EP8wA53OyQRNeZT+6khhACPOOGfCuUeU6btNa+wY20EGbCs4F8bzpN8yMzXi51VPunVMIN8u9oL2ixPuYUibknlEvs1DmlsirqHRlNdHytJ1wjK5E9p/T0P5Tj8dHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WcdK96zPKzndpx;
	Mon,  5 Aug 2024 08:55:41 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AABA180087;
	Mon,  5 Aug 2024 08:56:48 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 08:56:47 +0800
Message-ID: <ee560f28-0ff3-276c-1e4b-d72bd5a6fa4c@huawei.com>
Date: Mon, 5 Aug 2024 08:56:47 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] net/smc: add the max value of fallback reason
 count
To: Wenjia Zhang <wenjia@linux.ibm.com>, "D. Wythe"
	<alibuda@linux.alibaba.com>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <jaka@linux.ibm.com>, <tonylu@linux.alibaba.com>,
	<guwen@linux.alibaba.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240801113549.98301-1-shaozhengchao@huawei.com>
 <a69bfb91-3cfa-4e98-b655-e8f0d462c55d@linux.alibaba.com>
 <4213b756-a92f-4be9-951d-893f4a6590b4@linux.ibm.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <4213b756-a92f-4be9-951d-893f4a6590b4@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)

Hi Wenjia:
     I will fix it in V2.

Thank you

Zhengchao Shao

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
> IMO It should be 36 instead of 50 because of unnecessary smc_stats_fback 
> element and  unnecessary scanning e.g. in smc_stat_inc_fback_rsn_cnt(). 
> If there is any new reason code coming later, the one who are 
> introducing the new reason code should update the the value 
> correspondingly.
> Btw, I also it is a bug fix other than feature.
> 
> Thanks,
> Wenjia

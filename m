Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930F1DB947;
	Fri, 13 Sep 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235643; cv=none; b=O+36niOuFA+ZH8kuP/GNWZm70w4JS9Y/byzLECxldsY+slrc31ZiDl/w81J/oD8/q9nAtfbh3UmBRhiO5nc6xmZZ8B23oPC5zlI9PaCJM+WviRKWqU+sBUe1K1mdk3k3UNb4rJ5mYBduSavUdDM97sbMccjjPAkywWWdeW+TjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235643; c=relaxed/simple;
	bh=V9acdEU0Ob1i3pFcOEzI1pdIcCi/3pS+0lrJF7b/Jmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCr4yoFx+KlMC6N3satOhAjhFiUM4pnC7OkTZ71jE0RAA/ORlq2rsLOHL9U7Xma6nNitrQyJRdReiM2ffNwzVeYkZHmyhWPt8qxKzE9KdKgwmC0dPxRIW1enwr8zUF7UqotAmgZIWSwFWKq99vHpW3pBhIVb2Iv78OR1qq7Q538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p9FUmAkm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p9FUmAkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=V9acdEU0Ob1i3pFcOEzI1pdIcCi/3pS+0lrJF7b/Jmw=;
	b=p9FUmAkmzt8ZYE+8qoaOU1vut0WawO/CrYDtmOpIHq6YIr6XZGLqaXhuOY5KlD
	NRdmqbdnRCZeOCM9TaT2fdTAWTc9wtRjpMEKfWTqHoH4i7E++2K43VfepeuJm1WR
	Bst3k0nM3rSU/hxDJiDhy3OXMfvAQNIXGWEyL+6zkkRY4=
Received: from [192.168.0.104] (unknown [117.147.35.135])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wAX3xrSQ+RmVhhSAw--.31928S2;
	Fri, 13 Sep 2024 21:53:23 +0800 (CST)
Message-ID: <160ab123-8bad-7c38-c5b1-08a2d4d6eb20@163.com>
Date: Fri, 13 Sep 2024 21:53:23 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH net-next] net/smc: remove useless macros in smc_close.h
To: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com
References: <20240912144240.8635-1-shaozhengchao@163.com>
 <e13f417e-278a-4273-a5a6-f7a1197094cb@linux.alibaba.com>
From: shaozhengchao <shaozhengchao@163.com>
In-Reply-To: <e13f417e-278a-4273-a5a6-f7a1197094cb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX3xrSQ+RmVhhSAw--.31928S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF15Kw1UKrWxKF45ArWxXrb_yoWfAFb_Cr
	yxur1xC3WUXrn7KFZ5Jw4qvw1vyrn5Jr18Z3Z0yry3J395tr4UXFs5Kr9ay3sI9rs3XFZx
	XF45XrWDCa47ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUJ73PUUUUU==
X-CM-SenderInfo: pvkd065khqwuxkdrqiywtou0bp/1tbivhRZvGV4LDTTdwAAsu


On 2024/9/13 15:43, D. Wythe wrote:
>
>
> On 9/12/24 10:42 PM, Zhengchao Shao wrote:
>> After commit 51f1de79ad8e("net/smc: replace sock_put worker by
>> socket refcounting") is merged, SMC-COSES_SOCK_PUT_DELAY is no
>> longer used. So, remove it.
>
> SMC_CLOSE_SOCK_PUT_DELAY

My mistake. Thank you for your review.

Zhengchao Shao

>
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@163.com>
>> ---
>>   net/smc/smc_close.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
>> index 634fea2b7c95..9baee2eafc3b 100644
>> --- a/net/smc/smc_close.h
>> +++ b/net/smc/smc_close.h
>> @@ -17,7 +17,6 @@
>>   #include "smc.h"
>>     #define SMC_MAX_STREAM_WAIT_TIMEOUT        (2 * HZ)
>> -#define SMC_CLOSE_SOCK_PUT_DELAY        HZ
>>     void smc_close_wake_tx_prepared(struct smc_sock *smc);
>>   int smc_close_active(struct smc_sock *smc);


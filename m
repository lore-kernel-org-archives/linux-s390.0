Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F213473D;
	Wed,  6 Mar 2024 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736370; cv=none; b=O5Pv3YB3W+V997mRgn/c+n1Xty6PcfouPuN3aCCd+dGs40rP70+BwKaZe+8oHBDx3N5mDRvUf6iRqAivFIy3RyBPyOptKlB/B5eLNbdDY9n2GRIcmNRSGXwusrEh2/zRipA1ovgmPxlDrNb4NrcYPqst4wN5RdzIaIuDs6lKncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736370; c=relaxed/simple;
	bh=xQxrsyLimTBBhuBkH5zMty0TTj6jJd21W4ZD7XIL/Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfhZwSMVnxjgyfpQO5T17yID5MKpJgzPIwIqCRm4NQcyHMmLGDS4ILnzGR9w8vUjUOUGU/st3dPlpEzmk0RFY/thVituxILJqPc8aRlB8gJSD0hnZyX9dkpPFvkF7nN3YANOZbO2/GKUkm8rrm3usXfrg8y3XuB4YQzwQ+SXZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QQ/MC2Ej; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QQ/MC2Ej"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709736358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=irTbhX8jylQGDx+QGghLwQBRXMhhTmPPfVTLm6p6CMA=;
	b=QQ/MC2EjRXB0pzzP3HSjWZIaRDUnkZ8SMRKgHv9ZLvc0fbwHsaAOJLoE5k68PeyA8Ag1MDdoyV8xZTDCzDSLHzzpSP1THfnnYudaAh+A4RJE1k8Li5cGGrXtKGDHCAjd/F8lmn2a81X4UUecVVlZBs1feIhLj354cxuJh2tfxdE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1xslOR_1709736356;
Received: from 30.39.163.71(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W1xslOR_1709736356)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 22:45:57 +0800
Message-ID: <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
Date: Wed, 6 Mar 2024 22:45:56 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
To: Dmitry Antipov <dmantipov@yandex.ru>,
 "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jaka@linux.ibm.com" <jaka@linux.ibm.com>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
 <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/5 00:35, Dmitry Antipov wrote:
> On 2/23/24 06:36, Wen Gu wrote:
> 
>> One solution to this issue I can think of is to check whether
>> filp->private_data has been changed when the sock_fasync holds the sock lock,
>> but it inevitably changes the general code..
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index ed3df2f749bf..a28435195854 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -1443,6 +1443,11 @@ static int sock_fasync(int fd, struct file *filp, int on)
>>                  return -EINVAL;
>>
>>          lock_sock(sk);
>> +       /* filp->private_data has changed */
>> +       if (on && unlikely(sock != filp->private_data)) {
>> +               release_sock(sk);
>> +               return -EAGAIN;
>> +       }
>>          fasync_helper(fd, filp, on, &wq->fasync_list);
>>
>>          if (!wq->fasync_list)
>>
>> Let's see if anyone else has a better idea.
> 
> IIUC this is not a solution just because it decreases the probability of the race
> but doesn't eliminate it completely - an underlying socket switch (e.g. changing
> 'filp->private_data') may happen when 'fasync_helper()' is in progress.
> 
Hi Dmitry,

IIUC, the fallback (or more precisely the private_data change) essentially
always happens when the lock_sock(smc->sk) is held, except in smc_listen_work()
or smc_listen_decline(), but at that moment, userspace program can not yet
acquire this new socket to add fasync entries to the fasync_list.

So IMHO, the above patch should work, since it checks the private_data under
the lock_sock(sk). But if I missed something, please correct me.

And I wonder if you can still see the leak with the patch above through
your reproducer or syzbot's reproducer? I once ran your reproducer for about
50 mins and didn't see the leak.

Thanks!

> Dmitry
> 
> 

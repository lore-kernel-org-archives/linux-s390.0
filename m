Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0EE574;
	Wed, 27 Mar 2024 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711519967; cv=none; b=e9En+TbtdLMHG0EKyUwDmiBUdNmwJUWqDzFoehJsi8lhYNeb204gYFHoeMwN8tYilr8a8gVas+/H3l9kXKnt8W6qGrZ6CYJhqLwYL5dmC1uEkTeaN3B0k5gZx2zM0mj43Of1TB+rnVSYDRmucdeiMvOgv/qSICSAXntzix6fr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711519967; c=relaxed/simple;
	bh=FRN4FGEIXxZqMd9Dxbhy8xlh5SUrt4ZT8yCX4Xe/6nk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fMBcx61v3k4QxBnfihlpewKBHwXIYW1kgTYAC1YFl9jqVP+q+6bh+R0zh+5tDJJKwR+U5JXL05NdQm92BiiU6fdNuVTQMZhowNZe2hAx2TxJ7MStf0aMHDlhJix2bQckMkB8j7C+S7vWYTgumqaDskC1WYYyJxFcpuANbbOSOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b4clgp7R; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b4clgp7R"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711519954; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=w//wBJx0dmNDGEW+UAQSP0xfh5NfZViFFDaWBKW7THg=;
	b=b4clgp7R187dooEoNB2HjtzZ0p9Z16XVrIDlIhBc07Mq4oArbhRwdQDYYj5lf2RjBI/3GFczS20wTAh0wtm/IiWJEgc08rMAHOj87MKqtIGLnP3/FAHJfSyrn42JhMJsz/Y4hIBJRLyq9MJ4TTwaU0X2eFMc6MJpPtuyqVHJcqE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3NhBAT_1711519944;
Received: from 30.221.131.6(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3NhBAT_1711519944)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 14:12:34 +0800
Message-ID: <3045529a-11a3-421d-8da3-94788f12f6f4@linux.alibaba.com>
Date: Wed, 27 Mar 2024 14:12:24 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
To: "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>,
 "gbayer@linux.ibm.com" <gbayer@linux.ibm.com>,
 "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>,
 "jaka@linux.ibm.com" <jaka@linux.ibm.com>
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "Shvetsov, Alexander" <Alexander.Shvetsov@softline.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
 <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
 <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
 <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
 <93077cee-b81a-4690-9aa8-cc954f9be902@linux.ibm.com>
 <4a65f2f04d502a770627ccaacd099fd6a9d7f43a.camel@softline.com>
 <941b129e87fec6b2f22ed3bc75334bd8515565a1.camel@softline.com>
In-Reply-To: <941b129e87fec6b2f22ed3bc75334bd8515565a1.camel@softline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/26 16:18, Antipov, Dmitriy wrote:
> On Thu, 2024-03-07 at 13:21 +0300, Dmitry Antipov wrote:
> 
>> On Thu, 2024-03-07 at 10:57 +0100, Jan Karcher wrote:
>>
>>> We think it might be an option to secure the path in this function with
>>> the smc->clcsock_release_lock.
>>>
>>> ```
>>> 	lock_sock(&smc->sk);
>>> 	if (smc->use_fallback) {
>>> 		if (!smc->clcsock) {
>>> 			release_sock(&smc->sk);
>>> 			return -EBADF;
>>> 		}
>>> +		mutex_lock(&smc->clcsock_release_lock);
>>> 		answ = smc->clcsock->ops->ioctl(smc->clcsock, cmd, arg);
>>> +		mutex_unlock(&smc->clcsock_release_lock);
>>> 		release_sock(&smc->sk);
>>> 		return answ;
>>> 	}
>>> ```
>>>
>>> What do yo think about this?
>>
>> You're trying to fix it on the wrong path. FIOASYNC is a generic rather
>> than protocol-specific thing. So userspace 'ioctl(sock, FIOASYNC, [])'
>> call is handled with:
>>
>> -> sys_ioctl()
>>    -> do_vfs_ioctl()
>>      -> ioctl_fioasync()
>>        -> filp->f_op->fasync() (which is sock_fasync() for all sockets)
>>
>> rather than 'sock->ops->ioctl(...)'.
> 
> Any progress on this?

Hi Dmitry,

In my opinion, first we need to figure out what the root cause(race) of this leak is.
I am not very convinced about your analysis[1] and gave some my thoughts about it[2].
I would appreciate if you give your response about that to make this issue clearer and
get everyone on the same page (including SMC maintainers). Then we can see if your other
proposal[3] is a proper solution to the issue or if anyone has a better idea.

[1] https://lore.kernel.org/netdev/35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru/
[2] https://lore.kernel.org/netdev/a88a0731-6cbe-4987-b1e9-afa51f9ab057@linux.alibaba.com/
[3] https://lore.kernel.org/netdev/625c9519-7ae6-43a3-a5d0-81164ad7fd0e@yandex.ru/

Thanks.

> 
> Dmitry
> 

Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFB225D9;
	Wed,  5 Jun 2024 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717567293; cv=none; b=fGUxUmBNJ4gO20gPi9HdUMYhHkSJ4CbPICsuHH1R0FXNL713X0n8Aiwp5VKw21qybhT4G6ZfrS/tNyb4UB/b9C/uqJlp9+8q7YXN5pEIqAupfRX0fmV2wDjBFjJI1+stXP4tRG6b9ApGvy+MmU4dVdn4/htfAr8rIm0L/3fsB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717567293; c=relaxed/simple;
	bh=kspRoPiqT+60w/910CphqXYKi5/A7+b0R+YvgoUpxZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLXKgmW/eslF6jbeLaWu8Q/rH+MK7sFMZoXhbyvVajyw5IU7/QpOEm6ukI0uQ9d+gbTu6kfpOQocuUG5svhdDcYguQclHCnDS2K9AZC1rNwtbvWbMO2axYS77/5zK0TAh4w13CFLTOqm4vXOwHafP+g/m36ZJbfb1pn9xwgEvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=St/YVqDJ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="St/YVqDJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717567282; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7770HT+DXXn2uXZuUaw8VKFeHVqNBA2X1DYZ7hOedW8=;
	b=St/YVqDJe1lhFH2rmcg3mHt8YDInlq7ToOb77QOwpq3qha8rbSTPWt1yytlsMaWF//NmIVJcgVUe3Wdk1BrUdyiNxCFeW3JgV5nq9brwnbwDto8FsIxN6JoqLJHaMSY7gfRQkK8CvtKGSo61y9FCYJcnb4wensfOsqMfprcF8x8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7t4AJs_1717567280;
Received: from 30.221.129.197(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W7t4AJs_1717567280)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 14:01:21 +0800
Message-ID: <1884a3ff-1a1a-419c-b474-4d37bf760a77@linux.alibaba.com>
Date: Wed, 5 Jun 2024 14:01:20 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: avoid overwriting when adjusting sock
 bufsizes
To: Gerd Bayer <gbayer@linux.ibm.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240531085417.43104-1-guwen@linux.alibaba.com>
 <cc606c7b6fb53d00d80122b987c94bd7cb385af0.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <cc606c7b6fb53d00d80122b987c94bd7cb385af0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/5 00:16, Gerd Bayer wrote:
> Hi Wen Gu,
> 
> sorry for the late reply, I'm just catching up after a bit of a
> vacation.

No worries at all, I hope you had a great vacation!

> 
> On Fri, 2024-05-31 at 16:54 +0800, Wen Gu wrote:
>> When copying smc settings to clcsock, avoid setting clcsock's
>> sk_sndbuf to sysctl_tcp_wmem[1], since this may overwrite the value
>> set by tcp_sndbuf_expand() in TCP connection establishment.
>>
>> And the other setting sk_{snd|rcv}buf to sysctl value in
>> smc_adjust_sock_bufsizes() can also be omitted since the
>> initialization of smc sock and clcsock has set sk_{snd|rcv}buf to
>> smc.sysctl_{w|r}mem or ipv4_sysctl_tcp_{w|r}mem[1].
>>
>> Fixes: 30c3c4a4497c ("net/smc: Use correct buffer sizes when
>> switching between TCP and SMC")
>> Link:
>> https://lore.kernel.org/r/5eaf3858-e7fd-4db8-83e8-3d7a3e0e9ae2@linux.alibaba.com
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>> FYI,
>> The detailed motivation and testing can be found in the link above.
>> ---

<...>

> 
> As Wenjia already said, we've discussed this a bit.
> As I remember, I've added the sections to copy over the sysctl values
> as a "safety measure" when moving between smc/clc sockets - but had the
> wrong assumption in mind that e.g. in a fall-back a new TCP handshake
> would be done. Apparently, we didn't test the buffer size behavior in
> these scenarios enough to notice the "weird" behavior.
> 
> So we reviewed your initial report of the oddity per your message in
> the link above, too.
> 
> We fully agree that if no connection at the SMC level could be
> established, you should expect the socket buffersizes be used that had
> been established for the TCP connection - regardless if the fallback is
> due to the server or the client.
> 
> So feel free to add my
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>, too.
> 

Hi, Gerd and Wenjia. Thanks a lot for your confirmation.

And as for the last question in the initial report (link above), that
why the server does not call smc_copy_sock_settings_to_clc() like the
client when fallback happens, I guess it is because at the time that
server fallback, the new_smc sock has not been accepted, so there will
be no user's sock settings that needs to be copied to clcsock.

Thanks!

> Thanks,
> Gerd

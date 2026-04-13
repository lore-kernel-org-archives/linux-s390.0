Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9C3B19C1;
	Mon, 13 Apr 2026 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070883; cv=none; b=r4n1gDKNCiJFHJFwPMAQEekbZmYXnm+GBTEKdCEqy5VzqpAX+gbupFgun2YK0cUD9rT25etRzsV9YVAaUbOOIPEgvN9uKGP4NJIk4LmVSBzHg/nxlfKcDV7ypU2z+pj8YZTdLaODQB/JJtKetjrtb0wp82qxN523VvK1on/K7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070883; c=relaxed/simple;
	bh=eCNCtevYEOlPtIptnPSP7ZQ9h2nwal4iPtHtMoAwGU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXspRf07wkmG4P7MKffKr0uoeXHlBXe8LJIsk4zSw9yyw3QJ65SGcCJhhO+3LbMniBRKS4V+eMrehdU3fUroYHobNh/T+eUcVT1NU8I7C8+YcU3bTmR/D0KxzlJmptuWwP4jBtX1Gpo3I9IbXXvAEqsqiaJC5ozHdXdg6xiInOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ngA2INhY; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ngA2INhY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776070862; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Vak/yNZkX1L19eiRMLdMkGIWdQKJS64W1r1PP0NrJzo=;
	b=ngA2INhYVkGP3c2GcU5ibOYpJvvqANAvqKQoFVa+TdvngIjfN2wbxeaWKRzU1NY9jF+LFwDN/81TThQDRlAIemx+8H4FEtTsFUy/CCI24V1xE4F0YfW9ttWla8gGE76oijd7OXnpdNJowi3wc774YVr7y2ZskJZiAP3GyQ/UK7g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X0ubecx_1776070848;
Received: from 30.221.146.26(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X0ubecx_1776070848 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Apr 2026 17:00:59 +0800
Message-ID: <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
Date: Mon, 13 Apr 2026 17:00:48 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
To: Jakub Kicinski <kuba@kernel.org>, David Woodhouse <dwmw2@infradead.org>
Cc: tglx@kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jstultz@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, daniel.lezcano@kernel.org,
 sboyd@kernel.org, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
 <20260407104802.34429-3-guwen@linux.alibaba.com>
 <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20260412095301.4fe1fe65@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/4/13 00:53, Jakub Kicinski wrote:
> On Sun, 12 Apr 2026 17:32:22 +0100 David Woodhouse wrote:
>> On 12 April 2026 16:47:04 BST, Jakub Kicinski <kuba@kernel.org> wrote:
>>> On Tue,  7 Apr 2026 18:48:02 +0800 Wen Gu wrote:
>>>> +PTP EMULATED CLOCK SUPPORT
>>>> +M:	David Woodhouse <dwmw2@infradead.org>
>>>> +M:	Wen Gu <guwen@linux.alibaba.com>
>>>> +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> +L:	linux-kernel@vger.kernel.org
>>>> +S:	Maintained
>>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>>>
>>> Hi David,
>>>
>>> Do you have a tree to route the patches thru? Or do you really have
>>> access to the tip tree?
>>
>> I do not have access to the tip tree. I can make a shared tree on
>> git.infradead.org if the other two maintainers would like to send me
>> a SSH pubkey and preferred username...
> 
> Honestly I'd love for you to be the only M here, and the other two
> to be reviewers. Xuan Zhuo is currently at v40 trying to upstream
> an Ethernet driver. Some growth needed there to become a subsystem
> maintainer IMO.

Hi Jakub, David,

That works for us. We can act as reviewers.

If David sets up a new tree, I will update the MAINTAINERS entry
accordingly in v3.

Thanks.

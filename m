Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A237EFEE;
	Tue,  2 Jun 2026 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390313; cv=none; b=Fayl8HJIjbk08wYU9XzRIM/NN/5Y/nkbd/xBJ7Us8u7jXEKTGpZ7yNBkxd8ejCeG7YEz3XZYUCc+vrc5coB9LqdVT/SLCdoCY9acUlIYWf9/SrKiADBsiJTtX3k5bIdHVp5s5k7/eHeV9zSg4CcUdvlbiAxiQFS/hajywB42gR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390313; c=relaxed/simple;
	bh=lckzWpKm7tjsN3aBVHxq7DUSFbeMQmN8zXr083i/qFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnV8vVOaQdyMM2Z4OsuouqtVtBdvQ3ORnN8mcnsn6YPtWjwa5i4XEODpyyI+GoNMawXEpxZVXNz2guEMSyCH8aNekv6cUVpMR/LIXfNlQM3QXYDZGl15JCUiLRQQ1OU4FjIyKfuRYISGsTP97B9+3Ny3pYkHStD9b3P6/75ZA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w8FyjZln; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w8FyjZln"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780390308; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lMVE6WF7j9WLQW0DFwqLpY1Wg7pA22gZy4norUCwY8w=;
	b=w8FyjZlnr4tRGFw/MfpTGZkmDtMF5ISgVk9iu5V79zueLwgeV3uTAKEEYKdzuJSsrEr4K0oTiXBR9TSXHMl+bXs3gCgptbqF4Ppl2A71g0PBY/pdyjW6Xt5AmfPTXqLHN/9VjWPxhQagBmv2xboLO1bpSy96e56ZDqmRA21yaWo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X4423aB_1780390304;
Received: from 30.221.129.226(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X4423aB_1780390304 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 16:51:46 +0800
Message-ID: <01aef88e-8d0a-4ea4-b8ce-952259ce0bc8@linux.alibaba.com>
Date: Tue, 2 Jun 2026 16:51:44 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, tglx@kernel.org, andrew+netdev@lunn.ch,
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
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
 <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
 <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
 <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
 <0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/6/2 00:53, David Woodhouse wrote:
> On Mon, 2026-06-01 at 08:20 -0700, Richard Cochran wrote:
>> On Mon, Jun 01, 2026 at 08:03:26AM +0100, David Woodhouse wrote:
>>> If we move all the plain non-network PHC drivers (which, as noted,
>>> is
>>> basically *all* of them) into a drivers/ subdirectory, then perhaps
>>> we
>>
>> Sorry, just catching up here, so the idea is to have
>>
>>   linux/drivers/ptp/drivers  ?
> 
> That is my current suggestion.
> 
> It stems from Jakub's response in
> https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/ that "I
> really wish someone stepped up and created a separate subsystem for all
> these cloud / vm clocks. They have nothing to do with PTP."
> 
> There was some further bikeshedding in
> https://lore.kernel.org/netdev/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com/
> around how to split 'emulated' from other hardware drivers, but I don't
> much like that taxonomy. Some of these "virtual" clocks could just as
> easily exist in hardware with PTM too.
> 
> My observation is that with the sole exception of ptp_inet.c, *all* of
> the actual PHC drivers that live in drivers/ptp instead of drivers/net
> are "pure clock" drivers, so perhaps we split those all out into
> drivers/ptp/drivers/ and exclude them from the netdev maintenance?
> 

I think we don't need to split out all of them. The motivation was
to find an appropriate home for the PHC drivers that are read-only
and not disciplined by the host (ptp_vmw, ptp_vmclock, ptp_s390 and
the newly proposed ptp_cipu); they have little to do with networking.
The others are adjustable and tied to the network synchronization
stack (e.g. ptp4l); netdev is the right home for them.

My view is similar to Jakub's: the dividing line is whether the clock
provides authoritative time to the host and does not need to be
disciplined by it.

   Class A -- stays under netdev:
   - has its own physical counter/oscillator;
   - is adjustable (adjfine/adjtime/settime).

   Class B -- to be split out:
   - its time is maintained by an external source (hypervisor, DPU/IPU,
     or platform/arch);
   - the host side can only read it, not adjust it.

I will also adjust the relevant wording in the patch set accordingly,
dropping terms such as "non-NIC", "networking" and "IEEE 1588".

On the category name: the drivers we are splitting out only
provide time readout and do not support host discipline -- they behave
like a partial PHC. From that angle I think 'emulated' is defensible,
but I am also open to a better alternative.

> I'm reluctantly prepared to host and help maintain a drivers tree if
> it's necessary, but equally as happy to let you own it.
> 
> 

Thanks.

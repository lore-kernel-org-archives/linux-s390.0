Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5D23EA93;
	Tue, 17 Mar 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713574; cv=none; b=WZJyA7SaAB0rW9rg7VQmC/gU3b2aIUnb2nrP6DaMOzBanb8IqgFunc0SlqIXomrGKohsrBLJfbcsaJduZVrdhCfmbGyppCoOyLwXvQDxVpDGZA+wTkvT2Vz9auzSM+YgL8xC1caPnBMitKIKk2/0/+DSslm/TRsENDjM+lyiZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713574; c=relaxed/simple;
	bh=ZkomifTMTN7ZG/e5DBjrxlwrOm0ocoDJK/lAGRPbLkQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s7Wn0A2RNR7q4i2LsUpAeNNlTYlU33Ca/xW16wCpa8n8BCrJFBdIq6McR90ch6fl91/NPI7Yb6YRAlUy4XMNd/n7qAucMZroQNVliOEQlT1a2udSYF1gYQiFdXZTZwZvFDePZoGeXkSYhDMc3/57Eb2q0Qd6LeF4OJdti2dFTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JiO/MD/M; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JiO/MD/M"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773713569; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=25qRNyQtBw74MmNrl61kNkSF5nCwMJK0RbQdwmstsfA=;
	b=JiO/MD/MjvdPoigGei8y0PftucxSIci3odpsu48sUQ498Lesb+DCWZH4tc6Icsab38DexGm8zLu4dOx6MX7susYiMDblL+huTGo4S+oLSD6UyS1ghkcil8TNoStNRwDanlv+/odJeX7nNKLflcJz30pDNcZMoyHk523CZxvNBBU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0X.9KFWD_1773713557;
Received: from 30.221.130.125(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X.9KFWD_1773713557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 10:12:46 +0800
Message-ID: <78489ff1-c2fa-47dc-beb4-54e9410f7d5c@linux.alibaba.com>
Date: Tue, 17 Mar 2026 10:12:37 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to
 clock/timekeeping maintainership
From: Wen Gu <guwen@linux.alibaba.com>
To: David Woodhouse <dwmw2@infradead.org>, tglx@kernel.org,
 tglx@linutronix.de, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 mani@kernel.org, imran.shaik@oss.qualcomm.com,
 John Stultz <jstultz@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,
 svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org,
 dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 taniya.das@oss.qualcomm.com
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
 <be4c63a8dc43be15576565b4bd4567b3cf433d58.camel@infradead.org>
 <4a9af4b1-6820-4173-8daf-4201bb1bcca5@linux.alibaba.com>
In-Reply-To: <4a9af4b1-6820-4173-8daf-4201bb1bcca5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/2/27 20:25, Wen Gu wrote:
> 
> 
> On 2026/2/27 18:25, David Woodhouse wrote:
>> On Fri, 2026-02-27 at 16:19 +0800, Wen Gu wrote:
>>>
>>> # Request for comments
>>>
>>> 1. Following the clocksource/timekeeping and POSIX timer areas, this RFC routes
>>> changes for drivers/ptp/emulated/ to linux-kernel@vger.kernel.org (rather than
>>> netdev). However, the preferred integration path is still unclear (e.g. which
>>> tree should take such changes, and who should collect/pull them for merging). We
>>> would really appreciate guidance from the time/clock maintainers, especially any
>>> input from Thomas Gleixner, on the preferred tree/workflow for these changes.
>>>
>>> 2. This RFC currently lists us as the maintainers for drivers/ptp/emulated/ as a
>>> fallback contact point. Ideally, we would prefer this area to be maintained by
>>> clock/time experts in the long run. Suggestions on more suitable maintainers are
>>> very welcome.
>>
>> I'm happy to be involved too.
> 
> Thanks, David. It would be great to have you involved. Would you be willing to
> be listed in MAINTAINERS for drivers/ptp/emulated/?

Hi David,

Just following up in case this got lost in the thread.

You mentioned earlier that you'd be happy to be involved, so I wanted to
check whether you'd be comfortable being listed as a co-maintainer.

Thanks!

> 
> Regards.

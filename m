Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCD39F16E;
	Tue, 24 Mar 2026 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774324003; cv=none; b=M/4ocim4/5PVw79XmXm8xsTnLfQGKrGUaGUEib+ejkHJ96oD1CYwjiwJWBtRwiUuzPa45Q7BiG1F3Jer8mm0A8P5rac8r+jt+8i44O6tVzTYlDdqonth+6chMQNsKIrqzz7tx8lP9zObEVUT1SoFTYRV+yj0UtfkKMJaIraQhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774324003; c=relaxed/simple;
	bh=0PeVMEi1xnjHxw1FfnRAZZSarRt0/Dtbi/3bueBnvaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWb119oBtrFidFxbbmaEJwyC/lQyQRaVbpnyahJGUBlZITNFBZfyNvfGIJIS5XMWw+ojF3bxnT04thMXBohGZTD1Ic9vriMDPExzJB6KWnOSGJRfY/fnihHq8DJn41pIpkxLydkehfmXmcj8RzFfQmGTX19snu9kGSUYyFcd4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W8dBdgZZ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W8dBdgZZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774323997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gfj9pH9HdFGubioadCjBnLlcB4bnm19iAov+QtWe4RQ=;
	b=W8dBdgZZiD7sit7t3UzflEUwM7kzolxg35RLo84TqrIlkiZseML80/1dP1YdYcRjjoNKsbE4oXCw8pJAec33VGZ60HCJ+4J0CDmB9F/HTiOt7cYA3UKyhv4cIKBZjZgj1LSrIgXaaO/d53kIrXmQJy624hyWPzsbzDrJnWIF7w8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0X.d9ZI5_1774323994;
Received: from 30.221.131.145(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X.d9ZI5_1774323994 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 11:46:35 +0800
Message-ID: <025b7816-ca8e-4cea-bb84-bf324c8c3b22@linux.alibaba.com>
Date: Tue, 24 Mar 2026 11:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
To: Jakub Kicinski <kuba@kernel.org>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com,
 dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org,
 dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mani@kernel.org,
 imran.shaik@oss.qualcomm.com, taniya.das@oss.qualcomm.com
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
 <20260318073330.115808-3-guwen@linux.alibaba.com>
 <20260323192232.3a5205dc@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20260323192232.3a5205dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/24 10:22, Jakub Kicinski wrote:
> On Wed, 18 Mar 2026 15:33:30 +0800 Wen Gu wrote:
>> +PTP EMULATED CLOCK SUPPORT
>> +M:	Wen Gu <guwen@linux.alibaba.com>
>> +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> +L:	linux-kernel@vger.kernel.org
>> +S:	Maintained
> 
> I thought David W was supposed to be the main maintainer?
> Two moderately known developers from a single vendor/company
> is not enough to delegate this IMO.


Thanks for pointing this out.

We would also very much prefer for this area to be maintained
by people with deeper expertise in the clock/timekeeping domain
(such as David). The reason David was not listed in this version
is that an earlier attempt to ask about maintainership did not
receive a reply[1]. So we avoided adding without confirmation.

If David has no objections to being listed here, that would
definitely be preferable from our perspective. Other suggested
clock/timekeeping experts would also be very welcome.

[1] https://lore.kernel.org/all/78489ff1-c2fa-47dc-beb4-54e9410f7d5c@linux.alibaba.com/

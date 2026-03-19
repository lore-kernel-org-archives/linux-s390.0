Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F561A680A;
	Thu, 19 Mar 2026 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899388; cv=none; b=KKVqOcuqSbaux6ZdV64ZTHF+MdESD2RE7E7U/cJyvGlIoT9X3uEyFxyd8YsCB9D7YMB7DrPK+lmtStqcn6nWmwGVJ5/n/0NtDpk1NXLKdeE3SV+bmbVtfgQbtL67TpZBbd/XVG+c2tjI1tFyhK5TuPQxxybqkiS8PMaxxbxaWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899388; c=relaxed/simple;
	bh=2430zI9n334JkBj/TpnuTxA+jHhEUJVfLFav+xDkV6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAeqQtfpuILLaDv6m4oLxcTpxi7x2VWivCdr8gyNzMirfT0dZ4GDGbb40v5O4wq52SUC5kHKP3IlDgkz0njiUf6uREb53vrQ3n0ZJwosOhc9Ynx+WSyTRDvY8zKpekSQ/iUxnMyNGDm8IPmW4OFO+coFfddYRzVwS298iwvEYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TIxlZbm2; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TIxlZbm2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773899377; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Tj5vFVo8hvmkvdXB4Ef9ZyPku2Xx9xcDbTU8B8mwD7o=;
	b=TIxlZbm2XUL3W/PLwNRLkLwES1mWe3KKgJHH8G5/muP6hh6ZmVnAdyd/x6LbVeyATiaOxIcJWdjmD/Y9H5V1Kt/mm14lhjIGX/kYGTAmSTEqGQsWRXBbG1kTcnvHkOZPrLhmRmq+KF0pYUGtII1uDR4dTunor1RzcG7xe1PN97w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0X.HFnoa_1773899374;
Received: from 30.221.130.238(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X.HFnoa_1773899374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 13:49:35 +0800
Message-ID: <1919ef7e-1cff-4f52-873a-61ffe0000728@linux.alibaba.com>
Date: Thu, 19 Mar 2026 13:49:32 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ptp: split non-NIC PHC drivers into the
 clock/timekeeping maintenance domain
To: John Stultz <jstultz@google.com>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com,
 dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org,
 dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mani@kernel.org,
 imran.shaik@oss.qualcomm.com, taniya.das@oss.qualcomm.com
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
 <CANDhNCoFxsXdP7d6nbLTFLOrB_4GnDvhF4O6ZGyvGEVoqV4U2g@mail.gmail.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <CANDhNCoFxsXdP7d6nbLTFLOrB_4GnDvhF4O6ZGyvGEVoqV4U2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/3/19 01:05, John Stultz wrote:
> On Wed, Mar 18, 2026 at 12:33 AM Wen Gu <guwen@linux.alibaba.com> wrote:
>> - Following the model used by NTP related code, this series lists tip.git
>>    (timers/core) as the integration tree for emulated PTP clocks in the
>>    MAINTAINERS entry. Guidance from clock/timekeeping maintainers
>>    (Thomas Gleixner, John Stultz, Anna-Maria Behnsen, Frederic Weisbecker,
>>    Daniel Lezcano, Stephen Boyd) on whether this is the appropriate workflow
>>    for this class of drivers would be appreciated.
> 
> While I'm sure it would be good to continue to CC folks, I'm not sure
> if the timekeeping maintainers would be the right folks for these
> driver/ptp/ changes to flow through.
> Thomas has been doing the heavy lifting for a long while and I'd not
> want to put more on his shoulders.
> 
> Richard is listed as the maintainer for drivers/ptp/, is there any
> reason for it not to go through him?
> 
> thanks
> -john

Hi John,

Thanks a lot for the feedback.

Richard is indeed listed as the maintainer for the PTP subsystem and
the traditional network-oriented PHC drivers. The intention of this
series is not to bypass that role. I would very much welcome Richard's
thoughts on the proposed split and the appropriate workflow for these
drivers.

Historically the PTP subsystem lived under networking because the
original PHC devices were tightly coupled with NIC hardware and the
IEEE1588 packet timestamping pipeline.

Over time, however, the PTP userspace interface (/dev/ptpX together
with the PTP_* ioctls) has also become a widely used way to expose
high-precision clocks to userspace. Because of the stable interface
and the existing ecosystem (e.g. chrony, phc2sys), many platform or
virtualization-provided clocks have started reusing the same PTP
interface.

As a result, drivers/ptp/ now contains two different classes of
devices: traditional network-oriented PHC drivers and clocks which
are not tied to the IEEE1588 networking pipeline.

The difficulty today is that there is no very clear upstream path for
this class of drivers: they currently live under drivers/ptp/, but
their design and review concerns are often closer to clock/timekeeping
topics than to networking. This series tries to find a clearer
upstream path and review route for this class of drivers.

Regarding the merge path, the suggestion about tip.git was mainly an
attempt to identify a possible integration tree for these drivers, but
I'm open to suggestions if there is a better workflow.

Thanks again for taking a look.

Wen Gu

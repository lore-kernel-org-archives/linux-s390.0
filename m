Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439D3ECBC3;
	Fri, 27 Feb 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195119; cv=none; b=p1O44XsK+b0GDpouZ+EHjwVJXQU1RJHr/9qdcHKN1cSauhRbTMwzMSINX8VWxED6hnJx0HWZPKvGXukEwgl+kb4CEJHR4gSCn2qEoC0DfGwyhXIRrxkqLGktSBpMm7AqHvPWBf9omdl1tq5dx7AToMCfU5CPFeYpfcByR5E0olI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195119; c=relaxed/simple;
	bh=6v/LnHgifM1xkyYcS9H8qLXNafJwo9ow+LfRZalgBfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfVWtALUu+nN08QqaVwADlgL44CiR42vJDpOCRse1fbDEcKl2Ye19A6H3pmG3CEuVMBj+JljLea+P5skiAi7CdsMCFjkH0mB94cIFIZVreFOJTlAwkMM3P2DpJyRSWCBpKUYq68ZyeRXnX8lMOa1Nvoa+Y7JXTyX2416BiRSz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CRuEr3JM; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CRuEr3JM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772195114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y+2zUoGEZCz6y7wbpFdG8NpN7dLYx9L0ruHzbWaDWx4=;
	b=CRuEr3JMRLbyQoxrTbDRmOmgpzEQpIqQwPCAp++vHPbZa7t7oq9uE6d5u0dYhMWyK1DDIul0iAbqZTE+ZatVEVW8nYxPdX+JmGVoMq7iw8dLBfci7s+/0jVPZnua7r31iC6QBIQu9mRyPyHQ5dySYP4EO/hU3bu7j3Cm5No2Xuc=
Received: from 30.221.130.102(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WzuNAu2_1772195111 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 20:25:13 +0800
Message-ID: <4a9af4b1-6820-4173-8daf-4201bb1bcca5@linux.alibaba.com>
Date: Fri, 27 Feb 2026 20:25:11 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to
 clock/timekeeping maintainership
To: David Woodhouse <dwmw2@infradead.org>, tglx@kernel.org,
 tglx@linutronix.de, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 mani@kernel.org, imran.shaik@oss.qualcomm.com
Cc: vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,
 svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org,
 dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 taniya.das@oss.qualcomm.com
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
 <be4c63a8dc43be15576565b4bd4567b3cf433d58.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <be4c63a8dc43be15576565b4bd4567b3cf433d58.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/2/27 18:25, David Woodhouse wrote:
> On Fri, 2026-02-27 at 16:19 +0800, Wen Gu wrote:
>>
>> Patch 1 performs the refactor: move drivers and split Kconfig/Makefiles
>> accordingly, without intended functional changes.
>>
>> Patch 2 updates MAINTAINERS to match the new layout and adds a dedicated entry
>> for drivers/ptp/emulated/, moving review and ownership routing for this class
>> of drivers away from the netdev maintainership.
>>
>> No userspace ABI changes are intended, this is a refactor and maintenance
>> metadata update only.
> 
> While no ABI changes are intended in *this* patch series, we do need
> some.
> 
> These 'emulated' clocks mostly exist not to emulate IEEE1588 per se,
> but as a way to provide a precision real time clock to systems
> (especially virtual guests).
> 
> We have already discussed the need to expose clock error bounds, and to
> expose paired timestamps against the actual hardware counter (TSC, arch
> counter, timebase, etc.).
> 
> Another key difference is that we'll generally want to be able to
> derive UTC from these clocks, and feed them directly into the kernel's
> CLOCK_REALTIME.
> 
> I don't have strong views on whether we extend the /dev/ptpX userspace
> ABI, or start to treat these 'emulated' clocks as a class of device in
> their own right and just shim them to /dev/ptpX for compatibility.
> 

As mentioned in RFC v1, the use cases for drivers in the emulated PHC category
are expected to be quite diverse, and not limited to the virtualization/guest
time sync use case. For example, existing drivers such as ptp_ocp [1] and
upcoming ones such as mhi_phc [2] are not related to virtualization use cases.

The main motivation for this RFC is to find a clear in-tree home, upstreaming
path, and review/maintainership model for PHC/PTP drivers that use the existing
PTP userspace interface, but are not based on the IEEE 1588/network packet
timestamping pipeline, both for those already in the tree and for future
additions.

For virtualization-specific extensions (e.g. additional capabilities or ABI
changes), I agree they are valuable, but I think they are outside the scope of
this RFC series.

[1] https://lore.kernel.org/netdev/c85c77bc-9a8c-4336-ab79-89a981c43e01@linux.dev/
[2] https://lore.kernel.org/mhi/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/

>> # Request for comments
>>
>> 1. Following the clocksource/timekeeping and POSIX timer areas, this RFC routes
>> changes for drivers/ptp/emulated/ to linux-kernel@vger.kernel.org (rather than
>> netdev). However, the preferred integration path is still unclear (e.g. which
>> tree should take such changes, and who should collect/pull them for merging). We
>> would really appreciate guidance from the time/clock maintainers, especially any
>> input from Thomas Gleixner, on the preferred tree/workflow for these changes.
>>
>> 2. This RFC currently lists us as the maintainers for drivers/ptp/emulated/ as a
>> fallback contact point. Ideally, we would prefer this area to be maintained by
>> clock/time experts in the long run. Suggestions on more suitable maintainers are
>> very welcome.
> 
> I'm happy to be involved too.

Thanks, David. It would be great to have you involved. Would you be willing to
be listed in MAINTAINERS for drivers/ptp/emulated/?

Regards.

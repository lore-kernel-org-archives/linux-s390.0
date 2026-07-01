Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717D3BC687;
	Wed,  1 Jul 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907734; cv=none; b=M0CcDSRpbBIvUqLXBXHWIGaIn146zjptAd676OeaosHyY/hN3dTWeNymXPImE+mmV48lOdxymz77I72VOC8jk1XBLpujTrQnn/PYvA6vWYgj+gd/lS8r8ZWKv/wwpnbF70rBLp+04puraeOj0NJBxlxEK4KZCsx0bZ8ik+7DGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907734; c=relaxed/simple;
	bh=aW9OpH0bfWHMJsyxLEWPWr3FrY/QtwnB1r0vOhs8WO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv5RWoyVcx60GstcqXqHnC0IVqw5WfEcbW7A1JdPvKqEIxUstHdJ93eRHHBA07eUOebR7nriMGnGfOv8aF4jD635PzJCWigThNqsrN7wfO/pnIR66wAwk5PDH4PLQBApkYqRazMP0nPIj9zw2ES1y03V1vvQAsXeLQ5k6NNkb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qNiLJofF; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qNiLJofF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782907723; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hYNTn3LzwKliHTHWmAhNtZujz254oBwDLqzBpRDvS7k=;
	b=qNiLJofFxvQXCjKKUr/iFBX7m84cDhEeVFHeyA4jjbH0FUWlTFb0WVhRvBV25o03gIyR1yZPmGgBtVgzpfhAQ7ws2gCSdxt+w/PvkSJrGPYJzFjGHtIYng3HA9DVqu8w/Jo1woaG7SOFMJ1QkXm9PgEhAyt/CUyEoey8Tj1IPMo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X68SeK9_1782907711;
Received: from 30.221.129.218(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X68SeK9_1782907711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Jul 2026 20:08:41 +0800
Message-ID: <1d250249-78bd-4df5-9312-4ee64340ea97@linux.alibaba.com>
Date: Wed, 1 Jul 2026 20:08:30 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] ptp: split non-host-disciplined PHC drivers into a
 dedicated subdirectory
To: David Woodhouse <dwmw2@infradead.org>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-s390@vger.kernel.org, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com
References: <20260630031519.23072-1-guwen@linux.alibaba.com>
 <14969e704fb8e70deb549b2e1c8670f6756a8da7.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <14969e704fb8e70deb549b2e1c8670f6756a8da7.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/6/30 18:57, David Woodhouse wrote:
> On Tue, 2026-06-30 at 11:15 +0800, Wen Gu wrote:
> 
> I was thinking we'd move them to drivers/phc, and simplify them as we do.
> 
> Most of them are just a lot of PTP driver boilerplate, wrapping around
> one central function like
> 
> static int vmclock_get_crosststamp(struct vmclock_state *st,
>                                     struct ptp_system_timestamp *sts,
>                                     struct system_counterval_t *system_counter,
>                                     struct timespec64 *tspec)
> 
> ...which is called with different permutations of arguments depending
> on the actual PTP call.
> 
> I was thinking of reducing the duplication and having the PHC drivers
> provide *only* that central function. Let the common PHC code provide
> the interface to PTP (as well as to core timekeeping, for setting the
> clock at boot, for timekeeping_set_reference() in the vmclock case, and
> perhaps even for a PPS-like discipline from other clocks).
> 
> Here's a *very* hastily thrown together proof of concept; utterly
> untested and AI-produced, and I've only given it the bare minimum of
> oversight thus far (I have been meaning to do this for weeks but other
> things have taken precedence so far)...
> 
> https://git.infradead.org/?p=linux-phc.git;a=shortlog;h=refs/heads/next

Thanks for the POC. I've looked over it and agree this is a cleaner
approach overall. The v3 was meant as an interim step, but given the POC
it makes more sense to go straight to drivers/phc.

I'm happy to adapt the Alibaba CIPU PHC driver to the new framework
once it's in place, and glad to help along the way if needed.

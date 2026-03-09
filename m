Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5322D7B5;
	Mon,  9 Mar 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023316; cv=none; b=q/6p4E9jEpChqj8O4UDut13nTpej+Q3GVGU28tJpHEaMYG9YEFXDqK5abzDlxPAmLkdnilvQ6ptX15TKyO8/b8unR9dcSyuP4vBokwW5Ssn41d2hiNOcXcoZZRmtkS91/2nEQ9aKqfAmzpp2yyZoMe9sfUsgyVoW5H8PLsLdDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023316; c=relaxed/simple;
	bh=9+7Gl9tuAZ1Q0VSNcuAVDQMPoA6ngxLTTu1pfkwf7ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQvoPgj0cvsTRqEh9b6Hp2+ElfVIxGwogrGTUoScm1r2gdbXfthV6KVgLrOdBxiUvP0yaoBfcJ4DsfzAX6E7JeLPXXev6Ug45eBzX/MKtNCA3C2/9bAk1Q9cP5dYLfBHLgLCSghTCjnDHkpppoJuCBiikLLmlqV20mmPgP4tSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NlYjlLJF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NlYjlLJF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773023305; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qmhKuTU3gUKJMAVU5dtpO7oqXqxZXnfftl1UL5iMYm0=;
	b=NlYjlLJF0JPS2GiOOG6nAIb9XEeGmj3Pugsd95TgqKbjWsnwPKJh6jZrzSoMJVujyUcHEMg1mwb8CF6LsUyWmzI+imktExapM6byzCFlNfMcAsxHsrHXaQ3HUqnXTYcCdC7B0+mqAkbhIFuk57RcjXpAF3I95g0d05wqHHcF9EI=
Received: from 30.221.130.175(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X-TA9qB_1773023302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 10:28:23 +0800
Message-ID: <6397594f-eb3f-4207-9c20-b0f7e409054c@linux.alibaba.com>
Date: Mon, 9 Mar 2026 10:28:21 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to
 clock/timekeeping maintainership
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, tglx@kernel.org,
 tglx@linutronix.de, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mani@kernel.org,
 imran.shaik@oss.qualcomm.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, taniya.das@oss.qualcomm.com
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
 <be4c63a8dc43be15576565b4bd4567b3cf433d58.camel@infradead.org>
 <4a9af4b1-6820-4173-8daf-4201bb1bcca5@linux.alibaba.com>
 <20260305184110.13e79837@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20260305184110.13e79837@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/6 10:41, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 20:25:11 +0800 Wen Gu wrote:
>> As mentioned in RFC v1, the use cases for drivers in the emulated PHC category
>> are expected to be quite diverse, and not limited to the virtualization/guest
>> time sync use case. For example, existing drivers such as ptp_ocp [1] and
>> upcoming ones such as mhi_phc [2] are not related to virtualization use cases.
> 
> ptp_ocp is a real PCIe device with an atomic clock. mhi_phc is some
> qualcomm fw-defined thing, so more closely mapping what you're doing.
> ptp_ocp should probably stay under netdev, we maintain DPLL drivers,
> too. Main thing we/I don't want to deal with is all the corporate NIH
> virtualization excreta.

OK. ptp_ocp will be kept under netdev in the next version.

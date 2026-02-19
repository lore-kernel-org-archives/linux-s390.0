Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B15284898;
	Thu, 19 Feb 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524377; cv=none; b=QFEWwcrlkOUgyo5IN9c2MWRFV7OJr66wIRPqeEFPhhBoxEvCT+Kh9259qZL+wvvcJV7+wFjKqRoj+YStHl0UG2agtRypgKuooIcppAjTxZGnqFX+BfseUwbE3TE0aIWUGafX0pqYn2A8l2asCOJkCMSZbUIHCHwl2BlbhniFa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524377; c=relaxed/simple;
	bh=ei+32J12dH5XTmY6HIsq/qfutT8wLhlFs3aD7kLVufI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJh4TwNDHHHxvTIZGbMvD7YZuLSTv2ixwZWge1fzWb4qXwNrDqjER4p+kjrspbBDylgoZ+ipNKrtGCCe7khCGbCJIgs7Ms+7xoGsa6NV8ZY0QldjuW40MuowolimQfKnf1eECGy3mM2zfN9cYrcNuUnq2FphLX74waetLtKQRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jsuEO8X1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jsuEO8X1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J9A0nR1260396;
	Thu, 19 Feb 2026 18:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i77lVC
	+87WV3PYgyMRs88BGYUND9L7VM9FRfQUTm8vk=; b=jsuEO8X1bgt+KZBXDNNNQY
	paLZQ5ZgSZosZeqUYn1pe9WXnMzqGo04a3KJrh3bLvR5inW6+N8w+anvmdLMpMvx
	EXyImY+hxbqyFcJg/yO7NGzOo91Y4OMXjlFjrgBjdTR5TntVg1tjDKgT9QVR0evy
	lUVt+QvozMaEMA6cjafXxAvRUDztLzKDK/i8rxb8gT7CuhFLDoDsMEr7Ae+NjXuE
	f5dxwsGjw6LOj0fOy8vwW9IyzMWnqBlRxv+6g5k5B4Mp0DZTk3YM79IRn8/t9EL4
	mQ/3YC1wwjk8y1hmxArm0BudYv+wgarB6iwzs1bNb1q7jGyUTT1uzQNLLZVEz71A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s7dsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 18:06:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JHWwkH024324;
	Thu, 19 Feb 2026 18:06:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45da1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 18:06:08 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61JI678C13632220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 18:06:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88D465804B;
	Thu, 19 Feb 2026 18:06:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C08658059;
	Thu, 19 Feb 2026 18:06:06 +0000 (GMT)
Received: from [9.61.251.177] (unknown [9.61.251.177])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Feb 2026 18:06:06 +0000 (GMT)
Message-ID: <f6ef9900-ae3a-4580-a89d-f497fb4e5adf@linux.ibm.com>
Date: Thu, 19 Feb 2026 10:06:05 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lukas@wunner.de, Alex Williamson <alex@shazbot.org>, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20260219002010.GA3445930@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260219002010.GA3445930@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69975112 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KHt2tSRMWXP2V5P9C2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PgvV2eCn__ZMzQDdTIqaBapV090V5-Fl
X-Proofpoint-ORIG-GUID: WrJCnkgNYeeWHdlD_Gt9-2Vk2ySxY_MN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE2MCBTYWx0ZWRfXzR8yYh1Mxv/K
 tMs2C07tybTT8Qi9XaYmMINHICXHqr3uXBGdfqKzXjaM8B1GBKwh/U1/G9SwLK7tyjXseXc+N3Q
 1/3m9xzLAdaBNFTBpm4pgpMULg5+XoRFdEaX/oYT2kBc8NeBtyHaOoDa/d3YvYGsSxCucyve+Xt
 vWL9zBX+o1FMArKEeFfg16RkxLmmtFZHUJUg3SCZqWMecHifW2Ia4w1pIyqkZooVL3ZuBxvVAhe
 u4RigeZi5y3eG9P35f+gNOE4TYsMP0GGlmXxSjHPAKRm2B10mKy61KRsh0jqcUlFIj172I6qoPw
 2InjNQzO3WpZZ9Mv2Q+VbVxHHI96uYG/vicm4VzQx8qRmQbcQsGnR22xLfwpHz+RX+zwRPBUCQX
 3niqoiq8Ov5TCIGvYzdARRzpZcDYOid6f0MF9SPfYVrQffqI80d68O8bD3f/Nn7Va93k05z5Ifi
 ibfLMwpr2SRu+bCC8dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190160


On 2/18/2026 4:20 PM, Bjorn Helgaas wrote:
> On Wed, Feb 18, 2026 at 01:48:57PM -0800, Farhan Ali wrote:
>> On 2/18/2026 11:35 AM, Bjorn Helgaas wrote:
>>> On Wed, Feb 18, 2026 at 12:02:01PM -0700, Keith Busch wrote:
>>>> On Tue, Feb 17, 2026 at 11:55:43AM -0800, Farhan Ali wrote:
>>>>> Yes I think you are right, with this change the PCI Command
>>>>> register gets restored to state at enumeration. So we will
>>>>> lose the updated state after pci_clear_master() and
>>>>> pci_enable_device(). I think we can update the vfio driver to
>>>>> call pci_save_state() after pci_enable_device()?
>>>> Either that, or move the pci_enable_device() call to after the
>>>> function reset.
>>> I kind of like the latter idea because it seems a little simpler
>>> for the rule of thumb to be that a reset done by the PCI core
>>> returns the device to the same state as when the driver first
>>> probed the device.  Drivers would generally not use
>>> pci_save_state() at all, and they could share some initialization
>>> logic between probe and post-reset recovery.
>> I think the vfio-pci driver was intentionally doing the
>> pci_enable_device() before doing the reset. As per commit
>> 9a92c5091a42 ("vfio-pci: Enable device before attempting reset") it
>> was done to handle devices using PM reset, that were getting
>> incorrectly identified not supporting PM reset due to current state
>> of the device not being D0. It looks like pci_pm_reset() still
>> returns -EINVAL if current power state is not D0. So I think we
>> can't move pci_enable_device() after reset. Unless we want to update
>> pci_pm_reset() to not use cached value of current_state and read it
>> directly from register?
> Devices are generally disabled at .probe() time, so that will be the
> default saved state.  But every driver will expect the device to be
> enabled after the reset.  Skipping the save state at reset time seems
> like it would need a lot of work first and maybe it wouldn't ever be
> practical.  It wasn't really thought out; I was just hoping we could
> simplify the save-state model and maybe unify driver reset and error
> recovery paths.  I think we need to drop this patch at least for now.

Yeah, I agree this patch might be too disruptive for drivers. In that 
case would my previous version [1] to at least prevent saving state in 
case of an error be acceptable? Or is there another approach we should 
consider?

[1] https://lore.kernel.org/all/20260122194437.1903-4-alifm@linux.ibm.com/

>
> 9a92c5091a42 ("vfio-pci: Enable device before attempting reset") was
> mostly done to make pci_pm_reset() work, which requires the device to
> be in D0.  The main purpose of pci_enable_device() is to make device
> BARs accessible; it *does* also put the device in D0 because BARs are
> only accessible in D0, but pci_pm_reset() itself doesn't need the
> BARs.
>
> Other reset methods, e.g., FLR, don't seem to require the device to be
> in D0, so I'm not sure why pci_pm_reset() requires that.  I think the
> critical piece is the D3->D0 transition, and maybe we could arrange
> for that to happen even if the device is already in D1/D2/D3hot or
> even D3cold.

Looking at the PCI spec (v6.1) I didn't see any requirement for the 
device to be in D0 state to perform a power state change. So I think we 
should be able to transition from D1/D2/D3hot to D0. But IIUC if a 
device is in D3cold, then won't register reads/writes fail till power is 
available to the device?

Thanks

Farhan



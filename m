Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09644C8FE6;
	Wed,  7 Oct 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390085; cv=none; b=BqKWpBOUoE0UZ8Db4yf5EJamdgu8gSpyKwKJGDQydD8tj1+5RB5kcOjkJD3etQcyxBhmK7RNOzC0jZQx2NozxNB7ry/Llk90E1jrqgqmyWttS7qS3VnxUtd1yRzC8/nbLmpQWIq4FslZwJIYr411+Uuvl09cQ1I6cZMz6P2ETDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390085; c=relaxed/simple;
	bh=KLXiY9/UgqFjWDtgeUfveOwf7I+TL11jAHE0FrWbfYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHVPD7RUNk6J97op4qtnB+xmeLiT7J1vgO0ADSQrhJmSuAu7Q0bP4YYH2G7MJRQXV9h1aT5TmUYJszQyXYoM7XS0rU+Zy+OSNFT7G8lnv2c14AefijS74Kq2I1MTi8MOhh6zPwjAy/1T2ne+GhVQ4ALeDwS5DtnFtJqjmLg9y3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QBBivA98; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QBBivA98"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697F5SNQ2910922;
	Wed, 7 Oct 2026 16:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AkARvk
	SskQdVvXfjnLWTDuuTebmu2z6MRFCUIE5BxKk=; b=QBBivA98CQNY87YyfpLd1M
	SQfO/2vmJhZokwyxMiVqxhXL9AWN5S0zm+C4bsbg7a6bP8h8HACPQR8rxCXXrTSY
	HD26yXmOKMYcsEdRmQbRRDxa0QuxObexHpXMnjlvQfctggDrqcDJAwDNdm8eA9eH
	AJMmMI+/YVLWRkI2Gut2jDHR8U9Jxnw0uvgCKkqgLLB59Y9XIzw8Id/J3SclT6Fc
	YD+zgFb7LiZmW+bVD2s3NHHobPMRI7stHOj8QSPmqZSa1IRnN8iufEOMlV01Ufjm
	d9BfwAGYX3Tzm5tICN6J/6mmjK3UeePQCjpuhrsmZFFN+KK+V2TA9FE8XOy7IaMw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74xk7p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 16:21:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697FooTr2074568;
	Wed, 7 Oct 2026 16:21:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34r3ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 16:21:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697GKVal23986850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 16:20:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6098158054;
	Wed,  7 Oct 2026 16:21:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8730A5803F;
	Wed,  7 Oct 2026 16:21:15 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 16:21:15 +0000 (GMT)
Message-ID: <9e3894fa-0a1e-432b-ba1d-76ea34d4f648@linux.ibm.com>
Date: Wed, 7 Oct 2026 12:21:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390/pci: Use 32-bit fh outside of inline asm
To: Gerd Bayer <gbayer@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
 <20261007-rpcit_trcfh_upstream-v1-2-8a2718cfb90b@linux.ibm.com>
 <sashiko-outbox-162922@kernel.org>
 <8086f631ce7ce60f1763171c8f05b050ff6c73fd.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <8086f631ce7ce60f1763171c8f05b050ff6c73fd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BjrJsvZNyjM5Rk1QPNjm_2HVl1cfsngr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2NCBTYWx0ZWRfXz0kIyMbGmQkv
 viuw5Z/9KT+sBb/5aOfZDSla9Tsw1WT+lozv3PTUDUFo7jCd5Sk2cmvzHV12bb2ikgVzI5wtIHc
 IhFswVERFdOCyjmmkjeElpdgECducKE=
X-Proofpoint-GUID: BjrJsvZNyjM5Rk1QPNjm_2HVl1cfsngr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2NCBTYWx0ZWRfX9aeVsm4N+rZx
 lzgOHea4tItpq7dDcVSESE7mlLJIit5WaNZlvNiB1tRnXTY6rZ/m9Cuq38daXiFDFqFgvFrF76d
 dB9a8T9ME9/PhnFNYRYkcUVGj0SN+dQnz9391YRoFl/ZLMamDzqdXAy3cAuJf/F8ZTbGGnvg7eG
 gBiGLhJQWXZ5qmEwEi8Rw4+I/pWVFlvExN28GgrhjtPlOUDKg1zkbeQwxAFyT4OHP6JNBQF4k7s
 mlEtzV9qkScneW5tM6YA68wLYHHTWD8ZQ9NHstxMff2ZY02hRhBOnZdOWoCQbRzppI9OzwFogTv
 /p7Z7aDnPUN5jMCQXSptYezEO2GfKZEgP6Mze3lwOgR2MxfuoqYHt/zknLYHIsQONNPrbCjMO+Q
 +Gmi3HKEonQZ0M71Q6YafkKNHFr5OI3+XcOwG+9FXOjAzI0rlXGs+hSjAxbz3hN6TNHv3N4uI+Z
 PSYfdPGxaLN228LxUUg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6717e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=i2SW2bYGNGrD0rdaJRgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070064

On 10/7/26 10:46 AM, Gerd Bayer wrote:
> On Wed, 2026-10-07 at 11:19 +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] s390/pci: infinite loop in zpci_refresh_trans on CC=2
>> --
>>
>> commit 1c8706bb963f0d551da7d8535f804ca9f9b4305a
>> Author: Gerd Bayer <gbayer@linux.ibm.com>
>>
>> s390/pci: Use 32-bit fh outside of inline asm
>>     
>> zpci_refresh_trans() declared the PCI function handle as a u64 type just
>> because the actual RPCIT machine instruction required that in a 64bit
>> register, while the function handle is architected as a 32bit type and
>> defined as such in the zpci_dev struct.
>>
>>> diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
>>> index 2ba787e2304b5..053afb3e7a990 100644
>>> --- a/arch/s390/pci/pci_insn.c
>>> +++ b/arch/s390/pci/pci_insn.c
>>> @@ -117,13 +117,14 @@ static inline u8 __rpcit(u64 fn, u64 addr, u64 range, u8 *status)
>>>  	return CC_TRANSFORM(cc);
>>>  }
>>>  
>>> -int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
>>> +int zpci_refresh_trans(u32 fh, u64 addr, u64 range)
>>>  {
>>> +	u64 req = ZPCI_CREATE_REQ(fh, 0, 0);
>>>  	bool retried = false;
>>>  	u8 cc, status;
>>>  
>>>  	do {
>>> -		cc = __rpcit(fn, addr, range, &status);
>>> +		cc = __rpcit(req, addr, range, &status);
>>>  		if (cc == 2) {
>>>  			udelay(ZPCI_INSN_BUSY_DELAY);
>>
>> [Severity: High]
>> Does this retry loop risk causing an infinite loop or CPU stall when handling
>> large DMA spaces?
>>

This should really have been flagged as a pre-existing issue vs a new
regression, it is not a behavior introduced (or changed) by your patch.

>> When the s390x RPCIT instruction sets CC=2, it indicates that it cannot complete
>> the operation in the allotted time. It then updates the address and range
>> registers to reflect the remaining uncompleted portion.
> 
> I've re-read the relevant ISA documentation a couple times now. I don't
> find any mention of address and range being modified after RPCIT was
> executed - regardless of condition code or status.
> 
> Maybe @Niklas or @Matt have an idea where this allegation of "CC=2
> means partial completion and one should retry with an updated
> iova/range" comes from?

FWIW, it's not coming from QEMU -- we don't even have a CC=2 return case
for RPCIT today, and we never update the iova/range on return.

Perhaps, lacking access to the ISA documentation, it made an assumption
that the range would be updated to shorten the next RPCIT as this would
allow us to converge towards a smaller and smaller range each attempt to
potentially not hit the busy condition eventually - sounds logical anyway?

But I also find nothing that indicates the range will/should be updated
on CC=2 (or otherwise) from RPCIT; so it does just sound like a bad
assumption.

> 
>> However, in __rpcit(), addr_range is passed using an input-only constraint ("d"
>> instead of "+d"), and the arguments are passed by value:
>>
>> arch/s390/pci/pci_insn.c:__rpcit() {
>> 	union register_pair addr_range = {.even = addr, .odd = range};
>> 	...
>> 		: [addr_range] "d" (addr_range.pair)
>> }
>>
>> Because the hardware's partial progress updates to addr and range are discarded,
>> this loop continually re-invokes __rpcit() with the unmodified original
>> addr and range.

That matches your observation:  we indeed aren't taking updates to the
range in __rpcit().  But as you say: there aren't supposed to be any.

>>
>> If scanning the initial portion consistently exhausts the hardware time slice
>> (such as during IOMMU TLB flushes on devices with large DMA spaces in
>> zpci_refresh_all()), will the operation fail to advance and loop infinitely?
> 

That concern sounds valid at face value; if we tried something and it
couldn't be completed in time, from a linux perspective we are simply
trying it again without changing anything and hoping everything works
for the best this time.

> I see that all the PCI related instructions in this file may retry
> indefinitely (with delay) on CC=2. However, the architecture guarantees
> that at some point the instruction will end with any of the other
> condition codes.

I think that is the rub.  Sashiko couldn't possibly know that such an
architecture guarantee exists.

I suspect the question is also a bit theoretical: what happens if the
range is so big that it's impossible for the RPCIT to process it before
the CC2 trigger point due simply to how big the range provided is?  Then
you're guaranteed to hit it every time unless you 'chip away' at it by
shrinking the range after each attempt.

I would assume/hope that the SDMA-EDMA range limitation we impose on the
aperture size already ensures that it is easily possible to handle a
RPCIT from SDMA thru EDMA without tripping CC=2.
So then the CC=2 case becomes purely situational vs a guaranteed result
even for the largest possible RPCIT request.  That already makes it far
more reasonable to simply try it again.

So: assuming that architecture guarantee stands (we know RPCIT can
possibly complete for the largest possible range SDMA-EDMA, and we have
some architected guarantee that the loop will be broken otherwise e.g.
architecture says it won't keep giving us CC2s forever) then it sounds
like nothing to fix, but maybe worth a comment in a future patch that
explains these guarantees, based on what you find in the ISA.

I suppose we can consider whether linux should have its own redundancy
here or not in addition to those guarantees.  That sounds well beyond
the scope of this series and goes back to what I mentioned at the start:
 this is pre-existing bevahior and should not hold up this patch either way.

Thanks,
Matt

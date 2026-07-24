Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CA2931CF;
	Fri, 24 Jul 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897586; cv=none; b=su6kwJgHOwwcF6pGTovYr5DEwY7kOk2+9DepwMGmmG+XYR22oTDsTXvvWiupgpY+WW1OLsj/lmrZ77wvhahHQa5JzxwwUwt6EA1qxs0YoLILfxQebM4J8elF5zPAE2l8EleRaNueDf8zywuWMurkoJDFNLgVf8bj51QTSApDht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897586; c=relaxed/simple;
	bh=CmC/F55K3moMlrISeeTrXT3/rTgpSxtQ6HFTRr0x2hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWreLXisIIqJan4EbYYRn3YifizpAjLdX6rhUgBR1nQb61sVQLTugazqAIYIhQb5+JegwDmSWhX/RdNeoiSczWfE/KplQWEsnKU25ilaHspGJwu4IzeQ353opr2bvHaEW8t7J0M6hCgdpD3w/6WqYZ/rRwJNwRz8XtEM6xe8sxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B+UCJhbY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B+UCJhbY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCglrm4165845;
	Fri, 24 Jul 2026 12:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jSzijr
	u+6XETQXjuxeIfysHdIgdLSgsVhd+zEmI5wd4=; b=B+UCJhbY9My6wy0Zb2IESa
	zEUcLPQhdCgekl34GbYYhl8acSJJS2aR2ZEFuREFl+ar9gOX8Q15D+rNydpvN9wr
	/6c8f/8FzG3C8wIxCkUaoMUTtlgmD8rucj9pv9g+Mx8PLD6gNxOfZqGsaoPMJ9Zg
	Lk2UvKFtehKF6ThQaaWFms07MuqerbEl8bnQCNDs1wsGkRH6LivRa+3sOMSi+51F
	c63E6zbRslWACGYEVE8dk2FUv7ICfeOb7sOmruyotqHGng+566074amouzkLadHf
	xrm6r+cVKpP70jKfTX1wDtce2juMZuuFFJpibW9VechvfXq+ff1xOBo9icpBufpw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77avqjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:53:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OCoZfq021585;
	Fri, 24 Jul 2026 12:53:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wh12g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:53:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCqurP31261242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:52:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8337620081;
	Fri, 24 Jul 2026 12:52:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE7B2007D;
	Fri, 24 Jul 2026 12:52:56 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 12:52:56 +0000 (GMT)
Message-ID: <f713b3cb-f7f3-40d7-9ba7-8f8317e504a6@linux.ibm.com>
Date: Fri, 24 Jul 2026 14:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/mm: Add missing vm_start <= addr check to
 do_secure_storage_access()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260717131407.855327-1-hca@linux.ibm.com>
 <d7022700-114e-4aa7-ac56-5b805f700daf-agordeev@linux.ibm.com>
 <20260724124829.220718A2a-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260724124829.220718A2a-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v9agxg-tsh49qipHRo11CmUkxhS9thLt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX02eewKmXI5Pf
 typv6unE72CXtRadWBy1Rjgf1WvE1c+dTXN+k8oz6uFrqJRcnYKabqgjiqtmuXMZ/O1WCfwNf7S
 If/XVHj5vEMntsH6pEyBYGs8vZVTRgE=
X-Proofpoint-GUID: v9agxg-tsh49qipHRo11CmUkxhS9thLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX68EoblljnvWE
 E4uBtrNE+8iuQn/xvA0xVK/qoiA0dWoB1nS90uuecGK5PFu7o+BOiGZWR5MbB16fL2eGrc7vR7g
 75+dY6uOx369o2wDYzbVvdiXQvUqXcPqqZslaCpkfUOS9sEEjMu0szAt8+qpryasnz/b/Plgnre
 GCiYlhXpsecDRDOY8WGRlad5B7bQCJaapcS+eqZZTC4jQvsnoS/E4ZUa8U8BW3a91e7E/h9j+Fy
 AM+omQFAqh0YCvva/y6SFOQ3VLrzLXw0CDEUeZdizfKsiWQfnpxzRiK66+vXzj87NLX6AcAsAId
 Xd29GftMt8YwyEcXlJrSU2560sEXdGyzkct4vF8RTvjV7CwIi7uodejMf2WDztr3zuC1Jyi02OF
 55Jvi9w2msNO7AjiK6sUvB+rbGhCeKKpk/vX/lzAkoPIQ+nWEpkXuyKiRoPEi+CSFgfpgUxGwq9
 l81oxmu1PorvllCfm6w==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a63602d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=i-kwpukpLRl_NczjVPEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240115

Am 24.07.26 um 14:48 schrieb Heiko Carstens:
> On Fri, Jul 24, 2026 at 02:09:32PM +0200, Alexander Gordeev wrote:
>> On Fri, Jul 17, 2026 at 03:14:07PM +0200, Heiko Carstens wrote:
>>> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
>>> index 028aeb9c48d6..d6c58d78edc5 100644
>>> --- a/arch/s390/mm/fault.c
>>> +++ b/arch/s390/mm/fault.c
>>> @@ -456,10 +456,9 @@ void do_secure_storage_access(struct pt_regs *regs)
>>>   		if (faulthandler_disabled())
>>>   			return handle_fault_error_nolock(regs, 0);
>>>   		mm = current->mm;
>>> -		mmap_read_lock(mm);
>>> -		vma = find_vma(mm, addr);
>>> +		vma = lock_mm_and_find_vma(mm, addr, regs);
>>>   		if (!vma)
>>> -			return handle_fault_error(regs, SEGV_MAPERR);
>>> +			return handle_fault_error_nolock(regs, SEGV_MAPERR);
>>>   		folio = folio_walk_start(&fw, vma, addr, 0);
>>>   		if (!folio) {
>>>   			mmap_read_unlock(mm);
>>
>> The Sashiko feedback looks like a false positive to me.
>>
>> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> This has been integrated into the "[PATCH v4 0/8] s390: Reintroduce
> support for DCACHE_WORD_ACCESS" series. First I thought of keeping
> things separate, but decided then to address all of Sashiko reports
> and make the code look quite similar to do_exception().
> 
> So v4 is the only series that matters, everything else can be ignored.
> 
> What is still missing is kmemleak handling for which Christian posted
> a patch, but that appears to be incomplete. Or least my thinking is
> that there will be a subsequent patch.
> 
> Christian?

Yes, its on my todo list to extend the initial patch to also take care of
the other storage areas. Still doing other things first.....

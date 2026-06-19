Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05D372B39
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866333; cv=none; b=IofpkkEeg/SmgjbSxCCzJyzG8mYmNmP4/qefAuE5Rg6fZ+5hzG2WP0TvKDZ4D8p+4PewAKiadaqqD4bJ1OC8eXo/pHAiCktmafKi/PFi8EoZn/oNN0333r0ql7W0MRgO7lCWlkVBXvmIzdrsFU1qSflqMYqid55T8jF0LrUYCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866333; c=relaxed/simple;
	bh=CE+efygUipEmvi0ef8kaNSzTlppOtiyr8/v0sfReWBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tW2MnolAj6Uj6/ROGCLxVXjDSz8SBZdwXIK3BUC5fzRptxF0tyAhEid90VCPmp8PwQJFpNu0uN6nlN3dDUerB4webHr5yyprU8vQ8E2E5NZBgXoGB0r4KcCfj/zqlDbPrXvMk2cqIsq9n8KgGnb1jpaWONna5JrCrK4pc0FE8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EPsDNMvy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EPsDNMvy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mo9e1675409
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ucVIcJ
	EQqPKZJZyp9/SwGR7V2oQjFsDcEHp5n6Wu6oA=; b=EPsDNMvyXr1GZAgjpxlkei
	dQUB+A5HYB87nPbGtoS3alQiFPJMdoI3zXfWr21iWIAs5u3bOinXIy2Gp6KjNvlP
	I/I5xcFTvzFiYahJCY7Pf0JR1kUeh6gHrjRawBEfZDwm8NHwzkBEo5rHpgWtkwFu
	nse5/g6tFysQ/GQXoV97+deAcCrX/su6OJ58Dk24V8BC2FyXQuaD95JakxV4WJ7x
	5DadACniyvp51qKWmSSEklGW3HiyEcx2j27YLv075EHtot6Bvy+SOXqGasfMLPci
	uHtaIRE8/kQEvIXDRN6hpxmtkw407kqxh77tX3fbJX5KP2BFRS4dDx5084rxNOJw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw54k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:52:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JAnnaa008314
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:52:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1728exg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:52:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JAq69r52691396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 10:52:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D74BE2004D;
	Fri, 19 Jun 2026 10:52:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87FED20040;
	Fri, 19 Jun 2026 10:52:06 +0000 (GMT)
Received: from [9.111.31.109] (unknown [9.111.31.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 10:52:06 +0000 (GMT)
Message-ID: <3fb81ac0-c772-49b6-80a1-34a18f671061@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390/kvm: Refactor __diag_time_slice_end_directed for
 single exit point
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20260619101349.162430-1-ciunas@linux.ibm.com>
 <20260619101349.162430-2-ciunas@linux.ibm.com>
 <5811d93c-0f04-46ce-9578-9845db4399d1@linux.ibm.com>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <5811d93c-0f04-46ce-9578-9845db4399d1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX15WOeqgRI5Ad
 0V6ldZriBQaYO6wCgpWv9u3j/AEp016NTqarjcZqAF5dNGXJ7HOLfBXlE7f13Cca7trAK4w3vyO
 e+bXi52HhuaA5Nn8uTZu6xOH88q4few=
X-Proofpoint-GUID: as2TR6bF7eQtciLbCQArkMZ7CweKZkFq
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a351f5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=mPd_T9I2LWOKiksmw6gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: as2TR6bF7eQtciLbCQArkMZ7CweKZkFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX06aloGyFZ2TE
 oCYOuVezWD5tFpCJHj/mkRk9n4Rvh7WDeUlg0IHgVBWictXiKI2XxffS4c32ZaR8fkzwfzlYdtF
 Ksg0rRtlodjinxB+38/eINtGJq0Ht5FTQYZju9XpwTzhf9Cbfufs+0OnLCsq6VeZyAd0Tm8lJ2D
 tHz08tXhf58fw6cQHxzC67bQwMpxwne7REsje+WdaNg7LK+ro0rH4AzOv/iOKvlpFIeu1gVVa0f
 7br/hZtGKM3JEYjBpWlJSfOToIm4l0DRMW1HTBLZ/r7SbJbIgVo+kUXomVmA6ngV0P/2EvfFBPO
 Yy5EzWK81CQQ8GoVo698CZ/0RLcODigRmH05GO1KSKgTPVdr/JLp7xYETyYNVagvtysVl1iv1CY
 bPX2cXt0u4YL9MauoHxwAYmfXc5y7NkCJNvQDAhN64RDTVULchUozFR3C12GKWcfPW2FuYUz+t8
 EsYLI0fbWDuZVjvxZTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190100



On 19/06/2026 11:27, Christian Borntraeger wrote:
> 
> 
[ ... }
>> +        goto out;
>>       }
>>       if (kvm_vcpu_yield_to(tcpu) <= 0)
>>           goto no_yield;
>> -    VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: done", tid);
>> -    return 0;
>> +    result = "done";
>> +    goto out;
>>   no_yield:
>> -    VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: ignored", tid);
>>       vcpu->stat.diag_9c_ignored++;
>> +    result = "ignored";
>> +out:
>> +    VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
>> +           result);
> 
> result is a local variable that will go out of scope. You can not reference those
> in the s390dbf feature as it will only store the string pointer and it will not
> resolve the %s. So this wont work.
> 
> When sending a patch, please cc maintainers according to scripts/get_maintainers.pl
> 

Hi Christian, your right I missed that.
Would something like this be acceptable?

/* set depending on state: e.g */
int result = 2;

VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
        result == 0 ? "yield forwarded" :
        result == 1 ? "done" : "ignored");

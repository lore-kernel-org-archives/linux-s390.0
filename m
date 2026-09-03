Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158833F3273
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435989; cv=none; b=d2WiLN+BI6xUrhoRKdA1cwTUltEhaydL2JaUAJY19aer/w2Jfz+Uk/4NoeY4HynY0HdE9+mCrGY4nxMRkhldKUE7Fi0vxvxLFo2+kYW3/wU5cdYpIKg5Lq+8snFVGFpvRG2VxrS1W+qulgYdA3sa2JohuFvvP99ns1ReVQiS2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435989; c=relaxed/simple;
	bh=PgmP5gGBoRCwURb7ZzfmBX2ug9orCJa+Tr7ZgIQGsFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1+6UIntvZ0SIGSjeUazBlbsSk61QgJf3oDBQbNDzhLLQ752PE8n0bZfCQ63tP/QVbfC2YRubtZ5Lq0TkNut6mj/bLuZ7ne/ENBdpP4AM27vT7ENxVurCruuAs5YfcWduPo6ilgyhqeBJVEYbAHUNEMN3QoyezSR2g6cD0Ox+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzLO/cOv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzLO/cOv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AW5rD1606870
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 11:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4o2kRg
	MZnxN4Vbz9U8P51wrExbvWJi0hEoY9bUbNiaI=; b=pzLO/cOvg5BR+wfqYHShjE
	aBgjxwGwRqBWM9HN0uhEws88MHnU5Rdtg0+PK/PjnVgsvWdKsMtcjzlM0439J6o4
	krVV0nlsUwxVV5sDMTOTTZHykpDrfWColb7MSRHsA0vTJNF2+mT/TTXEtsmraBGY
	/CHtpQtpWoviBHPs3Pzj60CuqWSqraHFDKUQBuZl/kBxkZWx6p/9fzQosGvGRd/d
	WWThITMFeIdiicxa9MjBxbwgz944NrJm9yUr2C49sjq42KGwQ83GImlzmwYvXTBi
	LwzqSpkH5bQJCGvk8DsLR+dvBUPasrzu92R3ZEEmBy29BU9ADOTpe+DuCXbGE8zA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue47pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 11:46:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683BfFCK020788
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 11:46:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkffjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 11:46:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683BkFsa45351196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 11:46:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E23AB2004B;
	Thu,  3 Sep 2026 11:46:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92EE420049;
	Thu,  3 Sep 2026 11:46:15 +0000 (GMT)
Received: from [9.111.42.25] (unknown [9.111.42.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 11:46:15 +0000 (GMT)
Message-ID: <dc837639-bbe7-4807-a8b5-141279690bc0@linux.ibm.com>
Date: Thu, 3 Sep 2026 13:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/topology: Enable ASYM_PACKING to establish cpu
 priority
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260901-s390_sd_flags-v1-1-6755ba191d5a@linux.ibm.com>
 <20260901153038.152550B9b-hca@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260901153038.152550B9b-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: psml7YmmHcbmd61bo4D7zQpQwqGp8EH1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwMCBTYWx0ZWRfX8nvSufxSdvTK
 HfwZC8KP8sPE5dRQk1I3waLYvRO32KQ5Xc7HXcrhvlu/NFJG6vLF3en0KtGU4YgZa/6O0W8GwW/
 6XTVNsFWsXD5iLg/BM6smRL3bRIZNU58hUrXslyTKN6CCRuJr+MY/V6EvpImn76cC3TbySLNoic
 +9l+PeWYds+aJsgK5T2ylu6FeDzGX2NwLLxe+gmwVbRp9cS/SwvFBlO9jSnojm0CF86EZOkJCAw
 /vwMR06mUrXrNVmu4pX+Xlv/jLKdmIqv+Z7fIvX1PCfMIsCBEKHOTcJDeTz2VfRRBAJvsxNOajl
 OlzaZB5pIiDltDol79LHcQUDsciSDBj9iKCRbaIbgOl6cuRiKYusY2u1zLMG15SvkEPpihXqbl8
 7tc0iGoGkZbDQ8Rd8YIwf0jCUEcwifqtXnK0lv3b8x3DAQBsUecCPi69RjaXO6lWQscubSxVYV3
 WvKnj6XU3y7LbGX9x5w==
X-Proofpoint-ORIG-GUID: psml7YmmHcbmd61bo4D7zQpQwqGp8EH1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwMCBTYWx0ZWRfXxF1VfEAcpJ1R
 7dQTyx6Slqpi8aDkEBjbdWU76ium8btoMIWVwUVOeHjpqaZJ/gyMSYYITdntEKNuqiep2Ppr7jK
 bMFOq6weLEgXYQOHPn3ytMcpdSCCBrY=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a995e0d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=gjCB9uKQkqhSIuPYxYoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030100

On 01/09/2026 17:30, Heiko Carstens wrote:
> On Tue, Sep 01, 2026 at 04:40:26PM +0200, Mete Durlu wrote:
>> On s390 LPARs the hypervisor assigns varying CPU runtime capacities
>> under vertical polarization, making CPUs unequal. Add SD_ASYM_PACKING
>> into topology level flag callbacks so the scheduler keeps busier
>> scheduling groups packed onto higher-capacity CPUs.
>> Implement arch_asym_cpu_priority() using smp_cpu_get_capacity() as
>> the decision factor.
> 
> ...
>> Subtract the CPU number so that the CPUs with lower ids are prioritized.
> 
> Why?

In short terms, this prioritization prevents tasks from being scattered
all over and keeps them in a smaller region of cores. This is one of
reasons for performance improvements.
Subtracting CPU id also helps when all vertical high COREs are busy
and selection has to be made between vertical lows with equal capacity.
In such scenarios best performance is observed when the tasks are
grouped closer.

>> Only enabled on LPAR level as other guest levels either do not have
>> vertical polarization (which causes asymmetric CPUs), or machine backed
>> topology.
> 
> ...
> 
>> +static int s390_core_flags(void)
>> +{
>> +	int flags = cpu_core_flags();
>> +
>> +	if (machine_is_lpar())
>> +		flags |= SD_ASYM_PACKING;
>> +	return flags;
>> +}
> 
> Why is this machine_is_lpar()? This should actually test if cpu
> polarization is available to make this independent of some random
> environment test.

Ah, I wrongly thought that running on LPAR automatically means
that the configuration will have topology and polarization.

> Furthermore to me this reads like the above only makes sense in case of
> vertical polarization. What happens in case of horizontal polarization?
> Does SD_ASYM_PACKING have any negative impact for that case?

I was hoping that this grouping effect I described above would help
on horizontal polarization but the initial benchmarks show that the
the impact is a bit different and chaotic for horizontal polarization.
I'll conduct a couple of more runs to make sure.

OTOH, now that I think about it again by definition horizontal
polarization should treat all CPUs equally and now we are telling
the scheduler that they are not equal which does not make any sense.

I think the logical option is to tie presence of vertical polarization.
Oh and I just realized I missed the case for DEDICATED configuration.
I'll come back with more experiments and improve the commit description.

Thank you for having a look Heiko!


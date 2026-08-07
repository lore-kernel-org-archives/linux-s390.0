Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CF3BFE52;
	Fri,  7 Aug 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100747; cv=none; b=GOAA8m3RQ965S5tdnKIvmcoKb7jvBb7pmloKS3lEi2O0u6duTsFBo8SDqvk1j4mUtBo1XhtcjWeLhkH/hz+TywPFGqfmoBo2vZeRcYEMA44UFP6P8sSrxt2QMPkVlWAv74qewcDspc6/cWE7XOj3n1xD02YPgPCx/qC6PsrobUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100747; c=relaxed/simple;
	bh=7SjSMJ+FAkqiNxQb8Ui/NkU5t9UngIAVhvJR3IEEKfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlOpvYoudRGm2Ao+aiwV2I03Uv8PBhch9qrzR68nz3oZu76gk9Tzq03gPwE3fDlpXjGu8HucbQjmBNTPQv8TVQWklFmVDaVh1YSJbtrMXCRxtv0gaS8tvx3fsqKC6GtPJvOWt0JEuFoPaV5e8sBitzDtkAyOV4Q2I9WzMJP4+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NxPLJln9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NxPLJln9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IJwX4062558;
	Fri, 7 Aug 2026 11:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SQTUDk
	IhE3YuY48rB5OmRoQpJKwO8sE6Qkfz6LoUnJ0=; b=NxPLJln9Wz2k27shgE29Ph
	HLOL6TltCmFFSKkAMX45gNqEfgYIwDEPw57lRJB+kC/ynpAljnDHxxJDsXybubsS
	SOZZWAQTW3limsrjvNVe0ygCAjWqF3tqebnHnf5QwFKuh7bsvtnrvPXGZYQGdY5m
	1vSraWsr9c5cSkeirewh3O31WSAASvGZ/1+jRrPcxX9rqkcbnTe+mDiuLfXyySM1
	pimZ43tNSw9MWhU3lXP0AfMnoYTDmvraiIvq9/KcE1LrsfdK8K9mhzss6Bjsn1rd
	Garr7M5dZm9DLmFRjwjjTMfD38csSOmwqAvBGbQsSFdZNUaJdoMSlpIjRk4w4FLw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02befb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:05:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AuFps018966;
	Fri, 7 Aug 2026 11:05:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgq6nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:05:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677B5ePo25363120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:05:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFAD02004E;
	Fri,  7 Aug 2026 11:05:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A51E320049;
	Fri,  7 Aug 2026 11:05:39 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.90.112])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:05:39 +0000 (GMT)
Message-ID: <516fe0be-374c-49e0-bdd1-83ec7cefbe0a@linux.ibm.com>
Date: Fri, 7 Aug 2026 13:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/cpacf: Unpoison query results
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260806190223.3292580-1-iii@linux.ibm.com>
 <20260806191442.AAFE91F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806191442.AAFE91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75bc08 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8yQpLCr1Fxib-xGAfP8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX+WWKEnA7OXlB
 0CBmnWH2NxRorHGMrbav0vwb08zqA/8FH3/AtdWWpAiJBDBmXlQH0qnHDes7HRxU1+GK3gT0WJQ
 UjdpogRRhlvwEcTPsm+skiUU1SAxeZz5p8PpjmQnrrMafNmA+GvNoZ2vx1pkqDsgvEuQj1zcmc9
 4HFa5wlPHPUUgyBvCMPgHdNGTDOHb3R29GCJz92XMepXiu7G42ZbkBFIDfM03HuvVHrCntnQRo4
 qJaMnXmYXORlEWej5fq267npEHMK69IM7fKy8TGf1S/L6s4jE/Uf1sjd8fOYS39ynKvsoJct3Zo
 0gyeUVlT2hDGNIvRgdOnscWwE0qVSLjCAnnJvSCXwDqcEbLMs/b+akk3R3fFmE2gy0dsdjzMget
 QseyfHe06gwxC3orK5vk5odTxuhdLzb/epqa+7wzJs5Cd5aiqnMal6a9F4hzzpRBucnsQo5I7xF
 7ZxVJdygblCdZFm8JlA==
X-Proofpoint-ORIG-GUID: 0IsZxS70U9nnX2ARSiM6YFVhlCqX46tn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfXy/HW463oo5IP
 OvM8uLMMR6S8XhtQTPErXTKJlw4/lrVw8nH40mph+BoiNtjRqNH6tMJydI7YlSXMhz8zLObC1qZ
 MG32j5HS8fHUsEH+GKRaxJKwGZAu508=
X-Proofpoint-GUID: 0IsZxS70U9nnX2ARSiM6YFVhlCqX46tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070083



On 8/6/26 21:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch resolves KMSAN false positives for CPACF query instructions by unpoisoning the fixed-size query outputs, but fails to implement the same fix for the primary CPACF data processing wrappers (e.g., `cpacf_km`, `cpacf_kmc`, `cpacf_kmctr`, `cpacf_kma`, `cpacf_prno`). These functions execute CPU instructions (like `.insn rre`) that write to output buffers directly. Because the inline assembly clobbers "memory" but does not explicitly bind the destination memory as an output operand (it only binds the register holding the pointer), KMSAN is unaware that the buffer is initialized. If an uninitialized buffer is passed for out-of-place encryption or PRNG generation, later reads from the buffer will trigger false-positive use-of-uninitialized-value warnings.
> --
> 
> --- Patch [1]: [PATCH] s390/cpacf: Unpoison query results ---
> commit a5de23eacfba57cb30b8dc14f4c7ed05cf2e259d
> Author: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> s390/cpacf: Unpoison query results
> 
> Stop KMSAN from complaining about query results being uninitialized.
> 
>> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
>> index a83683169d98d..d4128d3fd5138 100644
>> --- a/arch/s390/include/asm/cpacf.h
>> +++ b/arch/s390/include/asm/cpacf.h
> [ ... ]
>> @@ -370,6 +371,7 @@ static __always_inline int cpacf_query_func(unsigned int opcode,
>>   static __always_inline void __cpacf_qai(unsigned int opcode, cpacf_qai_t *qai)
>>   {
>>   	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
>> +	kmsan_unpoison_memory(qai, sizeof(*qai));
>>   }
> 
> [Severity: High]
> This is a pre-existing issue, but should we also unpoison the buffers in the
> other CPACF data processing wrappers?
> 
> The primary CPACF data processing wrappers (such as cpacf_km(), cpacf_kmc(),
> cpacf_kmctr(), cpacf_kma(), and cpacf_prno()) execute CPU instructions that
> write to output buffers directly. Because the inline assembly clobbers memory
> but does not explicitly bind the destination memory as an output operand, KMSAN
> remains unaware that the buffer was initialized.
> 
> If an uninitialized buffer is passed for out-of-place encryption or PRNG
> generation, later reads from the buffer might trigger false-positive
> use-of-uninitialized-value warnings.
> 
> Would it be helpful to add kmsan_unpoison_memory() to these functions as well
> to prevent further false positives?

Fair point, will do.


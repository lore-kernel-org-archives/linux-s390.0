Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116593D967F
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887070; cv=none; b=cF8sMT4HhBsEcgRmpRMcQDhz0ozRmhtGUkanQ85rk5kXrIOXV0qGufkjxcBtTdikn65nfPtgX6KXzKN+MwfW+6lE1flK78qpJ0CfLRDGv02DzxqJLsY1oilxU5+Yxz8BWY7W7vWde79MNnmjUrnrBAarolDtGmUQ0KNMyKpp/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887070; c=relaxed/simple;
	bh=9gr52oOyBwTmK5CB2G5pDQTl39hCbDzkEU94Vn6IAxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mk6GGywE90K5xWRaa255wuwCRBjsT/hgUcMZH5N+x3m5eVJRMqobWF7HR9S95/msNZVIakPjZSoexpojAWUrSwne9FNl14aVkPJ5bnZoGLKc7CEmQJpmTQNElb4VuUa7jn02h3jh83Q3S4xUWYwDzofQJzQi3WyQhA7XT6NjyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HBIBybDM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HBIBybDM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5BppP797597;
	Fri, 24 Jul 2026 09:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DiwCwE
	V4xFuIssEKp2TcVISkDiyMs+//1lnkuGNhPEk=; b=HBIBybDMC0SweAKBcIyRfZ
	Mm2mhy1DyFZt3LeVoMQjQU1XDRHNQ9ugzLcIGX3NdAStZad9ufqqTH62EDIrJlzY
	qTDb8d7M4z0yHID1kQihUARqMh3N+0dHdPHkawa6LMShzjlkRDr4jCd9mTetwLnv
	8v/COVwwLzL7kqd0RzgvbpICqQN0ulOLq6J13pKY/NeSt0JIk7TAM7GPpBBGihob
	JQxu2np41mwTV4CdwuBAqsMkC24urxBn2BNPsZMkQxPcvDsNIqHdS5odnbCC+kFW
	cdtp/+x+eKrlsKApK8phNq5fcPhF/SXrsxKiEZyheXBI1jA617MY358SYZPDulPQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gkd35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:57:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O9napt017566;
	Fri, 24 Jul 2026 09:57:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gr5yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:57:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O9vfuG44564758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 09:57:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C224200C5;
	Fri, 24 Jul 2026 09:57:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00AB5200C4;
	Fri, 24 Jul 2026 09:57:41 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 09:57:40 +0000 (GMT)
Message-ID: <3b72c2c9-6dd4-4c28-bafc-326d31125a3e@linux.ibm.com>
Date: Fri, 24 Jul 2026 11:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/kvm: Add tracepoint for DIAG 9c directed
 yield operations
To: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org,
        svens@linux.ibm.com
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
 <20260625131615.262367-3-ciunas@linux.ibm.com>
 <71e16596-591a-4991-b217-ecdcf284ea67@linux.ibm.com>
 <4780639c-c5f1-474d-b51c-df9126ee6a1c@linux.ibm.com>
 <409ee2c5-d6d6-4d85-aedf-5645fa755680@linux.ibm.com>
 <4c4ca006-d5e2-4877-a4f9-702df91c013a@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <4c4ca006-d5e2-4877-a4f9-702df91c013a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX+sCQNJhiqS0X
 xHYCMMFyi7oIOaXoesIXuTeTY3RZDhRcwrcIhOmIvb6eGleUP1uwbLDP8jT0PtN6ADWxSQNh8gy
 9Kc4zNCZxu0EpiD6jge7kj/attCFosFVXzW9iufgXD3CubZ3Tj9XtGK1iL+Xc8FxahJbO5VOMkf
 jT4+OwiHhThOqUV/MnsGiiVUWHVPnTfNnnE+3nyelobIv1v9h1rvaOXSLmnzghDNbOWyka+fALc
 kTgHhJGLh3LyzR5xD5vzhYIRD1wvN7RUwdUwhUWDw5d+gveu3nzgN+KOu5JW3sdPM9PSeYzbsp9
 HedTDkd0eh/mPS+Dzj6j0SMorJufGr1lctw78a3irISVarNR5aA5zcLTv4VDbbP8YXJFx1aXf27
 VNkIJsohSVXayRCaqW4dj3Tp1tqY7qXpGrdhQiTtp0FAnJZ4CpC9G2bzEJ0NgFt+Ox4UjnHVwEK
 PFZWYLvHYehcQiuRAIQ==
X-Proofpoint-GUID: 4dNwkqfVqkA4GdgwKbOtqUm73r6fhUns
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a63371a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=fdmd8Z3vNSULM-V7rEIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX7pe/z5q3375b
 hUTO1v48jab3Czo5RpcYE2WQkxRYLF33dw0/uhuENC+5NvOdAiQUPDL/NqtJvesTV4LC1I4U+Ab
 g1BwUuse4s1YXCAHLmxSXxTiG+4B6oY=
X-Proofpoint-ORIG-GUID: 4dNwkqfVqkA4GdgwKbOtqUm73r6fhUns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240088



Am 24.07.26 um 11:00 schrieb Ciunas Bennett:
> 
> 
> On 24/07/2026 09:03, Christian Borntraeger wrote:
>>
>>
>> Am 23.07.26 um 21:56 schrieb Ciunas Bennett:
>>>
>>>
>>> On 23/07/2026 16:28, Christian Borntraeger wrote:
>>>>
>>>
>>> [...]
>>>
>>>>> +TRACE_EVENT(kvm_s390_diag_9c,
>>>>> +        TP_PROTO(VCPU_PROTO_COMMON, int target_vcpu, int target_cpu,
>>>>> +             const char *result),
>>>>> +        TP_ARGS(VCPU_ARGS_COMMON, target_vcpu, target_cpu, result),
>>>>> +
>>>>> +        TP_STRUCT__entry(
>>>>> +            VCPU_FIELD_COMMON
>>>>> +            __field(int, target_vcpu)
>>>>> +            __field(int, target_cpu)
>>>>> +            __field(int, current_cpu)
>>>>> +            __string(result, result)
>>>>> +            ),
>>>>> +
>>>>> +        TP_fast_assign(
>>>>> +            VCPU_ASSIGN_COMMON
>>>>> +            __entry->target_vcpu = target_vcpu;
>>>>> +            __entry->target_cpu = target_cpu;
>>>>> +            __entry->current_cpu = smp_processor_id();
>>>>> +            __assign_str(result);
>>>>> +            ),
>>>>> +
>>>>> +        VCPU_TP_PRINTK(
>>>>> +               "diag=9c vcpu=%d pcpu=%d target_vcpu=%d target_pcpu=%d result=%s",
>>>>> +               __entry->id,
>>>> I think vcpu=%d re-prints __entry->id, which VCPU_TP_PRINTK() already emits as the line prefix; likewise current_cpu/pcpu=%d duplicates ftrace's built-in per-event CPU column.
>>>> Can you double check?
>>>
>>> Yes it is and I was aware that VCPU_TP_PRINTK already includes the vCPU ID
>>> in the prefix, but I kept it in the message for readability.
>>> Having all the relevant fields together in a single format string makes
>>> the output a bit easier to grep and follow visually I find.
>>> That said, if you'd prefer to keep it consistent with the other
>>> tracepoints, I'm happy to drop the duplicate vCPU field.
>>
>> Yes, please drop.>
> 
> Just to quickly follow up on this: ftrace already prints both the vcpu and the pcpu, as shown in the output below.
> In that case, would you like me to remove both of them and keep only target_vcpu and target_pcpu?
> 
> [CPU 7/KVM-2066    [017] .....   827.871131: kvm_s390_diag_9c: 07[0404c00180000000-000001e619a6a9ea]: diag=9c vcpu=7 pcpu=17 target_vcpu=1 target_pcpu=23 result=ignored]

Its a bit harder to read, but yes try to avoid redundancy.

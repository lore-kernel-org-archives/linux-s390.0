Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582183546C9
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883652; cv=none; b=VI7Ioz1b2E9fktbm5kyRp7KlZrEEBdRxagm5m1k099hkjPJtMC94wf37TPZioyKCWA5MoOrs2GWjona1FYBWeVWEz5SxP9bjQ+0h6Ak0nqNiCx7PjiwgOl5Bmg2yY/PhNZI9n0wFgRJgppD/dNiYpJwXoRLkuAZ0q91Cn4vBg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883652; c=relaxed/simple;
	bh=wIGosUPqBec+oUqJSR/Sx28U1HcrOrh6Bltv8kxswqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBVJ8bP/fYVFYjJL4vJGhuAvx0S6GZbE41VIWSzf853Kg42HwtU15aupHdBHRuO4WydFB26g/nnnn5ceaFv1AnVuVOGtUAuj1cS+5rMmJmKPOvTo0jIlLxZFjkS1tIhX//PiWQ32omjoWfdN/vmPviv+7AyePJFdVS62bMvZD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EOWho2Qb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EOWho2Qb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bw7L798079;
	Fri, 24 Jul 2026 09:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ghrArP
	2puWMdRW0uyTmivHhcYz/qDPm+vMhq+hgoqf0=; b=EOWho2QbUeFvFrLupCCNnG
	5JsguG7/Mvekqx+FA5dWH6wYgQ87/Foh71pMXjPMmwafe9ZLaRiXE/MlY6SXZxsw
	O8lyCPaFlVFwOBtJwAHmlDdQGNUH7vjIh8CF6RuWIacA1Y7UA+S/+pEzZHXv7L4k
	z4Zci71WP3ql40WAZgMUtgnREKjAP8eEEYmx42Cr/xddhHE3QexH73x/Q18rprg8
	LLPZ2QyM49VxlCfrHNxm8A1/+YBJ9XBFX2RzTSa1iEalTpzau1zDCPWFS7ZUXTZs
	MAUkGsM8wXdCt9zWaV4tmrJoKUqBbOjChxmPCw92Z0Bzdh54tYGk/2izw2swf/8Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gk6t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:00:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8nine029010;
	Fri, 24 Jul 2026 09:00:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyqx11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:00:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O90hLW46858742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 09:00:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D18320191;
	Fri, 24 Jul 2026 09:00:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D40892010D;
	Fri, 24 Jul 2026 09:00:42 +0000 (GMT)
Received: from [9.111.78.39] (unknown [9.111.78.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 09:00:42 +0000 (GMT)
Message-ID: <4c4ca006-d5e2-4877-a4f9-702df91c013a@linux.ibm.com>
Date: Fri, 24 Jul 2026 10:00:42 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/kvm: Add tracepoint for DIAG 9c directed
 yield operations
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, svens@linux.ibm.com
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
 <20260625131615.262367-3-ciunas@linux.ibm.com>
 <71e16596-591a-4991-b217-ecdcf284ea67@linux.ibm.com>
 <4780639c-c5f1-474d-b51c-df9126ee6a1c@linux.ibm.com>
 <409ee2c5-d6d6-4d85-aedf-5645fa755680@linux.ibm.com>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <409ee2c5-d6d6-4d85-aedf-5645fa755680@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfXwHYsqz21KkPZ
 JAfNMneLgHpAVyNRdYQeVFVlZrUPMdlNNuTjMVJHdq9VN6ytqHO0sycM6OUWhvEooWHplg/9MeE
 3ur/4ay2Zje5p4aqxIBNDaWsKj99hyx8rxH/f+cIPIfNxUMu/FtV+c1StQRd0RenAzTYtDDPSwB
 vQcxX6+gXzMfwA+ghpfwgyKSrOhON5Ana4RR7BTolbp40shD7s/G8/9BUbx0YmHqpkHlJi5RSdI
 +wDDM22NMgaqreS3YRYy6SzhphMf/id14YXuxaV2vGEGEDtZMH/0MZ9Y6ymsB/ggxmclenlRvPp
 Bm1x3n7UP3UIOqZCw/No6O24kbpFb54+2MLCvt5FjF3voVd7bV8fwXw7TsizJAz2GzqkuWyNslV
 8pG0uV3Q9klvCXdZ6UZRKKtoseH/Cta5mdgo4DABONe/swGdGlq4GT8vxikJqUEi610d9t9MEIX
 ISBiJ1/lXN2ZDVXx4tA==
X-Proofpoint-GUID: VvVvGlm2eYTHeyc5jyK26a70JqMq7jHi
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a6329bf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=fdmd8Z3vNSULM-V7rEIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX6azTI+826vdP
 VO7GAaCtj3ak6h0C0nDJD06FQw8E7ODU2DneLYXztlljga0lSc/uxKGOKck7Mrif3dz525NSHIX
 QAoEdAnDpY+M+k/mZwSfIBck3flvfC0=
X-Proofpoint-ORIG-GUID: VvVvGlm2eYTHeyc5jyK26a70JqMq7jHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240078



On 24/07/2026 09:03, Christian Borntraeger wrote:
> 
> 
> Am 23.07.26 um 21:56 schrieb Ciunas Bennett:
>>
>>
>> On 23/07/2026 16:28, Christian Borntraeger wrote:
>>>
>>
>> [...]
>>
>>>> +TRACE_EVENT(kvm_s390_diag_9c,
>>>> +        TP_PROTO(VCPU_PROTO_COMMON, int target_vcpu, int target_cpu,
>>>> +             const char *result),
>>>> +        TP_ARGS(VCPU_ARGS_COMMON, target_vcpu, target_cpu, result),
>>>> +
>>>> +        TP_STRUCT__entry(
>>>> +            VCPU_FIELD_COMMON
>>>> +            __field(int, target_vcpu)
>>>> +            __field(int, target_cpu)
>>>> +            __field(int, current_cpu)
>>>> +            __string(result, result)
>>>> +            ),
>>>> +
>>>> +        TP_fast_assign(
>>>> +            VCPU_ASSIGN_COMMON
>>>> +            __entry->target_vcpu = target_vcpu;
>>>> +            __entry->target_cpu = target_cpu;
>>>> +            __entry->current_cpu = smp_processor_id();
>>>> +            __assign_str(result);
>>>> +            ),
>>>> +
>>>> +        VCPU_TP_PRINTK(
>>>> +               "diag=9c vcpu=%d pcpu=%d target_vcpu=%d target_pcpu=%d result=%s",
>>>> +               __entry->id,
>>> I think vcpu=%d re-prints __entry->id, which VCPU_TP_PRINTK() already emits as the line prefix; likewise current_cpu/pcpu=%d duplicates ftrace's built-in per-event CPU column.
>>> Can you double check?
>>
>> Yes it is and I was aware that VCPU_TP_PRINTK already includes the vCPU ID
>> in the prefix, but I kept it in the message for readability.
>> Having all the relevant fields together in a single format string makes
>> the output a bit easier to grep and follow visually I find.
>> That said, if you'd prefer to keep it consistent with the other
>> tracepoints, I'm happy to drop the duplicate vCPU field.
> 
> Yes, please drop.>

Just to quickly follow up on this: ftrace already prints both the vcpu and the pcpu, as shown in the output below.
In that case, would you like me to remove both of them and keep only target_vcpu and target_pcpu?

[CPU 7/KVM-2066    [017] .....   827.871131: kvm_s390_diag_9c: 07[0404c00180000000-000001e619a6a9ea]: diag=9c vcpu=7 pcpu=17 target_vcpu=1 target_pcpu=23 result=ignored]

[...] Ciunas

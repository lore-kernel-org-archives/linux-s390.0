Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC43F1AAD
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837654; cv=none; b=D2740bKw6SJxZbgOKb0S36IYXLU08B+ShGKb5UJ1eGrfTCgebixByQkboKk93RWDEyGTD53xw29XlpPGSm+thM+ZUafTjAEjRdzgzI3g63Ymz/tjotiL8QEVXLPMxPpGwLgpO4uwg3gLMXvE8qWvbfISVKlAHWgnkKyO5pFETvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837654; c=relaxed/simple;
	bh=Un9axPxA+PgRERWCCZyqKjP0km18ODwL3lmubjTM8MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubDMplHobPZ5/5oRz7wi0r97IvG1cjZyShp/EyuU+i7h64zn2sFLSTyo0oXp/8q/0qt0r0e/Q6DUobjnfKYmC/w4pUnrUVMVIBLFuLvdCmMSXzPzAj76ZNBLH+pRmrdJTAx7Y4nK7bphYr5HCRe5KGOmeNw5cvMr/HwBnDN1IC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gqi6eWCY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gqi6eWCY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NJBtGj3880244;
	Thu, 23 Jul 2026 20:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RSKIjX
	MlPjr7w9P1W+LdPrgwu02/0N9XKfhZdIR1a/g=; b=Gqi6eWCYSye7z7Og9/vUOv
	zuUJ1hR7PCBsN0xKEFLalABmVnoB1X1yZbX4c1835u6W9621dvey1UVithpULpVw
	Y710IDFo8YIjrGAe6Z/OMTP1ZSX2kQxDAt7FvhwnOIpenpAMDgX78IdomIXHLWR8
	HcZBKMp4OLxeTTG7f/dQtVSb8P4yV39Pc0Edvghc3VdZv2ePcDqTxMdXm6XYVOnI
	Yef28ij5biujZPPyFPdmspvnVvx38T6roFk4I8YMpoSY3KBwDr/FK7FRiCIWJfjy
	0nsgJZaA0sMe0983Uy5/INe53hkzGRAQqM8Ex3hBP9/JSDWf7u2k4OnmNdzY0GMg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahgtwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:14:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NK4fpr012373;
	Thu, 23 Jul 2026 20:14:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahdupp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:14:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NKE0kL34341176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 20:14:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21E642016F;
	Thu, 23 Jul 2026 19:56:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C9520176;
	Thu, 23 Jul 2026 19:56:32 +0000 (GMT)
Received: from [9.111.59.232] (unknown [9.111.59.232])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 19:56:32 +0000 (GMT)
Message-ID: <4780639c-c5f1-474d-b51c-df9126ee6a1c@linux.ibm.com>
Date: Thu, 23 Jul 2026 20:56:22 +0100
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
        linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
 <20260625131615.262367-3-ciunas@linux.ibm.com>
 <71e16596-591a-4991-b217-ecdcf284ea67@linux.ibm.com>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <71e16596-591a-4991-b217-ecdcf284ea67@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dlmdi6M9OMiF8Y4461E0i799PLjDLWEe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfX8QW9DiBxwoRU
 Ye6Uq9iMZQF9RFDBnXVY+9WiNTEhOhw5qf473GOzs8edkU/pmeV80ZlN2zGGKw/ZhAl+lWSgwHo
 voBA9D+ab5U16T4bQ2OVv5tB6Pqyv+2B4HoJai+OHMGionF/weC76Hvh9KrJG3V5uBoKdHfKKlK
 7TxdDUr/Elc3fre+KAARnsblow4BcRusDAnkSNYSbcM0ZRbaw8ZJ/3jA0BLvDWru60U2JB2HKgJ
 g6usTJW2WBZFoIkCLZW+lBzFYv1YitAI5Yd3i6wf1BGHTA2A4trz4zdUjBsA+lH1wvZKTTR8ysu
 sCmb8kG3YgEn/aqJXSHdlMjG7H9y1W0YRZlGefgGGUmfKN8wqtCDvBxRvgzQno+kdzsRevpV6Zr
 viCQoKLqv5CgDMM4To1bR3iWAimZi/+gg91+zEE26yKnrq83aNL85rdPlozbWWaWlX16qH91a13
 DkkD9x2rYWajcHmi1fQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfX4BIffdMj0eyD
 KaspCZRtPstYuHhQtnBD5jFajh5JkdbQ/YRzF7otCdPGqfuSfF/Kmya94jtwSSq9/nhDM15D3CA
 5z2XGraerT3fy3V+5udWptqh5l2QwrM=
X-Proofpoint-GUID: Dlmdi6M9OMiF8Y4461E0i799PLjDLWEe
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a62760d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-zd2vuy5fa4ByvGPDJwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230196



On 23/07/2026 16:28, Christian Borntraeger wrote:
>

[...]

>> +TRACE_EVENT(kvm_s390_diag_9c,
>> +        TP_PROTO(VCPU_PROTO_COMMON, int target_vcpu, int target_cpu,
>> +             const char *result),
>> +        TP_ARGS(VCPU_ARGS_COMMON, target_vcpu, target_cpu, result),
>> +
>> +        TP_STRUCT__entry(
>> +            VCPU_FIELD_COMMON
>> +            __field(int, target_vcpu)
>> +            __field(int, target_cpu)
>> +            __field(int, current_cpu)
>> +            __string(result, result)
>> +            ),
>> +
>> +        TP_fast_assign(
>> +            VCPU_ASSIGN_COMMON
>> +            __entry->target_vcpu = target_vcpu;
>> +            __entry->target_cpu = target_cpu;
>> +            __entry->current_cpu = smp_processor_id();
>> +            __assign_str(result);
>> +            ),
>> +
>> +        VCPU_TP_PRINTK(
>> +               "diag=9c vcpu=%d pcpu=%d target_vcpu=%d target_pcpu=%d result=%s",
>> +               __entry->id,
> I think vcpu=%d re-prints __entry->id, which VCPU_TP_PRINTK() already emits as the line prefix; likewise current_cpu/pcpu=%d duplicates ftrace's built-in per-event CPU column.
> Can you double check?

Yes it is and I was aware that VCPU_TP_PRINTK already includes the vCPU ID
in the prefix, but I kept it in the message for readability.
Having all the relevant fields together in a single format string makes
the output a bit easier to grep and follow visually I find.
That said, if you'd prefer to keep it consistent with the other
tracepoints, I'm happy to drop the duplicate vCPU field.

> 
>> +               __entry->current_cpu,
>> +               __entry->target_vcpu,
>> +               __entry->target_cpu,
>> +               __get_str(result))
> 
> result is a dynamic __string of three fixed literals — an int plus __print_symbolic() (matching diagnose_codes style in the same file) would also allow splitting "ignored", which currently conflates four distinct causes despite the commit's diagnosability goal.
> This is not trivial though, due to the VCPU_EVENT which also uses result. So maybe this is not that easy and feel free to ignore that.
>
I'm not against changing it to an int plus __print_symbolic() if you
think that is worth doing?
The hesitation is of course that VCPU_EVENT() cannot use __print_symbolic()
directly, so this would also need a small helper to map the result code
back to a string there. That means a bit more code for fairly limited
value in this case.
No issues to change it if you think it is worthwhile, but otherwise
I'd prefer to keep the current version and avoid the extra helper.

[...]

Ciunas

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D223C0A09
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880199; cv=none; b=cuUGhD4Yx6rBkVIARp+pRPZ4iFdD6h8yhraht/9zGILIeBlO9hmGta8guGlWGiVHd3si+uwA7848AkhFiRh1UCDMT5pvs2b6189yaCQHSvDEhkpkUWWr1G0Ew1HQbvnXeiEvmWu6//EeA9VEkBOuPmLTvZPxlUPfACwbNN6HxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880199; c=relaxed/simple;
	bh=wjf7Ik4CaAaGkKrCBodcd1FtV1Rs6cYq4M+JrLZt4io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4U/98jLzHIIgLHLN76uHdtSGhTZ13XEZRV7iZ6/tGaoIkOPQiz11hMjHh9/GFZpWv5n4/l0gmWsN4S8SW0QUmmLnjq0Q1BbnsdKLmTiJKxIzDo2EH6P6VCgwYF6fETBAfYp82e+Ge8Bm/D2xOJ6+xhsVZGWezZnD2a9xZVsdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OZpFbnYJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZpFbnYJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5BcfA903405;
	Fri, 24 Jul 2026 08:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RzYZWu
	E9PF0osv6qCGPMqPZekcujXxMOyz+EbOIjzHQ=; b=OZpFbnYJGTIh2BSRczuimD
	65z4vgan+kJxbqNYFAR680/AMBPITE2wEWh0bUhnSn1l/NhgS4rUi3B2VLOAzDUr
	psyiDwIWcJHgmdwfiOPqhrP4rgSl4z7Lc08J4P0+yS0sPlHdYS0lzcgBzcVjdPOH
	9tsiBZ+eR9yKk3LZUBTzh1BnuerqLfrH+vmmk6B5LUc+GRCQiegw2g7KYoAmjn3e
	iL9Qenex+XQlWb+PtUcOzQoxvjKXd4hwbT5xOL3vWEYDDd7uCGVZwxfXqxifBnfh
	VXcc211zy98mZ2KgXOJcLK4jTi1VdRk9I9/T7yklBId06AXEFMj26rD33xEd0r9A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abuqcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:03:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O7nonA023834;
	Fri, 24 Jul 2026 08:03:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyqr6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:03:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O838UV30933728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:03:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381212004F;
	Fri, 24 Jul 2026 08:03:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9E082004E;
	Fri, 24 Jul 2026 08:03:07 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 08:03:07 +0000 (GMT)
Message-ID: <409ee2c5-d6d6-4d85-aedf-5645fa755680@linux.ibm.com>
Date: Fri, 24 Jul 2026 10:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/kvm: Add tracepoint for DIAG 9c directed
 yield operations
To: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
 <20260625131615.262367-3-ciunas@linux.ibm.com>
 <71e16596-591a-4991-b217-ecdcf284ea67@linux.ibm.com>
 <4780639c-c5f1-474d-b51c-df9126ee6a1c@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <4780639c-c5f1-474d-b51c-df9126ee6a1c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfX8ZDClT7thzwz
 CGD/gfQ6urERV/2Rw3qnKIVYC9h43POmBV1mvvzJZM+RxVQcacNq4G48CHKhGjV2LSvOi7rQP+U
 l3CaezGdu1NMP50o0MmqBcCPcqNd0gjodvR5l+Nc4CzHHDWzTrhQIm1oisVAp0gwhsI/OxcTz88
 2sVwrKsGoCT/u9XZcUkyyxq2L3KwTpFAfR8b0QUI83aaqCqJRoqtDbuBG5effvh3TAMBh0+Z7cH
 DcHv2t8nKL/Upc/9AkE/GsRYiWEx5GVQkb65vka7gDRRGpTNklezrKGRzIG/ujR1DKokECX1PhK
 REiiwqtZa+X7O3pAthJDnfjWqdc9mD92+Fob83eizkZ5G66t0+WqwsYZhoBgSxK+LrbMmJV34Lt
 dFk7Fpp2KLQCyh6rhhvzOZMrbp+MJGGMw688iTiBObLl6xK1fHTbAW+WhMEND7myhvQ5F60Z7S4
 kD1XL+IffJbYpPIMMow==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a631c40 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Q66GB76_kSgIYyHDdBoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YIbjHLEsE0bzPksa5i9KwO-ZijYnv86L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfX3O9UwFg8cvqU
 Lr75iaKioC6+HR8IeexIwrKPUth8SeaXrw+/fTO4iGWg1+mrClSjzGdG4+JVcKMy0srImoBWqUf
 u/qQcFy65S5q5xXx7EhCiLVZgjn/3rU=
X-Proofpoint-GUID: YIbjHLEsE0bzPksa5i9KwO-ZijYnv86L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240069



Am 23.07.26 um 21:56 schrieb Ciunas Bennett:
> 
> 
> On 23/07/2026 16:28, Christian Borntraeger wrote:
>>
> 
> [...]
> 
>>> +TRACE_EVENT(kvm_s390_diag_9c,
>>> +        TP_PROTO(VCPU_PROTO_COMMON, int target_vcpu, int target_cpu,
>>> +             const char *result),
>>> +        TP_ARGS(VCPU_ARGS_COMMON, target_vcpu, target_cpu, result),
>>> +
>>> +        TP_STRUCT__entry(
>>> +            VCPU_FIELD_COMMON
>>> +            __field(int, target_vcpu)
>>> +            __field(int, target_cpu)
>>> +            __field(int, current_cpu)
>>> +            __string(result, result)
>>> +            ),
>>> +
>>> +        TP_fast_assign(
>>> +            VCPU_ASSIGN_COMMON
>>> +            __entry->target_vcpu = target_vcpu;
>>> +            __entry->target_cpu = target_cpu;
>>> +            __entry->current_cpu = smp_processor_id();
>>> +            __assign_str(result);
>>> +            ),
>>> +
>>> +        VCPU_TP_PRINTK(
>>> +               "diag=9c vcpu=%d pcpu=%d target_vcpu=%d target_pcpu=%d result=%s",
>>> +               __entry->id,
>> I think vcpu=%d re-prints __entry->id, which VCPU_TP_PRINTK() already emits as the line prefix; likewise current_cpu/pcpu=%d duplicates ftrace's built-in per-event CPU column.
>> Can you double check?
> 
> Yes it is and I was aware that VCPU_TP_PRINTK already includes the vCPU ID
> in the prefix, but I kept it in the message for readability.
> Having all the relevant fields together in a single format string makes
> the output a bit easier to grep and follow visually I find.
> That said, if you'd prefer to keep it consistent with the other
> tracepoints, I'm happy to drop the duplicate vCPU field.

Yes, please drop.> 
>>
>>> +               __entry->current_cpu,
>>> +               __entry->target_vcpu,
>>> +               __entry->target_cpu,
>>> +               __get_str(result))
>>
>> result is a dynamic __string of three fixed literals — an int plus __print_symbolic() (matching diagnose_codes style in the same file) would also allow splitting "ignored", which currently conflates four distinct causes despite the commit's diagnosability goal.
>> This is not trivial though, due to the VCPU_EVENT which also uses result. So maybe this is not that easy and feel free to ignore that.
>>
> I'm not against changing it to an int plus __print_symbolic() if you
> think that is worth doing?
> The hesitation is of course that VCPU_EVENT() cannot use __print_symbolic()
> directly, so this would also need a small helper to map the result code
> back to a string there. That means a bit more code for fairly limited
> value in this case.
> No issues to change it if you think it is worthwhile, but otherwise
> I'd prefer to keep the current version and avoid the extra helper.

Keep it as is.
Thank you for doing this.

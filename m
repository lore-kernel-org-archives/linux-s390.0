Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50943B3FF
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820513; cv=none; b=Ry25o3AlUkim+xwitaIzhtjEuFwXSwHeV+MefXfGTMiZjqyqGAbbFxg7fepJpfQW20H2yXQybNphpXH4UW8u/8p2zWXJ3zLE1AZPogP3HH2CZqhPuRNVnZHoTIT4OeGJSHfr3N5myduMjOhDylpWiu6pCXVXPaWClZf0xRGcdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820513; c=relaxed/simple;
	bh=UDQwDvoJqNufhQ6nRO4ZNXNxQ2zuA/RwKssNRHs/9b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd5AzuomWYZJ5+HyONIVnBusDbR1EObMriWkA4ucqVa2tOzUIGRNt11Oo/fgABUbQka2LYHYct4hoDruvmYPxSZqfpYsi4kWXU24EYYOCl16oloBeAqFSsYsO2W3iFAST0Zr3v28zYGeI8ToGJ14fxyWy3rhQNtAt361ay2azTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TzfOCWEq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TzfOCWEq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBic03094723;
	Thu, 23 Jul 2026 15:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mcD0fD
	FNwfo5nL5TCX7S2Nwvq/3pqm2S/irV18ByPBc=; b=TzfOCWEq+CB7WeMURF2Oau
	VyyTpTh8VUm3IdY1dWQRxKxEdkS+ZRxJoGir1T0dWUyXGVWBbg5sBSXX2j7NjNiN
	Fm9ZjStinbRhJ/aEdGBPE2oXfxC2r3DKoOLlnmRpr4LkT4cQLr/+VJ5nyrQr681z
	lI1+1HdchQ5gmqk70lAVvsF/7/Ktu+oGX6GUdtqJxdDTaq/iwSC/ZjHlkFRw+drw
	yjec2DEZpBYdHK27aJSUFbMMxtMp4MfPLo87YuyqF6Wl32xxjRmzuGKJOZqirs4A
	sxnBv6XIiLkfaEBZUmymQaycTQfCO4Q34jeSdsSW8Kb6FKlStu56mPv9Db8A6/3w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahfp7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:28:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NFJgZR024623;
	Thu, 23 Jul 2026 15:28:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4tjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:28:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NFSNAO47645040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 15:28:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D53BD2004B;
	Thu, 23 Jul 2026 15:28:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7102A20040;
	Thu, 23 Jul 2026 15:28:23 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 15:28:23 +0000 (GMT)
Message-ID: <71e16596-591a-4991-b217-ecdcf284ea67@linux.ibm.com>
Date: Thu, 23 Jul 2026 17:28:23 +0200
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
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260625131615.262367-3-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bf6r_8efEUtXiQiF80keJL7LSCrOPtW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfX0gM+jg3khp8M
 lOsMMr/vThGobUxln6V+HMD6++PJOHoM+fV8Z9zNjMNqQql70IAkWwjkPlfyB//J9v564UtkXZq
 7hDsppFM0To9HbaRPRYaGo1S/fP1deZgzACDw1SIKt7PxlI7pZmMhX5iOp/4rpfQuP2BKDovYG2
 7e8eNbEfKWJp/cV4PyjT/i6OuQO96jqcqx/aeFD/4zDCR5aWXbNoj9A5NudF85t2VMuh24/Wg4C
 PNUpkkb6KjCgShhWk1bdWaIIdUcNjCwxzmPoqfetMZ5gvfIwMMCUZP4L2ULlUbLi7sta8fxGgNV
 qzMjdova4LMzdpi71ewEwmLAgI9MsgEOGQ9KftxAkHpPdFdasZMCPsirWSZS4FpMmoWFVqzyl7g
 We/cObrARQm7MZsh/C6NqiyHKnm8Nx+KiuDpUvFyHLpT6BRXaScrTmuoOyJ64FxmrYKT6nu36Iq
 DIkH8LPZXL9ulet5xUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfXxBH9Lfm31eHb
 IT5n0aKoDQlrWwds3LykGrkpy3YHu7sIPslQKJe0TcriDTaz3qmQY6gaodwnGq4ClwrwtfIoPwK
 6QJyoIGjIZNhoAT/feYVJRNg09U6amE=
X-Proofpoint-GUID: bf6r_8efEUtXiQiF80keJL7LSCrOPtW7
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a62331c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=BM3haevJdxyxnGiVQXUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230149



Am 25.06.26 um 15:16 schrieb Ciunas Bennett:
> Add a new tracepoint kvm_s390_diag_9c to provide detailed observability
> for directed yield operations. The tracepoint captures:
> - Source and target VCPU IDs
> - Current and target physical CPU numbers
> - Operation result (done, ignored, yield forwarded)
> 
> This enables better analysis of VCPU scheduling behaviour and helps
> diagnose performance issues related to directed yields in virtualised
> s390 environments.

Nothing critical, just some ideas.

> 
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>
> ---
>   arch/s390/kvm/diag.c  |  1 +
>   arch/s390/kvm/trace.h | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 85c84421b510..031ab6e5d6c4 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -228,6 +228,7 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>   out:
>   	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
>   		   result);
> +	trace_kvm_s390_diag_9c(vcpu, tid, tcpu_cpu, result);
>   	return 0;
>   }
>   
> diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
> index aa419eb6a0c8..2d6da21f590c 100644
> --- a/arch/s390/kvm/trace.h
> +++ b/arch/s390/kvm/trace.h
> @@ -283,6 +283,36 @@ TRACE_EVENT(kvm_s390_handle_diag,
>   			   __print_symbolic(__entry->code, diagnose_codes))
>   	);
>   
> +TRACE_EVENT(kvm_s390_diag_9c,
> +	    TP_PROTO(VCPU_PROTO_COMMON, int target_vcpu, int target_cpu,
> +		     const char *result),
> +	    TP_ARGS(VCPU_ARGS_COMMON, target_vcpu, target_cpu, result),
> +
> +	    TP_STRUCT__entry(
> +		    VCPU_FIELD_COMMON
> +		    __field(int, target_vcpu)
> +		    __field(int, target_cpu)
> +		    __field(int, current_cpu)
> +		    __string(result, result)
> +		    ),
> +
> +	    TP_fast_assign(
> +		    VCPU_ASSIGN_COMMON
> +		    __entry->target_vcpu = target_vcpu;
> +		    __entry->target_cpu = target_cpu;
> +		    __entry->current_cpu = smp_processor_id();
> +		    __assign_str(result);
> +		    ),
> +
> +	    VCPU_TP_PRINTK(
> +		       "diag=9c vcpu=%d pcpu=%d target_vcpu=%d target_pcpu=%d result=%s",
> +		       __entry->id,
I think vcpu=%d re-prints __entry->id, which VCPU_TP_PRINTK() already emits as the line prefix; likewise current_cpu/pcpu=%d duplicates ftrace's built-in per-event CPU column.
Can you double check?

> +		       __entry->current_cpu,
> +		       __entry->target_vcpu,
> +		       __entry->target_cpu,
> +		       __get_str(result))

result is a dynamic __string of three fixed literals — an int plus __print_symbolic() (matching diagnose_codes style in the same file) would also allow splitting "ignored", which currently conflates four distinct causes despite the commit's diagnosability goal.
This is not trivial though, due to the VCPU_EVENT which also uses result. So maybe this is not that easy and feel free to ignore that.

> +	);
> +
>   TRACE_EVENT(kvm_s390_handle_lctl,
>   	    TP_PROTO(VCPU_PROTO_COMMON, int g, int reg1, int reg3, u64 addr),
>   	    TP_ARGS(VCPU_ARGS_COMMON, g, reg1, reg3, addr),


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581A41687C
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895531; cv=none; b=RRN+o0zyhZa6QqqKSF8iHx/P+N+Sq78sATRh9fHAZdzaO9XSkbCpKFTcT+38UrRnomwJDZeN/j4iDxOFZaSQwu6M5KlEYjbZ40AoTJPvFh5vTFgqF2cQSTudlzXgZPQb2XeYaAleq/lRkKVOWYl6/9gNsT7X6VEhG3ntf2UhcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895531; c=relaxed/simple;
	bh=/JPKHuFY2iBOrPNCHkDVEXDJIBdIKwqRAR965Im76Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAo7vY0hVkCv1cqEEhXQQpDJWKSDVwkqt+2bfEACWpWITUmssLqQE2twQA5FX9nsHXInVA8MhBjDs45TzcD5WksN+OuOx5o7ClKuS19cHfZLlg0+i0gASxQDmwPBI32JtrbMlglKVyuCy85sYcCdKR0A06jaJ3ViomxICOqvr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YHNWY8CL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YHNWY8CL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCCiBr4100564;
	Fri, 24 Jul 2026 12:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gfKn0B
	EWX641f1OfY7WPu1nPF0JPvk8a3dy67a+US8w=; b=YHNWY8CLLZdCZ0f2H1JkXZ
	zLQqVZnXf6bSQ4fIkQ19JPGUhwTm58Cgp4WV377DW3/tS0JnyF7DbdYbHpvWAggg
	QbS/3Nch043e0vGClGgla9WmmDh6VCOTzNRVjCaK1CM93BVLN14b2IavE7eRwLOm
	ay663IPfv8RjsDXCdzEELR7oRTwH1ptVC0lVWk534ZyAHERAggk3rez6eV+xEtRf
	VSfGvq/Jfp1PmriyV4PwMXgw2QV4HFCNPcoQiERyaffUSklhZapMUBqkjskrVusj
	hwjsVagEnH0OHNhdrd4GiftNfucENXYOSv3+WBRQ+DpFXlgcSqNUAWb0KfuOZVMA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77avk6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:18:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OC4krC028706;
	Fri, 24 Jul 2026 12:18:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyrj0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:18:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCIf9442271194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:18:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D762009E;
	Fri, 24 Jul 2026 12:18:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2562F2009C;
	Fri, 24 Jul 2026 12:18:41 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 12:18:41 +0000 (GMT)
Message-ID: <83a043d0-e42a-48ca-8193-93b4b55b69e9@linux.ibm.com>
Date: Fri, 24 Jul 2026 14:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] s390/kvm: Add tracepoint for DIAG 9c directed
 yield operations
To: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com
References: <20260724103959.14861-1-ciunas@linux.ibm.com>
 <20260724103959.14861-3-ciunas@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260724103959.14861-3-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lCBMoaHl-KZ7wLel5vJjFqycqZGAy5RW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExMSBTYWx0ZWRfX+Oir1kMhSU4e
 ZiDXinb/xk9ZXHb7tpp+bG2NZtrmhGnD1069w/dK+zQUVvua1DNpvuoj9dYiLANaIUpcC5MBiZC
 oPq7QLxfAOcLZgqQzXlJs4M0ICGEFxc=
X-Proofpoint-GUID: lCBMoaHl-KZ7wLel5vJjFqycqZGAy5RW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExMSBTYWx0ZWRfX4wP7yjM7l/OF
 tmEC1K+dBXuI2RXTtuhTiRArS+5oa+ibevJqr+zfOL7cnMG9ilis/nbZTZMf3rRoffdcWPVjTvx
 RX+sSDqlBLgMXo/MeX58f875bY93imkS2PYCeAnQQ186aatfIfCfrNKgkulCR+L6++RooziAp5P
 Liyplo6Qf+YOi2/Vmx81rkuMNWViYAMbLpuubVD11p5VilpunqJeU49LX1kSEnoUJ+yXmSaNZ63
 xt18R9gEwRGDmqzzzt7E3BJZEX5XIS7ImAhQhXpEXeoTvNfXoKEQ/1Wk+wj6zT5+bzp9uunPhLB
 8/G4MMixVTyyIot/CBXwOBmKFSGMEIXxfY657WcUBqZiQ1+FX7VBottkfeAvyoX1OC8g2AKDAK7
 pTOC16vlz54Xf0o4GCzFCcnMjqSD2MiI6X2oQ/tfdXbFKB6nqkNRuSfxBW0jlVmXklypw3prWlL
 5SkoI9IK6DxvKfkNedg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a635826 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=nAbXOUM1j8rPql2SkEwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240111

Am 24.07.26 um 12:39 schrieb Ciunas Bennett:
> Add a new tracepoint, kvm_s390_diag_9c, to provide visibility into
> directed yield operations. The tracepoint records:
> 
>    - Source vCPU context via the standard vCPU tracepoint fields
>    - Target vCPU ID
>    - Target physical CPU number
>    - Operation result (done, ignored, or yield forwarded)
> 
> This improves observability of vCPU scheduling behaviour and helps
> diagnose performance issues related to directed yields in virtualised
> s390 environments.
> 
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/diag.c  |  1 +
>   arch/s390/kvm/trace.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
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
> index aa419eb6a0c8..dd2685c7df5b 100644
> --- a/arch/s390/kvm/trace.h
> +++ b/arch/s390/kvm/trace.h
> @@ -283,6 +283,32 @@ TRACE_EVENT(kvm_s390_handle_diag,
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
> +		    __string(result, result)
> +		    ),
> +
> +	    TP_fast_assign(
> +		    VCPU_ASSIGN_COMMON
> +		    __entry->target_vcpu = target_vcpu;
> +		    __entry->target_cpu = target_cpu;
> +		    __assign_str(result);
> +		    ),
> +
> +	    VCPU_TP_PRINTK(
> +		       "diag=9c target_vcpu=%d target_pcpu=%d result=%s",
> +		       __entry->target_vcpu,
> +		       __entry->target_cpu,
> +		       __get_str(result))
> +	);
> +
>   TRACE_EVENT(kvm_s390_handle_lctl,
>   	    TP_PROTO(VCPU_PROTO_COMMON, int g, int reg1, int reg3, u64 addr),
>   	    TP_ARGS(VCPU_ARGS_COMMON, g, reg1, reg3, addr),


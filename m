Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D14156C5
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895056; cv=none; b=MI9ehDyzAkD6M4tDwUHiBS2tGfh9qxYf4fOqSkoYz6EbMjv90+GaA5CNN5A/NFQgzAnuoD+1pUh+/ONO90fmXsFxwKKnFc4rM4w/Xa3DFH596RjQ/YVbsyiQIMQnPpaLO3Cp7eGsIMR0Xh7pUk28bEnq0r5bP2LjwRJWYr0ONAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895056; c=relaxed/simple;
	bh=T3qH4RcaijpnQEwUON88tWs7xzy7uE9XIbRohD7sbmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3nEVd8tzlMmTrm9buaG8XXFprWTh6Qa1VGeDGL5rflkFb8rlvVedQbQmJoHD+N9vOr5C8yZ/XhKrYiRYjYoiEi20jPmLieBA1vnBWAaR/9gaBg4iCaHk2+MrldhZGuPrDBC2uzaLLOKVqunB0a1rL9cDxiJU+0HMaS3pKX5xZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=baW7q7WH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="baW7q7WH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADGW11550244;
	Fri, 24 Jul 2026 12:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oQX0Ui
	MUAMVt2jhPu+gNkh2r2yjhlspYTgarKGBSVOg=; b=baW7q7WHaVIA6mwZo8D1+K
	YM21u0wVvb0tHCAcsIwN03s17tkZ+0lglYmqVL27leNoBahi/s+SOvaUBYLeey+8
	CzohFoNOI54cCYWksWSLvguc7iUVpOBaKBT4uM47D0Q+N+lPH2tX/Q44t2bGCXTt
	XdRnAxYX6AzUqqBYPJAkhM0FyL86dZcJ+4VOj98JeGjXDsIg1oR1fIehZYJrzBIW
	eRCZa0G5paUulEtYQHZ+CSrt3wwuMlNZYQ2dyv0IHslBr6G1KZlj4VuUKgFOfhXa
	/Yg0HD+QO7qj9V5b4R7Col5gd3CloVCi9LxYDowZFqiRO00L7SK+FAkJ3XH0skhQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791cje2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:10:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OC4dZt001949;
	Fri, 24 Jul 2026 12:10:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqgyfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:10:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCAljL13828552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:10:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A9902016F;
	Fri, 24 Jul 2026 12:10:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF8292016D;
	Fri, 24 Jul 2026 12:10:46 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 12:10:46 +0000 (GMT)
Message-ID: <6419990c-c9f0-4a1a-ad80-c324b77d00e1@linux.ibm.com>
Date: Fri, 24 Jul 2026 14:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390/kvm: Refactor __diag_time_slice_end_directed
 for single exit point
To: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com
References: <20260724103959.14861-1-ciunas@linux.ibm.com>
 <20260724103959.14861-2-ciunas@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260724103959.14861-2-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ajCl58_WF7tvJ3pghhZyfwUxIXWJDHZm
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a63564c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=uzxnxIlgG1-5XWEOJ2kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwNiBTYWx0ZWRfX/kVzyMiGGSlw
 ++IYgK90P7Z7Fw1ij/w/Z3DrKmdFOroLPUdXUIdmP1jOLClab7jOiEXqdD8qaGeFBnSuLFyF/Uz
 43GRHxbx8+zZtQAVutaVJ9uVEeryfzY=
X-Proofpoint-GUID: ajCl58_WF7tvJ3pghhZyfwUxIXWJDHZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwNiBTYWx0ZWRfX85VCuD6qPXig
 ImFzu20tm/kCorgDkJA/ISJ38QsCHjtME8NNRyJqUjPdcrcuuHJcQFXvHh2mlMOhKdiSZW9xgch
 BtJvPVaRxVvLlg02BmCFnCGMd3iIhXIWfGhruANirJS4oPtE4i2X4yPioP64ph7dbSmRgpZWUqL
 +Lf3MlmXkEXeEoKMEUVTq/P04fnnDcvWBgvV5M4j8q2fkOyDFrgbmTM51+1uhaT1+BlXb1aQlle
 jCc4pSnI9x+HJFz09uiT3Gd6/cU+hfQwwD8yrebt04YCUmeFo/NbHPoqBTIIfPXJOxafmRol+fL
 rgMp4+hjuBDzqik9UMnhJuVu1vo8cQy6lvl2capb0M5fWc5emxH2JYTL8I3YjhpBUKkzL0lv8JZ
 Gu3A+oDkuYx5bSpRrpC9Ybno00752dg+IMHGuJo2g+cqR54Pugv7NeeqAXnz8ZHOKjDT/EWBd2O
 C2mR77PMl+k3yngHbjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240106



Am 24.07.26 um 12:39 schrieb Ciunas Bennett:
> Refactor the DIAG 9c (directed yield) handler to use a unified exit path,
> improving code maintainability and reducing duplication.
> Changes:
>   - Consolidate all exit paths to use a single 'out' label
>   - Replace multiple VCPU_EVENT logging calls with one unified call
>   - Introduce 'result' string variable to track operation outcome
>   - Initialize tcpu_cpu to -1 for safe handling across all code paths
>   - Ensure statistics updates occur before the common exit point
> 
> This refactoring maintains identical functionality while making the control
> flow clearer and easier to maintain. All three possible outcomes (yield
> forwarded, done, ignored) now converge at a single logging point
> 
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/kvm/diag.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index d89d1c381522..85c84421b510 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -186,7 +186,8 @@ static int diag9c_forwarding_overrun(void)
>   static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_vcpu *tcpu;
> -	int tcpu_cpu;
> +	const char *result;
> +	int tcpu_cpu = -1;
>   	int tid;
>   
>   	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
> @@ -211,21 +212,22 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>   		if (!vcpu_is_preempted(tcpu_cpu))
>   			goto no_yield;
>   		smp_yield_cpu(tcpu_cpu);
> -		VCPU_EVENT(vcpu, 5,
> -			   "diag time slice end directed to %d: yield forwarded",
> -			   tid);
>   		vcpu->stat.diag_9c_forward++;
> -		return 0;
> +		result = "yield forwarded";
> +		goto out;
>   	}
>   
>   	if (kvm_vcpu_yield_to(tcpu) <= 0)
>   		goto no_yield;
>   
> -	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: done", tid);
> -	return 0;
> +	result = "done";
> +	goto out;
>   no_yield:
> -	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: ignored", tid);
>   	vcpu->stat.diag_9c_ignored++;
> +	result = "ignored";
> +out:
> +	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
> +		   result);
>   	return 0;
>   }
>   


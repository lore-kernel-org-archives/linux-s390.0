Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027A33263B;
	Fri,  8 May 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234071; cv=none; b=KjRvSM24XZEIBnISeMruD9ss+Tu4dwYlbQHeERhjFzQURsGqBfaXQzcPMh2fhszDtU+bigyuXwP05tkJ1Z2jvGS9piokyycgoPZAmNHvuphgnuvvhxKJ/Pew1fGHHwQ5SBDRMqKrjq2410y9Ad3f9tQuohkl4H0LS/PkPzZtTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234071; c=relaxed/simple;
	bh=3UWWu+PmEDiFALmPE4N1tp9tyWVELBHZ2UV2eh3JVJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrD2MVdYs8kqcItJOyZivhq21PMCLFN+duVabcCLroJya8aIKBRZ87V5rQITHwSfNqLnka3u62d32XCA1+fJWtx/j1BPdHXv2h/D5y4MQq+FklZhJNw7GLx/hVOX15udN8Q5ja+YoLu7Bv2YERptItIWqxJkm+CyBLXcz1XJrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rWJnC+XO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rWJnC+XO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6486URDX067384;
	Fri, 8 May 2026 09:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xb2zy0
	u68s8ybmmqnW/cQZFqedf0nqTXc99dMsGGG2M=; b=rWJnC+XOJ1zvjzfjARfyvL
	+VIPGf8LvXA4yu4N0znX18i9Fyf/5gS1vNhlg5nxVepd/5+wHTSR5cREGRFetnSQ
	EyNmVunN2ND0lUJ6CqBWdgR57+RMuk/AwoFtjuxx16VRlPPEvVgylV23V2vWkzwk
	FR7u5kgAJDvgCDsFSpBaDa0tI9m5RwLx13sIMcMOYY2DfDo6vZbQBmbGuG9//+FK
	vNrx+ifeaCXJdALKFh0+5MCy5zQZt7TuvFjPeytxsBNSwp4oFOWYSMFo50f2ZO/T
	9CBOaVNLkhZrtRRba04Nr/sxBIUsXOpYI2V3efrYselXSmmYztno3JsqJa21BeQQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1u1xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 09:54:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6489sQBI016266;
	Fri, 8 May 2026 09:54:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e10072pu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 09:54:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6489sNX147907298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 09:54:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2668220075;
	Fri,  8 May 2026 09:54:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEEFB20074;
	Fri,  8 May 2026 09:54:22 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 09:54:22 +0000 (GMT)
Message-ID: <a8a40679-8949-46f3-a268-3952ee409a64@linux.ibm.com>
Date: Fri, 8 May 2026 11:54:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Toggle operation exception for
 userspace
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260507200836.3500368-1-farman@linux.ibm.com>
 <20260507200836.3500368-2-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260507200836.3500368-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gBAtNf43uLBuwCpTybUbkFgZi433yBDl
X-Proofpoint-GUID: gBAtNf43uLBuwCpTybUbkFgZi433yBDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA5OCBTYWx0ZWRfX2fqDm7U2QvQd
 XtrNZH7kBzCyGFZkmz7NDkm8glC1v5Yqfj/QQ7TVX5WbYf4ThSfUvSNw3f4g0TDZrQ9rLL1S74f
 gB1Zzdvxmniz41RuMwq5EamH1c/7dhEZEG0iGZPkrbps8N7NktKErQs7Ub6G3Cy3RhYJsVuE6aK
 YqF+T6PFlj6k+NKWRitA6yBiODYThTt+Xo4HmTGjvNdjmgPcENb9TZXWztyovOp8WQ0PYQuo20E
 iOfmD+HJ/wX3y3gg4WvFZihENxk8XBLVyTcLHMXP480P1eG5mi3MZp8Ap8y/YhZp2onmb2AvUB2
 5FTbjOLeKELJYkIDVnZ8HaYN3LaESDEepVOX30k24Wjbbs5pncSISVQOBdka3E+mAgWTXKxCfJI
 q66KOpzKYFeaD7NpsRaf+O1wSgvsQKj/XL5iSuxJKAW3wUiafQKLX3OPSc3YsH5nMAc/lAK+MDX
 jcnKGdpPk5aSfqQ1JfA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fdb2d3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=cZKMOd1B8ittd17GYGgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080098



Am 07.05.26 um 22:08 schrieb Eric Farman:
> The KVM_CAP_S390_USER_OPEREXEC capability allows operation exceptions
> to be forwarded to userspace. But the actual enablement at the hardware
> level occurs in kvm_arch_vcpu_postcreate(), and only if STFLE.74 or
> user_instr0 are enabled. The latter is associated with a separate
> capability (KVM_CAP_S390_USER_INSTR0), so the only way this happens
> for the USER_OPEREXEC capability is if STFLE.74 is enabled. KVM
> unconditionally enables this bit in kvm_arch_init_vm(), but the guest
> could disable it from the CPU model and thus ignore this capability.
> 
> Add USER_OPEREXEC to the check in kvm_arch_vcpu_postcreate(), such that
> either capability would enable this type of exception.
> 
> Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards operation exceptions")
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/kvm/kvm-s390.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e09960c2e6ed..a91a42174302 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3521,7 +3521,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>   		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
>   		sca_add_vcpu(vcpu);
>   	}
> -	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
> +	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
> +	    vcpu->kvm->arch.user_operexec)
>   		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
>   }
>   


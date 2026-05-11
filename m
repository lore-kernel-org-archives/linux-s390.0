Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E93A7F52;
	Mon, 11 May 2026 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486498; cv=none; b=igbOffAGVymPW7ZsVktsilnHVlKHS+WKqpdxhtUFZMMBaaXAnk+kGkqzeqcBfzQsank3SpMAo91u1vyRpOBLY3OVIu/Gzp5bQVXMNEd6jUduWf30EYoavifb5DdjMembSFXKZSfz6KrdRsmFLybRpE5jNNQKglU75fXqwBNUXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486498; c=relaxed/simple;
	bh=BH6VBUTB6gFLCslLqkLZ23R+HGbKKflB3AwnS/Yy0Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prMXfdsYcp4PPb6qRLEnqIGYHNcO+TOCl4Z+yCmfu/kZZWfdpbL6xzWGf5z1DMfTQyJzJJqozXL8Wu67jpp1nDWfrLgsp8kSD+5n1mrQah9R3yqiPERihRTRG3lw9hRJFIxQ2hw/X7mJlrqjgPVMFbpzz9q5vzbAp6hCcS3vdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oUlxVKjt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oUlxVKjt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AKlWaZ170022;
	Mon, 11 May 2026 08:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=86j3uI
	MKfuxtW2jG0bgUL7H8gpKJHVsY17aCgSC6p5g=; b=oUlxVKjtFcPZxUop5PLQ/i
	tp4fgsdQwF9AUXKGOfFKyccGdMTGQM93uosN2Fyq/KQmyQ+d6Kb9NToT0IzTnlIv
	VFbKNgsEvYmPpxeFwILNoYrdNQWBCijPS8cgzyOqWaLpUJJW6/MjFdShbSiUaKus
	I/lkXyG6p9DwQvIAQajzcLvEBsYoDhpm3FSNoBReCKMFZm94LX+rq7davdhUJY2I
	McbCnC7BXb3NnTWXmAeRqaTR3G59UWet/Ps3u5iUf+cgB442o8NaxQ+I81U62cL6
	qldW6MdA9xgZ4QtBfO/2EBJLHNGvqtG+437a7ABVqbpNc4+hl9Kjt0XtMWsHJ3gQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhpyk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 08:01:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B7sb5r014743;
	Mon, 11 May 2026 08:01:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvvdn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 08:01:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B81LMt41091534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 08:01:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A982004B;
	Mon, 11 May 2026 08:01:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B95E120043;
	Mon, 11 May 2026 08:01:20 +0000 (GMT)
Received: from [9.87.154.62] (unknown [9.87.154.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 08:01:20 +0000 (GMT)
Message-ID: <e1113713-56a5-4616-b417-231399b5ddc1@linux.ibm.com>
Date: Mon, 11 May 2026 10:01:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Toggle operation exception for
 userspace
To: Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260507200836.3500368-1-farman@linux.ibm.com>
 <20260507200836.3500368-2-farman@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260507200836.3500368-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a018cd5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=cZKMOd1B8ittd17GYGgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _ScXRlhyYawpq5XeDry357iKv0DZ0j6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MyBTYWx0ZWRfX8JMrZ3G49KOj
 D39vscnqk6o7F/PX2TW33NjvLGTDmGP9+M5EG1lJ27hB/wlWSYbZflGhRDvKDEN/aWVJDQ7A4nb
 VVl0MPnfWY6oEtFpip5Vbpci5e+/IRnPaWOzL8cXrK+FpHQEwOMEfDIIpcKLSH8tnHeqw3IG31m
 bpmfAMQEPL6W+Q3MnuENzasM/xQzKxpUOXjqpwQF3eFZk3V09rI6zxdiScAuXg0/elOoz71oFVe
 SqPmBadTvnzqQ01vH6c9gRl8c90DG9v5kGUa49yaPI0s2jN82Q/ar6/asb3toR3s4oafcvz9v/+
 XQhLWhOGKe/bRDl/8w0jcvqZLbdph8YR+F7hRfJ4TTEaKzTV16DFcjFuO2cp25RjmyT9QqqyKSy
 t2XBEERtqCkzDAlmVuXZb0+7QCsBu+7XvciBhCf4N7ITF3kFqXjNyelh1uUVssJZ3NrmilbwpTh
 laXyNDU998FMGACKR7g==
X-Proofpoint-GUID: _ScXRlhyYawpq5XeDry357iKv0DZ0j6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110083

On 5/7/26 22:08, Eric Farman wrote:
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

It boggles my mind that I missed this, sigh

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

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


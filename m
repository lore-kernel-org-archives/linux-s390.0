Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536204779A9;
	Tue, 22 Sep 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082319; cv=none; b=b626A1RVayn0TWJegITkHIZF/o5HXQrhcg0Oy3veZG1Qhu9MBj1pZ7CMf+zfl5VT6JEmUQaSL+gUdvpdFj4uuhjoM1YiM9jw1w/U69SQdi7WKYxq0rx4tVPLrtmW5ABVfIUDw77qXJSDTBaE3YenT9ASeu8PhsY94jGq7MhBVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082319; c=relaxed/simple;
	bh=VqtbYctysGdFmDunlBaW8b+Xv4eNL4vhsZyTH4fUHHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGnm7iHvAsR7iikVexsuoLC9BwkW+JRbe0qONCERfPE48QKfiqC1QIIAxxrTDiOOVkztZlhpwUn7pa5m6vHATVCJ3YtGONGX2mHr/GWdKJCVDrQI9KlkbGb8c6JIGagHpDit4iRXJot6x6d3IVRtB6B31VJdWNSv3DZPJrlR/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J4/wMRm2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J4/wMRm2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBZf3J343620;
	Tue, 22 Sep 2026 13:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5kGCIw
	XgEQLUHphtZaf7ZKv3E1EwR7UpRj7au9xK39o=; b=J4/wMRm26PncNbyptX0NJD
	eTsQeFNMzkS1cUcKECZKXOm3p8/E0u2EUhMwVXaeQOZT9UvDmkhYRp9HixD07KLL
	rKSR4xU9IaqHKojy+6HCTBduhYK47r9pZuyQPK0WF4vzAgNrt4p4sF9qwPfPosa3
	pbeJwpLq2VDU/5I2EUeC42oAiIlak503KNdNQDvE/yWGJqAFDUZkxFcjYwNgEJ/j
	RlkVt6bWb6R85/0Y1CWxT7D+LDGRMR4g3LPX+XreJr+YoaxyU6x7rKmwHEEN2N4w
	inNGQke/Ce41kFStyXeiiSaVUYDnSMOfOnhVFRIhIiILfC8c/lMPRAnmkFs8MceA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv5hpr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 13:05:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBWUEx1521388;
	Tue, 22 Sep 2026 13:05:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkcem3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 13:05:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MD4xlK14811538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 13:04:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD9672004D;
	Tue, 22 Sep 2026 13:04:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8415E2004B;
	Tue, 22 Sep 2026 13:04:59 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 13:04:59 +0000 (GMT)
Message-ID: <8a89aa0c-1a2f-4de8-8435-ca6691c82226@linux.ibm.com>
Date: Tue, 22 Sep 2026 15:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Add missing KVM s390 crypto attributes
To: Eric Farman <farman@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260918145151.2116991-1-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260918145151.2116991-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: bLdV8INr1UrW_b3JVQhR7DgshVMIA-d3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfX6JkcfAqngehb
 xTARnGX6nF9SUwbdeojLShZRG7XcfYIwNa40FMAeoQHjysMUXFpZQiQQI8e04eGaHtfGwYeDJRI
 xyxH+YKt905ZpV0KI1StDIox/b67bjg=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab27d02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=d3y8_kawna_tOOV282gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wn-Zk7_szKiLi3SUE4nNl8E1R3zZcuZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE5MCBTYWx0ZWRfX5pQhhXTEsFqf
 a8naEO9/c9gg1Xxabkn2j8XNdGQ7zB4S2UQZySG1E7yfddD7FLDsFgD1ForeTK1keFEkyc9m2o1
 P/rRLLqHJ5ZDs99JPIKhSdBH/oEH357c1pAnyMmlTPAyaLI5pUqjX8FYA5Y3TKf9IM7PbjIn8s5
 cJFbjVYgZXcC10TkIdccagHGgD0XPDH485X+sWOjjvbqVyKHNfg2OkOXnhdq5XUDd6aYzdczGx1
 NQDgDi347sXwJ//o1Rf3L1yag0agkMFLPVfciACENqbqjQ76+pFtHv3XT5cfKu575CH10Ok588q
 39i0ZpEXm3pGvUcZSdQzg+81UJHSagTM4bXHD0wV2SqYg81sRyHtxjIbd21pYeKt68mpCppBMxJ
 WevMiSRt6I8r1P+hM1pdz0XbsGqSwaip8BhNN/Qh3IRaxCMumXMKsvEOVwJWej/OB1Evpr2ooZU
 0suftzqLMQvxFp0a6kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220190



Am 18.09.26 um 16:51 schrieb Eric Farman:
> Device attributes to enable/disable the AP interpretive execution
> support for crypto were added to KVM several years ago, but they
> weren't added to the documentation itself.
> 
> Fixes: 37940fb0b6a2 ("KVM: s390: device attrs to enable/disable AP interpretation")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

thanks. Unless Jonathan objects, I will take that via the kvms390 tree.
> ---
>   Documentation/virt/kvm/devices/vm.rst | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
> index a4d39fa1b083..78e63eb9994e 100644
> --- a/Documentation/virt/kvm/devices/vm.rst
> +++ b/Documentation/virt/kvm/devices/vm.rst
> @@ -280,6 +280,24 @@ Allows user space to disable dea key wrapping, clearing the wrapping key.
>   :Parameters: none
>   :Returns:    0
>   
> +4.5. ATTRIBUTE: KVM_S390_VM_CRYPTO_ENABLE_APIE (w/o)
> +-------------------------------------------------------
> +
> +Allows user space to enable AP interpretive execution.
> +
> +:Parameters: none
> +:Returns:    0 for success
> +	     -EOPNOTSUPP if AP instructions not available for guest
> +
> +4.6. ATTRIBUTE: KVM_S390_VM_CRYPTO_DISABLE_APIE (w/o)
> +-------------------------------------------------------
> +
> +Allows user space to disable AP interpretive execution.
> +
> +:Parameters: none
> +:Returns:    0 for success
> +	     -EOPNOTSUPP if AP instructions not available for guest
> +
>   5. GROUP: KVM_S390_VM_MIGRATION
>   ===============================
>   


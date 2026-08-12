Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5743749EE;
	Wed, 12 Aug 2026 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522087; cv=none; b=jWg31NOK+D663+GPfL1TEGKPe4aSrqI6XNTQF4W1p7BVyyRvouSliAm7mzGpBWWXj4IavN+HOozuXqDInJZEEsGXL2bgJjlwIH7adKEkm9YqekAjzUcOtpPldjm7Tjbm2c/s1dkhp6n8xWT5OewxF8Y7TPQE+YaO5Opuf+G+2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522087; c=relaxed/simple;
	bh=raE1wxIyP4Cmj5Urcmek6+NiBgZW87iYANatBlC9BqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6nNs5XHmBrgCtx+TWX7yGy6VaV75rS8uKjpkfrll6mP2XbqDvTPleRus7z8CSoEQmtb7O4ClSrG1xL3qFe6qJx0l/llOoGhcDV5BsZutQwmFGggAAoPtPwM1YKkcMZ4wOEguKKVqYnkCYSFN/5ZHmHT8dZPP1MGUPJjCgN3lLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJgnx4IK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJgnx4IK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62YK72678689;
	Wed, 12 Aug 2026 08:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NRgVJ3
	hU234+jp0ih+BgpNV8r9Um8z77d/uAOaLA0eg=; b=IJgnx4IKU2Ja5lGPBrULau
	k/eaGD2U04jLpVcbrKuuM7xdddQYmFRJ95fNCk75SfB0dZRW2db4ntGlLPor20AQ
	G9U9c5xPxApmqW2RwhrQ8M6OAtAWMVRm374JGTnNspSW8DeKoA1/vaXdJ8m7vWbo
	qUhYq5T1xXLY/53Fqh7Sjf0VMLpT6qz1qnzRcfqyOA7pn+I+GadT39wGD4HCxEvA
	ugBl4L14lUCkYJCX91gRZV9HWEEI95t8xIP0Y29vfsss6T0/pxF72zFWYNKxy+2S
	UGBVRdqU9JpRwNCDK3CyIY1coYU6SpvnYeFw7q2nYSi3p6kgKaIroyfcz0kkiC3Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9sgce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:08:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7uSHx003562;
	Wed, 12 Aug 2026 08:08:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy4x4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:08:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C87xJE50856280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 08:07:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE972004B;
	Wed, 12 Aug 2026 08:07:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 254E62004D;
	Wed, 12 Aug 2026 08:07:59 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 08:07:59 +0000 (GMT)
Message-ID: <ee700f42-e8d6-49e0-bfa0-0ec72132652b@de.ibm.com>
Date: Wed, 12 Aug 2026 10:07:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] KVM: s390: Fix kvm_s390_clear_pv_state()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-10-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfXzRNF4pChKApG
 hrh2+46LrcfZWObK74qFCiH89RNa51EWEX3wxxXJ+8Sl6SC/Rg0DDEabyZXte4zLqmqtLu5zYeD
 Wb4c8m6P/9tyN+VrBFATuzL2hXcwrhOUnlPKda6e40C09cCuRx14Pq8qZfOiGuVb0nNTEXaZ/rC
 4B8AWjGo/9nfQNjbLnKXTyGZOR6wyuYpsIlzqNVAncRamk4bQAFRJno7omaiaX667BJFGjJ3nVm
 +Ofj/CWGm2INrUNI4KPwy0LO78RM/el63DqFveSlrmjmbT0jW/Uo016UPK/61ZwIwHOcg1jkrcw
 bDETzAHsCV0kTxzGi35/sZvULhYOVXXfUrD9RTKTdP2jLfMIGDkS0nRt+tD6RhVjUHPCBSaxSlk
 nHupuRbWrZcnhXogrcspw3RndqGMDfyxOYKdnAAw/JWklBeywSb1I+rowTpyS9649PKpRgs0sKK
 l9MB+yhAKwP7v5hIfaQ==
X-Proofpoint-ORIG-GUID: hARU0pCnqrsIhUDxyqbPBLF64ctGmZIv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX1VvcENgo1Ndb
 sbC6NRwp6UpyJ3r3/7vB8/aNQ5kn+9aRbqsX+EgZGR/vZsOc+SX+ZW08WLN1tFoDivXyVGuW67F
 +yS/hBXp8CHShye6vt7KKOI7jpCrKXQ=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c29e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=z9yk2LTjqm7JGs_eJUgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hARU0pCnqrsIhUDxyqbPBLF64ctGmZIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120063



Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> kvm_s390_clear_pv_state() needs to also clear the dumping flag, to
> allow the protected VM to be started again (as non-protected, with all
> protected state safely destroyed) after a forced reboot while a
> protected dump was ongoing and not completed.
> 
> Fixes: e40df9efd68a ("KVM: s390: pv: clear the state without memset")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/pv.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index b02e0159d3cd..98a9a57f71b9 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -242,6 +242,10 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
>   	kvm->arch.pv.guest_len = 0;
>   	kvm->arch.pv.stor_base = 0;
>   	kvm->arch.pv.stor_var = NULL;
> +	if (kvm->arch.pv.dumping) {
> +		kvm_s390_vcpu_unblock_all(kvm);
> +		kvm->arch.pv.dumping = false;
> +	}
>   }
>   
>   static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_stor_base)


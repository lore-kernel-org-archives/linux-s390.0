Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625813D8911;
	Wed, 25 Mar 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444564; cv=none; b=Ciz1jz7V74Y9Uk/knt6ZenKozzGcRRc6EMz8vkkmW051Qq+ykTxIhDDTPTqyaJB8fJJCBKqimgugAnYflrotvBtUpxL+EgiEI60eaJYGqmZPEGZ1dPMKwfgS6vb5Bhz9f0Tc0Wf3kmY5Zv9Qujmx2wpD3W5SYKwqsZVjjdG+eY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444564; c=relaxed/simple;
	bh=Lcd+s0km0RBzlR9MtzEf7Maia8oVs6AexewiRvQqPKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuZFSGVIDglIPjhglLXr8b+uQgdfGOxm0iaI+B+TVLSm34LPofO/myjHEjeZDA8oNYa/ESq6xvkRa2mhnzxGSw9yNxflB/7OVPvpKBWCj28dEuMwzHjJ5wVZaSTILlnbxqnVPIkbFTMFSaDRCcfpPANN+1OwIxF7ac4nTWl8EyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=REYC0sHU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="REYC0sHU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3jERf3430662;
	Wed, 25 Mar 2026 13:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NEdJxb
	PQ59cbTQ9Va5myDMqbe+jJQkSeiDkoVnEEUpY=; b=REYC0sHUkYhXpm7Bugo8m8
	LPBwDCOCKFnuynfBZZLQ9RLPlUKS+AF6ReQ9clWyq4kJ7ZduUmsnzK0UcWcWOjlQ
	QbNcNhwuCOhsKTAT60zjCTBUefTX+Lhd7RwMR8BZnQlPJyFIu7DFwx/u7MUklVly
	uiCqXL+sIGDnGffrW/AkpowrUkqfG+o8s3mNfGQFTxXnENYvaiO+Q/JQll0ikwCb
	aXsMy64nnWWzSQLT4aM8tXHUHK2jWkr8R5NqTW4kimrWhj8z7NrpRe6uFvFXZq0E
	NB4gFRgIYoQXgECMKpRM1MOoByqooqNzLqpTBJVkRy9wQa5y8LyZk5QDZMShJnvA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty0gux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:15:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PAGEXc006009;
	Wed, 25 Mar 2026 13:15:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ypr59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:15:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PDFpOr47448438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 13:15:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E7020040;
	Wed, 25 Mar 2026 13:15:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F3A720043;
	Wed, 25 Mar 2026 13:15:51 +0000 (GMT)
Received: from [9.111.62.177] (unknown [9.111.62.177])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 13:15:51 +0000 (GMT)
Message-ID: <d1c3d082-5a91-4924-85c8-d6a8fe90ed42@linux.ibm.com>
Date: Wed, 25 Mar 2026 14:15:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: s390: selftests: Add load psw bear test
To: Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20260323153637.3683-1-frankja@linux.ibm.com>
 <20260323153637.3683-3-frankja@linux.ibm.com>
 <77fb3826-08a2-4bf7-b9d5-2679072d0f7a@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <77fb3826-08a2-4bf7-b9d5-2679072d0f7a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c3e00c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=TE1tAO7cANGKIGOttpYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5MSBTYWx0ZWRfX+w61KSs1TXZI
 vkSktsCDmAk0AWFt8hB8m3VkYkOh3Qg6W8gxNukz/cn1jDWGEthDuZ81+oJHTgUitzxuVtAqzq9
 tjwG2dCxXa+kPfryFtfFICTPm15EYrPPvsnZ1SxYEE1SEYhTzWnWmn0Drz/XvomkQyQW/o3hVyV
 M06WjXAVapAujn7ONvBWMI8AiOCDq/D1Y1uivYzsJ0aBVHLerDCSXl6fLdO3rsB3o86RopSgZ5N
 3C+dn15C2w2LRvgsnENNbvDvBBiurddyBpcb847YdvxwiPlKDYiOWE2P4xV+CZQTGYL1As52pz6
 xCmby3pDKvqGBNvg3oiYvJhBFbj44pKzVS7LFv08sSH7fHHQ1JoZKzVsOU9VZNebbqqRhhdVD5T
 FJz69kVRUYjaHVEDHxuHJXeCwRlAQdsBbnj0vRLxztKfnQ5RVjZEtAm8O/cnLdsKE+SOW8qkWnP
 bhiMZNjJMu+Ne0tKliA==
X-Proofpoint-GUID: 1l7IH5reC02pa_SBnsT6OcRPh32uvKxM
X-Proofpoint-ORIG-GUID: 1l7IH5reC02pa_SBnsT6OcRPh32uvKxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250091

On 3/25/26 11:29, Christian Borntraeger wrote:
> Had a 2nd look.
> Just wanted to test that lpswe does indeed leaves the BEAR unchanged and then I
> realized that lpswey does not work in our guest due to missing cpu model.
> So either remove the lpswey test for now or fix it.
> Something like this on top

Yeah one additional problem is that a PGM during guest execution might 
easily be missed since there are no checks and guest execution currently 
actually ends with an operation exception as well.

I'll remove the lpswey test for this series and will try to come up with 
a fix for the PGM issue for 7.1 or 7.2.


> 
> --- a/tools/testing/selftests/kvm/s390/bear.c
> +++ b/tools/testing/selftests/kvm/s390/bear.c
> @@ -22,7 +22,10 @@ static void guest_lpswey(void)
>           u64 bear;
>    
>           asm volatile (
> -               "       larl    %%r3,lpswey_addr\n"
> +               "       larl    %%r3,jump_addr\n"
> +               "jump_addr:\n"
> +               "       j lpswey_addr\n"
> +               "       nop\n"
>                   "lpswey_addr:\n"
>                   "       .insn   siy,0xeb0000000071,%[psw],0\n"
>                   "       nop\n"
> @@ -107,21 +110,30 @@ static void test_lpswey(void)
>           struct kvm_vcpu *vcpu;
>           struct kvm_run *run;
>           struct kvm_vm *vm;
> +       struct kvm_s390_vm_cpu_processor proc;
> +       int r;
> +
> +       vm = vm_create(1);
> +       __kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
> +                                 KVM_S390_VM_CPU_PROCESSOR, &proc);
> +       proc.fac_list[3] |= 0x4000000000000000UL;
> +       r = __kvm_device_attr_set(vm->fd, KVM_S390_VM_CPU_MODEL,
> +                                 KVM_S390_VM_CPU_PROCESSOR, &proc);
> +       vcpu = vm_vcpu_add(vm, 0, guest_lpswey);
>    
> -       vm = vm_create_with_one_vcpu(&vcpu, guest_lpswey);
>           inject_mcheck(vcpu);
>           run = vcpu->run;
>           vcpu_run(vcpu);
> -       ksft_test_result(run->s.regs.gprs[3] != run->s.regs.gprs[4],
> -                        "emulation: lpswey bear does not match\n");
> +       ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
> +                        "emulation: lpswey bear does match previous\n");
>           kvm_vm_free(vm);
>    
>           vm = vm_create_with_one_vcpu(&vcpu, guest_lpswey);
>           run = vcpu->run;
>           vcpu_run(vcpu);
>           ksft_test_result(run->s.regs.gprs[3] &&
> -                        run->s.regs.gprs[3] != run->s.regs.gprs[4],
> -                        "interpretation: lpswey bear does not match\n");
> +                        run->s.regs.gprs[3] == run->s.regs.gprs[4],
> +                        "interpretation: lpswey bear does match previous\n");
>           kvm_vm_free(vm);
>    }
>    
> 


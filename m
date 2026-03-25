Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80893AD513;
	Wed, 25 Mar 2026 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434607; cv=none; b=L0o1S5kqIQmAYnKAtTWamjPIiS7YiPAXv6wBGq4MLP/ka00r3gRqk7Yu2Yr7ijAvuRHWEN1tlEN/A5N7dt+y8s1y471FX0hLQ70pZpkBUgBRLt2gqLQYOIbD3nATLLakDnWRRtOEofzFhm66OxQ4OwwtSx3hQ+s2dwjLqcQr8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434607; c=relaxed/simple;
	bh=9L6ADxI/B0I17pY4sQH8l+lnahMJHjSzsh0H03DnCtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awYSxBlE6BP37dt22IgskKaQwcUSolbuGU9Y4ZH9NUyb4BDjePgcIlhYVzUh0B4yGG3cpYFZavSQVKYkfdD+2F3Exi8zINe95m51XfnYvIm7tWN78BRSE6ZGYqlx2oky4dPru7MLECbqBOXXd0yDgItM9wqCuJNmlBo0xrFKMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rt4llHH9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rt4llHH9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P6EnrV3729349;
	Wed, 25 Mar 2026 10:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zX4xpI
	nXZsfOxe0QXtXrF2p2Qo6Jm/dwW9vWKyGoJdc=; b=rt4llHH90N5mNVm5O7w1Rb
	iNSTWaAWOkn+3d1Ah6c5rwVH2+Mrtqjpl5X89IsV3sNny0LEbWF9YU/xbcUHBNyl
	p+e5n5/CMpX+wGJ5VJB8C+I3xpa2rD4y6GAL/xzYzzaDciBov8hK2Tab3Px5u+3H
	x46ureyZ7LGevIxvaDUAxCnc05KCaX/NnygMboMuYUIahF+dWqZBWf03THwk8u+/
	CaqQOUUoTHyG/iJ9w4uAjKLYe8PWW2sWC8JEBJxSl3+4hNFAA10DkvolDyCKeQn5
	UYQAD193G3s8Y6a2LDAWU4zwJZuafWriBESMbDqLMs9mSFJpwd9zz05Sso0oSJkg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9yxf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 10:30:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P72cc8026771;
	Wed, 25 Mar 2026 10:30:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kx12m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 10:30:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PATvQF18809220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 10:29:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6E792004B;
	Wed, 25 Mar 2026 10:29:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D39520043;
	Wed, 25 Mar 2026 10:29:57 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 10:29:57 +0000 (GMT)
Message-ID: <77fb3826-08a2-4bf7-b9d5-2679072d0f7a@linux.ibm.com>
Date: Wed, 25 Mar 2026 11:29:56 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: s390: selftests: Add load psw bear test
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20260323153637.3683-1-frankja@linux.ibm.com>
 <20260323153637.3683-3-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260323153637.3683-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3XS_8W6GPNwKByfUe-YhiOOhYcbyRz8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MyBTYWx0ZWRfX3/1qz/jeBMcE
 JmEFKqv32f3Ys9aksTJ7kXAvOycadP/+KZ0IWQA37sNJ3cnY8hSGtGvyv88GO9dloYS+vtR5OKK
 66Eb8ihvoI4WAJU16PNXWIG4u+bUoDzgXme55hI/4RfSFkuzir1UPZu0Cnx+0oo/v6m2OXJjsAs
 dwJnWWRhLQ+eHHKEPkOuglNfF6EI6IOUeDapMZt3E+LziKZSiWneucfIRgO6/VZqVqv7sRqkp7l
 o7vQ/wxN3SngAX9PYT0o31MSKJqU9OWqKK2U4esqS2NmeaenRKGUXmfO1ymEqkTME9vLX66qrJx
 8ovK/ewSFQMiDfJCxcfMSB5CvVxiAw1r+NWZyZDob0w1N+sWOdj46rXeX83AYvXXXByDyQ+k2D0
 LQoI/C87MqQbBbE4ijGDcGeVTt6Xo1J7JhNex65j3K7wB/7VwImYLGx1YnLEEDjiixxH210Rs47
 cbBPb/GUj6llv6P9dgA==
X-Proofpoint-GUID: 3XS_8W6GPNwKByfUe-YhiOOhYcbyRz8v
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c3b92b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=n7dhi3OI2ghMCBVPbA4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250073

Had a 2nd look.
Just wanted to test that lpswe does indeed leaves the BEAR unchanged and then I
realized that lpswey does not work in our guest due to missing cpu model.
So either remove the lpswey test for now or fix it.
Something like this on top

--- a/tools/testing/selftests/kvm/s390/bear.c
+++ b/tools/testing/selftests/kvm/s390/bear.c
@@ -22,7 +22,10 @@ static void guest_lpswey(void)
         u64 bear;
  
         asm volatile (
-               "       larl    %%r3,lpswey_addr\n"
+               "       larl    %%r3,jump_addr\n"
+               "jump_addr:\n"
+               "       j lpswey_addr\n"
+               "       nop\n"
                 "lpswey_addr:\n"
                 "       .insn   siy,0xeb0000000071,%[psw],0\n"
                 "       nop\n"
@@ -107,21 +110,30 @@ static void test_lpswey(void)
         struct kvm_vcpu *vcpu;
         struct kvm_run *run;
         struct kvm_vm *vm;
+       struct kvm_s390_vm_cpu_processor proc;
+       int r;
+
+       vm = vm_create(1);
+       __kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
+                                 KVM_S390_VM_CPU_PROCESSOR, &proc);
+       proc.fac_list[3] |= 0x4000000000000000UL;
+       r = __kvm_device_attr_set(vm->fd, KVM_S390_VM_CPU_MODEL,
+                                 KVM_S390_VM_CPU_PROCESSOR, &proc);
+       vcpu = vm_vcpu_add(vm, 0, guest_lpswey);
  
-       vm = vm_create_with_one_vcpu(&vcpu, guest_lpswey);
         inject_mcheck(vcpu);
         run = vcpu->run;
         vcpu_run(vcpu);
-       ksft_test_result(run->s.regs.gprs[3] != run->s.regs.gprs[4],
-                        "emulation: lpswey bear does not match\n");
+       ksft_test_result(run->s.regs.gprs[3] == run->s.regs.gprs[4],
+                        "emulation: lpswey bear does match previous\n");
         kvm_vm_free(vm);
  
         vm = vm_create_with_one_vcpu(&vcpu, guest_lpswey);
         run = vcpu->run;
         vcpu_run(vcpu);
         ksft_test_result(run->s.regs.gprs[3] &&
-                        run->s.regs.gprs[3] != run->s.regs.gprs[4],
-                        "interpretation: lpswey bear does not match\n");
+                        run->s.regs.gprs[3] == run->s.regs.gprs[4],
+                        "interpretation: lpswey bear does match previous\n");
         kvm_vm_free(vm);
  }
  


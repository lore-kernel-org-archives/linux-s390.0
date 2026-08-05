Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871593DE456;
	Wed,  5 Aug 2026 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919291; cv=none; b=S2MbjYaZsIUdjjf9MLQoTb2rvvXeFAipkFwUlYYNtGmdwKhPcsC9De7TX41BvjXgyZcCNOBPmF8OaCajGnFzQTs8qwXip8i39l5ZyQgZQyRO34ukb1j+K4sJttr7iAmcsFwh3poHcrpDDyd3N3OdaPkqjRII2s0wzoK26ootAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919291; c=relaxed/simple;
	bh=N/8smBpL3nhgl1cRNg6zSWlN20EhhEUppjKtY7oe+aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vErmUz/ehDrkDkvD3o/puSwc64AdBOIP0tGL0mD7wwR+lAdQEIDJ0jMFfSCFm2MIecKL4hYYJfnwb/qxOoOkSpTFOoBvDPWPZaj+OlgjmFbfjo9rDmYrldAQTAheZrKNCIo8p24o6vp+NujpDyd3bgwOdoStM7lxbCM6oVXqxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NbcQw2yX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NbcQw2yX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755mCq72909930;
	Wed, 5 Aug 2026 08:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L+qstq
	//dyXpozpdIYKJD4rprOP3/zuOpcK8yHLhFVY=; b=NbcQw2yX6Elv710yzUrRjf
	WqpT42N8G7Pt69mkFqxRdlK0FGzZ2co5HFCvnryOcV2PlY707UADEBYgs6/cZgRV
	lOv8Q9Lfb6gr3Ld+oTJUUL4ZY3RSIIhWB/LxbjaYPWzCVOJMzRj0S/NoICn3Y+Zb
	/XVUueYk8pZiYDjXntzEGzHA+77W8NzKTi+NPsq/OmWm/evYJkLyOfv79GkNlb4v
	UOAqhEc/amtpKIgD8K85JHRq9oGN742vcyzxtipP01yJq8zt+bbL/zurbtGXM/58
	yG4gdmG3T4o5SV2AEYa7Im4U4WArxIUsGx6uYaqlwq1B6ZT/9GQCctYuayeeFptA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g9stb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:41:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758QJAX023752;
	Wed, 5 Aug 2026 08:41:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw5vax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:41:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6758fLaL31588944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 08:41:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD1EB2004B;
	Wed,  5 Aug 2026 08:41:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FBB820040;
	Wed,  5 Aug 2026 08:41:21 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 08:41:21 +0000 (GMT)
Message-ID: <dabd9090-e1b6-4695-8782-47b6c8e37a73@linux.ibm.com>
Date: Wed, 5 Aug 2026 10:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] KVM: s390: Take srcu when importing watchpoint
 data
To: sashiko-reviews@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-7-borntraeger@linux.ibm.com>
 <20260804184024.B9A961F000E9@smtp.kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260804184024.B9A961F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2NCBTYWx0ZWRfX0canNU0jnPmw
 7+UPzm4Hu6XddtIMEyCMmKqssapoBaMPs1BDEtgdCZpQnyhofM8jn0Ou3Xj7rqjXvBdaijHLzkQ
 bRg1iJWjECjzPwHB/5+XNOsElw8kI0y1UEmzOVzxg1/ZSOVXgfRlHNtEplbV6BVPOr8vfFG8Kei
 Rs+S0yrFTZhViFrxvbe2dMso5NP67GVJkDwVuTjPTgJs0K7bn54i7W76jzrWfztN8fRlc3u97+b
 lkHP66QBmS9O69pJTx9Fk/A7Rg0U4I9Hw39muDz3bkO7wmeiPba10YQrW67x+ob2k6WQRmXm8SO
 lbeNyZ+rMrAqMFggUi7UNEVDIcnMTR5xL9ebFd+KslY6HOwRt4Mq7xFIW0qB1GFTnAxhOhSCl2n
 /PKK2uQGPo5PCme+izmwsJD8L83Y043hE4hb/tpFYCJIbbqHSY4ZBLGXh4yZ7+JCYw+Wg60xEJz
 0usdzdeWw2FqqK8TGXw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a72f736 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=CqDQVMNXfGTbBfhByaQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I3wRAU3sU_BApMvTViLDZlucNOwDRvAR
X-Proofpoint-ORIG-GUID: I3wRAU3sU_BApMvTViLDZlucNOwDRvAR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2NCBTYWx0ZWRfXx5Y/wssZU1AZ
 Eot5B2AALe30BXfIVeO+01BGVEwr9OWk+8H6QrC2rjELLi/sg+CarkRBLdloKZfX1RtBA3ce5Kv
 bZ7TA+uVL0FSQZ46QEKFR4cRlKQ9cLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050064

Am 04.08.26 um 20:40 schrieb sashiko-bot@kernel.org:
> 
> [Severity: High]
> Could holding the SRCU read lock across this call introduce a userfaultfd
> deadlock?
> 
> Inside kvm_s390_import_bp_data(), the very first operation is:
> 
> arch/s390/kvm/guestdbg.c:kvm_s390_import_bp_data() {
>      ...
>      bp_data = memdup_array_user(dbg->arch.hw_bp, dbg->arch.nr_hw_bp,
>                                  sizeof(*bp_data));
>      ...
> }
> 
> If user space maps this array using userfaultfd, the VCPU thread will block
> in copy_from_user() while holding the kvm->srcu read lock. If the user space
> userfaultfd handler attempts to execute a VM-wide KVM ioctl that modifies
> memslots (such as KVM_SET_USER_MEMORY_REGION), that ioctl will call
> synchronize_srcu(&kvm->srcu). The VCPU thread would wait for the page fault
> to be resolved, and the userfaultfd handler would wait for the SRCU lock to
> be released.


Now I am puzzled. Sashiko basically asked for srcu protection for the guest access
in the same review series. But I want to followup nevertheless.


There are other places in KVM code which do access guest memory under the srcu.

1.
KVM_SET_NESTED_STATE — arch/x86/kvm/x86.c
               idx = srcu_read_lock(&vcpu->kvm->srcu);
               r = kvm_x86_ops.nested_ops->set_state(vcpu, user_kvm_nested_state, &kvm_state);
               srcu_read_unlock(&vcpu->kvm->srcu, idx);
with  vmx_set_nested_state() then copying  the vmcs12 from user


2.
KVM_GET_MSRS / KVM_SET_MSRS — arch/x86/kvm/x86.c

       case KVM_SET_MSRS: {
               int idx = srcu_read_lock(&vcpu->kvm->srcu);
               r = msr_io(vcpu, argp, do_set_msr, 0);
               srcu_read_unlock(&vcpu->kvm->srcu, idx);
               break;
       }
argp goes in as a raw void __user *, and msr_io() does both user copies inside that section:

       if (copy_from_user(&msrs, user_msrs, sizeof(msrs)))


3.
KVM_S390_MEM_OP
kvm_s390_vm_mem_op_abs() has
         scoped_guard(srcu, &kvm->srcu) {
[...]
                 if (acc_mode == GACC_STORE && copy_from_user(tmpbuf, uaddr, mop->size))
                         return -EFAULT;


4.
KVM_PRE_FAULT_MEMORY generic KVM holds srcu across a loop of kvm_arch_vcpu_pre_fault_memory() calls that fault in guest memory,

5.
and last but not least,isnt vcpu_run also holding kvm->srcu when handling page faults?

In the end the cycle seems userspace constructed. It deadlocks only if its own uffd handler
is made to depend on a vcpu blocked on that same handler.The faulting side waits in
TASK_KILLABLE (mm/userfaultfd.c:2673) — SIGKILL to the process releases the srcu section
and lets the other thread finish.  So we can get out of it.


So I think this finding is wrong. Paolo?

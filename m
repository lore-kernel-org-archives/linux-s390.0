Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgDVP6V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 11:58:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MFfljV040749
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 11:58:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30jrj5s32j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 11:58:19 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 22 Apr 2020 16:57:23 +0100
Subject: Re: [PATCH v2 1/7] KVM: s390: clean up redundant 'kvm_run' parameters
References: <20200422125810.34847-1-tianjia.zhang@linux.alibaba.com>
 <20200422125810.34847-2-tianjia.zhang@linux.alibaba.com>
 <20200422154543.2efba3dd.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Apr 2020 17:58:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200422154543.2efba3dd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <dc5e0fa3-558b-d606-bda9-ed281cf9e9ae@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, frankja@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 22.04.20 15:45, Cornelia Huck wrote:
> On Wed, 22 Apr 2020 20:58:04 +0800
> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> 
>> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
>> structure. Earlier than historical reasons, many kvm-related function
> 
> s/Earlier than/For/ ?
> 
>> parameters retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time.
>> This patch does a unified cleanup of these remaining redundant parameters.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 37 ++++++++++++++++++++++---------------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index e335a7e5ead7..d7bb2e7a07ff 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4176,8 +4176,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  	return rc;
>>  }
>>  
>> -static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>> +static void sync_regs_fmt2(struct kvm_vcpu *vcpu)
>>  {
>> +	struct kvm_run *kvm_run = vcpu->run;
>>  	struct runtime_instr_cb *riccb;
>>  	struct gs_cb *gscb;
>>  
>> @@ -4235,7 +4236,7 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>  		}
>>  		if (vcpu->arch.gs_enabled) {
>>  			current->thread.gs_cb = (struct gs_cb *)
>> -						&vcpu->run->s.regs.gscb;
>> +						&kvm_run->s.regs.gscb;
> 
> Not sure if these changes (vcpu->run-> => kvm_run->) are really worth
> it. (It seems they amount to at least as much as the changes advertised
> in the patch description.)
> 
> Other opinions?

Agreed. It feels kind of random. Maybe just do the first line (move kvm_run from the
function parameter list into the variable declaration)? Not sure if this is better.

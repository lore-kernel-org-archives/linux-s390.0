Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14778 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729275AbgFVQN4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 12:13:56 -0400
Subject: Re: [PATCH v9 2/2] s390/kvm: diagnose 0x318 sync and reset
References: <20200622154636.5499-1-walling@linux.ibm.com>
 <20200622154636.5499-3-walling@linux.ibm.com>
 <20200622180459.4cf7cbf4.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <93bd30de-2cd0-a044-4e9b-05b1eda9acb3@linux.ibm.com>
Date: Mon, 22 Jun 2020 12:13:13 -0400
MIME-Version: 1.0
In-Reply-To: <20200622180459.4cf7cbf4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 6/22/20 12:04 PM, Cornelia Huck wrote:
> On Mon, 22 Jun 2020 11:46:36 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> DIAGNOSE 0x318 (diag318) sets information regarding the environment
>> the VM is running in (Linux, z/VM, etc) and is observed via
>> firmware/service events.
>>
>> This is a privileged s390x instruction that must be intercepted by
>> SIE. Userspace handles the instruction as well as migration. Data
>> is communicated via VCPU register synchronization.
>>
>> The Control Program Name Code (CPNC) is stored in the SIE block. The
>> CPNC along with the Control Program Version Code (CPVC) are stored
>> in the kvm_vcpu_arch struct.
>>
>> This data is reset on load normal and clear resets.
> 
> Looks good to me AFAICS without access to the architecture.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 
> One small thing below.
> 
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  4 +++-
>>  arch/s390/include/uapi/asm/kvm.h |  5 ++++-
>>  arch/s390/kvm/kvm-s390.c         | 11 ++++++++++-
>>  arch/s390/kvm/vsie.c             |  1 +
>>  include/uapi/linux/kvm.h         |  1 +
>>  5 files changed, 19 insertions(+), 3 deletions(-)
> 
> (...)
> 
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 4fdf30316582..35cdb4307904 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1031,6 +1031,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_PPC_SECURE_GUEST 181
>>  #define KVM_CAP_HALT_POLL 182
>>  #define KVM_CAP_ASYNC_PF_INT 183
>> +#define KVM_CAP_S390_DIAG318 184
> 
> Should we document this in Documentation/virt/kvm/api.rst?
> 
> (Documentation of KVM caps generally seems to be a bit of a
> hit-and-miss, though. But we could at least document the s390 ones :)
> 
> I also noticed that the new entries for the vcpu resets and pv do not
> seem to be in proper rst format. Maybe fix that and add the new doc in
> an add-on series?
> 

Sure thing. I'll fix up the rst and add docs for the new DIAG cap.

>>  
>>  #ifdef KVM_CAP_IRQ_ROUTING
>>  
> 


-- 
Regards,
Collin

Stay safe and stay healthy

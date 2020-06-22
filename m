Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbgFVOvA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 10:51:00 -0400
Subject: Re: [PATCH v8 2/2] s390/kvm: diagnose 0x318 sync and reset
References: <20200618222222.23175-1-walling@linux.ibm.com>
 <20200618222222.23175-3-walling@linux.ibm.com>
 <20200622122456.781492a8.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <43967a50-a69c-face-805d-7cc935d3f230@de.ibm.com>
Date: Mon, 22 Jun 2020 16:50:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200622122456.781492a8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com



On 22.06.20 12:24, Cornelia Huck wrote:
> On Thu, 18 Jun 2020 18:22:22 -0400
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
>> The CPNC is shadowed/unshadowed in VSIE.
>>
>> This data is reset on load normal and clear resets.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  4 +++-
>>  arch/s390/include/uapi/asm/kvm.h |  5 ++++-
>>  arch/s390/kvm/kvm-s390.c         | 11 ++++++++++-
>>  arch/s390/kvm/vsie.c             |  3 +++
>>  include/uapi/linux/kvm.h         |  1 +
>>  5 files changed, 21 insertions(+), 3 deletions(-)
>>
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
> Do we strictly need this new cap, or would checking against the sync
> regs capabilities be enough?

We could check the sync_regs valid field to decide about the sync. We do
that for ETOKEN as well and QEMU also uses it in handle_diag_318.

I think what this is used for is actually to tell the QEMU CPU model
if this is there. And for that the sync_reg validity seems wrong. So better
keep the CAP?

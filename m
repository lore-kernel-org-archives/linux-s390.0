Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbgENPY4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 11:24:56 -0400
Subject: Re: [PATCH v6 2/2] s390/kvm: diagnose 318 handling
References: <20200513221557.14366-1-walling@linux.ibm.com>
 <20200513221557.14366-3-walling@linux.ibm.com>
 <20200514110544.147a63f8.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <d4cfe6dc-4ce6-b588-88fd-9e0bc6684e8a@linux.ibm.com>
Date: Thu, 14 May 2020 11:24:48 -0400
MIME-Version: 1.0
In-Reply-To: <20200514110544.147a63f8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On 5/14/20 5:05 AM, Cornelia Huck wrote:
> On Wed, 13 May 2020 18:15:57 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>> be intercepted by SIE and handled via KVM. Let's introduce some
>> functions to communicate between userspace and KVM via ioctls. These
>> will be used to get/set the diag318 related information, as well as
>> check the system if KVM supports handling this instruction.
>>
>> This information can help with diagnosing the environment the VM is
>> running in (Linux, z/VM, etc) if the OS calls this instruction.
>>
>> By default, this feature is disabled and can only be enabled if a
>> user space program (such as QEMU) explicitly requests it.
>>
>> The Control Program Name Code (CPNC) is stored in the SIE block
>> and a copy is retained in each VCPU. The Control Program Version
>> Code (CPVC) is not designed to be stored in the SIE block, so we
>> retain a copy in each VCPU next to the CPNC.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  Documentation/virt/kvm/devices/vm.rst | 29 +++++++++
>>  arch/s390/include/asm/kvm_host.h      |  6 +-
>>  arch/s390/include/uapi/asm/kvm.h      |  5 ++
>>  arch/s390/kvm/diag.c                  | 20 ++++++
>>  arch/s390/kvm/kvm-s390.c              | 89 +++++++++++++++++++++++++++
>>  arch/s390/kvm/kvm-s390.h              |  1 +
>>  arch/s390/kvm/vsie.c                  |  2 +
>>  7 files changed, 151 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
>> index 0aa5b1cfd700..9344d45ace6d 100644
>> --- a/Documentation/virt/kvm/devices/vm.rst
>> +++ b/Documentation/virt/kvm/devices/vm.rst
>> @@ -314,3 +314,32 @@ Allows userspace to query the status of migration mode.
>>  	     if it is enabled
>>  :Returns:   -EFAULT if the given address is not accessible from kernel space;
>>  	    0 in case of success.
>> +
>> +6. GROUP: KVM_S390_VM_MISC
> 
> This needs to be rstyfied, matching the remainder of the file.
> 
>> +Architectures: s390
>> +
>> + 6.1. KVM_S390_VM_MISC_ENABLE_DIAG318
>> +
>> + Allows userspace to enable the DIAGNOSE 0x318 instruction call for a
>> + guest OS. By default, KVM will not allow this instruction to be executed
>> + by a guest, even if support is in place. Userspace must explicitly enable
>> + the instruction handling for DIAGNOSE 0x318 via this call.
>> +
>> + Parameters: none
>> + Returns:    0 after setting a flag telling KVM to enable this feature
>> +
>> + 6.2. KVM_S390_VM_MISC_DIAG318 (r/w)
>> +
>> + Allows userspace to retrieve and set the DIAGNOSE 0x318 information,
>> + which consists of a 1-byte "Control Program Name Code" and a 7-byte
>> + "Control Program Version Code" (a 64 bit value all in all). This
>> + information is set by the guest (usually during IPL). This interface is
>> + intended to allow retrieving and setting it during migration; while no
>> + real harm is done if the information is changed outside of migration,
>> + it is strongly discouraged.
> 
> (Sorry if we discussed that already, but that was some time ago and the
> info has dropped out of my cache...)
> 
> Had we considered doing this in userspace only? If QEMU wanted to
> emulate diag 318 in tcg, it would basically need to mirror what KVM
> does; diag 318 does not seem like something where we want to optimize
> for performance, so dropping to userspace seems feasible? We'd just
> need an interface for userspace to forward anything set by the guest.
> 

My reservation with respect to handling this in userspace only is that
the data set by the instruction call is relevant to both host-level and
guest-level kernels. That data is set during kernel setup.

Right now, the instruction call is used to set a hard-coded "name code"
value, but later we want to use this instruction to also set some sort
of unique version code. The format of the version code is not yet
determined.

If guest support is handled in userspace only, then we'll have to update
the version codes in both the Linux kernel /and/ QEMU, which might be a
bit messy if things go out of sync.

>> +
>> + Parameters: address of a buffer in user space (u64), where the
>> +	     information is read from or stored into
>> + Returns:    -EFAULT if the given address is not accessible from kernel space;
>> +	     -EOPNOTSUPP if feature has not been requested to be enabled first;
>> +	     0 in case of success
> 


-- 
--
Regards,
Collin

Stay safe and stay healthy

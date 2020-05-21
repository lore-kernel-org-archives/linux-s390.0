Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbgEUGPw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 May 2020 02:15:52 -0400
Subject: Re: [PATCH v7 3/3] s390/kvm: diagnose 0x318 get/set handling
References: <20200515221935.18775-1-walling@linux.ibm.com>
 <20200515221935.18775-4-walling@linux.ibm.com>
 <b08dbb8a-76fd-3693-d470-6171074ffce4@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <d1ef0fed-053c-8e95-f5a6-53423de27957@linux.ibm.com>
Date: Thu, 21 May 2020 02:15:47 -0400
MIME-Version: 1.0
In-Reply-To: <b08dbb8a-76fd-3693-d470-6171074ffce4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 5/18/20 5:15 AM, Christian Borntraeger wrote:
> 
> 
> On 16.05.20 00:19, Collin Walling wrote:
>> DIAGNOSE 0x318 (diag 318) sets information regarding the environment
>> the VM is running in (Linux, z/VM, etc) and is observed via
>> firmware/service events.
>>
>> This is a privileged s390x instruction that must be intercepted by
>> SIE. Userspace handling is required, so let's introduce some functions
>> to communicate between userspace and KVM via ioctls. These will be used
>> to get/set the diag 318 related information.
>>
>> The Control Program Name Code (CPNC) is stored in the SIE block. The
>> CPNC along with the Control Program Version Code (CPVC) are stored in
>> the kvm_arch struct.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  Documentation/virt/kvm/devices/vm.rst | 21 +++++++
>>  arch/s390/include/asm/kvm_host.h      |  5 +-
>>  arch/s390/include/uapi/asm/kvm.h      |  4 ++
>>  arch/s390/kvm/kvm-s390.c              | 82 +++++++++++++++++++++++++++
>>  arch/s390/kvm/vsie.c                  |  2 +
>>  5 files changed, 113 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
>> index 0aa5b1cfd700..52cc906dd7bd 100644
>> --- a/Documentation/virt/kvm/devices/vm.rst
>> +++ b/Documentation/virt/kvm/devices/vm.rst
>> @@ -314,3 +314,24 @@ Allows userspace to query the status of migration mode.
>>  	     if it is enabled
>>  :Returns:   -EFAULT if the given address is not accessible from kernel space;
>>  	    0 in case of success.
>> +
>> +6. GROUP: KVM_S390_VM_MISC
>> +==========================
>> +
>> +:Architectures: s390
>> +
>> +6.1. KVM_S390_VM_MISC_DIAG_318 (r/w)
>> +-----------------------------------
>> +
>> +Allows userspace to retrieve and set the DIAGNOSE 0x318 information,
>> +which consists of a 1-byte "Control Program Name Code" and a 7-byte
>> +"Control Program Version Code" (a 64 bit value all in all). This
>> +information is set by the guest (usually during IPL). This interface is
>> +intended to allow retrieving and setting it during migration; while no
>> +real harm is done if the information is changed outside of migration,
>> +it is strongly discouraged.
>> +
>> +:Parameters: address of a buffer in user space (u64), where the
>> +	     information is read from or stored into
>> +:Returns:    -EFAULT if the given address is not accessible from kernel space;
>> +	     0 in case of success
> 
> 
> An alternative would be a new sync_reg value + KVM capability.
> 
> 

I did some investigation into this (new grounds for me)

sync_reg would handle the migration part, and then we'd just need the
ioctl so the diag instruction handler can set the data. Does that sound
right?

-- 
Regards,
Collin

Stay safe and stay healthy

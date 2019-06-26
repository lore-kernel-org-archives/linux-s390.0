Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728006AbfFZNvL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 09:51:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QDlu1R066893
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 09:51:10 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tc8apwjxv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 09:51:09 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <walling@linux.ibm.com>;
        Wed, 26 Jun 2019 14:51:09 +0100
Subject: Re: [PATCH v5 2/2] s390/kvm: diagnose 318 handling
References: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
 <1561475022-18348-3-git-send-email-walling@linux.ibm.com>
 <20190626141133.340127d7.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 26 Jun 2019 09:51:06 -0400
MIME-Version: 1.0
In-Reply-To: <20190626141133.340127d7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4c4beea9-bbae-61cf-4ec3-c42fae9b2238@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: david@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On 6/26/19 8:11 AM, Cornelia Huck wrote:
> On Tue, 25 Jun 2019 11:03:42 -0400
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
>> The get/set functions are introduced primarily for VM migration and
>> reset, though no harm could be done to the system if a userspace
>> program decides to alter this data (this is highly discouraged).
>>
>> The Control Program Name Code (CPNC) is stored in the SIE block (if
>> host hardware supports it) and a copy is retained in each VCPU. The
>> Control Program Version Code (CPVC) is not designed to be stored in
>> the SIE block, so we retain a copy in each VCPU next to the CPNC.
>>
>> At this time, the CPVC is not reported during a VM_EVENT as its
>> format is yet to be properly defined.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   Documentation/virtual/kvm/devices/vm.txt | 14 ++++++
>>   arch/s390/include/asm/kvm_host.h         |  5 +-
>>   arch/s390/include/uapi/asm/kvm.h         |  4 ++
>>   arch/s390/kvm/diag.c                     | 17 +++++++
>>   arch/s390/kvm/kvm-s390.c                 | 81 ++++++++++++++++++++++++++++++++
>>   arch/s390/kvm/kvm-s390.h                 |  1 +
>>   arch/s390/kvm/vsie.c                     |  2 +
>>   7 files changed, 123 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
>> index 4ffb82b..56f7d9c 100644
>> --- a/Documentation/virtual/kvm/devices/vm.txt
>> +++ b/Documentation/virtual/kvm/devices/vm.txt
>> @@ -268,3 +268,17 @@ Parameters: address of a buffer in user space to store the data (u64) to;
>>   	    if it is enabled
>>   Returns:    -EFAULT if the given address is not accessible from kernel space
>>   	    0 in case of success.
>> +
>> +6. GROUP: KVM_S390_VM_MISC
>> +Architectures: s390
>> +
>> +6.1. KVM_S390_VM_MISC_DIAG318 (r/w)
>> +
>> +Allows userspace to access the DIAGNOSE 0x318 information which consists of a
>> +1-byte "Control Program Name Code" and a 7-byte "Control Program Version Code".
>> +This information is initialized during IPL and must be preserved during
>> +migration.
>> +
>> +Parameters: address of a buffer in user space to store the data (u64) to
>> +Returns:    -EFAULT if the given address is not accessible from kernel space
>> +	     0 in case of success.
> 
> Hm, this looks a bit incomplete to me. IIUC, the guest will set this
> via diag 318, and this interface is intended to be used by user space
> for retrieving/setting this during migration. What about the following:
> 
> 
> Allows userspace to retrieve and set the DIAGNOSE 0x318 information,
> which consists of a 1-byte "Control Program Name Code" and a 7-byte
> "Control Program Version Code" (a 64 bit value all in all). This
> information is set by the guest (usually during IPL). This interface is
> intended to allow retrieving and setting it during migration; while no
> real harm is done if the information is changed outside of migration,
> it is strongly discouraged.
> 
> Parameters: address of a buffer in user space (u64), where the
>              information is read from or stored into
> Returns:    -EFAULT if the given address is not accessible from kernel space
> 	     0 in case of success
> 
> Otherwise, no further comments from me.
> 

This is much more concise, thank you!

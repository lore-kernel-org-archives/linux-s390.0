Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727279AbgBLQhF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 11:37:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CGZPfv086317
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 11:37:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4bp9enc6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 11:37:03 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 12 Feb 2020 16:37:02 -0000
Subject: Re: [PATCH 35/35] DOCUMENTATION: Protected virtual machine
 introduction and IPL
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-36-borntraeger@de.ibm.com>
 <20200212120104.106e8ce2.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Feb 2020 17:36:56 +0100
MIME-Version: 1.0
In-Reply-To: <20200212120104.106e8ce2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <5928cacb-8f4b-c865-32f6-c478db68e330@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 12.02.20 12:01, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:58 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Add documentation about protected KVM guests and description of changes
>> that are necessary to move a KVM VM into Protected Virtualization mode.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: fixing and conversion to rst]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/index.rst        |   2 +
>>  Documentation/virt/kvm/s390-pv-boot.rst |  79 ++++++++++++++++
>>  Documentation/virt/kvm/s390-pv.rst      | 116 ++++++++++++++++++++++++
>>  MAINTAINERS                             |   1 +
>>  4 files changed, 198 insertions(+)
>>  create mode 100644 Documentation/virt/kvm/s390-pv-boot.rst
>>  create mode 100644 Documentation/virt/kvm/s390-pv.rst
>>
> (...)
>> diff --git a/Documentation/virt/kvm/s390-pv-boot.rst b/Documentation/virt/kvm/s390-pv-boot.rst
>> new file mode 100644
>> index 000000000000..47814e53369a
>> --- /dev/null
>> +++ b/Documentation/virt/kvm/s390-pv-boot.rst
>> @@ -0,0 +1,79 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================
>> +s390 (IBM Z) Boot/IPL of Protected VMs
>> +======================================
>> +
>> +Summary
>> +-------
>> +Protected Virtual Machines (PVM) are not accessible by I/O or the
>> +hypervisor.  When the hypervisor wants to access the memory of PVMs
>> +the memory needs to be made accessible. When doing so, the memory will
>> +be encrypted.  See :doc:`s390-pv` for details.
> 
> Maybe
> 
> "The memory of Protected Virtual Machines (PVMs) is not accessible to
> I/O or the hypervisor. In those cases where the hypervisor needs to
> access the memory of a PVM, that memory must be made accessible. Memory
> made accessible to the hypervisor will be encrypted. See :doc:`s390-pv`
> for details."

looks good.

> 
> ?
> 
>> +
>> +On IPL a small plaintext bootloader is started which provides
> 
> "On IPL (boot), a small plaintext bootloader is started, which..."

ok


> 
> ?
> 
>> +information about the encrypted components and necessary metadata to
>> +KVM to decrypt the protected virtual machine.
> 
> (...)
> 
>> +Diag308
>> +-------
>> +This diagnose instruction is the basis for VM IPL. The VM can set and
> 
> "This diagnose instruction is the basic mechanism to handle IPL and
> related operations for virtual machines." ?


ok


> 
>> +retrieve IPL information blocks, that specify the IPL method/devices
>> +and request VM memory and subsystem resets, as well as IPLs.
>> +
>> +For PVs this concept has been extended with new subcodes:
> 
> s/For PVs/For PVMs,/

ok
> 
> (...)
> 
>> +When running in protected mode some subcodes will result in exceptions
> 
> s/When running in protected mode/When running in protected virtualization mode,/
> 
ok

> ?
> 
>> +or return error codes.
>> +
>> +Subcodes 4 and 7 will result in specification exceptions as they would
>> +not clear out the guest memory.
>> +When removing a secure VM, the UV will clear all memory, so we can't
>> +have non-clearing IPL subcodes.
> 
> "Subcodes 4 and 7, which specify operations that do not clear the guest
> memory, will result in specification exceptions. This is because the UV
> will clear all memory when a secure VM is removed, and therefore
> non-clearing IPL subcodes are not allowed."

ok


> 
> ?
> 
> (...)
>> diff --git a/Documentation/virt/kvm/s390-pv.rst b/Documentation/virt/kvm/s390-pv.rst
>> new file mode 100644
>> index 000000000000..dbe9110dfd1e
>> --- /dev/null
>> +++ b/Documentation/virt/kvm/s390-pv.rst
>> @@ -0,0 +1,116 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=========================================
>> +s390 (IBM Z) Ultravisor and Protected VMs
>> +=========================================
>> +
>> +Summary
>> +-------
>> +Protected virtual machines (PVM) are KVM VMs, where KVM can't access
>> +the VM's state like guest memory and guest registers anymore. Instead,
> 
> "...are KVM VMs that do not allow KVM to access VM state like guest
> memory or guest registers."
> 
> ?
> 
> (...)
> 
>> +The Interception Parameters state description field still contains the
>> +the bytes of the instruction text, but with pre-set register values
>> +instead of the actual ones. I.e. each instruction always uses the same
>> +instruction text, in order not to leak guest instruction text.
>> +This also implies that the register content that a guest had in r<n>
>> +may be in r<m> from the hypervisors point of view.
> 
> s/hypervisors/hypervisor's/

ack.

> 
>> +
>> +The Secure Instruction Data Area contains instruction storage
>> +data. Instruction data, i.e. data being referenced by an instruction
>> +like the SCCB for sclp, is moved over the SIDA. When an instruction is
> 
> s/over/via/ ?

ack
> 
>> +intercepted, the SIE will only allow data and program interrupts for
>> +this instruction to be moved to the guest via the two data areas
>> +discussed before. Other data is either ignored or results in validity
>> +interceptions.
> 
> (...)
> 

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730315AbgBYQnG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 11:43:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PGb7Yv057665
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 11:43:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yd4h2xtkr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 11:43:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 16:43:02 -0000
Subject: Re: [PATCH v4 33/36] DOCUMENTATION: Protected virtual machine
 introduction and IPL
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-34-borntraeger@de.ibm.com>
 <20200225172255.6ec8e7ac.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 17:42:54 +0100
MIME-Version: 1.0
In-Reply-To: <20200225172255.6ec8e7ac.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f7d8e2f6-5ae2-939c-eaab-3019daefcc63@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 25.02.20 17:22, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 06:41:04 -0500
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
>>  Documentation/virt/kvm/s390-pv-boot.rst |  83 +++++++++++++++++
>>  Documentation/virt/kvm/s390-pv.rst      | 116 ++++++++++++++++++++++++
>>  MAINTAINERS                             |   1 +
>>  4 files changed, 202 insertions(+)
>>  create mode 100644 Documentation/virt/kvm/s390-pv-boot.rst
>>  create mode 100644 Documentation/virt/kvm/s390-pv.rst
>>
> (...)
>> diff --git a/Documentation/virt/kvm/s390-pv-boot.rst b/Documentation/virt/kvm/s390-pv-boot.rst
>> new file mode 100644
>> index 000000000000..b762df206ab7
>> --- /dev/null
>> +++ b/Documentation/virt/kvm/s390-pv-boot.rst
>> @@ -0,0 +1,83 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================
>> +s390 (IBM Z) Boot/IPL of Protected VMs
>> +======================================
>> +
>> +Summary
>> +-------
>> +The memory of Protected Virtual Machines (PVMs) is not accessible to
>> +I/O or the hypervisor. In those cases where the hypervisor needs to
>> +access the memory of a PVM, that memory must be made accessible.
>> +Memory made accessible to the hypervisor will be encrypted. See
>> +:doc:`s390-pv` for details."
>> +
>> +On IPL (boot) a small plaintext bootloader is started, which provides
>> +information about the encrypted components and necessary metadata to
>> +KVM to decrypt the protected virtual machine.
>> +
>> +Based on this data, KVM will make the protected virtual machine known
>> +to the Ultravisor(UV) and instruct it to secure the memory of the PVM,
> 
> s/Ultravisor(UV)/Ultravisor (UV)/

ack
> 
>> +decrypt the components and verify the data and address list hashes, to
>> +ensure integrity. Afterwards KVM can run the PVM via the SIE
>> +instruction which the UV will intercept and execute on KVM's behalf.
> (...)
>> +Subcodes 4 and 7, which specify operations that do not clear the guest
>> +memory, will result in specification exceptions. This is because the
>> +UV will clear all memory when a secure VM is removed, and therefore
>> +non-clearing IPL subcodes are not allowed."
> 
> stray '"'

ack
> 
> (...)
>> diff --git a/Documentation/virt/kvm/s390-pv.rst b/Documentation/virt/kvm/s390-pv.rst
>> new file mode 100644
>> index 000000000000..27fe03eaeaad
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
>> +Protected virtual machines (PVM) are KVM VMs that do not allow KVM to
>> +access VM state like guest memory or guest registers. Instead, the
>> +PVMs are mostly managed by a new entity called Ultravisor (UV). The UV
>> +provides an API that can be used by PVMs and KVM to request management
>> +actions.
>> +
>> +Each guest starts in the non-protected mode and then may make a
> 
> s/in the/in/

ack.
> 
>> +request to transition into protected mode. On transition, KVM
>> +registers the guest and its VCPUs with the Ultravisor and prepares
>> +everything for running it.
> (...)
>> +
>> +Mask notification interceptions
>> +-------------------------------
>> +In order to be notified when a PVM enables a certain class of
>> +interrupt, KVM cannot intercept lctl(g) and lpsw(e) anymore. As a
> 
> "KVM cannot intercept (...) in order to notified..." might read a bit
> better.

ok.

>> +replacement, two new interception codes have been introduced: One
>> +indicating that the contents of CRs 0, 6, or 14 have been changed,
>> +indicating different interruption subclasses; and one indicating that
>> +PSW bit 13 has been changed, indicating that a machine check
>> +intervention was requested and those are now enabled.
>> +
>> +Instruction emulation
>> +---------------------
>> +With the format 4 state description for PVMs, the SIE instruction already
>> +interprets more instructions than it does with format 2. It is not able
>> +to interpret every instruction, but needs to hand some tasks to KVM;
>> +therefore, the SIE and the ultravisor safeguard emulation inputs and outputs.
>> +
>> +The control structures associated with SIE provide the Secure
>> +Instruction Data Area (SIDA), the Interception Parameters (IP) and the
>> +Secure Interception General Register Save Area.  Guest GRs and most of
>> +the instruction data, such as I/O data structures, are filtered.
>> +Instruction data is copied to and from the Secure Instruction Data
>> +Area (SIDA) when needed.  Guest GRs are put into / retrieved from the
> 
> I think you can use 'SIDA' directly the second time.

ack
> 
>> +Secure Interception General Register Save Area.
> 
> (...)
> 
> Otherwise,
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

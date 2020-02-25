Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2238 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731411AbgBYTam (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 14:30:42 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PJOHwR137751
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 14:30:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb00aqy4u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 14:30:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 19:30:39 -0000
Subject: Re: [PATCH v4 36/36] KVM: s390: protvirt: Add KVM api documentation
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-37-borntraeger@de.ibm.com>
 <20200225165059.5a2f48a5.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 20:30:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200225165059.5a2f48a5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a392d135-c0aa-3513-b633-70aa6c7e88bd@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 25.02.20 16:50, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 06:41:07 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Add documentation for KVM_CAP_S390_PROTECTED capability and the
>> KVM_S390_PV_COMMAND ioctl.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/api.rst | 55 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 7505d7a6c0d8..20abb8b2594e 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -4648,6 +4648,51 @@ the clear cpu reset definition in the POP. However, the cpu is not put
>>  into ESA mode. This reset is a superset of the initial reset.
>>  
>>  
>> +4.125 KVM_S390_PV_COMMAND
>> +-------------------------
>> +
>> +:Capability: KVM_CAP_S390_PROTECTED
>> +:Architectures: s390
>> +:Type: vm ioctl
>> +:Parameters: struct kvm_pv_cmd
>> +:Returns: 0 on success, < 0 on error
>> +
>> +::
>> +
>> +  struct kvm_pv_cmd {
>> +	__u32 cmd;	/* Command to be executed */
>> +	__u16 rc;	/* Ultravisor return code */
>> +	__u16 rrc;	/* Ultravisor return reason code */
>> +	__u64 data;	/* Data or address */
>> +	__u32 flags;    /* flags for future extensions. Must be 0 for now */
>> +	__u32 reserved[3];
>> +  };
>> +
>> +cmd values:
>> +
>> +KVM_PV_ENABLE
>> +  Allocate memory and register the VM with the Ultravisor, thereby
>> +  donating memory to the Ultravisor making it inaccessible to KVM.
>> +  Also converts all existing CPUs to protected ones. Future hotplug
>> +  CPUs will become protected during creation.
> 
> "Allocate memory and register the VM with the Ultravisor, thereby
> donating memory to the Ultravisor that will become inaccsessible to
> KVM. All existing CPUs are converted to protected ones. After this
> command has succeeded, any CPU added via hotplug will become protected
> during its creation as well."


ok

>> +
>> +KVM_PV_DISABLE
>> +  Deregisters the VM from the Ultravisor and frees memory that was
>> +  donated, so the kernel can use it again. All registered VCPUs are
>> +  converted back to non-protected ones.
> 
> "Deregister the VM from the Ultravisor and reclaim the memory that had
> been donated to the Ultravisor, making it usable by the kernel again.
> ..."

ok

> 
>> +
>> +KVM_PV_VM_SET_SEC_PARMS
>> +  Pass the image header from VM memory to the Ultravisor in
>> +  preparation of image unpacking and verification.
>> +
>> +KVM_PV_VM_UNPACK
>> +  Unpack (protect and decrypt) a page of the encrypted boot image.
>> +
>> +KVM_PV_VM_VERIFY
>> +  Verify the integrity of the unpacked image. Only if this succeeds,
>> +  KVM is allowed to start protected VCPUs.
>> +
>> +
>>  5. The kvm_run structure
>>  ========================
>>  
>> @@ -6026,3 +6071,13 @@ Architectures: s390
>>  
>>  This capability indicates that the KVM_S390_NORMAL_RESET and
>>  KVM_S390_CLEAR_RESET ioctls are available.
>> +
>> +8.23 KVM_CAP_S390_PROTECTED
>> +
>> +Architecture: s390
>> +
>> +This capability indicates that KVM can start protected VMs and the
>> +Ultravisor has therefore been initialized.> 
> "This capability indicates that the Ultravisor has been initialized and
> KVM can therefore start protected VMs."

ok.
> 
>> +This will provide the new KVM_S390_PV_COMMAND ioctl and it will allow
>> +KVM_MP_STATE_LOAD as new MP_STATE. KVM_SET_MP_STATE can now fail for
>> +protected guests when the state change is invalid.
> 

> "This capability governs the KVM_S390_PV_COMMAND ioctl and the
> KVM_MP_STATE_LOAD MP_STATE. KVM_SET_MP_STATE can fail for protected
> guests when the state change is invalid."

ok

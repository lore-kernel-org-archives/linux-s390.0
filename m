Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgBJM0o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:26:44 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ACJ774105454
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:26:44 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tnumwah-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:26:43 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 12:26:41 -0000
Subject: Re: [PATCH 09/35] KVM: s390: protvirt: Add KVM api documentation
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-10-borntraeger@de.ibm.com>
 <f7089ad6-65d2-35fc-16fb-b94e968fd4e8@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 13:26:35 +0100
MIME-Version: 1.0
In-Reply-To: <f7089ad6-65d2-35fc-16fb-b94e968fd4e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aae6434d-de87-503d-de51-4cee52d375b9@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 08.02.20 15:57, Thomas Huth wrote:
> On 07/02/2020 12.39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Add documentation for KVM_CAP_S390_PROTECTED capability and the
>> KVM_S390_PV_COMMAND and KVM_S390_PV_COMMAND_VCPU ioctls.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/api.txt | 61 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>
>> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
>> index 73448764f544..4874d42286ca 100644
>> --- a/Documentation/virt/kvm/api.txt
>> +++ b/Documentation/virt/kvm/api.txt
>> @@ -4204,6 +4204,60 @@ the clear cpu reset definition in the POP. However, the cpu is not put
>>  into ESA mode. This reset is a superset of the initial reset.
>>  
>>  
>> +4.125 KVM_S390_PV_COMMAND
>> +
>> +Capability: KVM_CAP_S390_PROTECTED
>> +Architectures: s390
>> +Type: vm ioctl
>> +Parameters: struct kvm_pv_cmd
>> +Returns: 0 on success, < 0 on error
>> +
>> +struct kvm_pv_cmd {
>> +	__u32	cmd;	/* Command to be executed */
>> +	__u16	rc;	/* Ultravisor return code */
>> +	__u16	rrc;	/* Ultravisor return reason code */
>> +	__u64	data;	/* Data or address */
> 
> That remindes me ... do we maybe want a "reserved" field in here for
> future extensions? Or is the "data" pointer enough?


This is now:

struct kvm_pv_cmd {

        __u32 cmd;      /* Command to be executed */
        __u32 flags;    /* flags for future extensions. Must be 0 for now */
        __u64 data;     /* Data or address */
        __u64 reserved[2];
};

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726959AbgBTN5G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 08:57:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KDuuGw084542
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 08:57:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubptdgk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 08:57:00 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 20 Feb 2020 13:55:26 -0000
Subject: Re: [PATCH v3 10/37] KVM: s390: protvirt: Add KVM api documentation
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-11-borntraeger@de.ibm.com>
 <d9580cae-6448-4d7a-347a-281df969e945@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Feb 2020 14:55:18 +0100
MIME-Version: 1.0
In-Reply-To: <d9580cae-6448-4d7a-347a-281df969e945@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cfe9a914-30b2-e858-5aee-7873864b411c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 20.02.20 14:05, David Hildenbrand wrote:
> On 20.02.20 11:39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Add documentation for KVM_CAP_S390_PROTECTED capability and the
>> KVM_S390_PV_COMMAND and KVM_S390_PV_COMMAND_VCPU ioctls.
> 
> Outdated.

ACK.

> 
> I suggest moving this after "[PATCH v3 37/37] KVM: s390: protvirt:
> introduce and enable KVM_CAP_S390_PROTECTED" or even squashing it into
> that one.

Will move at the end. 

[...]

>> +8.23 KVM_CAP_S390_PROTECTED
>> +
>> +Architecture: s390
>> +
>> +This capability indicates that KVM can start protected VMs and the
>> +Ultravisor has therefore been initialized.
>>
> 
> Maybe document that KVM_S390_PV_COMMAND and the new MP is available.
> Also maybe that MP commands can now fail.

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index faca9977cbe7..7faf32b92d8c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6081,3 +6081,6 @@ Architecture: s390
 
 This capability indicates that KVM can start protected VMs and the
 Ultravisor has therefore been initialized.
+This will provide the new KVM_S390_PV_COMMAND ioctl and it will allow
+KVM_MP_STATE_LOAD as new MP_STATE. KVM_SET_MP_STATE can now fail for
+protected guests when the state change is invalid.

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729434AbgBNVWN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 16:22:13 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ELKa5a051039
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 16:22:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j8963n0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 16:22:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 14 Feb 2020 21:22:10 -0000
Subject: Re: [PATCH 08/35] KVM: s390: protvirt: Add initial lifecycle handling
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-9-borntraeger@de.ibm.com>
 <e627e0a6-b27a-7e3a-05cd-056eb49ed16e@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Feb 2020 22:22:05 +0100
MIME-Version: 1.0
In-Reply-To: <e627e0a6-b27a-7e3a-05cd-056eb49ed16e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c764c5c8-9e09-b980-2f85-a7860ae998a4@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 14.02.20 19:39, David Hildenbrand wrote:
> On 07.02.20 12:39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> This contains 3 main changes:
>> 1. changes in SIE control block handling for secure guests
>> 2. helper functions for create/destroy/unpack secure guests
>> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
>> machines
[...]
> 
> I feel like my review comments for this patch were lost, so not
> repeating them

Basically you only asked if we could combine vm/vcpu_create/destroy into
enable/disable. Janosch came up with some cases regarding error handling
where the enable/disable would be hard to do right and exposing the single
interfaces provide some advantages.

If you still want to go down that path, please look at the next round of
kernel/qemu patches and then lets discuss.

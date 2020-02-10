Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbgBJNZQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 08:25:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADJ7Bc050967
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:25:16 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1umrn5ds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:25:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 13:25:13 -0000
Subject: Re: [PATCH 34/35] KVM: s390: protvirt: Add UV cpu reset calls
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-35-borntraeger@de.ibm.com>
 <20200210141725.27979f51.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 14:25:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200210141725.27979f51.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <90a1cde9-6442-a7d2-e589-f32efd532341@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 10.02.20 14:17, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:57 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> For protected VMs, the VCPU resets are done by the Ultravisor, as KVM
>> has no access to the VCPU registers.
>>
>> As the Ultravisor will only accept a call for the reset that is
>> needed, we need to fence the UV calls when chaining resets.
> 
> Last time, I suggested replacing this with
> 
> "Note that the ultravisor will only accept a call for the exact reset
> that has been requested."
> 
> I still suggest that :)

Will do.

> 
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

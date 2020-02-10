Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726816AbgBJSfG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:35:06 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AIMNhr108558
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:35:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u80jamv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:35:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 18:35:03 -0000
Subject: Re: [PATCH 24/35] KVM: s390: protvirt: disallow one_reg
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-25-borntraeger@de.ibm.com>
 <20200210185307.73b45f78.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 19:34:56 +0100
MIME-Version: 1.0
In-Reply-To: <20200210185307.73b45f78.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <df4805f2-0c51-6ee9-2082-42d0f2276bd3@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 10.02.20 18:53, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:47 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> A lot of the registers are controlled by the Ultravisor and never
>> visible to KVM. Some fields in the sie control block are overlayed,
>> like gbea. As no userspace uses the ONE_REG interface on s390 it is safe
>> to disable this for protected guests.
> 
> Last round, I suggested
> 
> "As no known userspace uses the ONE_REG interface on s390 if sync regs
> are available, no functionality is lost if it is disabled for protected
> guests."

If you think this variant is better I can use this, I am fine with either. 
> 
> Any opinion on that?
> 
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/api.txt | 6 ++++--
>>  arch/s390/kvm/kvm-s390.c       | 3 +++
>>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

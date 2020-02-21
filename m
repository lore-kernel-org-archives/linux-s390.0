Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgBULNZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 06:13:25 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LBATo2020634
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 06:13:24 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ya6e6dj10-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 06:13:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 21 Feb 2020 11:13:22 -0000
Subject: Re: [PATCH v3 36/37] KVM: s390: rstify new ioctls in api.rst
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-37-borntraeger@de.ibm.com>
 <20200221115132.60b0fbde.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Feb 2020 12:13:16 +0100
MIME-Version: 1.0
In-Reply-To: <20200221115132.60b0fbde.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <67b9a5ee-559b-6a21-4a03-40092a9fd41a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 21.02.20 11:51, Cornelia Huck wrote:
> On Thu, 20 Feb 2020 05:40:19 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> We also need to rstify the new ioctls that we added in parallel to the
>> rstification of the kvm docs.
> 
> This looks like it could be merged independently of the protected virt
> patches?
> 
Yes, but I did that while doing the other patch. Will go via kvm/master.


>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++---------------
>>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

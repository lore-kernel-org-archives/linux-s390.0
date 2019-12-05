Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23066 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfLERH5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 12:07:57 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5H7c3q172857
        for <linux-s390@vger.kernel.org>; Thu, 5 Dec 2019 12:07:56 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq5u90hdg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Dec 2019 12:07:55 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 5 Dec 2019 17:07:51 -0000
Subject: Re: [PATCH] KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
References: <20191205125147.229367-1-borntraeger@de.ibm.com>
 <087b1693-6ec0-94e3-d94a-f55c2e717438@redhat.com>
 <26f905be-3f09-3b3b-3008-ef64fc93e36c@de.ibm.com>
 <20191205160930.GA13800@osiris>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 5 Dec 2019 18:07:47 +0100
MIME-Version: 1.0
In-Reply-To: <20191205160930.GA13800@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <35c2623e-6bfa-5b5f-23b6-ae4fb3e6ecb6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>



On 05.12.19 17:09, Heiko Carstens wrote:
> On Thu, Dec 05, 2019 at 02:16:02PM +0100, Christian Borntraeger wrote:
>> On 05.12.19 14:09, Thomas Huth wrote:
>>> On 05/12/2019 13.51, Christian Borntraeger wrote:
>>>> There is no ENOTSUPP for userspace
>>>>
>>>> Reported-by: Julian Wiedmann <jwi@linux.ibm.com>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>> -		return -ENOTSUPP;
>>>> +		return -EOPNOTSUPP;
>>> There seems to be another one in arch/s390/include/asm/uv.h, are you
>>> going to fix that, too?
>> I looked into that but it seemed that this is not exposed to
>> userspace and just kept internal.
> 
> Could you remove that one as well, please? Otherwise people start
> copy-pasting this (again). I thought we got rid of them all, and now
> they crept in again.

Will do a separate patch as this goes via s390 tree, ok?

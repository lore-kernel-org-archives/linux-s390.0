Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbgBJRfO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 12:35:14 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AHWexe068401
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 12:35:13 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn50j04-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 12:35:13 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 17:35:11 -0000
Subject: Re: [PATCH 0/1] s390/uv: fix for ultravisor query function
References: <20200210165439.3767-1-borntraeger@de.ibm.com>
 <20200210183249.7816e316.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 18:35:07 +0100
MIME-Version: 1.0
In-Reply-To: <20200210183249.7816e316.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4521aff3-57f5-4a5b-80b6-0d1543f4f832@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>



On 10.02.20 18:32, Cornelia Huck wrote:
> On Mon, 10 Feb 2020 11:54:38 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> As outlined by the architects the query command could actually return more
>> than the minimal 168 bytes.
>>
>> I will carry this with the KVM host support for protected virtualization
> 
> As this is cc:stable (and also relevant for the guest side), why not
> merge it right now?
> 
Agreed. Will do.

>>
>> Christian Borntraeger (1):
>>   s390/uv: Fix handling of length extensions
>>
>>  arch/s390/boot/uv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 

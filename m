Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgBRGph (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 01:45:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I6jWoM043266
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 01:45:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y87e65rqm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 01:45:33 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 18 Feb 2020 06:44:57 -0000
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D78AA37@SHSMSX104.ccr.corp.intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Feb 2020 07:44:50 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D78AA37@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <16c66640-85bf-b158-9685-ea59359d1771@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>


On 18.02.20 04:36, Tian, Kevin wrote:
>> From: Christian Borntraeger
>> Sent: Friday, February 7, 2020 7:39 PM
>>
>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
>> With the introduction of protected KVM guests on s390 there is now a
>> concept of inaccessible pages. These pages need to be made accessible
>> before the host can access them.
>>
>> While cpu accesses will trigger a fault that can be resolved, I/O
>> accesses will just fail.  We need to add a callback into architecture
>> code for places that will do I/O, namely when writeback is started or
>> when a page reference is taken.
> 
> What about hooking the callback to DMA API ops?

Not all device drivers do use the DMA API so it wont work for us.

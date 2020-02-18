Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727438AbgBRQat (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 11:30:49 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IGK0Eg034616
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 11:30:49 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y87e6skyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 11:30:48 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 18 Feb 2020 16:30:46 -0000
Subject: Re: [PATCH v2 39/42] example for future extension: mm:gup/writeback:
 add callbacks for inaccessible pages: error cases
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-40-borntraeger@de.ibm.com>
 <20200218162546.GC1133@willie-the-truck>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Feb 2020 17:30:40 +0100
MIME-Version: 1.0
In-Reply-To: <20200218162546.GC1133@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e7f91b4f-455f-5fc7-19ab-51362dec4e62@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Sean Christopherson <sean.j.christopherson@intel.com>



On 18.02.20 17:25, Will Deacon wrote:
> On Fri, Feb 14, 2020 at 05:26:55PM -0500, Christian Borntraeger wrote:
>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
>> This is a potential extension to do error handling if we fail to
>> make the page accessible if we know what others need.
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  mm/gup.c            | 17 ++++++++++++-----
>>  mm/page-writeback.c |  6 +++++-
>>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> Sorry, I missed this when replying elsewhere in the thread!
> Anyway, looks good to me:
> 
> Acked-by: Will Deacon <will@kernel.org>

I can use that for a combined patch (this one merged into the first) ? Correct?

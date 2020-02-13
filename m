Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729383AbgBMHnm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Feb 2020 02:43:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D7dCKU038732
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 02:43:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4j89a3wp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 02:43:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 13 Feb 2020 07:43:39 -0000
Subject: Re: [PATCH 05/35] s390/mm: provide memory management functions for
 protected KVM guests
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-6-borntraeger@de.ibm.com>
 <20200212144212.1d0b4226.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Feb 2020 08:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200212144212.1d0b4226.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e0642555-9781-163a-7dd3-75e769dfb2d9@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>



On 12.02.20 14:42, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:28 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
>> This provides the basic ultravisor calls and page table handling to cope
>> with secure guests:
>> - provide arch_make_page_accessible
>> - make pages accessible after unmapping of secure guests
>> - provide the ultravisor commands convert to/from secure
>> - provide the ultravisor commands pin/unpin shared
>> - provide callbacks to make pages secure (inacccessible)
>>  - we check for the expected pin count to only make pages secure if the
>>    host is not accessing them
>>  - we fence hugetlbfs for secure pages
>>
>> Co-developed-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/gmap.h        |   2 +
>>  arch/s390/include/asm/mmu.h         |   2 +
>>  arch/s390/include/asm/mmu_context.h |   1 +
>>  arch/s390/include/asm/page.h        |   5 +
>>  arch/s390/include/asm/pgtable.h     |  34 +++++-
>>  arch/s390/include/asm/uv.h          |  52 +++++++++
>>  arch/s390/kernel/uv.c               | 172 ++++++++++++++++++++++++++++
>>  7 files changed, 263 insertions(+), 5 deletions(-)
> 
> (...)
> 
>> +/*
>> + * Requests the Ultravisor to encrypt a guest page and make it
>> + * accessible to the host for paging (export).
>> + *
>> + * @paddr: Absolute host address of page to be exported
>> + */
>> +int uv_convert_from_secure(unsigned long paddr)
>> +{
>> +	struct uv_cb_cfs uvcb = {
>> +		.header.cmd = UVC_CMD_CONV_FROM_SEC_STOR,
>> +		.header.len = sizeof(uvcb),
>> +		.paddr = paddr
>> +	};
>> +
>> +	uv_call(0, (u64)&uvcb);
>> +
>> +	if (uvcb.header.rc == 1 || uvcb.header.rc == 0x107)
> 
> I think this either wants a comment or some speaking #defines.

Yes. We will improve some other aspects of this patch, but I will add

	/* Return on success or if this page was already exported */
> 
>> +		return 0;
>> +	return -EINVAL;
>> +}
> 
> (...)
> 

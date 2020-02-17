Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728868AbgBQOi7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 09:38:59 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEcsBu097672
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:38:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1gfgdn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:38:58 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 14:38:38 -0000
Subject: Re: [PATCH v2 40/42] example for future extension: mm:gup/writeback:
 add callbacks for inaccessible pages: source indication
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-41-borntraeger@de.ibm.com>
 <20200217141511.GA14704@oc3748833570.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 15:38:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200217141511.GA14704@oc3748833570.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <24e25fd4-34e7-a40c-d11c-e9f4892daad2@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ulrich Weigand <uweigand@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>



On 17.02.20 15:15, Ulrich Weigand wrote:
> On Fri, Feb 14, 2020 at 05:26:56PM -0500, Christian Borntraeger wrote:
>> +enum access_type {
>> +	MAKE_ACCESSIBLE_GENERIC,
>> +	MAKE_ACCESSIBLE_GET,
>> +	MAKE_ACCESSIBLE_GET_FAST,
>> +	MAKE_ACCESSIBLE_WRITEBACK
>> +};
>>  #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
>> -static inline int arch_make_page_accessible(struct page *page)
>> +static inline int arch_make_page_accessible(struct page *page, int where)
> 
> If we want to make this distinction, wouldn't it be simpler to just
> use different function names, like
>   arch_make_page_accessible_for_writeback
>   arch_make_page_accessible_for_gup
> etc.

Agreed.
I would suggest to do these changes when somebody needs them, though.
On the other hand, Patch 39 (the error handling) is something that we
could merge now.

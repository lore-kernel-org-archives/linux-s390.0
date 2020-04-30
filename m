Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbgD3Tiu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 15:38:50 -0400
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
 <d77d1e86-ac99-8c18-658c-d8150a71b11e@de.ibm.com>
 <540f483f-5e58-f342-e771-9d90c4d3fb6a@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <f32fa7f8-a259-80cc-ec70-d9cd690a8430@de.ibm.com>
Date: Thu, 30 Apr 2020 21:38:28 +0200
MIME-Version: 1.0
In-Reply-To: <540f483f-5e58-f342-e771-9d90c4d3fb6a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com



On 30.04.20 21:32, Dave Hansen wrote:
> On 4/30/20 11:12 AM, Christian Borntraeger wrote:
>> On 29.04.20 18:07, Dave Hansen wrote:
>>> On 4/28/20 3:50 PM, Claudio Imbrenda wrote:
>>>> If a page is inaccesible and it is used for things like sendfile, then
>>>> the content of the page is not always touched, and can be passed
>>>> directly to a driver, causing issues.
>>>>
>>>> This patch fixes the issue by adding a call to arch_make_page_accessible
>>>> in page_cache_pipe_buf_confirm; this fixes the issue.
>>> I spent about 5 minutes putting together a patch:
>>>
>>> 	https://sr71.net/~dave/intel/accessible.patch
>> You only set the page flag for compound pages. that of course leaves a big pile
>> of pages marked a not accessible, thus explaining the sendto trace and all kind
>> of other random traces.
> 
> Ahh, nice catch!  That does explain an oddity or two that I saw.
> 
>> What do you see when you also do the  SetPageAccessible(page);
>> in the else page of prep_new_page (order == 0).
>> (I do get > 10000 of these non compound page allocs just during boot).
> 
> Yes, I see the same thing.
> 
> I updated the patch and double-checked that it triggers properly with a
> socket-based sendfile().

Do you have a calltrace? 

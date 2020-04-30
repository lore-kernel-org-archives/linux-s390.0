Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34003 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgD3Tcc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 15:32:32 -0400
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
 <d77d1e86-ac99-8c18-658c-d8150a71b11e@de.ibm.com>
Message-ID: <540f483f-5e58-f342-e771-9d90c4d3fb6a@intel.com>
Date: Thu, 30 Apr 2020 12:32:31 -0700
MIME-Version: 1.0
In-Reply-To: <d77d1e86-ac99-8c18-658c-d8150a71b11e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com

On 4/30/20 11:12 AM, Christian Borntraeger wrote:
> On 29.04.20 18:07, Dave Hansen wrote:
>> On 4/28/20 3:50 PM, Claudio Imbrenda wrote:
>>> If a page is inaccesible and it is used for things like sendfile, then
>>> the content of the page is not always touched, and can be passed
>>> directly to a driver, causing issues.
>>>
>>> This patch fixes the issue by adding a call to arch_make_page_accessible
>>> in page_cache_pipe_buf_confirm; this fixes the issue.
>> I spent about 5 minutes putting together a patch:
>>
>> 	https://sr71.net/~dave/intel/accessible.patch
> You only set the page flag for compound pages. that of course leaves a big pile
> of pages marked a not accessible, thus explaining the sendto trace and all kind
> of other random traces.

Ahh, nice catch!  That does explain an oddity or two that I saw.

> What do you see when you also do the  SetPageAccessible(page);
> in the else page of prep_new_page (order == 0).
> (I do get > 10000 of these non compound page allocs just during boot).

Yes, I see the same thing.

I updated the patch and double-checked that it triggers properly with a
socket-based sendfile().

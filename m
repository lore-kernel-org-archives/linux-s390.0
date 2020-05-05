Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:35924 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgEEO51 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 May 2020 10:57:27 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
 <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
 <20200505135556.GA9920@oc3748833570.ibm.com>
 <fd300dca-f0b4-ce3b-4a97-244030624fbd@de.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a6eb1246-0c9e-be8c-eeeb-e5a56b1d09b4@intel.com>
Date: Tue, 5 May 2020 07:57:25 -0700
MIME-Version: 1.0
In-Reply-To: <fd300dca-f0b4-ce3b-4a97-244030624fbd@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On 5/5/20 7:01 AM, Christian Borntraeger wrote:
> On 05.05.20 15:55, Ulrich Weigand wrote:
>> On Tue, May 05, 2020 at 05:34:45AM -0700, Dave Hansen wrote:
>>>> static inline __must_check bool try_get_page(struct page *page)
>>>> {
>>>>         page = compound_head(page);
>>>>         if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>>>>                 return false;
>>>>         page_ref_inc(page);
>>>>         return true;
>>>> }
>>>
>>> If try_get_page() collides with a freeze_page_refs(), it'll hit the
>>> WARN_ON_ONCE(), which is surely there for a good reason.  I'm not sure
>>> that warning is _actually_ valid since freeze_page_refs() isn't truly a
>>> 0 refcount.  But, the fact that this hasn't been encountered means that
>>> the testing here is potentially lacking.
>>
>> This is indeed interesting.  In particular if you compare try_get_page
>> with try_get_compound_head in gup.c, which does instead:
>>
>>         if (WARN_ON_ONCE(page_ref_count(head) < 0))
>>                 return NULL;
>>
>> which seems more reasonable to me, given the presence of the
>> page_ref_freeze method.  So I'm not sure why try_get_page has <= 0.
> 
> Just looked at 
> commit 88b1a17dfc3ed7728316478fae0f5ad508f50397  mm: add 'try_get_page()' helper function
> 
> which says:
>     Also like 'get_page()', you can't use this function unless you already
>     had a reference to the page.  The intent is that you can use this
>     exactly like get_page(), but in situations where you want to limit the
>     maximum reference count.
>     
>     The code currently does an unconditional WARN_ON_ONCE() if we ever hit
>     the reference count issues (either zero or negative), as a notification
>     that the conditional non-increment actually happened.
> 
> If try_get_page must be called with an existing reference, that means
> that when we call it the page reference is already higher and our freeze
> will never succeed. That would imply that we cannot trigger this. No?

For gup, we hold the page table lock over the try_grab_page().  That
ensures that nobody can drop the reference while try_grab_page() is in
progress.  The migration page_ref_freeze() code also never races with
this because it first shoots down the PTEs before freezing refs.

My worry with the s390 code is that it leaves the PTEs in place while
freezing refs.  This seems new, otherwise we would have been tripping
the gup warning.

For the page cache, there's a reference taken because of the page's
presence in the page cache xarray.  But, the page cache uses
page_cache_get_speculative(), not try_grab_page().  It doesn't have the
warning on the <=0 refcount.

Either way, I agree that the try_get_page()
WARN_ON_ONCE(page_ref_count(page) <= 0) is looking fishy.

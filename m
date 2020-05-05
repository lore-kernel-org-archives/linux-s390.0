Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728932AbgEEOEJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 10:04:09 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
 <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
 <20200505135556.GA9920@oc3748833570.ibm.com>
 <fd300dca-f0b4-ce3b-4a97-244030624fbd@de.ibm.com>
Message-ID: <d1de4fb2-dfe6-83fa-9973-2505d4c397ec@de.ibm.com>
Date: Tue, 5 May 2020 16:03:00 +0200
MIME-Version: 1.0
In-Reply-To: <fd300dca-f0b4-ce3b-4a97-244030624fbd@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ulrich Weigand <uweigand@de.ibm.com>, Dave Hansen <dave.hansen@intel.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com



On 05.05.20 16:01, Christian Borntraeger wrote:
> 
> 
> On 05.05.20 15:55, Ulrich Weigand wrote:
>> On Tue, May 05, 2020 at 05:34:45AM -0700, Dave Hansen wrote:
>>> On 5/4/20 6:41 AM, Ulrich Weigand wrote:
>>>> You're right that there is no mechanism to prevent new references,
>>>> but that's really never been the goal either.  We're simply trying
>>>> to ensure that no I/O is ever done on a page that is in the "secure"
>>>> (or inaccessible) state.  To do so, we rely on the assumption that
>>>> all code that starts I/O on a page cache page will *first*:
>>>> - mark the page as pending I/O by either taking an extra page
>>>>   count, or by setting the Writeback flag; then:
>>>> - call arch_make_page_accessible(); then:
>>>> - start I/O; and only after I/O has finished:
>>>> - remove the "pending I/O" marker (Writeback and/or extra ref)
>>>
>>> Let's ignore writeback for a moment because get_page() is the more
>>> general case.  The locking sequence is:
>>>
>>> 1. get_page() (or equivalent) "locks out" a page from converting to
>>>    inaccessbile,
>>> 2. followed by a make_page_accessible() guarantees that the page
>>>    *stays* accessible until
>>> 3. I/O is safe in this region
>>> 4. put_page(), removes the "lock out", I/O now unsafe
>>
>> Yes, exactly.
>>
>>> They key is, though, the get_page() must happen before
>>> make_page_accessible() and *every* place that acquires a new reference
>>> needs a make_page_accessible().
>>
>> Well, sort of: every place that acquires a new reference *and then
>> performs I/O* needs a make_page_accessible().  There seem to be a
>> lot of plain get_page() calls that aren't related to I/O.
>>
>>> try_get_page() is obviously one of those "new reference sites" and it
>>> only has one call site outisde of the gup code: generic_pipe_buf_get(),
>>> which is effectively patched by the patch that started this thread.  The
>>> fact that this one oddball site _and_ gup are patched now is a good sign.
>>>
>>> *But*, I still don't know how that could work nicely:
>>>
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
> If try_get_page must not be called with an existing reference, that means
		s/not//
> that when we call it the page reference is already higher and our freeze
> will never succeed. That would imply that we cannot trigger this. No?
> 

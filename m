Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37689 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfJJMOX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 08:14:23 -0400
Date: Thu, 10 Oct 2019 20:14:03 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: "reuse mergeable anon_vma as parent when fork" causes a crash on
 s390
Message-ID: <20191010121403.GA13088@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1570656570.5937.24.camel@lca.pw>
 <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
 <20191010023601.GA4793@richard>
 <20191010031516.GA5060@richard>
 <8e0d9999-9ee3-78e5-2737-5a504243413c@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0d9999-9ee3-78e5-2737-5a504243413c@yandex-team.ru>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Wei Yang <richardw.yang@linux.intel.com>, Shakeel Butt <shakeelb@google.com>, Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, Oct 10, 2019 at 11:29:44AM +0300, Konstantin Khlebnikov wrote:
>On 10/10/2019 06.15, Wei Yang wrote:
>> On Thu, Oct 10, 2019 at 10:36:01AM +0800, Wei Yang wrote:
>> > Hi, Qian, Shakeel
>> > 
>> > Thanks for testing.
>> > 
>> > Sounds I missed some case to handle. anon_vma_clone() now would be called in
>> > vma_adjust, which is a different case when it is introduced.
>> > 
>> 
>> Well, I have to correct my statement. The reason is we may did something more
>> in anon_vma_clone().
>> 
>> Here is a quick fix, while I need to go through all the cases carefully.
>
>Oops, I've overlooked this case too.
>
>You have to check src->anon_vma
>otherwise in  __split_vma or copy_vma dst could pick completely random anon_vma.
>
>Also checking prev will not hurt, just to be sure.
>
>So, something like this should work:
>
>if (!dst->anon_vma && src->anon_vma &&
>    prev && pprev && pprev->anon_vma == src->anon_vma)
>      dst->anon_vma = prev->anon_vma;
>

This may not be the root cause, I found another problem of it.

Let me prepare a patch to fix it.

>> 
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 12f6c3d7fd9d..2844f442208d 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -271,7 +271,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>>           * 1. Parent has vm_prev, which implies we have vm_prev.
>>           * 2. Parent and its vm_prev have the same anon_vma.
>>           */
>> -       if (pprev && pprev->anon_vma == src->anon_vma)
>> +       if (!dst->anon_vma && pprev && pprev->anon_vma == src->anon_vma)
>>                  dst->anon_vma = prev->anon_vma;
>>          list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>> 
>> > BTW, do you have the specific test case? So that I could verify my change. The
>> > kernel build test doesn't trigger this.
>> > 
>> > Thanks a lot :-)
>> > 
>> > On Wed, Oct 09, 2019 at 03:21:11PM -0700, Shakeel Butt wrote:
>> > -- 
>> > Wei Yang
>> > Help you, Help me
>> 

-- 
Wei Yang
Help you, Help me

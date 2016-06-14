Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [LKP] [lkp] [mm] 5c0a85fad9: unixbench.score -6.3% regression
References: <20160606022724.GA26227@yexl-desktop>
 <20160606095136.GA79951@black.fi.intel.com>
 <87a8iw5enf.fsf@yhuang-dev.intel.com> <8760tk5aym.fsf@yhuang-dev.intel.com>
 <20160608085811.GB12655@black.fi.intel.com>
 <87porn44fm.fsf@yhuang-dev.intel.com>
 <CA+55aFy4oYis6HTu7o4YwiFawRtDOPO=87v8oHZdTFS+BjnA8g@mail.gmail.com>
 <20160613125248.GA30109@black.fi.intel.com>
 <CA+55aFx2TdqHW5VvirF-fAe4rRtSKK6BH06LyN4Ma3Q7ifJkxA@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 16:03:23 +0200
MIME-Version: 1.0
In-Reply-To: <CA+55aFx2TdqHW5VvirF-fAe4rRtSKK6BH06LyN4Ma3Q7ifJkxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <57600EAB.9030000@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Minchan Kim <minchan@kernel.org>, Vinayak Menon <vinmenon@codeaurora.org>, Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, LKP <lkp@01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/14/2016 08:11 AM, Linus Torvalds wrote:
> On Mon, Jun 13, 2016 at 5:52 AM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
>> On Sat, Jun 11, 2016 at 06:02:57PM -0700, Linus Torvalds wrote:
>>>
>>> I've timed it at over a thousand cycles on at least some CPU's, but
>>> that's still peanuts compared to a real page fault. It shouldn't be
>>> *that* noticeable, ie no way it's a 6% regression on its own.
>>
>> Looks like setting accessed bit is the problem.
> 
> Ok. I've definitely seen it as an issue, but never to the point of
> several percent on a real benchmark that wasn't explicitly testing
> that cost.
> 
> I reported the excessive dirty/accessed bit cost to Intel back in the
> P4 days, but it's apparently not been high enough for anybody to care.
> 
>> We spend 36% more time in page walk only, about 1% of total userspace time.
>> Combining this with page walk footprint on caches, I guess we can get to
>> this 3.5% score difference I see.
>>
>> I'm not sure if there's anything we can do to solve the issue without
>> screwing relacim logic again. :(
> 
> I think we should say "screw the reclaim logic" for now, and revert
> commit 5c0a85fad949 for now.
> 
> Considering how much trouble the accessed bit is on some other
> architectures too, I wonder if we should strive to simply not care
> about it, and always leaving it set. And then rely entirely on just
> unmapping the pages and making the "we took a page fault after
> unmapping" be the real activity tester.
> 
> So get rid of the "if the page is young, mark it old but leave it in
> the page tables" logic entirely. When we unmap a page, it will always
> either be in the swap cache or the page cache anyway, so faulting it
> in again should be just a minor fault with no actual IO happening.
> 
> That might be less of an impact in the end - yes, the unmap and
> re-fault is much more expensive, but it presumably happens to much
> fewer pages.

FWIW, something like that is what Martin did for s390 3 years ago.
We now use invalidation and page faults to implement the *young 
functions in  pgtable.h (basically using a SW young bit). This
helped us to get rid of the storage keys (which contain the HW 
reference bit). The performance did not seem to suffer.

See commit 0944fe3f4a323f436180d39402cae7f9c46ead17
s390/mm: implement software referenced bits

> 
> What do you think?

Your proposal would be to do the software tracking via
invalidation/fault part of the generic mm code and not to hide it
in the architecture backend. Correct?

> 
>              Linus
> 

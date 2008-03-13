Return-Path: <linux-kernel-owner+w=401wt.eu-S1756544AbYCMSoC@vger.kernel.org>
Message-ID: <47D9754B.1030509@goop.org>
Date: Thu, 13 Mar 2008 11:41:15 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [patch 0/6] Guest page hinting version 6.
References: <20080312132132.520833247@de.ibm.com> <Pine.LNX.4.64.0803131627450.17244@blonde.site>
In-Reply-To: <Pine.LNX.4.64.0803131627450.17244@blonde.site>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, zach@vmware.com, frankeh@watson.ibm.com, rusty@rustcorp.com.au, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl, Keir Fraser <keir@xensource.com>, Ian Pratt <ian.pratt@xensource.com>
List-ID: <linux-s390.vger.kernel.org>

Hugh Dickins wrote:
> On Wed, 12 Mar 2008, Martin Schwidefsky wrote:
>   
>> Greetings,
>> I've dedusted the guest page hinting patches and ported them to todays
>> upstream git tree. There is one reject if applied to 2.6.24-rc5-mm1 but
>> that is easy to fix. The code stills works as expected on my test system.
>>
>> Our z/VM performance team recently published a report on guest page
>> hinting vs. the ballooner approach on SLES10 for a farm of web servers.
>> The code on SLES10 differs a bit from the upstream variant but the
>> performance results should be still valid.  You will find the report
>> here:
>>
>>   http://www.vm.ibm.com/perf/reports/zvm/html/530cmm.html
>>
>> (the VMRM-CMM the web page speaks about is the balloon approach,
>>  CMMA is the guest page hinting).
>>
>> Both approaches to the memory overcommit problem show comparable benefits
>> for this workload, with an advantage for guest page hinting for large
>> number of guests. For other workloads your mileage may vary.
>>
>> The main benefit for guest page hinting vs. the ballooner is that there
>> is no need for a monitor that keeps track of the memory usage of all the
>> guests, a complex algorithm that calculates the working set sizes and for
>> the calls into the guest kernel to control the size of the balloons.
>> The host just does normal LRU based paging. If the host picks one of the
>> pages the guest can recreate, the host can throw it away instead of writing
>> it to the paging device. Simple and elegant.
>> The main disadvantage is the added complexity that is introduced to the
>> guests memory management code to do the page state changes and to deal
>> with discard faults.
>>
>> The last versions of the patches do not differ much, I consider the code
>> to be stable. My question now is how to proceed with the code. I sure
>> would love to see the code going upstream some day but that depends on
>> the mm developers as the code adds complexity that needs to be supported.
>> If the general feeling is that the advantages of this approach do not
>> warrent for the added complexity this will likely be the last time you
>> will hear about guest page hinting. 
>>     
>
> Oh, that would be such a shame.  Your guest page hinting patches remind
> me of that childhood thrill, when once a year the circus comes to town ;)
>
> But seriously, I'm ashamed to see my name in the Cc list: it would
> be very unfair if your patches never made it in, just because I've
> failed to find the time to wrap my own puny brain around them.
>
> It's very encouraging to see Jeremy and Rusty weighing in.  I hope
> Zach will too, and I've added Andrea: their support would count a lot.
> You have Nick on the list, good, I've added Christoph and Peter
> (if you do resend, linux-mm might prove more useful than linux-kernel).
>   

I like the idea and it seems basically sound, but unfortunately Xen 
won't be able to make use of it in the near term, because it doesn't 
support any kind of backing for guest domain memory.  There has been 
some thought about adding this kind of functionality to Xen.  Keir, Ian: 
do you think this kind of support in the kernel be useful to us?

One concern I have is that 4k is really a very fine grain.  We're 
thinking about moving Xen's memory management to operate in 2M chunk 
units, which would allow guests to directly use large pages with the 
corresponding reduction in TLB pressure.  One side-effect of this is 
that we'd need to change ballooning to be in 2M rather than 4k units in 
order to prevent physical memory fragmentation.

Page hinting at 4k resolution poses the same problem.  Would this 
technique still be useful operating on 2M chunks?  Certainly it seems 
less likely that you could easily get a whole 2M area with the same 
fine-grained properties that these patches track.  Would some kind of 
page/sub-page tracking be useful?

My other concern is just correctness over time on the Linux side.  We 
already have enough trouble keeping things like the pte and page 
structure state in sync, with resulting rare data-loss bugs.  Adding 
another layer which only applies in specific environments raises the 
possibility for new bugs to be un-noticed for a long time.  How can we 
structure the VM changes to make sure that its robust in the face of 
maintenance?

    J

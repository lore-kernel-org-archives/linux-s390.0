Return-Path: <linux-kernel-owner+w=401wt.eu-S1758878AbXFGG73@vger.kernel.org>
Message-ID: <4667ACC3.60009@de.ibm.com>
Date: Thu, 07 Jun 2007 08:59:15 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu> <46674EA9.9090601@de.ibm.com> <1181198376.7348.202.camel@twins>
In-Reply-To: <1181198376.7348.202.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Peter Zijlstra wrote:
> On Thu, 2007-06-07 at 02:17 +0200, Martin Peschke wrote:
>> Ingo Molnar wrote:
>>> * Martin Peschke <mp3@de.ibm.com> wrote:
>>>
>>>> The output has changed from a terribly wide table to an enormously 
>>>> long list (just the generic way the statistics code prints data). 
>>> Sigh, why dont you _ask_ before doing such stuff?
>> A nice diffstat is always worth a try, isn't it?
>> And I see other reasons for code sharing.
>> Ah, and doing it has been actually quite simple once I had figured out
>> what the original code does. :-)
>>
>>> It is a terribly wide table because that makes it easily greppable
>> If one looks for contentions of "xtime_lock" within my enormously long list,
>> they could issue:
>>
>>     grep -e "xtime_lock contentions" data
>>
>> and get
>>
>>     xtime_lock contentions 0x17bd2 3327 account_ticks+0x96/0x184
>>     xtime_lock contentions other 0
>>
>> for example.
>>
>> So how is this worse?
> 
> How will you find the 5 most contended locks with 1 grep?
> 
> It used to be:
>   grep ":" /proc/lock_stat | head -n 5

grep "contention" data |sort -k 4 -n |tail -n 5

&rq->rq_lock_key contentions 0x34c04 613 task_rq_lock+0x64/0xb0
&zone->lock contentions 0x8322e 770 __free_pages_ok+0x1b2/0x534
&zone->lock contentions 0x82828 1017 free_pages_bulk+0x40/0x42c
xtime_lock contentions 0x17bd2 3327 account_ticks+0x96/0x184
&inode->i_mutex contentions 0x3273ee 8807 mutex_lock+0x3e/0x4c

Admittedly this gives you the top five contention points, as my prototype
tracks this without accounting the total number of contentions for a
given lock in another counter.

If the above command line isn't good enough, we could easily put a total
contentions counter for each lock back in (see lock_stat_info).

> 
> lock stat is more about finding who is bad than examining a particular
> lock (of course in the process of fixing that lock, that does become
> interesting).

Sure. I guess that applies to most other statistics.

Return-Path: <linux-kernel-owner+w=401wt.eu-S933662AbXEGMoP@vger.kernel.org>
Message-ID: <463F1F11.8060508@de.ibm.com>
Date: Mon, 07 May 2007 14:44:01 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 3/3] readahead statistics slimmed down
References: <1178214999.5639.79.camel@dix> <f6b15c890705050255l7ab6fb42y93714a6da8b3d2b5@mail.gmail.com>
In-Reply-To: <f6b15c890705050255l7ab6fb42y93714a6da8b3d2b5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <wfg@mail.ustc.edu.cn>, swen@vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Fengguang Wu wrote:
> 2007/5/3, Martin Peschke <mp3@de.ibm.com>:
>>
>> This patch implements the bulk of the existing the adaptive readahead
>> statistics with lib/statistics.c.
>>
>> The output format differs somewhat as the the statistics code just emits
>> lists of items and doesn't do tables. It is feasible to leave
>> reformating and beautification to some user scripts, if needed. This
>> patch omits some summary data, most of which can be done in user space
>> as well.
>>
>> Sample output (from dd'ing a disk):
>>
>> cache_miss.total 0 0
>> cache_miss.initial 0 0
>> cache_miss.clock 10 10
>> cache_miss.context 0 0
> 
> 
> Martin,
> 
> The new form of readahead statistics is appreciated. The code is much
> simpler and the output is suitable for scripting. Thank you for doing the
> conversion.
> 
> Me too have trimmed out the original ra_events_show() stuff based on your
> patches. However, later on it becomes obvious that the current adaptive
> readahead patch needs non-trivial rework. So the accounting patches were 
> put
> off. Expect to see them in the adaptive readahead kernel module ;-)
> 
> Thank you,
> Fengguang Wu

I have been wondering whether this one might be worth staging in -mm along with 
the other readahead patches. It would be work be work in progress like the other 
readahead patches. But I leave this decision to you and Andrew.

THanks for the positive feedback.

Martin

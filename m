Return-Path: <linux-kernel-owner+w=401wt.eu-S965706AbXFGAWR@vger.kernel.org>
Message-ID: <46674FA6.8060904@de.ibm.com>
Date: Thu, 07 Jun 2007 02:21:58 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
References: <1181165656.7133.23.camel@dix> <20070606231041.GB11592@elte.hu>
In-Reply-To: <20070606231041.GB11592@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Ingo Molnar wrote:
> * Martin Peschke <mp3@de.ibm.com> wrote:
> 
>> - lock_time_inc() vs. statistic_add_util()
> 
> please fix the coding style in lib/statistic.c. It's full of:
> 
> {
>         unsigned long long i;
>         if (value <= stat->u.histogram.range_min)
>                 return 0;
> 
> put a newline after variable sections.
> 
> and:
> 
>         on_each_cpu(_statistic_barrier, NULL, 0, 1);
>         return 0;
> 
> preferably use a newline before 'return' statements as well. (this is 
> not always necessary, but in the above case it looks better)

Will do (in my local tree, for the time being).

Good points. Thnaks for reviewing.


	Martin

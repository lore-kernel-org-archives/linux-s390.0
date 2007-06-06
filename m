Return-Path: <linux-kernel-owner+w=401wt.eu-S965985AbXFFXLA@vger.kernel.org>
Date: Thu, 7 Jun 2007 01:10:41 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
Message-ID: <20070606231041.GB11592@elte.hu>
References: <1181165656.7133.23.camel@dix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1181165656.7133.23.camel@dix>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Martin Peschke <mp3@de.ibm.com> wrote:

> - lock_time_inc() vs. statistic_add_util()

please fix the coding style in lib/statistic.c. It's full of:

{
        unsigned long long i;
        if (value <= stat->u.histogram.range_min)
                return 0;

put a newline after variable sections.

and:

        on_each_cpu(_statistic_barrier, NULL, 0, 1);
        return 0;

preferably use a newline before 'return' statements as well. (this is 
not always necessary, but in the above case it looks better)

	Ingo

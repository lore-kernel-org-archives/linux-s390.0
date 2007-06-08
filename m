Return-Path: <linux-kernel-owner+w=401wt.eu-S970047AbXFHRAb@vger.kernel.org>
Message-ID: <46698B1D.3000806@de.ibm.com>
Date: Fri, 08 Jun 2007 19:00:13 +0200
From: Martin Peschke <mp3@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
References: <1181165656.7133.23.camel@dix> <1181202258.7348.217.camel@twins>
In-Reply-To: <1181202258.7348.217.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Peter Zijlstra wrote:
> I'm confused as to where the class->stat objects are initialised? Is
> that done in lock_stat_init()? If so, then you have a bug.

static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];

I assume this gets us class structures containing all zeros, doesn't it?
Then class->stat is zeros as well, which is handled by lib/statistics.
(In this case, data gathering hasn't been turned on yet, and statistic_inc()
and similar functions don't access other areas of struct statistic.)

Martin

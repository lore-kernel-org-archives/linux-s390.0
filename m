Return-Path: <linux-kernel-owner+w=401wt.eu-S1754641AbZCEVJn@vger.kernel.org>
Date: Thu, 5 Mar 2009 22:09:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: Expose a constant for the number of words
 representing the CRs
Message-ID: <20090305220926.58a380bf@skybook>
In-Reply-To: <878wnjviwo.fsf@caffeine.danplanet.com>
References: <1236271688-18806-1-git-send-email-danms@us.ibm.com>
	<87tz67vrkc.fsf@caffeine.danplanet.com>
	<20090305203527.48d7c2cd@skybook>
	<878wnjviwo.fsf@caffeine.danplanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dan Smith <danms@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 05 Mar 2009 12:01:11 -0800
Dan Smith <danms@us.ibm.com> wrote:

> MS> Have you looked at git390 lately ?
> 
> Yes.  My patch still applies cleanly there.  What am I missing?

You need to look at the correct branch:

http://git390.marist.edu/cgi-bin/gitweb.cgi?p=linux-2.6.git;a=shortlog;h=refs/heads/features

The feature branch which contains the patches for the next merge window
contains your patch. I've added it a few weeks ago, but I might have
forgotten to drop you a note that I did so.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

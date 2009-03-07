Return-Path: <linux-kernel-owner+w=401wt.eu-S1756488AbZCGVKh@vger.kernel.org>
Date: Sat, 7 Mar 2009 22:10:15 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: Expose a constant for the number of words
 representing the CRs
Message-ID: <20090307221015.7aff8204@de.ibm.com>
In-Reply-To: <87zlfzu0vw.fsf@caffeine.danplanet.com>
References: <1236271688-18806-1-git-send-email-danms@us.ibm.com>
	<87tz67vrkc.fsf@caffeine.danplanet.com>
	<20090305203527.48d7c2cd@skybook>
	<878wnjviwo.fsf@caffeine.danplanet.com>
	<20090305220926.58a380bf@skybook>
	<87zlfzu0vw.fsf@caffeine.danplanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dan Smith <danms@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 05 Mar 2009 13:15:47 -0800
Dan Smith <danms@us.ibm.com> wrote:

> MS> The feature branch which contains the patches for the next merge
> MS> window contains your patch. I've added it a few weeks ago, but I
> MS> might have forgotten to drop you a note that I did so.
> 
> Ah, yeah, I never heard anything :)
> 
> The patch I sent earlier to day has been updated to catch another use
> of the magic '3'.  Can we replace the old with the new in that branch?

Sure, I've added the new one to my patch set.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

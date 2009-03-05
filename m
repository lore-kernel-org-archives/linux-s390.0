Return-Path: <linux-kernel-owner+w=401wt.eu-S1755613AbZCEVQD@vger.kernel.org>
From: Dan Smith <danms@us.ibm.com>
Subject: Re: [PATCH] s390: Expose a constant for the number of words representing the CRs
References: <1236271688-18806-1-git-send-email-danms@us.ibm.com>
	<87tz67vrkc.fsf@caffeine.danplanet.com>
	<20090305203527.48d7c2cd@skybook>
	<878wnjviwo.fsf@caffeine.danplanet.com>
	<20090305220926.58a380bf@skybook>
Date: Thu, 05 Mar 2009 13:15:47 -0800
In-Reply-To: <20090305220926.58a380bf@skybook> (Martin Schwidefsky's message
	of "Thu, 5 Mar 2009 22:09:26 +0100")
Message-ID: <87zlfzu0vw.fsf@caffeine.danplanet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

MS> The feature branch which contains the patches for the next merge
MS> window contains your patch. I've added it a few weeks ago, but I
MS> might have forgotten to drop you a note that I did so.

Ah, yeah, I never heard anything :)

The patch I sent earlier to day has been updated to catch another use
of the magic '3'.  Can we replace the old with the new in that branch?

Thanks Martin!

-- 
Dan Smith
IBM Linux Technology Center
email: danms@us.ibm.com

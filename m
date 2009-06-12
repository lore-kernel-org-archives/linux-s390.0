Return-Path: <linux-kernel-owner+w=401wt.eu-S932494AbZFLGih@vger.kernel.org>
Date: Fri, 12 Jun 2009 08:37:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 05/38] s390: hibernation support for s390
Message-ID: <20090612083744.3d0d3fa4@skybase>
In-Reply-To: <20090608064451.GD1444@ucw.cz>
References: <20090604161847.513682672@de.ibm.com>
	<20090604161900.659762303@de.ibm.com>
	<20090608064451.GD1444@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Hans-Joachim Picht <hans@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 8 Jun 2009 08:44:51 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2009-06-04 18:18:52, Martin Schwidefsky wrote:
> > From: Hans-Joachim Picht <hans@linux.vnet.ibm.com>
> > 
> > This patch introduces the hibernation backend support to the 
> > s390 architecture. Now it is possible to suspend a mainframe Linux 
> > guest using the following command:
> > 
> > echo disk > /sys/power/state
> 
> Should this one be last in series?
> 
> Otherwise no obvious problems...

Ok, I will move the base patch to the end of the patch queue.
Thanks for the review.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

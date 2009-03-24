Return-Path: <linux-kernel-owner+w=401wt.eu-S1757575AbZCXIYS@vger.kernel.org>
Date: Tue, 24 Mar 2009 09:23:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator -
 hang traced
Message-ID: <20090324092354.62bfb91a@skybase>
In-Reply-To: <1237846740.7068.15.camel@jstultz-laptop>
References: <200903080230.10099.elendil@planet.nl>
	<200903181307.44867.elendil@planet.nl>
	<1237391338.32698.9.camel@jstultz-laptop>
	<200903230111.08814.elendil@planet.nl>
	<1237846740.7068.15.camel@jstultz-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: John Stultz <johnstul@us.ibm.com>
Cc: Frans Pop <elendil@planet.nl>, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 23 Mar 2009 15:19:00 -0700
John Stultz <johnstul@us.ibm.com> wrote:

> Fixing the divide issue avoids the problem (and is pretty important to
> get upstream), but the underlying issue that we allow ONESHOT clockevent
> mode to be used while the jiffies clocksource is in use is a concern.

The bug only appears on 31-bit if the kernel is compiled for a G5. All
current distros use at 64-bit kernels with a cpu >= z900. The severity
is relative .. but the bug fix is upstream and Greg picked it up for
his stable releases.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

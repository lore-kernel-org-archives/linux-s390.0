Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Apr 2016 08:19:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] cpu/hotplug: fix rollback during error-out in
 __cpu_disable()
Message-ID: <20160408061949.GA3433@osiris>
References: <20160405104912.GC3937@osiris>
 <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris>
 <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de>
 <5703A836.7030708@linutronix.de>
 <20160405121155.GF6890@osiris>
 <20160405155904.GA19022@linutronix.de>
 <20160406195133.GB3485@osiris>
 <57067938.6030908@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57067938.6030908@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 07, 2016 at 05:14:00PM +0200, Sebastian Andrzej Siewior wrote:
> On 04/06/2016 09:51 PM, Heiko Carstens wrote:
> > This fixes the issue that a second cpu_down() will take forever, if
> > __cpu_disable() fails.
> 
> Yes. But even without the second take down your CPU isn't complete up.
> 
> > However it does not fix the issue that CPU_DOWN_FAILED will be seen on a
> > different cpu than the cpu that was supposed to be taken offline.
> 
> This is correct. It fixes only the regression you reported.
> The CPU_DOWN_FAILED patches are on hold for now.

Ok, I was bit confused here. So you may add

Tested-by: Heiko Carstens <heiko.carstens@de.ibm.com>

if you want to :)

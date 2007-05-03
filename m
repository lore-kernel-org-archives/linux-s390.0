Return-Path: <linux-kernel-owner+w=401wt.eu-S932649AbXECIfx@vger.kernel.org>
Subject: Re: [PATCH 6/8] Kconfig: no userspace I/O on s390.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070503053047.GB7458@kroah.com>
References: <20070420113430.GG3738@skybase>
	 <20070503053047.GB7458@kroah.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 10:36:14 +0200
Message-Id: <1178181374.32267.17.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2007-05-02 at 22:30 -0700, Greg KH wrote:
> > Hide the config menu for userspace I/O on s390.
> 
> Why?  Who says s390 can't have userspace I/O drivers someday?

Theoretically yes, but in practice this is very unlikely to happen. Some
reasons why:
1) There are only very few device drivers for s390, the few we need
we'll do as kernel space drivers
2) The irq abstraction of uio is awkward. The irq handler uses a 32-bit
integer. On s390 each ccw device has it's own irq and ccw devices are
identified with a string "x.y.zzzz". Then there are devices that deliver
external interrupts where a 16-bit number is used to identify the
source. You could invent some mapping logic of a 32 bit integer to all
the possible interrupt sources but it doesn't really match.
3) s390 doesn't use memory mapped i/o, you always need to execute a
privileged instruction to trigger activity on the device, e.g. ssch for
a ccw device, siga for qdio, nqap for crypto, ...

So I have my doubts that we will ever see a uio driver for s390. If we
do we can unhide the config menu again.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

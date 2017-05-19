Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 2/9] timers: provide a "modern" variant of timers
Date: Fri, 19 May 2017 10:48:51 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFFAA38@AcuExch.aculab.com>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
In-Reply-To: <20170516114812.10660-3-hch@lst.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: 'Christoph Hellwig' <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christoph Hellwig
> Sent: 16 May 2017 12:48
>
> The new callback gets a pointer to the timer_list itself, which can
> then be used to get the containing structure using container_of
> instead of casting from and to unsigned long all the time.

What about sensible drivers that put some other value in the 'data'
field?

Perhaps it ought to have been 'void *data'.

Seems retrograde to be passing the address of the timer structure
(which, in principle, the callers no nothing about).

So I wouldn't call it 'modern', just different.

	David

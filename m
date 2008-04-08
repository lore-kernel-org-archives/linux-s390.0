Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
In-Reply-To: Oleg Nesterov's message of  Tuesday, 8 April 2008 15:35:19 +0400 <20080408113519.GA227@tv-sign.ru>
References: <20080329001230.D013726FA1D@magilla.localdomain>
	<20080329001341.7F93826FA1D@magilla.localdomain>
	<alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
	<20080408113519.GA227@tv-sign.ru>
Message-ID: <20080408195143.57F3326F992@magilla.localdomain>
Date: Tue,  8 Apr 2008 12:51:43 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20080408195143.BM94clUJScfTSk_Z7yWdrQJLTV-f2W_dG_bKQ7Z2shw@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Off hand, I concur with you and Linus.  I wasn't involved in the
introduction of TIF_RESTORE_SIGMASK and never thought too much about
it before.  In my recent changes I only considered the issue of
getting it out of _TIF_WORK_MASK et al to free up the low bit, and
didn't contemplate the structure of the implementation beyond that.

I don't think it's "too late" to change anything.  (It's never too
late!  It just might take a while to make a change in a safe and
orderly fashion for all the arch's.)  After my patch series, the
details are fully in the arch's corner.  It should be straightforward
to convert one at a time to use regs->return_register = -ERESTARTRESTOREMASK
to implement set_restore_sigmask() if you want to tackle it.


Thanks,
Roland

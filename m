Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18415.28947.208842.304790@cargo.ozlabs.ibm.com>
Date: Sun, 30 Mar 2008 21:53:07 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
In-Reply-To: <alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
References: <20080329001230.D013726FA1D@magilla.localdomain>
	<20080329001341.7F93826FA1D@magilla.localdomain>
	<alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20080330105307.WAhl4OEbq41djUUqjHKfMXU3pygzbO6Ax0WKu8eqgnQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Linus Torvalds writes:

> Of course, it may well not be worth it. Unlike the TIF flags, the TS flags 
> have been architecture-specific and I don't think all architectures even 
> do them (x86 uses them for FP state bits and stuff like that).

Powerpc has a "local_flags" field.  I don't mind changing it if we are
going to have a consistent name across architectures, but "status" (as
x86 uses) seems a bit nondescript to me.

Paul.

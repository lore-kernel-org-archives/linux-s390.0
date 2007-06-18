Return-Path: <linux-kernel-owner+w=401wt.eu-S1760245AbXFRIOL@vger.kernel.org>
Subject: Re: [patch] use __asm__ rather than asm in asm-s390/ptrace.h
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070618073605.GA3580@osiris.boeblingen.de.ibm.com>
References: <200706180223.07122.vapier@gentoo.org>
	 <20070618073605.GA3580@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Mon, 18 Jun 2007 10:15:18 +0200
Message-Id: <1182154518.3335.4.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Mike Frysinger <vapier@gentoo.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2007-06-18 at 09:36 +0200, Heiko Carstens wrote:
> Hmm.. spka is a sort of priviledged instruction and shouldn't be
> user space visible.
> I will move it so it's under #ifdef __KERNEL__.

Yes, I think this is better. On a side node, why did we add psw_set_key
to ptrace.h? processor.h would have made more sense, no? It sets the key
in the psw, it is not usable in userspace and ptrace doesn't provide an
interface for reading/writing to the psw key. So a patch that moves the
inline to processor.h alongside __load_psw and __load_psw_mask would be
my solution.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

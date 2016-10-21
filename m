From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
Date: Fri, 21 Oct 2016 14:06:05 +0200
Message-ID: <20161021120605.GD3142@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 21, 2016 at 01:58:53PM +0200, Christian Borntraeger wrote:
> Christian Borntraeger (5):
>   processor.h: introduce cpu_relax_yield
>   stop_machine: yield CPU during stop machine
>   s390: make cpu_relax a barrier again
>   Remove cpu_relax_lowlatency users
>   remove cpu_relax_lowlatency

Yay for killing cpu_relax_lowlatency()...

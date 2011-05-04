Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 4 May 2011 09:03:12 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Message-ID: <20110504070312.GD20828@elte.hu>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20110504070312.OmyEKIKXgtE4wDdsmkSpq3_R596CSJT9n_U-liskE6g@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Sven Eckelmann <sven@narfation.org> wrote:

> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

>  arch/x86/include/asm/atomic.h      |    1 +
>  arch/x86/include/asm/atomic64_64.h |    1 +

Acked-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo

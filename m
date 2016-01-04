Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 4 Jan 2016 14:26:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 11/32] mips: reuse asm-generic/barrier.h
Message-ID: <20160104132610.GX6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-12-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-12-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160104132610.8NPSVkSbkJPyaOXGjV1YY7_qYdB2EYx_pNipcnLToo4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrey Konovalov <andreyknvl@google.com>, David Daney <ddaney.cavm@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 31, 2015 at 09:07:10PM +0200, Michael S. Tsirkin wrote:
> -#define smp_store_release(p, v)						\
> -do {									\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	WRITE_ONCE(*p, v);						\
> -} while (0)
> -
> -#define smp_load_acquire(p)						\
> -({									\
> -	typeof(*p) ___p1 = READ_ONCE(*p);				\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	___p1;								\
> -})

David Daney wanted to use fancy new MIPS barriers to provide better
implementations of this.

This patch isn't in the way of that, just a FYI.

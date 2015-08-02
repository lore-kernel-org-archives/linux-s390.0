Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <1438548631.2249.125.camel@stgolabs.net>
Subject: Re: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in
 smp_store_release/smp_load_acquire
From: Davidlohr Bueso <dave@stgolabs.net>
In-Reply-To: <1438528264-714-1-git-send-email-andreyknvl@google.com>
References: <1438528264-714-1-git-send-email-andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 02 Aug 2015 13:50:31 -0700
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150802205031.ZQhjqWdBUFvTulxHLl9Ib-lAp7CLRMrcCV2ZB9bOpBU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Alexander Duyck <alexander.h.duyck@redhat.com>, Andre Przywara <andre.przywara@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2015-08-02 at 17:11 +0200, Andrey Konovalov wrote:
> Replace ACCESS_ONCE() macro in smp_store_release() and smp_load_acquire()
> with WRITE_ONCE() and READ_ONCE() on x86, arm, arm64, ia64, metag, mips,
> powerpc, s390, sparc and asm-generic since ACCESS_ONCE does not work
> reliably on non-scalar types.
> 
> WRITE_ONCE() and READ_ONCE() were introduced in the commits 230fa253df63
> ("kernel: Provide READ_ONCE and ASSIGN_ONCE") and 43239cbe79fc ("kernel:
> Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)").
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>

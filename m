From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Thu, 14 Jan 2016 11:24:01 +0200
Message-ID: <20160114111632-mutt-send-email-mst@redhat.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5696CF08.8080700@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linu
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 13, 2016 at 02:26:16PM -0800, Leonid Yegoshin wrote:
> And all that is out-of-topic here in my mind. I just want to be sure that
> this patchset still provides a use of a specific lightweight SYNCs on MIPS
> vs bold and heavy generalized "SYNC 0" in any case.
> 
> - Leonid.

Of course it does. All this patchset does is rename smp_mb/rmb/wmb
to __smp_mb()/__smp_rmb()/__smp_wmb()
and then asm-generic does #define smp_mb __smp_mb
or #define smp_mb barrier depending on CONFIG_SMP.

Why is that needed? So we can implement
[PATCH v3 28/41] asm-generic: implement virt_xxx memory barriers

-- 
MST

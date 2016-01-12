Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 12 Jan 2016 10:43:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160112103913-mutt-send-email-mst@redhat.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56945366.2090504@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160112084336.GrywMd-SCeSbr880rhNTiVmH4WLguK-gRdyMdwyJeUg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 11, 2016 at 05:14:14PM -0800, Leonid Yegoshin wrote:
> On 01/10/2016 06:18 AM, Michael S. Tsirkin wrote:
> >On mips dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
> >smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
> >the asm-generic variants exactly. Drop the local definitions and pull in
> >asm-generic/barrier.h instead.
> >
> This statement doesn't fit MIPS barriers variations. Moreover, there is a
> reason to extend that even more specific, at least for smp_store_release and
> smp_load_acquire, look into
> 
>     http://patchwork.linux-mips.org/patch/10506/
> 
> - Leonid.

Fine, but it matches what current code is doing.  Since that
MIPS_LIGHTWEIGHT_SYNC patch didn't go into linux-next yet, do
you see a problem reworking it on top of this patchset?

-- 
MST

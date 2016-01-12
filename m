From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 00/41] arch: barrier cleanup + barriers for virt
Date: Tue, 12 Jan 2016 13:50:07 +0100
Message-ID: <20160112125007.GR6344@twins.programming.kicks-ass.net>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jan 10, 2016 at 04:16:22PM +0200, Michael S. Tsirkin wrote:
> I parked this in vhost tree for now, though the inclusion of patch 1 from tip
> creates a merge conflict - but one that is trivial to resolve.
> 
> So I intend to just merge it all through my tree, including the
> duplicate patch, and assume conflict will be resolved.
> 
> I would really appreciate some feedback on arch bits (especially the x86 bits),
> and acks for merging this through the vhost tree.

Thanks for doing this, looks good to me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

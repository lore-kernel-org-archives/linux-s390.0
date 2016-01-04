Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 4 Jan 2016 15:09:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 33/34] xenbus: use virt_xxx barriers
Message-ID: <20160104140939.GC6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-34-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-34-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160104140939.2oFv8cJUzG5BsLc0VqrTLs_X_iXvrxaHAJAxgRS8aDI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 31, 2015 at 09:10:01PM +0200, Michael S. Tsirkin wrote:
> drivers/xen/xenbus/xenbus_comms.c uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to virt_xxx barriers which serve this exact purpose.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/xen/xenbus/xenbus_comms.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index fdb0f33..ecdecce 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -123,14 +123,14 @@ int xb_write(const void *data, unsigned len)
>  			avail = len;
>  
>  		/* Must write data /after/ reading the consumer index. */
> -		mb();
> +		virt_mb();
>  

So its possible to remove this barrier entirely, see the "CONTROL
DEPENDNCIES" chunk of memory-barrier.txt.

But do that in a separate patch series and only if you really really
need the performance.

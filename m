From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 22/32] s390: define __smp_xxx
Date: Mon, 4 Jan 2016 14:45:25 +0100
Message-ID: <20160104134525.GA6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-23-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1451572003-2440-23-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>linux-
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 31, 2015 at 09:08:38PM +0200, Michael S. Tsirkin wrote:
> This defines __smp_xxx barriers for s390,
> for use by virtualization.
> 
> Some smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
> 
> Note: smp_mb, smp_rmb and smp_wmb are defined as full barriers
> unconditionally on this architecture.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/barrier.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> index c358c31..fbd25b2 100644
> --- a/arch/s390/include/asm/barrier.h
> +++ b/arch/s390/include/asm/barrier.h
> @@ -26,18 +26,21 @@
>  #define wmb()				barrier()
>  #define dma_rmb()			mb()
>  #define dma_wmb()			mb()
> -#define smp_mb()			mb()
> -#define smp_rmb()			rmb()
> -#define smp_wmb()			wmb()
> -
> -#define smp_store_release(p, v)						\
> +#define __smp_mb()			mb()
> +#define __smp_rmb()			rmb()
> +#define __smp_wmb()			wmb()
> +#define smp_mb()			__smp_mb()
> +#define smp_rmb()			__smp_rmb()
> +#define smp_wmb()			__smp_wmb()

Why define the smp_*mb() primitives here? Would not the inclusion of
asm-generic/barrier.h do this?

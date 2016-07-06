Return-Path: <bsingharora@gmail.com>
Message-ID: <1467802454.9143.1.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 06 Jul 2016 20:54:14 +1000
In-Reply-To: <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org
Cc: dave@stgolabs.net, peterz@infradead.org, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, waiman.long@hpe.com, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, paulmck@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

On Tue, 2016-06-28 at 10:43 -0400, Pan Xinhui wrote:
> This is to fix some lock holder preemption issues. Some other locks
> implementation do a spin loop before acquiring the lock itself. Currently
> kernel has an interface of bool vcpu_is_preempted(int cpu). It take the cpu
								^^ takes
> as parameter and return true if the cpu is preempted. Then kernel can break
> the spin loops upon on the retval of vcpu_is_preempted.
> 
> As kernel has used this interface, So lets support it.
> 
> Only pSeries need supoort it. And the fact is powerNV are built into same
		   ^^ support
> kernel image with pSeries. So we need return false if we are runnig as
> powerNV. The another fact is that lppaca->yiled_count keeps zero on
					  ^^ yield
> powerNV. So we can just skip the machine type.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/spinlock.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 523673d..3ac9fcb 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -52,6 +52,24 @@
>  #define SYNC_IO
>  #endif
>  
> +/*
> + * This support kernel to check if one cpu is preempted or not.
> + * Then we can fix some lock holder preemption issue.
> + */
> +#ifdef CONFIG_PPC_PSERIES
> +#define vcpu_is_preempted vcpu_is_preempted
> +static inline bool vcpu_is_preempted(int cpu)
> +{
> +	/*
> +	 * pSeries and powerNV can be built into same kernel image. In
> +	 * principle we need return false directly if we are running as
> +	 * powerNV. However the yield_count is always zero on powerNV, So
> +	 * skip such machine type check

Or you could use the ppc_md interface callbacks if required, but your
solution works as well

> +	 */
> +	return !!(be32_to_cpu(lppaca_of(cpu).yield_count) & 1);
> +}
> +#endif
> +
>  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
>  	return lock.slock == 0;


Balbir Singh.

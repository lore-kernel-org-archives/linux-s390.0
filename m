From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH v6 10/11] x86, xen: support vcpu preempted
	check
Date: Fri, 28 Oct 2016 15:43:25 -0400
Message-ID: <20161028194325.GE2879@char.us.oracle.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1477642287-24104-11-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1477642287-24104-11-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, mpe@ellerman.id.au, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 28, 2016 at 04:11:26AM -0400, Pan Xinhui wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> Support the vcpu_is_preempted() functionality under Xen. This will
> enhance lock performance on overcommitted hosts (more runnable vcpus
> than physical cpus in the system) as doing busy waits for preempted
> vcpus will hurt system performance far worse than early yielding.
> 
> A quick test (4 vcpus on 1 physical cpu doing a parallel build job
> with "make -j 8") reduced system time by about 5% with this patch.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/x86/xen/spinlock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
> index 3d6e006..74756bb 100644
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -114,7 +114,6 @@ void xen_uninit_lock_cpu(int cpu)
>  	per_cpu(irq_name, cpu) = NULL;
>  }
>  
> -

Spurious change.
>  /*
>   * Our init of PV spinlocks is split in two init functions due to us
>   * using paravirt patching and jump labels patching and having to do
> @@ -137,6 +136,8 @@ void __init xen_init_spinlocks(void)
>  	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
>  	pv_lock_ops.wait = xen_qlock_wait;
>  	pv_lock_ops.kick = xen_qlock_kick;
> +
> +	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
>  }
>  
>  /*
> -- 
> 2.4.11
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel

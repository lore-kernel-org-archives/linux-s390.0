From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
Date: Wed, 19 Oct 2016 19:24:03 +0200
Message-ID: <20161019172403.GA9240@potion>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, jgross@suse.com, kvm@vger.kernel.org, peterz@infradead.org, xen-devel-request@lists.xenproject.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

2016-10-19 06:20-0400, Pan Xinhui:
> This is to fix some lock holder preemption issues. Some other locks
> implementation do a spin loop before acquiring the lock itself.
> Currently kernel has an interface of bool vcpu_is_preempted(int cpu). It
> takes the cpu as parameter and return true if the cpu is preempted.  Then
> kernel can break the spin loops upon on the retval of vcpu_is_preempted.
> 
> As kernel has used this interface, So lets support it.
> 
> We use one field of struct kvm_steal_time to indicate that if one vcpu
> is running or not.
> 
> unix benchmark result:
> host:  kernel 4.8.1, i5-4570, 4 cpus
> guest: kernel 4.8.1, 8 vcpus
> 
> 	test-case			after-patch	  before-patch
> Execl Throughput                       |    18307.9 lps  |    11701.6 lps 
> File Copy 1024 bufsize 2000 maxblocks  |  1352407.3 KBps |   790418.9 KBps
> File Copy 256 bufsize 500 maxblocks    |   367555.6 KBps |   222867.7 KBps
> File Copy 4096 bufsize 8000 maxblocks  |  3675649.7 KBps |  1780614.4 KBps
> Pipe Throughput                        | 11872208.7 lps  | 11855628.9 lps 
> Pipe-based Context Switching           |  1495126.5 lps  |  1490533.9 lps 
> Process Creation                       |    29881.2 lps  |    28572.8 lps 
> Shell Scripts (1 concurrent)           |    23224.3 lpm  |    22607.4 lpm 
> Shell Scripts (8 concurrent)           |     3531.4 lpm  |     3211.9 lpm 
> System Call Overhead                   | 10385653.0 lps  | 10419979.0 lps 
> 
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> @@ -98,6 +98,10 @@ struct pv_time_ops {
>  	unsigned long long (*steal_clock)(int cpu);
>  };
>  
> +struct pv_vcpu_ops {
> +	bool (*vcpu_is_preempted)(int cpu);
> +};
> +

(I would put it into pv_lock_ops to save the plumbing.)

> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -45,7 +45,8 @@ struct kvm_steal_time {
>  	__u64 steal;
>  	__u32 version;
>  	__u32 flags;
> -	__u32 pad[12];
> +	__u32 preempted;

Why __u32 instead of __u8?

> +	__u32 pad[11];
>  };

Please document the change in Documentation/virtual/kvm/msr.txt, section
MSR_KVM_STEAL_TIME.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> @@ -415,6 +415,15 @@ void kvm_disable_steal_time(void)
> +static bool kvm_vcpu_is_preempted(int cpu)
> +{
> +	struct kvm_steal_time *src;
> +
> +	src = &per_cpu(steal_time, cpu);
> +
> +	return !!src->preempted;
> +}
> +
>  #ifdef CONFIG_SMP
>  static void __init kvm_smp_prepare_boot_cpu(void)
>  {
> @@ -488,6 +497,8 @@ void __init kvm_guest_init(void)
>  	kvm_guest_cpu_init();
>  #endif
>  
> +	pv_vcpu_ops.vcpu_is_preempted = kvm_vcpu_is_preempted;

Would be nicer to assign conditionally in the KVM_FEATURE_STEAL_TIME
block.  The steal_time structure has to be zeroed, so this code would
work, but the native function (return false) is better if we know that
the kvm_vcpu_is_preempted() would always return false anway.

Old KVMs won't have the feature, so we could also assign only when KVM
reports it, but that requires extra definitions and the performance gain
is fairly small, so I'm ok with this.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> @@ -2057,6 +2057,8 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
>  		return;
>  
> +	vcpu->arch.st.steal.preempted = 0;
> +
>  	if (vcpu->arch.st.steal.version & 1)
>  		vcpu->arch.st.steal.version += 1;  /* first time write, random junk */
>  
> @@ -2812,6 +2814,16 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  {
> +	if (vcpu->arch.st.msr_val & KVM_MSR_ENABLED)
> +		if (kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
> +					&vcpu->arch.st.steal,
> +					sizeof(struct kvm_steal_time)) == 0) {
> +			vcpu->arch.st.steal.preempted = 1;
> +			kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
> +					&vcpu->arch.st.steal,
> +					sizeof(struct kvm_steal_time));
> +		}

Please name this block of code.  Something like
  kvm_steal_time_set_preempted(vcpu);

Thanks.

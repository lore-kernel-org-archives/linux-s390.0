From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH V3 4/5] kvm/stats: Add provisioning for 64-bit vm and vcpu
 statistics
Date: Wed, 13 Jul 2016 11:04:08 +0200
Message-ID: <57860408.1000203@de.ibm.com>
References: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-mips@linux-mips.org, linux-s390@vger.kernel.org, james.hogan@imgtec.com, kvm@vger.kernel.org, marc.zyngier@arm.com, benh@kernel.crashing.org, kvm-ppc@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au, cornelia.huck@de.ibm.com, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

On 07/13/2016 10:53 AM, Suraj Jitindar Singh wrote:
> vms and vcpus have statistics associated with them which can be viewed
> within the debugfs. Currently it is assumed within the vcpu_stat_get() and
> vm_stat_get() functions that all of these statistics are represented as
> u32s, however the next patch adds some u64 statistics.
> 
> Thus modify these two functions, vcpu_stat_get() and vm_stat_get(), such
> that they expect u64 statistics and update vm and vcpu statistics to u64s
> accordingly.
> 
> ---
> Change Log:
> 
> V1 -> V2:
> 	- Nothing
> V2 -> V3:
> 	- Instead of implementing separate u32 and u64 functions keep the
> 	  generic functions and modify them to expect u64s. Thus update all
> 	  vm and vcpu statistics to u64s accordingly.

Have not looked into everything, but I agree with changing everything to 64bit.


> @@ -3583,8 +3583,8 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
>  };
> 
>  static const struct file_operations *stat_fops_per_vm[] = {
> -	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
> -	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
> +	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
> +	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
>  };
unrelated white space changes?

> 
>  static int vm_stat_get(void *_offset, u64 *val)
> @@ -3628,8 +3628,8 @@ static int vcpu_stat_get(void *_offset, u64 *val)
>  DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
> 
>  static const struct file_operations *stat_fops[] = {
> -	[KVM_STAT_VCPU] = &vcpu_stat_fops,
> -	[KVM_STAT_VM]   = &vm_stat_fops,
> +	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
> +	[KVM_STAT_VM]		= &vm_stat_fops,
>  };
> 
>  static int kvm_init_debug(void)
> 

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH V3 4/5] kvm/stats: Add provisioning for 64-bit vm and vcpu
 statistics
Date: Fri, 15 Jul 2016 17:49:59 +1000
Message-ID: <578895A7.5060001@gmail.com>
References: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
 <57860408.1000203@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <57860408.1000203@de.ibm.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, james.hogan@imgtec.com, agraf@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, cornelia.huck@de.ibm.com, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 13/07/16 19:04, Christian Borntraeger wrote:
> On 07/13/2016 10:53 AM, Suraj Jitindar Singh wrote:
>> vms and vcpus have statistics associated with them which can be viewed
>> within the debugfs. Currently it is assumed within the vcpu_stat_get() and
>> vm_stat_get() functions that all of these statistics are represented as
>> u32s, however the next patch adds some u64 statistics.
>>
>> Thus modify these two functions, vcpu_stat_get() and vm_stat_get(), such
>> that they expect u64 statistics and update vm and vcpu statistics to u64s
>> accordingly.
>>
>> ---
>> Change Log:
>>
>> V1 -> V2:
>> 	- Nothing
>> V2 -> V3:
>> 	- Instead of implementing separate u32 and u64 functions keep the
>> 	  generic functions and modify them to expect u64s. Thus update all
>> 	  vm and vcpu statistics to u64s accordingly.
> Have not looked into everything, but I agree with changing everything to 64bit.
>
>
>> @@ -3583,8 +3583,8 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
>>  };
>>
>>  static const struct file_operations *stat_fops_per_vm[] = {
>> -	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
>> -	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
>> +	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
>> +	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
>>  };
> unrelated white space changes?

Woops, I'll fix that. Thanks

>
>>  static int vm_stat_get(void *_offset, u64 *val)
>> @@ -3628,8 +3628,8 @@ static int vcpu_stat_get(void *_offset, u64 *val)
>>  DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
>>
>>  static const struct file_operations *stat_fops[] = {
>> -	[KVM_STAT_VCPU] = &vcpu_stat_fops,
>> -	[KVM_STAT_VM]   = &vm_stat_fops,
>> +	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
>> +	[KVM_STAT_VM]		= &vm_stat_fops,
>>  };
>>
>>  static int kvm_init_debug(void)
>>

From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 29 Aug 2017 13:18:29 +0000
Subject: Re: [kvms390:next 4/6] arch/s390/kvm/vsie.c:933:1: error: expected identifier or '(' before '}' toke
Message-Id: <296ac421-4282-ad6d-aa6b-57ad9726c8f9@de.ibm.com>
In-Reply-To: <201708292151.OGjwPPyE%fengguang.wu@intel.com>
References: <201708292151.OGjwPPyE%fengguang.wu@intel.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please ignore, I pushed too quick....

On 08/29/2017 03:16 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
> head:   046c6c5d238e286fe9ed3a9e371d9b2e7f33eef6
> commit: b194476e22b37e1eb9b650a82f701823abb7d93f [4/6] KVM: s390: Multiple Epoch Facility support
> config: s390-allmodconfig (attached as .config)
> compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b194476e22b37e1eb9b650a82f701823abb7d93f
>         # save the attached .config to linux build tree
>         make.cross ARCH=s390 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    arch/s390/kvm/vsie.c: In function 'register_shadow_scb':
>>> arch/s390/kvm/vsie.c:926:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      if (scb_s->ecd & ECD_MEF)
>      ^~
>    arch/s390/kvm/vsie.c:928:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>       if (scb_s->epoch < vcpu->kvm->arch.epoch)
>       ^~
>    In file included from include/linux/spinlock.h:50:0,
>                     from include/linux/vmalloc.h:4,
>                     from arch/s390/kvm/vsie.c:12:
>    arch/s390/kvm/vsie.c: At top level:
>>> include/linux/preempt.h:210:1: error: expected identifier or '(' before 'do'
>     do { \
>     ^
>>> arch/s390/kvm/vsie.c:932:2: note: in expansion of macro 'preempt_enable'
>      preempt_enable();
>      ^~~~~~~~~~~~~~
>>> include/linux/preempt.h:213:3: error: expected identifier or '(' before 'while'
>     } while (0)
>       ^
>>> arch/s390/kvm/vsie.c:932:2: note: in expansion of macro 'preempt_enable'
>      preempt_enable();
>      ^~~~~~~~~~~~~~
>>> arch/s390/kvm/vsie.c:933:1: error: expected identifier or '(' before '}' token
>     }
>     ^
> --
>    arch/s390//kvm/vsie.c: In function 'register_shadow_scb':
>    arch/s390//kvm/vsie.c:926:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      if (scb_s->ecd & ECD_MEF)
>      ^~
>    arch/s390//kvm/vsie.c:928:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>       if (scb_s->epoch < vcpu->kvm->arch.epoch)
>       ^~
>    In file included from include/linux/spinlock.h:50:0,
>                     from include/linux/vmalloc.h:4,
>                     from arch/s390//kvm/vsie.c:12:
>    arch/s390//kvm/vsie.c: At top level:
>>> include/linux/preempt.h:210:1: error: expected identifier or '(' before 'do'
>     do { \
>     ^
>    arch/s390//kvm/vsie.c:932:2: note: in expansion of macro 'preempt_enable'
>      preempt_enable();
>      ^~~~~~~~~~~~~~
>>> include/linux/preempt.h:213:3: error: expected identifier or '(' before 'while'
>     } while (0)
>       ^
>    arch/s390//kvm/vsie.c:932:2: note: in expansion of macro 'preempt_enable'
>      preempt_enable();
>      ^~~~~~~~~~~~~~
>    arch/s390//kvm/vsie.c:933:1: error: expected identifier or '(' before '}' token
>     }
>     ^
> 
> vim +933 arch/s390/kvm/vsie.c
> 
> a3508fbe David Hildenbrand 2015-07-08  904  
> a3508fbe David Hildenbrand 2015-07-08  905  /*
> adbf1698 David Hildenbrand 2016-05-27  906   * Register the shadow scb at the VCPU, e.g. for kicking out of vsie.
> adbf1698 David Hildenbrand 2016-05-27  907   */
> adbf1698 David Hildenbrand 2016-05-27  908  static void register_shadow_scb(struct kvm_vcpu *vcpu,
> adbf1698 David Hildenbrand 2016-05-27  909  				struct vsie_page *vsie_page)
> adbf1698 David Hildenbrand 2016-05-27  910  {
> 91473b48 David Hildenbrand 2015-10-29  911  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> 91473b48 David Hildenbrand 2015-10-29  912  
> adbf1698 David Hildenbrand 2016-05-27  913  	WRITE_ONCE(vcpu->arch.vsie_block, &vsie_page->scb_s);
> b917ae57 David Hildenbrand 2015-07-07  914  	/*
> b917ae57 David Hildenbrand 2015-07-07  915  	 * External calls have to lead to a kick of the vcpu and
> b917ae57 David Hildenbrand 2015-07-07  916  	 * therefore the vsie -> Simulate Wait state.
> b917ae57 David Hildenbrand 2015-07-07  917  	 */
> b917ae57 David Hildenbrand 2015-07-07  918  	atomic_or(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
> 91473b48 David Hildenbrand 2015-10-29  919  	/*
> 91473b48 David Hildenbrand 2015-10-29  920  	 * We have to adjust the g3 epoch by the g2 epoch. The epoch will
> 91473b48 David Hildenbrand 2015-10-29  921  	 * automatically be adjusted on tod clock changes via kvm_sync_clock.
> 91473b48 David Hildenbrand 2015-10-29  922  	 */
> 91473b48 David Hildenbrand 2015-10-29  923  	preempt_disable();
> 91473b48 David Hildenbrand 2015-10-29  924  	scb_s->epoch += vcpu->kvm->arch.epoch;
> b194476e Collin L. Walling 2016-07-26  925  
> b194476e Collin L. Walling 2016-07-26 @926  	if (scb_s->ecd & ECD_MEF)
> b194476e Collin L. Walling 2016-07-26  927  		scb_s->epdx += vcpu->kvm->arch.epdx;
> b194476e Collin L. Walling 2016-07-26  928  		if (scb_s->epoch < vcpu->kvm->arch.epoch)
> b194476e Collin L. Walling 2016-07-26  929  			scb_s->epdx += 1;
> b194476e Collin L. Walling 2016-07-26  930  	}
> b194476e Collin L. Walling 2016-07-26  931  
> 91473b48 David Hildenbrand 2015-10-29 @932  	preempt_enable();
> adbf1698 David Hildenbrand 2016-05-27 @933  }
> adbf1698 David Hildenbrand 2016-05-27  934  
> 
> :::::: The code at line 933 was first introduced by commit
> :::::: adbf16985c387851fd3454ca34893705dbde7f98 KVM: s390: vsie: speed up VCPU irq delivery when handling vsie
> 
> :::::: TO: David Hildenbrand <dahi@linux.vnet.ibm.com>
> :::::: CC: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

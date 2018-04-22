From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Sun, 22 Apr 2018 12:42:04 -0400
Message-ID: <559056f8-2c89-0fbd-5b18-0e792d220180@linux.vnet.ibm.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <201804210852.eaNyyLPe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201804210852.eaNyyLPe%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 04/20/2018 08:11 PM, kbuild test robot wrote:
> Hi Tony,
>
> Thank you for the patch! Yet something to improve:

Sorry about this, I must have missed the warnings. It should all be good 
to do with v2 of
the patch.

>
> [auto build test ERROR on s390/features]
> [also build test ERROR on v4.17-rc1 next-20180420]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Tony-Krowiak/KVM-s390-reset-crypto-attributes-for-all-vcpus/20180421-050734
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: s390-allyesconfig (attached as .config)
> compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=s390
>
> All error/warnings (new ones prefixed by >>):
>
>     arch/s390/kvm/kvm-s390.c: In function 'kvm_s390_vcpu_crypto_reset_all':
>>> arch/s390/kvm/kvm-s390.c:800:10: error: implicit declaration of function 'kvm_s390_vcpu_crypto_setup'; did you mean 'kvm_s390_vcpu_crypto_reset_all'? [-Werror=implicit-function-declaration]
>               kvm_s390_vcpu_crypto_setup(vcpu);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>               kvm_s390_vcpu_crypto_reset_all
>     arch/s390/kvm/kvm-s390.c: At top level:
>>> arch/s390/kvm/kvm-s390.c:805:13: warning: conflicting types for 'kvm_s390_vcpu_crypto_setup'
>      static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> arch/s390/kvm/kvm-s390.c:805:13: error: static declaration of 'kvm_s390_vcpu_crypto_setup' follows non-static declaration
>     arch/s390/kvm/kvm-s390.c:800:10: note: previous implicit declaration of 'kvm_s390_vcpu_crypto_setup' was here
>               kvm_s390_vcpu_crypto_setup(vcpu);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/s390/kvm/kvm-s390.c: In function 'kvm_s390_vm_set_crypto':
>     arch/s390/kvm/kvm-s390.c:810:6: warning: unused variable 'i' [-Wunused-variable]
>       int i;
>           ^
>     arch/s390/kvm/kvm-s390.c:809:19: warning: unused variable 'vcpu' [-Wunused-variable]
>       struct kvm_vcpu *vcpu;
>                        ^~~~
>     cc1: some warnings being treated as errors
>
> vim +800 arch/s390/kvm/kvm-s390.c
>
>     791	
>     792	void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>     793	 {
>     794		int i;
>     795		struct kvm_vcpu *vcpu;
>     796	
>     797		kvm_s390_vcpu_block_all(kvm);
>     798	
>     799		kvm_for_each_vcpu(i, vcpu, kvm)
>   > 800		        kvm_s390_vcpu_crypto_setup(vcpu);
>     801	
>     802		kvm_s390_vcpu_unblock_all(kvm);
>     803	}
>     804	
>   > 805	static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>     806	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

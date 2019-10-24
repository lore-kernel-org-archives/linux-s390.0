Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:65375 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfJXRjW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 13:39:22 -0400
Date: Fri, 25 Oct 2019 01:38:51 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [kvms390:protvirt 23/37] arch/s390/kvm/kvm-s390.c:3650:30: warning:
 passing argument 1 of 'uv_convert_to_secure' makes integer from pointer
 without a cast
Message-ID: <201910250149.tTOom2DK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hfwzr3may37lerzm"
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kbuild-all@lists.01.org, linux-s390@vger.kernel.org


--hfwzr3may37lerzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git protvirt
head:   c18cc8b3d6089420f52d8e2c1de67a8b1afab9b1
commit: 690453485fdbc052afa80a38688f3ab0133da979 [23/37] KVM: s390: protvirt: Make sure prefix is always protected
config: s390-debug_defconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 690453485fdbc052afa80a38688f3ab0133da979
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/s390/kvm/kvm-s390.c: In function 'kvm_s390_handle_requests':
>> arch/s390/kvm/kvm-s390.c:3650:30: warning: passing argument 1 of 'uv_convert_to_secure' makes integer from pointer without a cast [-Wint-conversion]
       rc = uv_convert_to_secure(vcpu->arch.gmap,
                                 ^~~~
   In file included from arch/s390/kvm/kvm-s390.c:47:0:
   arch/s390/include/asm/uv.h:345:19: note: expected 'long unsigned int' but argument is of type 'struct gmap *'
    static inline int uv_convert_to_secure(unsigned long handle, unsigned long gaddr) { return 0; }
                      ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/kvm-s390.c:3653:30: warning: passing argument 1 of 'uv_convert_to_secure' makes integer from pointer without a cast [-Wint-conversion]
       rc = uv_convert_to_secure(vcpu->arch.gmap,
                                 ^~~~
   In file included from arch/s390/kvm/kvm-s390.c:47:0:
   arch/s390/include/asm/uv.h:345:19: note: expected 'long unsigned int' but argument is of type 'struct gmap *'
    static inline int uv_convert_to_secure(unsigned long handle, unsigned long gaddr) { return 0; }
                      ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/uaccess.h:11:0,
                    from include/linux/crypto.h:21,
                    from include/crypto/hash.h:11,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/skbuff.h:20,
                    from include/linux/if_ether.h:19,
                    from arch/s390/include/asm/diag.h:12,
                    from arch/s390/include/asm/kvm_para.h:25,
                    from include/uapi/linux/kvm_para.h:36,
                    from include/linux/kvm_para.h:5,
                    from include/linux/kvm_host.h:32,
                    from arch/s390/kvm/kvm-s390.c:23:
   arch/s390/include/asm/uaccess.h: In function '__get_user_fn':
   arch/s390/include/asm/uaccess.h:143:9: warning: 'rc' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return rc;
            ^~

vim +/uv_convert_to_secure +3650 arch/s390/kvm/kvm-s390.c

  3630	
  3631	static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
  3632	{
  3633	retry:
  3634		kvm_s390_vcpu_request_handled(vcpu);
  3635		if (!kvm_request_pending(vcpu))
  3636			return 0;
  3637		/*
  3638		 * We use MMU_RELOAD just to re-arm the ipte notifier for the
  3639		 * guest prefix page. gmap_mprotect_notify will wait on the ptl lock.
  3640		 * This ensures that the ipte instruction for this request has
  3641		 * already finished. We might race against a second unmapper that
  3642		 * wants to set the blocking bit. Lets just retry the request loop.
  3643		 */
  3644		if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu)) {
  3645			int rc;
  3646			rc = gmap_mprotect_notify(vcpu->arch.gmap,
  3647						  kvm_s390_get_prefix(vcpu),
  3648						  PAGE_SIZE * 2, PROT_WRITE);
  3649			if (!rc && kvm_s390_pv_is_protected(vcpu->kvm)) {
> 3650				rc = uv_convert_to_secure(vcpu->arch.gmap,
  3651							  kvm_s390_get_prefix(vcpu));
  3652				WARN_ON_ONCE(rc && rc != -EEXIST);
  3653				rc = uv_convert_to_secure(vcpu->arch.gmap,
  3654							  kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
  3655				WARN_ON_ONCE(rc && rc != -EEXIST);
  3656				rc = 0;
  3657			}
  3658			if (rc) {
  3659				kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
  3660				return rc;
  3661			}
  3662			goto retry;
  3663		}
  3664	
  3665		if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu)) {
  3666			vcpu->arch.sie_block->ihcpu = 0xffff;
  3667			goto retry;
  3668		}
  3669	
  3670		if (kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu)) {
  3671			if (!ibs_enabled(vcpu)) {
  3672				trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 1);
  3673				kvm_s390_set_cpuflags(vcpu, CPUSTAT_IBS);
  3674			}
  3675			goto retry;
  3676		}
  3677	
  3678		if (kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu)) {
  3679			if (ibs_enabled(vcpu)) {
  3680				trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 0);
  3681				kvm_s390_clear_cpuflags(vcpu, CPUSTAT_IBS);
  3682			}
  3683			goto retry;
  3684		}
  3685	
  3686		if (kvm_check_request(KVM_REQ_ICPT_OPEREXC, vcpu)) {
  3687			vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
  3688			goto retry;
  3689		}
  3690	
  3691		if (kvm_check_request(KVM_REQ_START_MIGRATION, vcpu)) {
  3692			/*
  3693			 * Disable CMM virtualization; we will emulate the ESSA
  3694			 * instruction manually, in order to provide additional
  3695			 * functionalities needed for live migration.
  3696			 */
  3697			vcpu->arch.sie_block->ecb2 &= ~ECB2_CMMA;
  3698			goto retry;
  3699		}
  3700	
  3701		if (kvm_check_request(KVM_REQ_STOP_MIGRATION, vcpu)) {
  3702			/*
  3703			 * Re-enable CMM virtualization if CMMA is available and
  3704			 * CMM has been used.
  3705			 */
  3706			if ((vcpu->kvm->arch.use_cmma) &&
  3707			    (vcpu->kvm->mm->context.uses_cmm))
  3708				vcpu->arch.sie_block->ecb2 |= ECB2_CMMA;
  3709			goto retry;
  3710		}
  3711	
  3712		/* nothing to do, just clear the request */
  3713		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
  3714		/* we left the vsie handler, nothing to do, just clear the request */
  3715		kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
  3716	
  3717		return 0;
  3718	}
  3719	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--hfwzr3may37lerzm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--hfwzr3may37lerzm--

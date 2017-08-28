From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture
 Mode
Date: Mon, 28 Aug 2017 21:27:08 +0200
Message-ID: <d72ff520-8fac-34d9-e71a-53697a59957c@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


>  		rc = handle_sigp_dst(vcpu, order_code, cpu_addr,
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 025ea20..181db5b 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -80,6 +80,7 @@ static struct facility_def facility_defs[] = {
>  			78, /* enhanced-DAT 2 */
>  			130, /* instruction-execution-protection */
>  			131, /* enhanced-SOP 2 and side-effect */
> +			138, /* configuration z/architecture mode (czam) */
>  			146, /* msa extension 8 */
>  			-1  /* END */
>  		}
> 

Thinking about it, this should be the right thing to do instead of the
last hunk:

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 84c069afc02f..39115f5a38df 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1927,6 +1927,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned
long type)
        memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
               S390_ARCH_FAC_LIST_SIZE_BYTE);

+       /* we are always in CZAM mode - even on pre z14 machines */
+       set_kvm_facility(kvm->arch.model.fac_mask, 138);
+       set_kvm_facility(kvm->arch.model.fac_list, 138);
+       /* we emulate STHYI in kvm */
        set_kvm_facility(kvm->arch.model.fac_mask, 74);
        set_kvm_facility(kvm->arch.model.fac_list, 74);
        if (MACHINE_HAS_TLB_GUEST) {

That would produce consistent results for very old QEMU.

-- 

Thanks,

David

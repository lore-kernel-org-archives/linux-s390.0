From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 02/19] KVM: s390: refactor crypto initialization
Date: Tue, 14 Nov 2017 12:50:28 +0100
Message-ID: <20171114125028.1653a2cc.cohuck@redhat.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-3-git-send-email-akrowiak@linux.vnet.ibm.com>
        <6e65f497-5cae-f731-2885-a9ce19d92d8b@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <6e65f497-5cae-f731-2885-a9ce19d92d8b@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, david@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2 Nov 2017 13:41:18 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 10/13/2017 07:38 PM, Tony Krowiak wrote:
> > This patch introduces the following changes to crypto initialization.
> > 
> > * For key management operations support, the crypto control block
> >   (CRYCB) referenced by the KVM guest's SIE state description is
> >   formatted only if the Message-Security-Assist (MSA) extension 3
> >   facility is installed (STFLE.76 is set). Virtualization of AP
> >   facilities, however; requires that a CRYCB of the appropriate
> >   format be made available to SIE regardless of the value of STFLE.76.
> > 
> > * The Execution Controls A (ECA) field bit 28 in the SIE block needs
> >   to be set to enable interpretive execution mode of adjunct processor (AP)
> >   instructions.  
> 
> We should fence setting ECA to cases where we have virtualization capability 
> for crypto. In addition we need to bind this somehow to the CPU model, so
> I guess we need to add some CRYPTO feature e.g. add KVM_S390_VM_CPU_FEAT_AP to the
> list of know features
> (see arch/s390/include/uapi/asm/kvm.h)
> ---snip---
> #define KVM_S390_VM_CPU_FEAT_ESOP       0
> #define KVM_S390_VM_CPU_FEAT_SIEF2      1
> #define KVM_S390_VM_CPU_FEAT_64BSCAO    2
> #define KVM_S390_VM_CPU_FEAT_SIIF       3
> #define KVM_S390_VM_CPU_FEAT_GPERE      4
> #define KVM_S390_VM_CPU_FEAT_GSLS       5
> #define KVM_S390_VM_CPU_FEAT_IB         6
> #define KVM_S390_VM_CPU_FEAT_CEI        7
> #define KVM_S390_VM_CPU_FEAT_IBS        8
> #define KVM_S390_VM_CPU_FEAT_SKEY       9
> #define KVM_S390_VM_CPU_FEAT_CMMA       10
> #define KVM_S390_VM_CPU_FEAT_PFMFI      11
> #define KVM_S390_VM_CPU_FEAT_SIGPIF     12
> #define KVM_S390_VM_CPU_FEAT_KSS        13
> ---snip---

So, we need this so userspace can add the appropriate flags, right?

> 
> 
> I will try to find out a way to properly detect that.

Did you manage to find out?

> 
> 
> 
> > 
> > Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> > ---
> >  arch/s390/include/asm/kvm_host.h |    1 +
> >  arch/s390/kvm/kvm-s390.c         |   17 +++++++++++++----
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> > index 50a6b25..5683f18 100644
> > --- a/arch/s390/include/asm/kvm_host.h
> > +++ b/arch/s390/include/asm/kvm_host.h
> > @@ -188,6 +188,7 @@ struct kvm_s390_sie_block {
> >  #define ECA_MVPGI	0x01000000
> >  #define ECA_VX		0x00020000
> >  #define ECA_PROTEXCI	0x00002000
> > +#define ECA_AP		0x00000008
> >  #define ECA_SII		0x00000001
> >  	__u32	eca;			/* 0x004c */
> >  #define ICPT_INST	0x04
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 40d0a1a..e57fc9b 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -1819,7 +1819,9 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
> >  {
> >  	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
> > 
> > -	if (kvm_s390_apxa_installed())
> > +	if (!test_kvm_facility(kvm, 76))
> > +		kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT2); /* format 0 */
> > +	else if (kvm_s390_apxa_installed())
> >  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
> >  	else
> >  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
> > @@ -1836,12 +1838,12 @@ static u64 kvm_s390_get_initial_cpuid(void)
> > 
> >  static void kvm_s390_crypto_init(struct kvm *kvm)
> >  {
> > -	if (!test_kvm_facility(kvm, 76))
> > -		return;
> > -
> >  	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
> >  	kvm_s390_set_crycb_format(kvm);
> > 
> > +	if (!test_kvm_facility(kvm, 76))
> > +		return;
> > +
> >  	/* Enable AES/DEA protected key functions by default */
> >  	kvm->arch.crypto.aes_kw = 1;
> >  	kvm->arch.crypto.dea_kw = 1;
> > @@ -2366,8 +2368,15 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
> >  	vcpu->arch.enabled_gmap = vcpu->arch.gmap;
> >  }
> > 
> > +static void kvm_s390_vcpu_set_crypto_exec_mode(struct kvm_vcpu *vcpu)
> > +{
> > +	vcpu->arch.sie_block->eca |= ECA_AP;
> > +}
> > +
> >  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
> >  {
> > +	kvm_s390_vcpu_set_crypto_exec_mode(vcpu);
> > +
> >  	if (!test_kvm_facility(vcpu->kvm, 76))
> >  		return;
> >   
> 

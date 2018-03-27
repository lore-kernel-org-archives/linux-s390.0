From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 03/14] KVM: s390: CPU model support for AP
 virtualization
Date: Tue, 27 Mar 2018 13:30:34 +0200
Message-ID: <20180327133034.1562ad88.cohuck@redhat.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1521051954-25715-4-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180327125911.5c7ecf34.cohuck@redhat.com>
        <327f20bc-741d-ac0a-8e3f-929e8ad73159@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <327f20bc-741d-ac0a-8e3f-929e8ad73159@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Mar 2018 13:22:56 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 27/03/2018 12:59, Cornelia Huck wrote:
> > On Wed, 14 Mar 2018 14:25:43 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >  
> >> Introduces a new CPU model feature and two CPU model
> >> facilities to support AP virtualization for KVM guests.
> >>
> >> CPU model feature:
> >>
> >> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
> >> AP instructions are available on the guest. This
> >> feature will be enabled by the kernel only if the AP
> >> instructions are installed on the linux host. This feature
> >> must be specifically turned on for the KVM guest from
> >> userspace to use the VFIO AP device driver for guest
> >> access to AP devices.
> >>
> >> CPU model facilities:
> >>
> >> 1. AP Query Configuration Information (QCI) facility is installed.
> >>
> >>     This is indicated by setting facilities bit 12 for
> >>     the guest. The kernel will not enable this facility
> >>     for the guest if it is not set on the host. This facility
> >>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
> >>     feature is not installed.
> >>
> >> 2. AP Facilities Test facility (APFT) is installed.
> >>
> >>     This is indicated by setting facilities bit 15 for
> >>     the guest. The kernel will not enable this facility for
> >>     the guest if it is not set on the host. This facility
> >>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
> >>     feature is not installed.
> >>
> >> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> >> ---
> >>   arch/s390/include/asm/kvm_host.h |    1 +
> >>   arch/s390/include/uapi/asm/kvm.h |    1 +
> >>   arch/s390/kvm/kvm-s390.c         |    4 ++++
> >>   arch/s390/tools/gen_facilities.c |    2 ++
> >>   4 files changed, 8 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> >> index c47731d..a60c45b 100644
> >> --- a/arch/s390/kvm/kvm-s390.c
> >> +++ b/arch/s390/kvm/kvm-s390.c
> >> @@ -350,6 +350,10 @@ static void kvm_s390_cpu_feat_init(void)
> >>   
> >>   	if (MACHINE_HAS_ESOP)
> >>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
> >> +
> >> +	if (ap_instructions_installed()) /* AP instructions installed on host */
> >> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);  
> > That's another dependency of the base kvm-s390 module on zcrypt, which
> > I don't like at all.  
> 
> In fact there is a tricky thing about zcrypt it is that even it is 
> configured a a module
> CONFIG_ZCRYPT=M, the AP BUS is built statically with the kernel.
> See drivers/s390/crypto/Makefile
> "
> ap-objs := ap_bus.o ap_card.o ap_queue.o
> obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
> "
> ugly isn't it?

Yeah, I found it... interesting the first time I saw it.

> 
> >
> > There are two possibilities here:
> > - Exposing the features makes sense even if no zcrypt driver is active
> >    in the host. Then, ap_instructions_installed() needs to be moved into
> >    always-built code (see my comments for the interface in patch 1).  
> 
> This is what we need for future enhancement I think.

OK, so that function needs to go into whatever place the interface used
in patch 1 goes to as well.

> 
> > - Exposing the features makes sense only if we actually want to make
> >    vfio-ap available. Then we should provide the proper check in the
> >    vfio-ap parts (which depends on zcrypt) and stub it out if vfio-ap is
> >    not configured.
> >  
> >> +
> >>   	/*
> >>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
> >>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).  
> 
> 

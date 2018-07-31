From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 31 Jul 2018 11:48:51 +0000
Subject: Re: [PATCH v7 21/22] KVM: s390: CPU model support for AP virtualization
Message-Id: <20180731134851.6955ce27.cohuck@redhat.com>
In-Reply-To: <20180726195429.31960-22-borntraeger@de.ibm.com>
References: <20180726195429.31960-22-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Jul 2018 21:54:28 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new CPU model feature and two CPU model
> facilities to support AP virtualization for KVM guests.
> 
> CPU model feature:
> 
> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
> AP instructions are available on the guest. This
> feature will be enabled by the kernel only if the AP
> instructions are installed on the linux host. This feature
> must be specifically turned on for the KVM guest from
> userspace to use the VFIO AP device driver for guest
> access to AP devices.
> 
> CPU model facilities:
> 
> 1. AP Query Configuration Information (QCI) facility is installed.
> 
>    This is indicated by setting facilities bit 12 for
>    the guest. The kernel will not enable this facility
>    for the guest if it is not set on the host. This facility
>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>    feature is not installed.
> 
>    If this facility is not set for the KVM guest, then only
>    APQNs with an APQI less than 16 will be available to the
>    guest regardless of the guest's matrix configuration. This
>    is a limitation of the AP bus running on the guest.

What is "the AP bus running on the guest"? The AP bus is a Linux
construct, and while we only care about Linux guests right now for AP,
I would not word it that way.

"If this facility is not set for the KVM guest, then only
APQNs with an APQI less than 16 will be used by a Linux
guest regardless of the matrix configuration for the virtual
machine. This is a limitation of the Linux AP bus."

?

> 
> 2. AP Facilities Test facility (APFT) is installed.
> 
>    This is indicated by setting facilities bit 15 for
>    the guest. The kernel will not enable this facility for
>    the guest if it is not set on the host. This facility
>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>    feature is not installed.
> 
>    If this facility is not set for the KVM guest, then no
>    AP devices will be available to the guest regardless of
>    the guest's matrix configuration. This is a limitation
>    of the AP bus running under the guest.

Same here.

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c         | 7 +++++++
>  arch/s390/tools/gen_facilities.c | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 738b090fcf54..0eecc9ddb364 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -367,6 +367,13 @@ static void kvm_s390_cpu_feat_init(void)
>  
>  	if (MACHINE_HAS_ESOP)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
> +
> +	/*
> +	 * Check if AP instructions installed on host

/* check whether AP instructions are installed on host */

?

> +	 */
> +	if (ap_instructions_available() == 0)
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
> +
>  	/*
>  	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>  	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 90a8c9e84ca6..a52290bb8ad5 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -106,6 +106,8 @@ static struct facility_def facility_defs[] = {
>  
>  		.name = "FACILITIES_KVM_CPUMODEL",
>  		.bits = (int[]){
> +			12, /* AP Query Configuration Information */
> +			15, /* AP Facilities Test */
>  			-1  /* END */
>  		}
>  	},

Other than the nits above, patch looks good to me.

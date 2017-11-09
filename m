From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: provide a capability for AIS state
 migration
Date: Thu, 9 Nov 2017 10:53:41 +0100
Message-ID: <20171109105341.2dba6e59.cohuck@redhat.com>
References: <20171109094723.137958-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171109094723.137958-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu,  9 Nov 2017 10:47:23 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The AIS capability was introduced in 4.12, while the interface to
> migrate the state was added in 4.13. Unfortunately it is not possible
> for userspace to detect the migration capability without creating a flic
> kvm device. As in QEMU the the cpu model detection runs on the "none"

s/the the/the/

> machine this will result in cpu model issues regarding the "ais"
> capability.
> 
> To get the "ais" capability properly let's add a new KVM capability that
> tells userspace that AIS states can be migrated.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virtual/kvm/api.txt               | 8 ++++++++
>  Documentation/virtual/kvm/devices/s390_flic.txt | 2 ++
>  arch/s390/kvm/kvm-s390.c                        | 1 +
>  include/uapi/linux/kvm.h                        | 1 +
>  4 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index e63a35f..51553ba 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4347,3 +4347,11 @@ This capability indicates that userspace can load HV_X64_MSR_VP_INDEX msr.  Its
>  value is used to denote the target vcpu for a SynIC interrupt.  For
>  compatibilty, KVM initializes this msr to KVM's internal vcpu index.  When this
>  capability is absent, userspace can still query this msr's value.
> +
> +8.13 KVM_CAP_S390_AIS_MIGRATION
> +
> +Architectures: s390
> +Parameters: none
> +
> +This capability indicates if the flic device will be able to get/set the
> +AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute.

"and allows to discover this without having to create a flic device."

> diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
> index 27ad53c..a4e20a0 100644
> --- a/Documentation/virtual/kvm/devices/s390_flic.txt
> +++ b/Documentation/virtual/kvm/devices/s390_flic.txt
> @@ -151,6 +151,8 @@ struct kvm_s390_ais_all {
>      to an ISC (MSB0 bit 0 to ISC 0 and so on). The combination of simm bit and
>      nimm bit presents AIS mode for a ISC.
>  
> +    KVM_DEV_FLIC_AISM_ALL is indicated by KVM_CAP_S390_AIS_MIGRATION.
> +
>  Note: The KVM_SET_DEVICE_ATTR/KVM_GET_DEVICE_ATTR device ioctls executed on
>  FLIC with an unknown group or attribute gives the error code EINVAL (instead of
>  ENXIO, as specified in the API documentation). It is not possible to conclude
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index de6a5b7..8f4b655 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -395,6 +395,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_USER_INSTR0:
>  	case KVM_CAP_S390_CMMA_MIGRATION:
>  	case KVM_CAP_S390_AIS:
> +	case KVM_CAP_S390_AIS_MIGRATION:
>  		r = 1;
>  		break;
>  	case KVM_CAP_S390_MEM_OP:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8388875..b605956 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -930,6 +930,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PPC_SMT_POSSIBLE 147
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
> +#define KVM_CAP_S390_AIS_MIGRATION 150
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  

With the small addition above,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

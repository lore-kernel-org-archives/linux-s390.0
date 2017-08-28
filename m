From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 06/11] KVM: s390: Multiple Epoch Facility support
Date: Mon, 28 Aug 2017 13:21:44 +0200
Message-ID: <20170828132144.0641d8ae.cohuck@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
        <1503907651-65296-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503907651-65296-3-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Aug 2017 10:07:29 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> 
> Allow for the enablement of MEF and the support for the extended
> epoch in SIE and VSIE for the extended guest TOD-Clock.
> 
> A new interface is used for getting/setting a guest's extended
> TOD-Clock that uses a single ioctl invocation, KVM_S390_VM_TOD_EXT.
> The old method of getting and setting the guest TOD-Clock is
> retained and is used when the old ioctls are called.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virtual/kvm/devices/vm.txt |  14 ++++-
>  arch/s390/include/asm/kvm_host.h         |   6 +-
>  arch/s390/include/uapi/asm/kvm.h         |   6 ++
>  arch/s390/kvm/kvm-s390.c                 | 101 +++++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.h                 |   2 +
>  arch/s390/kvm/vsie.c                     |  10 +++
>  arch/s390/tools/gen_facilities.c         |   1 +
>  7 files changed, 138 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
> index 903fc92..8a86778 100644
> --- a/Documentation/virtual/kvm/devices/vm.txt
> +++ b/Documentation/virtual/kvm/devices/vm.txt
> @@ -176,7 +176,8 @@ Architectures: s390
>  
>  3.1. ATTRIBUTE: KVM_S390_VM_TOD_HIGH
>  
> -Allows user space to set/get the TOD clock extension (u8).
> +Allows user space to set/get the TOD clock extension (u8). (superseded by

s/(u8)./(u8)/

> +KVM_S390_VM_TOD_EXT).
>  
>  Parameters: address of a buffer in user space to store the data (u8) to
>  Returns:    -EFAULT if the given address is not accessible from kernel space
> @@ -190,6 +191,17 @@ the POP (u64).
>  Parameters: address of a buffer in user space to store the data (u64) to
>  Returns:    -EFAULT if the given address is not accessible from kernel space
>  
> +3.3. ATTRIBUTE: KVM_S390_VM_TOD_EXT
> +
> +Allows user space to set/get bits 0-63 of the TOD clock register as defined in
> +the POP (u64), as well as the TOD clock extension (u8) if supported by the
> +host.

I would be a bit more explicit on what happens if the tod clock
extension is not supported. What about:

"Allows user space to set/get bits 0-63 of the TOD clock register as
defined in the POP (u64). If the host supports the TOD clock extension
(u8), it also allows user space to set it. If the host does not support
it, it is stored as 0 and not allowed to be set to a value != 0."

> +
> +Parameters: address of a buffer in user space to store the data
> +            (kvm_s390_vm_tod_clock) to
> +Returns:    -EFAULT if the given address is not accessible from kernel space
> +	    -EINVAL if setting the TOD clock extension to != 0 is not supported
> +
>  4. GROUP: KVM_S390_VM_CRYPTO
>  Architectures: s390
>  

Else, looks good AFAICS.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

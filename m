From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/3] kvm: s390: Per-vm kvm device controls
Date: Thu, 10 Apr 2014 13:29:43 +0200
Message-ID: <534680A7.7090404@suse.de>
References: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com> <1397128604-50161-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397128604-50161-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 10.04.14 13:16, Christian Borntraeger wrote:
> From: Dominik Dingel <dingel@linux.vnet.ibm.com>
>
> We sometimes need to get/set attributes specific to a virtual machine
> and so need something else than ONE_REG.
>
> Let's copy the KVM_DEVICE approach, and define the respective ioctls
> for the vm file descriptor.
>
> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   Documentation/virtual/kvm/api.txt        |  8 ++---
>   Documentation/virtual/kvm/devices/vm.txt |  6 ++++
>   arch/s390/kvm/kvm-s390.c                 | 54 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/kvm.h                 |  1 +
>   4 files changed, 65 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/virtual/kvm/devices/vm.txt
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index c24211d..f69731a 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2314,8 +2314,8 @@ struct kvm_create_device {
>   
>   4.80 KVM_SET_DEVICE_ATTR/KVM_GET_DEVICE_ATTR
>   
> -Capability: KVM_CAP_DEVICE_CTRL
> -Type: device ioctl
> +Capability: KVM_CAP_DEVICE_CTRL, KVM_CAP_VM_ATTRIBUTES for vm device
> +Type: device ioctl, vm ioctl
>   Parameters: struct kvm_device_attr
>   Returns: 0 on success, -1 on error
>   Errors:
> @@ -2340,8 +2340,8 @@ struct kvm_device_attr {
>   
>   4.81 KVM_HAS_DEVICE_ATTR
>   
> -Capability: KVM_CAP_DEVICE_CTRL
> -Type: device ioctl
> +Capability: KVM_CAP_DEVICE_CTRL, KVM_CAP_VM_ATTRIBUTES for vm device
> +Type: device ioctl, vm ioctl
>   Parameters: struct kvm_device_attr
>   Returns: 0 on success, -1 on error
>   Errors:
> diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
> new file mode 100644
> index 0000000..4fe1532
> --- /dev/null
> +++ b/Documentation/virtual/kvm/devices/vm.txt
> @@ -0,0 +1,6 @@
> +Generic vm interface
> +====================================
> +
> +The interface handles per-vm attributes, such as CMMA status on s390 and is
> +similar in way to ONE_REG, but targeting the whole vm instead of one vcpu
> +alone. It is available with KVM_CAP_VM_ATTRIBUTES.

This document doesn't sound impressively useful :).


Alex

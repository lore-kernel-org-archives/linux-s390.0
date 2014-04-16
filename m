From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 3/3] kvm: s390: Exploiting generic userspace interface
 for cmma\
Date: Wed, 16 Apr 2014 15:49:06 -0300
Message-ID: <20140416184906.GA8773@amt.cnet>
References: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
 <1397128604-50161-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397128604-50161-4-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 10, 2014 at 01:16:44PM +0200, Christian Borntraeger wrote:
> From: Dominik Dingel <dingel@linux.vnet.ibm.com>
> 
> To enable CMMA and to reset its state we use the vm kvm_device ioctls,
> encapsulating attributes within the KVM_S390_VM_MEM_CTRL group.
> 
> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virtual/kvm/devices/vm.txt | 18 ++++++++++++++
>  arch/s390/include/uapi/asm/kvm.h         |  7 ++++++
>  arch/s390/kvm/kvm-s390.c                 | 42 ++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)

Sounds awkward to use these three ioctls for something not 
returned by KVM_CREATE_DEVICE.

/* ioctls for fds returned by KVM_CREATE_DEVICE */
#define KVM_SET_DEVICE_ATTR       _IOW(KVMIO,  0xe1, struct kvm_device_attr)
#define KVM_GET_DEVICE_ATTR       _IOW(KVMIO,  0xe2, struct kvm_device_attr)
#define KVM_HAS_DEVICE_ATTR       _IOW(KVMIO,  0xe3, struct kvm_device_attr)

Is that much of a problem to introduce

struct kvm_vm_attr and

/* ioctls for fds returned by KVM_CREATE_VM */
#define KVM_SET_VM_ATTR       _IOW(KVMIO,  0xa, struct kvm_vm_attr)
#define KVM_GET_VM_ATTR       _IOW(KVMIO,  0xb, struct kvm_vm_attr)
#define KVM_HAS_VM_ATTR       _IOW(KVMIO,  0xc, struct kvm_vm_attr)

?

Other than that (which would be mostly organizational issue) per-vm
attributes seem fine to me.

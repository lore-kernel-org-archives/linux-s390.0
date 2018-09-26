From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
Date: Wed, 26 Sep 2018 15:44:46 +0200
Message-ID: <20180926154446.2f6e666f.cohuck@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-25-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-25-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018 19:16:39 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new VM crypto device attributes (KVM_S390_VM_CRYPTO)
> to enable or disable AP instruction interpretation from userspace
> via the KVM_SET_DEVICE_ATTR ioctl:
> 
> * The KVM_S390_VM_CRYPTO_ENABLE_APIE attribute enables hardware
>   interpretation of AP instructions executed on the guest.
> 
> * The KVM_S390_VM_CRYPTO_DISABLE_APIE attribute disables hardware
>   interpretation of AP instructions executed on the guest. In this
>   case the instructions will be intercepted and pass through to
>   the guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/include/uapi/asm/kvm.h |  2 ++
>  arch/s390/kvm/kvm-s390.c         | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)

Other than the nits that David had, this looks fine.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 8/9] KVM: s390: advertise KVM_CAP_S390_IRQCHIP
Date: Tue, 22 Jul 2014 10:32:12 +0200
Message-ID: <53CE218C.5020505@redhat.com>
References: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com> <1405970065-3740-9-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405970065-3740-9-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 21/07/2014 21:14, Christian Borntraeger ha scritto:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> We should advertise all capabilities, including those that can
> be enabled.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index dd902e6..339b34a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -166,6 +166,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>  	case KVM_CAP_IOEVENTFD:
>  	case KVM_CAP_DEVICE_CTRL:
>  	case KVM_CAP_ENABLE_CAP_VM:
> +	case KVM_CAP_S390_IRQCHIP:
>  	case KVM_CAP_VM_ATTRIBUTES:
>  	case KVM_CAP_MP_STATE:
>  		r = 1;
> 

Should I apply this to 3.16 as well (or Cc: stable)?

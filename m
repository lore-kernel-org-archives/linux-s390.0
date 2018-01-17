From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/6] KVM: s390: wire up seb feature
Date: Wed, 17 Jan 2018 12:22:38 +0100
Message-ID: <d732ca53-9aba-8db5-b748-09193a615963@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-6-git-send-email-schwidefsky@de.ibm.com>
 <4fa9b6fa-40cb-b51e-0aa8-2e21bd93d526@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4fa9b6fa-40cb-b51e-0aa8-2e21bd93d526@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

> while this is kvm code, my current plan is to submit the "final"
> version after review and probably some fixes/renames via Martin
> together with the other patches.  Are you ok with that? Right now it
> seems that the CAP number is still fine.
Sure, though there will be a capability introduced by PPC for similar
purposes, so check for conflicts.

On 17/01/2018 12:18, Christian Borntraeger wrote:
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2c93cbb..0c18f73 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -421,6 +421,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_GS:
>  		r = test_facility(133);
>  		break;
> +	case KVM_CAP_S390_SEB:
> +		r = test_facility(82);
> +		break;
>  	default:
>  		r = 0;

Can you add a generic "test facility" capability and ioctl?

Paolo

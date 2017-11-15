From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH 21/22] KVM: s390: Add KVM HPAGE capability
Date: Wed, 15 Nov 2017 11:06:55 +0100
Message-ID: <ea2a81f6-10ff-7596-6df5-ad4a65765fe7@redhat.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06.11.2017 23:29, Janosch Frank wrote:
> KVM huge page backing support can not be easily tested under
> s390. Currently testing is only possible after most of the guest has
> already been set up.
> 
> To indicate, that KVM has huge page backing support, we add the
> KVM_CAP_S390_HPAGE capability. This does not mean, that transparent
> huge pages are supported.

Are there any plans to support it? (my feeling is that it could be
somewhat tricky :) )

> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8388875..2cd359a 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -930,6 +930,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PPC_SMT_POSSIBLE 147
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
> +#define KVM_CAP_S390_HPAGE 150
>  
What about facilities/features that require PGSTE to be around. Have we
fixed up all handlers? (I remember some features/instructions triggering
special SIE exits in case they hit a large pmd in the gmap).

Which of these facilities will we have to disable in user space? (e.g.
we already handle CMM in QEMU if we detect explicit huge pages).

(lack of public documentation makes this hard to review/understand)

-- 

Thanks,

David / dhildenb

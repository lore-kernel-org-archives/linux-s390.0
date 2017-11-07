From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC/PATCH 21/22] KVM: s390: Add KVM HPAGE capability
Date: Tue, 7 Nov 2017 11:07:28 +0100
Message-ID: <20171107110728.6e56d33d.cohuck@redhat.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
        <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  6 Nov 2017 23:29:59 +0100
Janosch Frank <frankja@linux.vnet.ibm.com> wrote:

> KVM huge page backing support can not be easily tested under
> s390. Currently testing is only possible after most of the guest has
> already been set up.
> 
> To indicate, that KVM has huge page backing support, we add the
> KVM_CAP_S390_HPAGE capability. This does not mean, that transparent
> huge pages are supported.
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
>  #ifdef KVM_CAP_IRQ_ROUTING
>  

Not looking into the rest of this patch set (for fear of my sanity :),
but I think this needs to be documented in
Documentation/virtual/kvm/api.txt.

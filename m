Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727485AbgBQKla (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 05:41:30 -0500
Subject: Re: [PATCH v2 07/42] KVM: s390: protvirt: Add UV debug trace
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-8-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d33fd043-a350-bc75-87d0-e6485163ae17@redhat.com>
Date: Mon, 17 Feb 2020 11:41:15 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-8-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Let's have some debug traces which stay around for longer than the
> guest.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c |  9 ++++++++-
>  arch/s390/kvm/kvm-s390.h | 11 +++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d7ff30e45589..cc7793525a69 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -220,6 +220,7 @@ static struct kvm_s390_vm_cpu_subfunc kvm_s390_available_subfunc;
>  static struct gmap_notifier gmap_notifier;
>  static struct gmap_notifier vsie_gmap_notifier;
>  debug_info_t *kvm_s390_dbf;
> +debug_info_t *kvm_s390_dbf_uv;
>  
>  /* Section: not file related */
>  int kvm_arch_hardware_enable(void)
> @@ -460,7 +461,12 @@ int kvm_arch_init(void *opaque)
>  	if (!kvm_s390_dbf)
>  		return -ENOMEM;
>  
> -	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view))
> +	kvm_s390_dbf_uv = debug_register("kvm-uv", 32, 1, 7 * sizeof(long));
> +	if (!kvm_s390_dbf_uv)
> +		goto out;


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

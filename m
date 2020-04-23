Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728115AbgDWMCY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Apr 2020 08:02:24 -0400
Subject: Re: [PATCH v1 1/1] s390/protvirt: fix compilation issue
References: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e8bfe89b-ba4d-c46b-412d-9fdb44c6cd34@redhat.com>
Date: Thu, 23 Apr 2020 14:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, gor@linux.ibm.com, cohuck@redhat.com, kbuild test robot <lkp@intel.com>, Philipp Rudo <prudo@linux.ibm.com>

On 23.04.20 14:01, Claudio Imbrenda wrote:
> The kernel fails to compile with CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> set but CONFIG_KVM unset.
> 
> This patch fixes the issue by making the needed variable always available.
> 
> Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Philipp Rudo <prudo@linux.ibm.com>
> Suggested-by: Philipp Rudo <prudo@linux.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/boot/uv.c   | 2 --
>  arch/s390/kernel/uv.c | 3 ++-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index 8fde561f1d07..f887a479cdc7 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -7,9 +7,7 @@
>  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>  int __bootdata_preserved(prot_virt_guest);
>  #endif
> -#if IS_ENABLED(CONFIG_KVM)
>  struct uv_info __bootdata_preserved(uv_info);
> -#endif
>  
>  void uv_query_info(void)
>  {
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index c86d654351d1..4c0677fc8904 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -23,10 +23,11 @@
>  int __bootdata_preserved(prot_virt_guest);
>  #endif
>  
> +struct uv_info __bootdata_preserved(uv_info);
> +
>  #if IS_ENABLED(CONFIG_KVM)
>  int prot_virt_host;
>  EXPORT_SYMBOL(prot_virt_host);
> -struct uv_info __bootdata_preserved(uv_info);
>  EXPORT_SYMBOL(uv_info);
>  
>  static int __init prot_virt_setup(char *val)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

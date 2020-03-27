Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbgC0KXj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 06:23:39 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RA2KDP105422
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:23:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewxr3qg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:23:38 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 27 Mar 2020 10:23:29 -0000
Subject: Re: [PATCH v2] s390/gmap: return proper error code on ksm unsharing
References: <20200327092356.25171-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 27 Mar 2020 11:23:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200327092356.25171-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <859b9810-eb50-6f81-ec12-3f22cc5c1d2c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

On 27.03.20 10:23, Christian Borntraeger wrote:
> If a signal is pending we might return -ENOMEM instead of -EINTR.
> We should propagate the proper error during KSM unsharing.
> 
> Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 27926a06df32..1ef864c252e6 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2552,12 +2552,13 @@ int gmap_mark_unmergeable(void)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> +	int ret;
>  
>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -				MADV_UNMERGEABLE, &vma->vm_flags)) {
> -			return -ENOMEM;
> -		}
> +		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> +				  MADV_UNMERGEABLE, &vma->vm_flags);
> +		if (ret)
> +			return ret;
>  	}
>  	mm->def_flags &= ~VM_MERGEABLE;
>  	return 0;


After the qemu patch discussion I would add


diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 0e268b3d1591..ba8f9cbe4376 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4680,6 +4680,12 @@ KVM_PV_ENABLE
   command has succeeded, any CPU added via hotplug will become
   protected during its creation as well.
 
+  Errors:
+
+  =====      =============================
+  EINTR      an unmasked signal is pending
+  =====      =============================
+
 KVM_PV_DISABLE
 
   Deregister the VM from the Ultravisor and reclaim the memory that


and change the patch description to something like


    s390/gmap: return proper error code on ksm unsharing
    
    If a signal is pending we might return -ENOMEM instead of -EINTR.
    We should propagate the proper error during KSM unsharing.
    unmerge_ksm_pages returns -ERESTARTSYS on signal_pending. This gets
    translated by entry.S to -EINTR. It is important to get this error
    code so that userspace can retry.
    
    Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
    Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
    Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
    Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
    Reviewed-by: David Hildenbrand <david@redhat.com>
    Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

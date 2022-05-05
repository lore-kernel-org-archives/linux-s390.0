Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ECC433F5
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiEEOtH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380750AbiEEOtE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 10:49:04 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D588514081
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651761924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jyfGq7dMfrbIZ4AP54s9Y4BCxr+1pD8LVHEm2Fcyagk=;
        b=HNOlUWtvKPzBdqlf+27kGl7Y8AGqIHS8SDk30D7TuD6EwhwfTx8nSSR7M0UeUpox/6HY1E
        7oBZwhTOUIs4bqcu9pEuyqQECjvMdOQRxVljQ4NsxYc1NrOhGUz/cghBYS0GMRvzLVkKOc
        t4wIegXksdzVGH1jDWbLAX37bfE4qZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-1vW_o107P0Gy-htHrGj9SQ-1; Thu, 05 May 2022 10:45:20 -0400
X-MC-Unique: 1vW_o107P0Gy-htHrGj9SQ-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso4586670wma.6
        for <linux-s390@vger.kernel.org>; Thu, 05 May 2022 07:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=jyfGq7dMfrbIZ4AP54s9Y4BCxr+1pD8LVHEm2Fcyagk=;
        b=b6h16CorWebLLkHgjYBh4YJgKc8Aj6r52mviXeKi0lvfKANbff8WEObYbfJfR7naKt
         Ken3CSl6X0vsFavFdAGHwDf0cRWiSu0H9nWu8HqXUdvTvjs7sEhknUF+nI7dIYcj5HIQ
         ywQVNFgO0kjrhng8YbI7DyomULraTc3jrXOhbOnNA1vqbAleGhe6S3ZlUT1uGy2ZS/lx
         M91UlTetOrSUjf/1ZSxkGNhNi9kUM05px7XveLsYifsdyDEb5p0X1QAqOJIk0A4XE78S
         Zb+wmtEr9jyv8b9wFGFXMvJ1cJbqVmruGMHEp4IfkfxQHaYkeZUguGuKalynRibYztCr
         IioA==
X-Gm-Message-State: AOAM533+1YZpkLxkmnAyIvOQ5T7QBHFPUVpyjuOyt5fGiC8Lc9GksSJk
        FnGE7FjrsG3jkMEnH75za4ivBJAgUn2yM/dSlVIXr0x2M3l1UoJFkKHH2Mi19JKzsboX97Txf/a
        vKmJR6S0clNzKP2he4F7Gpw==
X-Received: by 2002:adf:fe84:0:b0:20a:dc0b:4f2d with SMTP id l4-20020adffe84000000b0020adc0b4f2dmr21500160wrr.229.1651761919146;
        Thu, 05 May 2022 07:45:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZQq4VH2YS9CYoJkurgdMeySXi6KiIogT8HsYcwxJv74M68UxhhdX5HsfgALsw7hRyBw/cSA==
X-Received: by 2002:adf:fe84:0:b0:20a:dc0b:4f2d with SMTP id l4-20020adffe84000000b0020adc0b4f2dmr21500139wrr.229.1651761918878;
        Thu, 05 May 2022 07:45:18 -0700 (PDT)
Received: from [192.168.8.104] (tmo-082-126.customers.d1-online.com. [80.187.82.126])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b0039456c00ba7sm6101976wms.1.2022.05.05.07.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 07:45:18 -0700 (PDT)
Message-ID: <08f78cc7-b34e-cdca-72b8-a0f9163f3ca7@redhat.com>
Date:   Thu, 5 May 2022 16:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     borntraeger@de.ibm.com, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, scgl@linux.ibm.com,
        mimu@linux.ibm.com, nrb@linux.ibm.com
References: <20220414080311.1084834-1-imbrenda@linux.ibm.com>
 <20220414080311.1084834-2-imbrenda@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v10 01/19] KVM: s390: pv: leak the topmost page table when
 destroy fails
In-Reply-To: <20220414080311.1084834-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/04/2022 10.02, Claudio Imbrenda wrote:
> Each secure guest must have a unique ASCE (address space control
> element); we must avoid that new guests use the same page for their
> ASCE, to avoid errors.
> 
> Since the ASCE mostly consists of the address of the topmost page table
> (plus some flags), we must not return that memory to the pool unless
> the ASCE is no longer in use.
> 
> Only a successful Destroy Secure Configuration UVC will make the ASCE
> reusable again.
> 
> If the Destroy Configuration UVC fails, the ASCE cannot be reused for a
> secure guest (either for the ASCE or for other memory areas). To avoid
> a collision, it must not be used again. This is a permanent error and
> the page becomes in practice unusable, so we set it aside and leak it.
> On failure we already leak other memory that belongs to the ultravisor
> (i.e. the variable and base storage for a guest) and not leaking the
> topmost page table was an oversight.
> 
> This error (and thus the leakage) should not happen unless the hardware
> is broken or KVM has some unknown serious bug.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 29b40f105ec8d55 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")
> ---
>   arch/s390/include/asm/gmap.h |  2 +
>   arch/s390/kvm/pv.c           |  9 ++--
>   arch/s390/mm/gmap.c          | 80 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index 40264f60b0da..746e18bf8984 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -148,4 +148,6 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
>   			     unsigned long gaddr, unsigned long vmaddr);
>   int gmap_mark_unmergeable(void);
>   void s390_reset_acc(struct mm_struct *mm);
> +void s390_remove_old_asce(struct gmap *gmap);
> +int s390_replace_asce(struct gmap *gmap);
>   #endif /* _ASM_S390_GMAP_H */
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index 7f7c0d6af2ce..3c59ef763dde 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -166,10 +166,13 @@ int kvm_s390_pv_deinit_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
>   	atomic_set(&kvm->mm->context.is_protected, 0);
>   	KVM_UV_EVENT(kvm, 3, "PROTVIRT DESTROY VM: rc %x rrc %x", *rc, *rrc);
>   	WARN_ONCE(cc, "protvirt destroy vm failed rc %x rrc %x", *rc, *rrc);
> -	/* Inteded memory leak on "impossible" error */
> -	if (!cc)
> +	/* Intended memory leak on "impossible" error */
> +	if (!cc) {
>   		kvm_s390_pv_dealloc_vm(kvm);
> -	return cc ? -EIO : 0;
> +		return 0;
> +	}
> +	s390_replace_asce(kvm->arch.gmap);
> +	return -EIO;
>   }
>   
>   int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index af03cacf34ec..e8904cb9dc38 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2714,3 +2714,83 @@ void s390_reset_acc(struct mm_struct *mm)
>   	mmput(mm);
>   }
>   EXPORT_SYMBOL_GPL(s390_reset_acc);
> +
> +/**
> + * s390_remove_old_asce - Remove the topmost level of page tables from the
> + * list of page tables of the gmap.
> + * @gmap the gmap whose table is to be removed
> + *
> + * This means that it will not be freed when the VM is torn down, and needs
> + * to be handled separately by the caller, unless an intentional leak is
> + * intended. Notice that this function will only remove the page from the

"intentional leak is intended" ... sounds redundant. Scratch the first 
"intentional" ?

> + * list, the page will still be used as a top level page table (and ASCE).
> + */
> +void s390_remove_old_asce(struct gmap *gmap)
> +{
> +	struct page *old;
> +
> +	old = virt_to_page(gmap->table);
> +	spin_lock(&gmap->guest_table_lock);
> +	list_del(&old->lru);
> +	/*
> +	 * In case the ASCE needs to be "removed" multiple times, for example
> +	 * if the VM is rebooted into secure mode several times
> +	 * concurrently, or if s390_replace_asce fails after calling
> +	 * s390_remove_old_asce and is attempted again later. In that case

"In case the ASCE ... . In that case" - this should be either one big 
sentence, or better, scratch the first "In case" and use "Sometimes" or 
something similar to start the first sentence.

> +	 * the old asce has been removed from the list, and therefore it
> +	 * will not be freed when the VM terminates, but the ASCE is still
> +	 * in use and still pointed to.
> +	 * A subsequent call to replace_asce will follow the pointer and try
> +	 * to remove the same page from the list again.
> +	 * Therefore it's necessary that the page of the ASCE has valid
> +	 * pointers, so list_del can work (and do nothing) without
> +	 * dereferencing stale or invalid pointers.
> +	 */
> +	INIT_LIST_HEAD(&old->lru);
> +	spin_unlock(&gmap->guest_table_lock);
> +}
> +EXPORT_SYMBOL_GPL(s390_remove_old_asce);
> +
> +/**
> + * s390_replace_asce - Try to replace the current ASCE of a gmap with
> + * another equivalent one.
> + * @gmap the gmap

"the gmap" is not a very helpful description for a parmeter that is already 
called gmap. Write at least "the guest map that should be replaced" ?

> + *
> + * If the allocation of the new top level page table fails, the ASCE is not
> + * replaced.
> + * In any case, the old ASCE is always removed from the list. Therefore the
> + * caller has to make sure to save a pointer to it beforehands, unless an

s/beforehands/beforehand/

> + * intentional leak is intended.

scratch "intentional".

> + */
> +int s390_replace_asce(struct gmap *gmap)
> +{
> +	unsigned long asce;
> +	struct page *page;
> +	void *table;
> +
> +	s390_remove_old_asce(gmap);
> +
> +	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> +	if (!page)
> +		return -ENOMEM;
> +	table = page_to_virt(page);
> +	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
> +
> +	/*
> +	 * The caller has to deal with the old ASCE, but here we make sure
> +	 * the new one is properly added to the list of page tables, so that
> +	 * it will be freed when the VM is torn down.
> +	 */
> +	spin_lock(&gmap->guest_table_lock);
> +	list_add(&page->lru, &gmap->crst_list);
> +	spin_unlock(&gmap->guest_table_lock);
> +
> +	/* Set new table origin while preserving existing ASCE control bits */
> +	asce = (gmap->asce & ~_ASCE_ORIGIN) | __pa(table);
> +	WRITE_ONCE(gmap->asce, asce);
> +	WRITE_ONCE(gmap->mm->context.gmap_asce, asce);
> +	WRITE_ONCE(gmap->table, table);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(s390_replace_asce);

  Thomas


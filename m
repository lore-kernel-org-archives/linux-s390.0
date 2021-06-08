Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CDEC47082
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFDB610F8
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 16:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFHQnf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhFHQnf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Jun 2021 12:43:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A499FC061787
        for <linux-s390@vger.kernel.org>; Tue,  8 Jun 2021 09:41:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 11so10934231plk.12
        for <linux-s390@vger.kernel.org>; Tue, 08 Jun 2021 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b/MZpiR66ewTSim1WwCgmLNKDwnWD3pufYpqwYfLPKU=;
        b=eppItGX1DgZiHMFm/WaH4b6ozdA44efGectWI1T2JKxSAAS0Osf16y7A2zCxg4TQBg
         K9YrCHhg6ZQuXCXLl+5ZWKAIJ4uWKQKGATy79/XnCMTwppi1cXc8Z/R9UUKJhLR4k4mm
         7V7ULWc/F2ufJoOGyi1vMLbpWgQZ985RF//a5Bi1Cd21z3jyKj9VjnjMmTblL0dXsQw5
         sWnQ8Sd+kvZCBiuDQPwB9heuWIc3dM4BH3XfdhVugKP8YyV0zxwOHvRT14pieUjJasps
         m05wg7SkpadjM8e5a4CDBQEFETfiSA8B855xkvVGqH0qzJ8D4X9wKcy4GkztAs3MPicV
         SY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b/MZpiR66ewTSim1WwCgmLNKDwnWD3pufYpqwYfLPKU=;
        b=ZYbAH6FKBgFlyehR4Xgj/hMI3chHr5RUsmY4s0R8qOsvu48BMAuyYyr76imzov4xwk
         LIdqh7kYzIuu8xjSuPbC1WBWoEOSXqE6JyM7WVtxQ9I0opbnCgu4fWGWCw+jrFw9YVoL
         RDbQ1lw59GOQDu0QSezDm0k4/OwTCMT42W73/hetoUe4/0vAtISc/4PoBSdZs/s3UlP/
         MU3yoDPNGb6gDjKzK8dWEDnyJi5wPdvzt6cBbjqk+N5Ot30gJSFpGedyF+4WOr4ULA2t
         EcKmJyJwxo76XoEaP72riXu9alGH/Ktlz3+HQUYXzVW+iGigh9so4eKBr5EOpKtHXT/8
         VR2Q==
X-Gm-Message-State: AOAM533l+8Z5tlJ4nFguZ8TKJUE/aipteJ0Am/25Q+k5+ul+EQEwSSJv
        GgUfYwwb1OsTk8BhHnsPaSNL3g==
X-Google-Smtp-Source: ABdhPJyLX/erWPaMyVyNgXSpSeNvJjb8Ds8CeGzeCnkGsW/Qodl00uQSPBRqaRwMmuoqc4szSEv3FA==
X-Received: by 2002:a17:902:d88e:b029:10e:601e:d779 with SMTP id b14-20020a170902d88eb029010e601ed779mr853444plz.82.1623170500557;
        Tue, 08 Jun 2021 09:41:40 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id b20sm14218333pjh.11.2021.06.08.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:41:39 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:41:36 +0000
From:   David Matlack <dmatlack@google.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, drjones@redhat.com,
        frankja@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, peterx@redhat.com,
        venkateshs@chromium.org
Subject: Re: [PATCH v2] KVM: selftests: introduce P47V64 for s390x
Message-ID: <YL+dwGhYheOiliZG@google.com>
References: <4d6513f3-d921-dff0-d883-51c6dbdcbe39@de.ibm.com>
 <20210608123954.10991-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608123954.10991-1-borntraeger@de.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 08, 2021 at 02:39:54PM +0200, Christian Borntraeger wrote:
> s390x can have up to 47bits of physical guest and 64bits of virtual
> address  bits. Add a new address mode to avoid errors of testcases
> going beyond 47bits.

Thanks for the fix. My apologies for breaking s390.

The patch "KVM: selftests: Fix 32-bit truncation of vm_get_max_gfn()"
has already been added to stable so you may want to add the following:

Fixes: ef4c9f4f6546 ("KVM: selftests: Fix 32-bit truncation of vm_get_max_gfn()")
Cc: stable@vger.kernel.org

> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
> v1->v2:
> - remove wrong comment
> - use 5 levels of page tables
>  tools/testing/selftests/kvm/include/kvm_util.h | 3 ++-
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index fcd8e3855111..b602552b1ed0 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -43,6 +43,7 @@ enum vm_guest_mode {
>  	VM_MODE_P40V48_4K,
>  	VM_MODE_P40V48_64K,
>  	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
> +	VM_MODE_P47V64_4K,
>  	NUM_VM_MODES,
>  };
>  
> @@ -60,7 +61,7 @@ enum vm_guest_mode {
>  
>  #elif defined(__s390x__)
>  
> -#define VM_MODE_DEFAULT			VM_MODE_P52V48_4K
> +#define VM_MODE_DEFAULT			VM_MODE_P47V64_4K
>  #define MIN_PAGE_SHIFT			12U
>  #define ptes_per_page(page_size)	((page_size) / 16)
>  
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 28e528c19d28..b126fab6c4e1 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -175,6 +175,7 @@ const char *vm_guest_mode_string(uint32_t i)
>  		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
>  		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
>  		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
> +		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
>  	};
>  	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
>  		       "Missing new mode strings?");
> @@ -192,6 +193,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>  	{ 40, 48,  0x1000, 12 },
>  	{ 40, 48, 0x10000, 16 },
>  	{  0,  0,  0x1000, 12 },
> +	{ 47, 64,  0x1000, 12 },
>  };
>  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>  	       "Missing new mode params?");
> @@ -277,6 +279,9 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
>  #endif
>  		break;
> +	case VM_MODE_P47V64_4K:
> +		vm->pgtable_levels = 5;
> +		break;
>  	default:
>  		TEST_FAIL("Unknown guest mode, mode: 0x%x", mode);
>  	}
> -- 
> 2.31.1
> 

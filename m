Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC8C48BCF
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713F86139A
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhFIOsA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238105AbhFIOr6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623249963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAU1zAInzx6+HrQSFp6ko34nkWsZXJD3O7CzG1wYgc4=;
        b=Lw5RIMyRn8eurI5P2G8p3a06EC8I9JfZxVsp9FNLXnpg2nj86QFwfBDTb3B393T6nOVj/o
        YUzs1D7cqOt8aDQtGQoWV93bMmqunVxBA2KWPzvI9/x8P5LbfCrOQsGv19qyS0yjIQYNfn
        5jA6LmhlCsyx5iEXfTQrrIEmaZr4XRg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-6aCFJvSrMqyZxOv2vD_2nQ-1; Wed, 09 Jun 2021 10:46:01 -0400
X-MC-Unique: 6aCFJvSrMqyZxOv2vD_2nQ-1
Received: by mail-wm1-f71.google.com with SMTP id l18-20020a05600c4f12b02901921c0f2098so1052490wmq.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Jun 2021 07:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AAU1zAInzx6+HrQSFp6ko34nkWsZXJD3O7CzG1wYgc4=;
        b=twRegfKNrYyAGfEo9jTxdOlS0SFqcV/cpLzLh4FbxFuC1SMTVYkLTK1jAei5Q0EbVd
         gdgG025nfDv82gYeKW6syELrB/Jta8elytdtGEQoxGI80jTquxzb6sHJYlFnWwTYORXA
         sf8Yg33qGxFeWtIef51z1oW3hnhT0G6ZYMuK64wAdDd84c56Ubkz167fT0gQiJwjHtvk
         ZuElddMINQGEu1ViVBBugY2QX557d6qHUE9S8wW6On7wHCrndPsUFr0PksHC+j34Vg5M
         zZM6SaRgZznu/vq4Nb04wJheYBr/rKZ8TxBAR87qckF3pp0vgj7xXtQrMR9679rrz+kp
         Mhrw==
X-Gm-Message-State: AOAM5319bGOjNkhywrv+JjxbqMbIHzneLdJOCQbUZjDSXqxTqhU4ZRap
        ku3gGEEx5SmrnOxHj+oIOeH1073C+NN8j0QJbwWluW2uMMqOH0bKV4KOJPzn13uSBnJFtL8FQXD
        FWgayf3zNemzvUwR76HKKd4itgYkl71RdHezDb9jy2LfijnhwE1hjZog/qK+jhAbIOAFUlw==
X-Received: by 2002:adf:e907:: with SMTP id f7mr212953wrm.112.1623249960239;
        Wed, 09 Jun 2021 07:46:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8wWl9iBsdp8NJzL7GA3JhN3F5793eKjJk9isccJu44zxan/zDVm9zk47iipTv1xUXcvDIKg==
X-Received: by 2002:adf:e907:: with SMTP id f7mr212915wrm.112.1623249959932;
        Wed, 09 Jun 2021 07:45:59 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id u15sm6321326wmq.48.2021.06.09.07.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:45:59 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 2/7] lib: unify header guards
To:     Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210609143712.60933-1-cohuck@redhat.com>
 <20210609143712.60933-3-cohuck@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <42e29a14-3870-5289-9067-5c9c1284e7dd@redhat.com>
Date:   Wed, 9 Jun 2021 16:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609143712.60933-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 09.06.21 16:37, Cornelia Huck wrote:
> Standardize header guards to _LIB_HEADER_H_.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   lib/alloc_page.h       | 4 ++--
>   lib/libcflat.h         | 4 ++--
>   lib/list.h             | 4 ++--
>   lib/pci-edu.h          | 4 ++--
>   lib/pci-host-generic.h | 4 ++--
>   lib/setjmp.h           | 4 ++--
>   lib/string.h           | 6 +++---
>   lib/vmalloc.h          | 4 ++--
>   8 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/alloc_page.h b/lib/alloc_page.h
> index 1af1419d49b6..eed2ba06eeaf 100644
> --- a/lib/alloc_page.h
> +++ b/lib/alloc_page.h
> @@ -5,8 +5,8 @@
>    * with byte granularity.
>    */
>   
> -#ifndef ALLOC_PAGE_H
> -#define ALLOC_PAGE_H 1
> +#ifndef _ALLOC_PAGE_H_
> +#define _ALLOC_PAGE_H_
>   
>   #include <stdbool.h>
>   #include <asm/memory_areas.h>
> diff --git a/lib/libcflat.h b/lib/libcflat.h
> index 460a1234ea6a..f40b431d1550 100644
> --- a/lib/libcflat.h
> +++ b/lib/libcflat.h
> @@ -17,8 +17,8 @@
>    * Authors: Hollis Blanchard <hollisb@us.ibm.com>
>    */
>   
> -#ifndef __LIBCFLAT_H
> -#define __LIBCFLAT_H
> +#ifndef _LIBCFLAT_H_
> +#define _LIBCFLAT_H_
>   
>   #ifndef __ASSEMBLY__
>   
> diff --git a/lib/list.h b/lib/list.h
> index 7f9717ef6258..ed3e52b40075 100644
> --- a/lib/list.h
> +++ b/lib/list.h
> @@ -1,5 +1,5 @@
> -#ifndef LIST_H
> -#define LIST_H
> +#ifndef _LIST_H_
> +#define _LIST_H_
>   
>   #include <stdbool.h>
>   
> diff --git a/lib/pci-edu.h b/lib/pci-edu.h
> index 44b4ba168768..9db94aec0bc7 100644
> --- a/lib/pci-edu.h
> +++ b/lib/pci-edu.h
> @@ -12,8 +12,8 @@
>    * Edu device is a virtualized device in QEMU. Please refer to
>    * docs/specs/edu.txt in QEMU repository for EDU device manual.
>    */
> -#ifndef __PCI_EDU_H__
> -#define __PCI_EDU_H__
> +#ifndef _PCI_EDU_H_
> +#define _PCI_EDU_H_
>   
>   #include "pci.h"
>   #include "asm/io.h"
> diff --git a/lib/pci-host-generic.h b/lib/pci-host-generic.h
> index 0ffe6380ec8f..3020ee22c837 100644
> --- a/lib/pci-host-generic.h
> +++ b/lib/pci-host-generic.h
> @@ -1,5 +1,5 @@
> -#ifndef PCI_HOST_GENERIC_H
> -#define PCI_HOST_GENERIC_H
> +#ifndef _PCI_HOST_GENERIC_H_
> +#define _PCI_HOST_GENERIC_H_
>   /*
>    * PCI host bridge supporting structures and constants
>    *
> diff --git a/lib/setjmp.h b/lib/setjmp.h
> index 2c56b4c68aaa..6afdf665681a 100644
> --- a/lib/setjmp.h
> +++ b/lib/setjmp.h
> @@ -4,8 +4,8 @@
>    * This code is free software; you can redistribute it and/or modify it
>    * under the terms of the GNU Library General Public License version 2.
>    */
> -#ifndef LIBCFLAT_SETJMP_H
> -#define LIBCFLAT_SETJMP_H 1
> +#ifndef _LIBCFLAT_SETJMP_H_
> +#define _LIBCFLAT_SETJMP_H_
>   
>   typedef struct jmp_buf_tag {
>   	long int regs[8];
> diff --git a/lib/string.h b/lib/string.h
> index e1febfed7fb2..b07763eaef10 100644
> --- a/lib/string.h
> +++ b/lib/string.h
> @@ -4,8 +4,8 @@
>    * This code is free software; you can redistribute it and/or modify it
>    * under the terms of the GNU Library General Public License version 2.
>    */
> -#ifndef __STRING_H
> -#define __STRING_H
> +#ifndef _STRING_H_
> +#define _STRING_H_
>   
>   extern size_t strlen(const char *buf);
>   extern size_t strnlen(const char *buf, size_t maxlen);
> @@ -23,4 +23,4 @@ extern int memcmp(const void *s1, const void *s2, size_t n);
>   extern void *memmove(void *dest, const void *src, size_t n);
>   extern void *memchr(const void *s, int c, size_t n);
>   
> -#endif /* _STRING_H */
> +#endif /* _STRING_H_ */
> diff --git a/lib/vmalloc.h b/lib/vmalloc.h
> index 8b158f591d75..346f94f198c5 100644
> --- a/lib/vmalloc.h
> +++ b/lib/vmalloc.h
> @@ -1,5 +1,5 @@
> -#ifndef VMALLOC_H
> -#define VMALLOC_H 1
> +#ifndef _VMALLOC_H_
> +#define _VMALLOC_H_
>   
>   #include <asm/page.h>
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


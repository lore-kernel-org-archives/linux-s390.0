Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC02C6FA8E
	for <linux-s390@archiver.kernel.org>; Tue, 28 Feb 2023 15:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjB1P6B (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjB1P5u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Feb 2023 10:57:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B232CCA
        for <linux-s390@vger.kernel.org>; Tue, 28 Feb 2023 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677599796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7pSWC5euLmUDx9YG5RWzWaGkcDB950fdhQfUYWKICc=;
        b=ZSChi6PCbVgB4ID1cv6gHwSECIe4OuDgIMTq9REYSJaYl9Bf5lSORAPqF9nF4FY6kYjdHP
        0rpMHiVugl0FfrSZ7kusLx2puVZVVd3rGCqTue3pS+eYTtT5A9Z1AGPyVPXzEsiDDvsgSV
        zDbR8uz7qH6HtSCPQlQ1dlM1cz+5/+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-EEkipdrmOTO40jM-J0axpA-1; Tue, 28 Feb 2023 10:56:35 -0500
X-MC-Unique: EEkipdrmOTO40jM-J0axpA-1
Received: by mail-wm1-f69.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so7085906wml.2
        for <linux-s390@vger.kernel.org>; Tue, 28 Feb 2023 07:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7pSWC5euLmUDx9YG5RWzWaGkcDB950fdhQfUYWKICc=;
        b=X/4wFKCl1YrVjKbLv9y0VbR/G/sPnjgZSMfwYaJ8Vzk35LB3wQzjQkl4TETJubCuf/
         oa/iXEQELwso/gI4jFPCTitDJ9w1sNaqr70Xg9SXxkHnD6bKuuHZMBxOCgkLNHPv9n7R
         48mwYybiaFr6kLQkII2H5f5YQwhqxoubuEcNiVIM3lJSCm7bkOaenj1HgaOEEsgbPhb7
         kC0xYNY6P0c/eSjqblnzSWRPggcej0nPbety5VvcZoiNBglYeIrB8tz9hTaZB1d3Nn9t
         vlhCF4zCCRQAPHvzEgGBVB8zwKo3RDwV15A8l0rdvLLjbVT6kLwCGFtMiwxm/QgZOlr/
         17Jw==
X-Gm-Message-State: AO0yUKV7JwH88KaSgyIYNlTB019rMNyZHsridrcqsRRqcTXjkinWoYF0
        fcZe8XlyoM4cq9mQsy5187gYFHMNp2in6rnqRlylwSqOsbC/ApEqt8rBB8p+QkjKN4h2qS9Nh+N
        FoTX4fEiAdQOCw75kLs5AWQ==
X-Received: by 2002:a05:600c:1e20:b0:3df:9858:c037 with SMTP id ay32-20020a05600c1e2000b003df9858c037mr9985230wmb.12.1677599793385;
        Tue, 28 Feb 2023 07:56:33 -0800 (PST)
X-Google-Smtp-Source: AK7set/U2v9f8GltbBAhuiD5VLcyopD+EwumVs1dLk0qMzdF/fI8DkaFn74NX3LW8zhnIM6FtbCCQg==
X-Received: by 2002:a05:600c:1e20:b0:3df:9858:c037 with SMTP id ay32-20020a05600c1e2000b003df9858c037mr9985221wmb.12.1677599793078;
        Tue, 28 Feb 2023 07:56:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:b800:3757:baed:f95e:20ac? (p200300cbc706b8003757baedf95e20ac.dip0.t-ipconnect.de. [2003:cb:c706:b800:3757:baed:f95e:20ac])
        by smtp.gmail.com with ESMTPSA id hn6-20020a05600ca38600b003e21f01c426sm13465165wmb.9.2023.02.28.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:56:32 -0800 (PST)
Message-ID: <bd656b2c-9a20-dea9-dcef-9cc965bccc9e@redhat.com>
Date:   Tue, 28 Feb 2023 16:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mm-unstable v1 19/26] riscv/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hughd@google.com, jhubbard@nvidia.com, jgg@nvidia.com,
        rppt@linux.ibm.com, shy828301@gmail.com, vbabka@suse.cz,
        namit@vmware.com, aarcange@redhat.com, peterx@redhat.com,
        linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
References: <mhng-b8dc8a57-dde0-4995-bbb7-3948a95ba0b1@palmer-ri-x1c9a>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <mhng-b8dc8a57-dde0-4995-bbb7-3948a95ba0b1@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28.02.23 16:50, Palmer Dabbelt wrote:
> On Fri, 13 Jan 2023 09:10:19 PST (-0800), david@redhat.com wrote:
>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
>> from the offset. This reduces the maximum swap space per file: on 32bit
>> to 16 GiB (was 32 GiB).
> 
> Seems fine to me, I doubt anyone wants a huge pile of swap on rv32.

Patch is already upstream, so we can't add tags unfortunately. Thanks 
for the review!

-- 
Thanks,

David / dhildenb


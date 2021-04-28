Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9788C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934A66141F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 09:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhD1JFY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237400AbhD1JFX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 05:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619600678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zy/Tt/0rdk34PfJBg6ggCnjTL4icF91iTv6QpcHj3wY=;
        b=FTTP1+tDphGRKReR7h7duMj6r6aBJ5qhooEoWGwz0PzgzKEkBQtwHW5KZgdaVUlZ4IONvJ
        i+qQ8Rr1F74T66KQlB9ifk5tuDvfXYpxOSurVIp2I6Q8TqkdF8e4ghrMZtX/SOZ4TaQbNn
        vIdo1p/vYztw20g1CavFQ59ameO2iCo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-EJgBZe_VOMWaPBWzcZl9ag-1; Wed, 28 Apr 2021 05:04:36 -0400
X-MC-Unique: EJgBZe_VOMWaPBWzcZl9ag-1
Received: by mail-wm1-f69.google.com with SMTP id n9-20020a1c40090000b02901401bf40f9dso3561330wma.0
        for <linux-s390@vger.kernel.org>; Wed, 28 Apr 2021 02:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Zy/Tt/0rdk34PfJBg6ggCnjTL4icF91iTv6QpcHj3wY=;
        b=BMFGneAPlSjWT8zdrzG3Ckz+b6UZDBYUiVWdfxBLt/tEkXovt09wDST4ZY25Hx8ZfQ
         4m7o6+f3Q8AJpjbxamjs3CPuNncJA7Jlb64Z7VpDZY1yEdie57p1Erfz0EDKx/Nnjh9Y
         jxo5YBQxJszeUSzhaI3HXyPbZXEawsaDRw2Hv2F1rIRK9JEOkpr7VAJb2bDUvmf4vKRR
         Iu1YYsBtuylHKnnje0c0ImMagSgbHmGJvvcLFrAslsdjzvYNPjwITPiy7t+8oYb38QnG
         oVq0AAUOzfHM2yl+7CPm6V9S8VNcgr7qAYTsD1HJa6xRRGr0S/yySpkC97mSli0jb5qG
         zWHg==
X-Gm-Message-State: AOAM533u9i0o0L0n3gZE6hNA8qLPtOYBmwzx6RbRm85AHKOjw9rAFWNv
        RyfUovYf6cdMHh6TeGr2CTiDE+pnZ8u1T2v7XZ3DkkWPWC/CcsTcUOyATsYnl3xBFMZRWvPk4Y3
        k0FNvFM1a41esMnZ0uMUnFA==
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr3192326wmi.138.1619600675594;
        Wed, 28 Apr 2021 02:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyHQN1kXxwPITyG57p5yBf6PwQPqB7SzwurYnctESLQPRWN6ybBTj8o2+iODN0NtgGzZQI8g==
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr3192278wmi.138.1619600675202;
        Wed, 28 Apr 2021 02:04:35 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id f24sm5734617wmb.32.2021.04.28.02.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:04:34 -0700 (PDT)
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        peifengl55 <peifengl55@gmail.com>,
        schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens" <heiko.carstens@de.ibm.com>,
        zhangshiming <zhangshiming@oppo.com>,
        zhouhuacai <zhouhuacai@oppo.com>,
        guoweichao <guoweichao@oppo.com>, guojian <guojian@oppo.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210414023803.937-1-lipeifeng@oppo.com>
 <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
 <c289b9dc-1259-c829-8ee4-1bee94d7d73d@redhat.com>
 <2021042611194631963076@oppo.com>
 <7dcc87f5-9ae5-613a-0cf4-820334592b90@redhat.com>
 <20210426181947189100132@oppo.com>
 <9808e36a-9e4e-d1e2-da49-beb567681a8b@redhat.com>
 <2021042812031720737751@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <ebc8310e-05ea-0a2a-bcdd-9072e5bf0f86@redhat.com>
Date:   Wed, 28 Apr 2021 11:04:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2021042812031720737751@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>  >> Essentially CONFIG_SPARSEMEM, whereby we can have huge holes in physical
>  >> memory layout and memory areas coming/going with memory hot(un)plug.
>  >> Usually we manage all metadata per section. For example, pageblocks are
>  >> allocated per section. We avoid arrays that depend on the
>  >> initial/maximum physical memory size.
> 
> CONFIG_SPRSEMEM has been opened in some of our product with 
> Qcom-platform and
> MTK platform. AFAIK, multi_freearea would not bring problem to 
> it？because the patch
> just manage the physical memory of zone to serveral section(free_area) 
> and adjust the
> the range of pages-PFN for buddy-alloc-pages by the alloction-order. 
> With memory
> hot(un)plug, we would initialize the members of "multi_freearea" in zone.

 From your description only I cannot tell how that would really work. 
Your description of 1) indicated that we are dealing with an array to 
manage memory segments, and arrays are a bad data structure when it 
comes to sparsity.

> 
> The patch has been merged in the baseline of our product that has been 
> sold all over the
> world with Linux-4.4/4.9/4.19 so that i don't think there will be too 
> much risk. Of course,
> i might be wrong.

Just always keep in mind that upstream Linux has a very broad community. 
What might be "good enough" for smartphones might not be well suited for 
servers, VMs, embedded devices, other archs ... just imagine the RAM 
size differences, sparse layout, dynamic memory changes, ...

Adding additional complexity to the buddy has to have a compelling 
benefit; keep in mind that any complexity we introduce has to be 
maintained in the long term.

Having that said, starting with small steps is IMHO the right approach.

-- 
Thanks,

David / dhildenb


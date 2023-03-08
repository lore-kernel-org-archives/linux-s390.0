Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C12C678D5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Mar 2023 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCHSP3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCHSP2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Mar 2023 13:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5745AC222F
        for <linux-s390@vger.kernel.org>; Wed,  8 Mar 2023 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678299241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqVUMBgLdWuWEkEiWBuCdYbN5kgycGc8p0MkzJipZw8=;
        b=GPeTbRNinbIQjNht+2WkSJvZjMljWhc3tvMCLobN+t7xTVl0036sptF60yhErT4VnZzL8u
        TWY0d7l2ZGdyKKdjVmZScWt2N6mpnNhizTIsG3QiDXWVg/aJRLUUGA3T5dwphREjcUjpu0
        OjZxZq/JVQhsNjMeEZsc4Q4970A8Org=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-9kOEZXt3PnmLwWfkY1fw1A-1; Wed, 08 Mar 2023 13:14:00 -0500
X-MC-Unique: 9kOEZXt3PnmLwWfkY1fw1A-1
Received: by mail-wm1-f70.google.com with SMTP id l31-20020a05600c1d1f00b003e8626cdd42so6173510wms.3
        for <linux-s390@vger.kernel.org>; Wed, 08 Mar 2023 10:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299239;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqVUMBgLdWuWEkEiWBuCdYbN5kgycGc8p0MkzJipZw8=;
        b=u1cobQLyGGwEsabvBt/rOlBeP7QCg4BMvfLTcT8UBLB90OAr2Jww263CwIpMomCkKd
         +Exr/9sJCqC/6YrD2WZMBW4LmKCahEw+YMgrm9d2O6jljmY7c0VViyPguT6PJ5zz5Yl6
         fRzZMlalOtk0DUcd7IDtTb5qXOC2cx007vrd5uHY284x/tp/YZ9tNhEa13Szuo+pmKJ7
         OJyxna8j2+71wZvIILD72nxTZRnkS5zbAZa5zaNOi6s6yi5MqaQJ/l00NXEh4ygQn0AU
         EOPAejkWSp5IJr936XEVzuYIRd+R+xeCSXgPXwIIz7BzKOF9ezhSor0WlOeHIazlS1D0
         lYsg==
X-Gm-Message-State: AO0yUKVf0ist4yEoYarLS7x3Y2YuRCn4WfIX8S8ItP1XSyjujiEcpidG
        lcOZ085aYm1nG24Qs9sZKPpLEXYNMUsnlUienbEbROCeAGlHJyyMelHALriqDHSRcgVdvNgDy/k
        lM4XJtD5PgModNf8kW53R/w==
X-Received: by 2002:a05:600c:1e8d:b0:3e2:669:757 with SMTP id be13-20020a05600c1e8d00b003e206690757mr16617456wmb.10.1678299238875;
        Wed, 08 Mar 2023 10:13:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+WPqgI4NzGQjNxiuwyUBe8i9sylAhAstDgZK0opmz/cBRzcC+hzIeoGWHq+f4Os0qszuvRgQ==
X-Received: by 2002:a05:600c:1e8d:b0:3e2:669:757 with SMTP id be13-20020a05600c1e8d00b003e206690757mr16617435wmb.10.1678299238573;
        Wed, 08 Mar 2023 10:13:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:cb00:d372:1da8:9e9e:422d? (p200300cbc71bcb00d3721da89e9e422d.dip0.t-ipconnect.de. [2003:cb:c71b:cb00:d372:1da8:9e9e:422d])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b003e20fa01a86sm201680wmq.13.2023.03.08.10.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:13:58 -0800 (PST)
Message-ID: <a5c9b925-57ac-eeab-6258-0ff9fed16af7@redhat.com>
Date:   Wed, 8 Mar 2023 19:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: add PTE pointer parameter to
 flush_tlb_fix_spurious_fault()
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-x86 <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20230306161548.661740-1-gerald.schaefer@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230306161548.661740-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06.03.23 17:15, Gerald Schaefer wrote:
> s390 can do more fine-grained handling of spurious TLB protection faults,
> when there also is the PTE pointer available.
> 
> Therefore, pass on the PTE pointer to flush_tlb_fix_spurious_fault() as
> an additional parameter.
> 
> This will add no functional change to other architectures, but those with
> private flush_tlb_fix_spurious_fault() implementations need to be made
> aware of the new parameter.
> 
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


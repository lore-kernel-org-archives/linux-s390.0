Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67AC6FD18
	for <linux-s390@archiver.kernel.org>; Tue, 18 Apr 2023 15:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjDRPqo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDRPqn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Apr 2023 11:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47193137
        for <linux-s390@vger.kernel.org>; Tue, 18 Apr 2023 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681832709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27YuiGTc/1Ayk3pIwHwifC0cK9cQSm41NYDsP6qMI7E=;
        b=CDPJWjw7922+HWw5MqXWuotkaTCG5XVEvGU1OSihcrxAc9NydIVybPt59TN32MBRtuA/5m
        UFxuV07/YeaK2h96WTHKE4Xc2Lrlnzyri5go6ZXhcHvV4A47wf/QxXJa4YP8FT4DCwQ8QM
        +Mu/7eMO8xZc5VF/cbvXjIiEcZcwDkE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-gvE64t5WPJqCOdPXTCasaQ-1; Tue, 18 Apr 2023 11:45:07 -0400
X-MC-Unique: gvE64t5WPJqCOdPXTCasaQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f08ed462c0so42522955e9.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Apr 2023 08:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832706; x=1684424706;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27YuiGTc/1Ayk3pIwHwifC0cK9cQSm41NYDsP6qMI7E=;
        b=BL1E3LuLJUi3RHVH9vTmsTyZxDNF35btatZEM81BPmetC0FcKESZF86EB5qAhcPkJm
         umCcuyXU+ckEzH6c5J2ixnyxtCLt7UoZp+IwJ4W/XBA6s08o9hMKy5SORy/fuj0VPOey
         MM8JVgFHuIWTFDwzrsgdiPxBzC+sa5ptVBUYKrm1UjHk+4UJ9ytS4Sbg3Ksai+lkoBW1
         7evPx2bnVkm6ZZeVdJuJDenqb+7N1bmDsWZMj0oSVq9BeMrWpYJQ54XraTBDV3iUoPfk
         voC0Ru6VNFTrVykz9w+p/yB6sIu/jpX1SZBWJHeguH/J8nkCSUtBeYUe8tM9JdndA4C9
         VpqA==
X-Gm-Message-State: AAQBX9eR+dcsYVApAnAaZeBfytkf2XJqXc/CNNXIg57lPAnHWdsLRjxM
        o3laKG7f5ZbJhrWORsb+p3CdBvoHvJ8esl/tAyiitHo3E9qtBvnxsISsIbG/S0him/MMV5EysnU
        v1iO+1lJM5FSjz6tcLN62cg==
X-Received: by 2002:a5d:6dcc:0:b0:2ef:b8ae:8791 with SMTP id d12-20020a5d6dcc000000b002efb8ae8791mr2341924wrz.10.1681832706618;
        Tue, 18 Apr 2023 08:45:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350boD2pgyaTgtT87B/OGZT/ZiXFytTcP4U4+Qx8x/yMODSTgYDG7+n20ySQtuSYJgFc2NPKTdg==
X-Received: by 2002:a5d:6dcc:0:b0:2ef:b8ae:8791 with SMTP id d12-20020a5d6dcc000000b002efb8ae8791mr2341904wrz.10.1681832706235;
        Tue, 18 Apr 2023 08:45:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:3f00:7545:deb6:f2f4:27ef? (p200300cbc7153f007545deb6f2f427ef.dip0.t-ipconnect.de. [2003:cb:c715:3f00:7545:deb6:f2f4:27ef])
        by smtp.gmail.com with ESMTPSA id z10-20020a5d654a000000b002daeb108304sm13380984wrv.33.2023.04.18.08.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:45:05 -0700 (PDT)
Message-ID: <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
Date:   Tue, 18 Apr 2023 17:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230417205048.15870-2-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17.04.23 22:50, Vishal Moola (Oracle) wrote:
> s390 uses page->index to keep track of page tables for the guest address
> space. In an attempt to consolidate the usage of page fields in s390,
> replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.
> 
> This will help with the splitting of struct ptdesc from struct page, as
> well as allow s390 to use _pt_frag_refcount for fragmented page table
> tracking.
> 
> Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NULL
> before freeing the pages as well.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

[...]

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3fc9e680f174..2616d64c0e8c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -144,7 +144,7 @@ struct page {
>   		struct {	/* Page table pages */
>   			unsigned long _pt_pad_1;	/* compound_head */
>   			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> -			unsigned long _pt_pad_2;	/* mapping */
> +			unsigned long _pt_s390_gaddr;	/* mapping */
>   			union {
>   				struct mm_struct *pt_mm; /* x86 pgds only */
>   				atomic_t pt_frag_refcount; /* powerpc */

The confusing part is, that these gmap page tables are not ordinary 
process page tables that we would ordinarily place into this section 
here. That's why they are also not allocated/freed using the typical 
page table constructor/destructor ...

-- 
Thanks,

David / dhildenb


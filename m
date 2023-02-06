Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E73C61DA4
	for <linux-s390@archiver.kernel.org>; Mon,  6 Feb 2023 03:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBFDTY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Feb 2023 22:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFDTX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 5 Feb 2023 22:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434112042
        for <linux-s390@vger.kernel.org>; Sun,  5 Feb 2023 19:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675653514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HUnXR7sTsl7YLdib1oIsNCKOxnTEFsrq4tcNXVLT5m4=;
        b=fsVeQD5HhgDtw0OANPTWFjLM19HiDP6eXKL4vunRkM50YKlk4Se603vfacpQQ/TmPolqDf
        7liXh6ZDSiv6H/oDyY4s0xCTT6PrstSHqG/qN6xdbz7b0lQkFSyVI5h84jEuEVwf3Nqj5n
        jI9eDDsJmexHI+CzZbbQxwCCqDW6UjQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-CUCrdAWpNDWrGxMK-mx9xA-1; Sun, 05 Feb 2023 22:18:33 -0500
X-MC-Unique: CUCrdAWpNDWrGxMK-mx9xA-1
Received: by mail-qt1-f199.google.com with SMTP id c16-20020ac85190000000b003b841d1118aso5783032qtn.17
        for <linux-s390@vger.kernel.org>; Sun, 05 Feb 2023 19:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUnXR7sTsl7YLdib1oIsNCKOxnTEFsrq4tcNXVLT5m4=;
        b=U87HhQclAFP8QVCE98PZbYatW66x3y+52z2H0DrIbmtVNle8HOzc2xUAZ+3ld7Z1h7
         12Z1tHa38AOiHx0EEuCwOatT4x8iz+s0sKNX6aOYkg9Ypg3m++uhz16dx7rb9/p4KBqa
         MnislRG25tlCFVEmkz0R7uFvBo4ksKihjIF1vz2rXYHUvfao3QRKTZcsCXTM2VfkyjNV
         i92Ix65JWQ8uDACTN50ckSh+jrJe9viZimw9l/73h3yHPZVOlTZ4koPphvxs10KjNsw0
         MdBMz9IbdQiyVRhH9zSX+b4Wv7PSWn8tsxN8Z+5uucZ7aID8bfH1Ldf3tf1TyaqfRzL6
         UQ+A==
X-Gm-Message-State: AO0yUKXWmYBWGKdfFXfMgVILX5yFwh/4VMogELl1AiCbZKSbff8QP+qi
        HKvy9p84c/yMPCEjix5XemdF3CDHgTZ8+FdLQZp/XPtCpTuib5oqt5QLPlXirXLYUqgo5ghCTSp
        +r5o/lo6l88Q5LTKHlgSV6w==
X-Received: by 2002:a05:622a:17c4:b0:3b8:5199:f841 with SMTP id u4-20020a05622a17c400b003b85199f841mr33929530qtk.0.1675653512190;
        Sun, 05 Feb 2023 19:18:32 -0800 (PST)
X-Google-Smtp-Source: AK7set/cpAGW2ESxNhYZ0jEVuvvuRs8ZuhdHof+3DnmWont85g1bLMGsUjVwGkO9KhDgbxDFzB1GTQ==
X-Received: by 2002:a05:622a:17c4:b0:3b8:5199:f841 with SMTP id u4-20020a05622a17c400b003b85199f841mr33929514qtk.0.1675653511960;
        Sun, 05 Feb 2023 19:18:31 -0800 (PST)
Received: from xz-m1.local (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b6-20020a379906000000b007186c9e167esm6574425qke.52.2023.02.05.19.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 19:18:31 -0800 (PST)
Date:   Sun, 5 Feb 2023 22:18:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+BxhuGUx1K+3XHb@xz-m1.local>
References: <20230205231704.909536-1-peterx@redhat.com>
 <Y+BFjQDBIFq5ih+t@casper.infradead.org>
 <Y+BPy3jFcHqOnWL0@x1n>
 <Y+BrJhxeJbAp49QE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+BrJhxeJbAp49QE@casper.infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 06, 2023 at 02:51:18AM +0000, Matthew Wilcox wrote:
> That wasn't what I meant.  I meant putting VM_FAULT_BADMAP and
> VM_FAULT_SIGSEGV in mm_types.h.  Not having "Here is a range of reserved
> arch private ones".

VM_FAULT_SIGSEGV is there already; I assume you meant adding them all
directly into vm_fault_reason.

Then I don't think it's a good idea..

Currently vm_fault_reason is a clear interface for handle_mm_fault() for
not only arch pffault handlers but also soft faults like GUP.

If handle_mm_fault() doesn't return VM_FAULT_BADMAP at all, I don't think
we should have it as public API at all.  When arch1 people reading the
VM_FAULT_ documents, it shouldn't care about some fault reason that only
happens with arch2.  Gup shouldn't care about it either.

Logically a new page fault handler should handle all the retval of
vm_fault_reason afaiu.  That shouldn't include e.g. VM_FAULT_BADMAP either.

Thanks,

-- 
Peter Xu


Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB5C636D4
	for <linux-s390@archiver.kernel.org>; Mon,  6 Feb 2023 00:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBFAzZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Feb 2023 19:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBFAzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 5 Feb 2023 19:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5613DFA
        for <linux-s390@vger.kernel.org>; Sun,  5 Feb 2023 16:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675644879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RtOrxUe6MXUilzi3ALeyX9aNN6+6Dp+de8fvauQCp/I=;
        b=Hrxqg0b0x1JE5AsWN8Ur2s7CV8VZ08FzU0ZrphavyCf+Z9Rnz5L7hfV2WxMYCnvZLuY8ix
        Wi9uR8sTHNT/SkNVie2ab/2erBLS6oMnrzL+Y1FreVgTdlkj66VhXQDobAnq/iwRCYYoPc
        YO2ak5DR+rYeArgk6c60lJQZyR4JJW0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-4uioBpitN96olEQSko3MzA-1; Sun, 05 Feb 2023 19:54:37 -0500
X-MC-Unique: 4uioBpitN96olEQSko3MzA-1
Received: by mail-qk1-f199.google.com with SMTP id v186-20020a37dcc3000000b0072a264a6208so6996193qki.21
        for <linux-s390@vger.kernel.org>; Sun, 05 Feb 2023 16:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtOrxUe6MXUilzi3ALeyX9aNN6+6Dp+de8fvauQCp/I=;
        b=h+Fp7HkE85yuzrQw7yjmcSKcwPn7U3wR4Mo7oDKAPnJ2+GtYBcMOjP55CArQUD1UnU
         GVWTW9zvxHoM8GVVZxDRIqr+JQ/kcJ/OCjLiBkHPSnaayxyJ8PG5VttWVePbeBMEMBdN
         +zWDENRDPigGTpo1f+mNJgjriTKFgmvPJ5tu+Ard9K99C0jodvOJMxmYykWRCnv56Ax9
         K8X642lSKiQ5sAKjoG3qmo1OBJQPuJUu4Zv97HoI7LReJe6ixUJznZxx1cYtYJ/52iFo
         uDwI5tppPOJaXjHHw4EWjibGk/KEzfaIYe9JNoKZpPGGy6K10nIlcKTSr//DzIifngIb
         6nKQ==
X-Gm-Message-State: AO0yUKUmbKREW7Pl4XjXOI5CFF3hG/jSx6wzYVAMcPXqVLxYLzIzPeoY
        ME7zuQYzrKypcVBS4eMsT40zpaFMAqlTPnEobaiKV9a6tJ8YfTzswSIFKAumvfoGalPy2q+dqFC
        0vktjIKu8+omTaf+O1XXoZg==
X-Received: by 2002:ac8:70c6:0:b0:3b8:6d44:ca7e with SMTP id g6-20020ac870c6000000b003b86d44ca7emr30245545qtp.4.1675644877148;
        Sun, 05 Feb 2023 16:54:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/bBn9Wk9zrv600E6sElTcu40EYMTtlJ9J9a7mc/Qqbw8vjmF+ThB3qUAXhFvwAv8oykMT1bA==
X-Received: by 2002:ac8:70c6:0:b0:3b8:6d44:ca7e with SMTP id g6-20020ac870c6000000b003b86d44ca7emr30245533qtp.4.1675644876816;
        Sun, 05 Feb 2023 16:54:36 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id pe4-20020a05620a850400b0071ada51ab48sm6441832qkn.37.2023.02.05.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:54:36 -0800 (PST)
Date:   Sun, 5 Feb 2023 19:54:35 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+BPy3jFcHqOnWL0@x1n>
References: <20230205231704.909536-1-peterx@redhat.com>
 <Y+BFjQDBIFq5ih+t@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+BFjQDBIFq5ih+t@casper.infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 06, 2023 at 12:10:53AM +0000, Matthew Wilcox wrote:
> On Sun, Feb 05, 2023 at 06:17:01PM -0500, Peter Xu wrote:
> > I noticed a few collision usage on VM_FAULT_* definition in the page fault
> > path on arm/arm64/s390 where the VM_FAULT_* can overlap with the generic
> > definition of vm_fault_reason.
> > 
> > The major overlapped part being VM_FAULT_HINDEX_MASK which is used only by
> > the hugetlb hwpoisoning.
> > 
> > I'm not sure whether any of them can have a real impact, but that does not
> > look like to be expected.  I didn't copy stable, if anyone thinks it should
> > please shoot.  Nor did I test them in any form - I just changed the
> > allocations from top bits and added a comment for each of them.
> 
> This seems like a bad way to do it.  Why not just put these VM_FAULT_*
> definitions in linux/mm_types.h?  Then we'll see them when adding new
> VM_FAULT codes.  Sure, they won't be used by every architecture, but
> so what?

My initial version actually contains a few VM_FAULT_PRIVATE_N there, but I
noticed only the minority uses that, especially there's s390 which takes 5
entries.  I didn't had my mind straight on which's the best to go, then I
removed them and posted this simpler version, with comment on each to fix
the issues, more in a sense of raising the problem first.

I agree it isn't a problem at all, not until 32 bits all used up.  But that
seems to slightly encourage more archs from using the new private entries
which I wanted to avoid.

If to take a closer look, we may not really need that much private entries.
With s390, what I read is:

  - VM_FAULT_BADMAP could be replaced directly with VM_FAULT_SIGSEGV?
  - VM_FAULT_PFAULT could be replaced directly with VM_FAULT_BADCONTEXT?

Then if I'm not wrong we can already reduce 5->3 private entries.

I didn't directly change that because I am not 100% confident and I can't
test them myself.  It'll be great if arch people can have a look at either
s390 and arm to see whether there's chance of simplifcations first.  So the
patchset is more of raising the collision issue first, meanwhile great to
attract attention for arch people to refactor upon it.

I can also try to reduce the private entries and introduce PRIVATE entries
accordingly as you suggested, but I'll need more help on reviews and tests
than this one.

Thanks,

-- 
Peter Xu


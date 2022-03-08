Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76068C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  8 Mar 2022 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbiCHRs7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349250AbiCHRs6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 12:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6786748329
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646761680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FakVQP6MiE/Zi0gwIeYZLkyYTc78bBZSuWUh+KCXbNw=;
        b=bkI/8vsdbf5tHIN9D31azGMqzZ6vgbXJjyaMDy2KzrEbwwihMdev6daB9f+2H82Hx5ntqG
        3byqYnlK+ZKHufoTdCMrZsrDF7A7gyYiWNvop06FF/sS36pll7hjhK2m1SezGU8NRhkFQQ
        7yjoFi8Ylar7Pzt13DmV80R0LUuQbqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-rdfWgIg9NOizMP6FZz52Xw-1; Tue, 08 Mar 2022 12:47:59 -0500
X-MC-Unique: rdfWgIg9NOizMP6FZz52Xw-1
Received: by mail-wm1-f70.google.com with SMTP id m34-20020a05600c3b2200b0038115c73361so6724352wms.5
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 09:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=FakVQP6MiE/Zi0gwIeYZLkyYTc78bBZSuWUh+KCXbNw=;
        b=6Ead20qrQwgktM8FjSuSRS2Pncd9pVY501sSwcrFapMa9f4apnhpbEqtX8GZLyAlbo
         mPsk7OBJ0cbocoMqMb/qtV3Q8EAVyEswnvDiM1Oguyf8CT63Bzfov5X7ji7dtSsEh7Rm
         GfilbBkBgAuk028GEu3vKLCBQoDVT5v3nNJP7s+Mzb6DMdleYbBh9Y6SXLsWvWr78v8l
         z+vkOwO6i3jHybFv/m5hht30OzXWDonb626CO/6bDdIYzV6mx2tpfAqzEXy9LGLgrlan
         PjY6/lCHGPEVBs2+CQc4P4hHBIPFG5np/Vg9QcFid+zLalJsi5WDsJWDKtjbKmWNP48r
         tzPw==
X-Gm-Message-State: AOAM533AT5uKg6bUgbd3PwveRCIy4ZTW1oLt0jfUPMKZvSAQSORWebg8
        PLhETbXpeKW+zQizE8wej8kKVNdsA2QzQ1Ib0A8vFgrbQgpPnrmMMAoofU7VoeGZ0yMIflpFxSQ
        cq7ojJl7d0k+Qel8Tbs+NAg==
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr13637141wrq.715.1646761677978;
        Tue, 08 Mar 2022 09:47:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSc5uWGLBJT5WFw8W0WWnMeFJYAnXme99qyz4GnTqJ1cWsvoBhhkzFi7FmWm0wZEHWPxW2pQ==
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr13637130wrq.715.1646761677718;
        Tue, 08 Mar 2022 09:47:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm14380253wrw.49.2022.03.08.09.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:47:57 -0800 (PST)
Message-ID: <6614d129-7635-5908-bab4-bb1f121e1742@redhat.com>
Date:   Tue, 8 Mar 2022 18:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
In-Reply-To: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.03.22 18:26, Linus Torvalds wrote:
> On Tue, Mar 8, 2022 at 12:21 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> As raised offline already, I suspect
>>
>> shrink_active_list()
>> ->page_referenced()
>>  ->page_referenced_one()
>>   ->ptep_clear_flush_young_notify()
>>    ->ptep_clear_flush_young()
>>
>> which results on s390x in:
>>
>> static inline pte_t pte_mkold(pte_t pte)
>> {
>>         pte_val(pte) &= ~_PAGE_YOUNG;
>>         pte_val(pte) |= _PAGE_INVALID;
>>         return pte;
>> }
> 
> Yeah, that looks likely.
> 
> It looks to me like GUP just doesn't care about _PAGE_INVALID on s390,
> and happily looks up that page despite it not being "present" as far
> as hardware is concerned.
> 
> Your actual patch looks pretty nasty, though. We avoid marking it
> accessed on purpose (to avoid atomicity issues wrt hw-dirty bits etc),
> but still, that patch makes me go "there has to be a better way".

It certainly only works if we don't have hw dirty bits that might get
set concurrently -- for example, on s390x there is no such requirement.

As raised by Gerald, arch_faults_for_dirty_pte (and existing
arch_faults_on_old_pte) might be one option to get rid of the s390x
special-casing, and detect any arch that might update the dirty bit
concurrently.

Interestingly, mm/huge_memory.c:touch_pmd() doesn't seem to care about
concurrent dirty-bit updates by the hardware. Hmm.

But, of course, I'm open for alternatives, maybe we could adjust
fault_in_safe_writeable() to not use GUP as raised by you in the other
reply.

-- 
Thanks,

David / dhildenb


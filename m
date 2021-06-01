Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A54FC4708F
	for <linux-s390@archiver.kernel.org>; Tue,  1 Jun 2021 09:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB2261375
	for <linux-s390@archiver.kernel.org>; Tue,  1 Jun 2021 09:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhFAJEC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233539AbhFAJEB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Jun 2021 05:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622538140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTj0e2ix7Em5ReRBGmBE8UcFjJXaGmDtfxA9DwPKs3Y=;
        b=hl5WtER7JX53dBcKImZjoE4E6KN9LoXwoMyigbxWhzWkOWPZpdeAiu+PmU/q0+IunsoGhN
        Yo66ulpzstSzLhhTrtXenzpOU7dgAvXVUxsEbekOoe20CEKuba75uU6PStmzEGMitZe29N
        Alxkuqq1//928qwfQ4rZUCgxtdhPy1Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-PSQ2ge4lPH6UozU88qGJ9g-1; Tue, 01 Jun 2021 05:02:19 -0400
X-MC-Unique: PSQ2ge4lPH6UozU88qGJ9g-1
Received: by mail-wr1-f72.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so4564845wre.9
        for <linux-s390@vger.kernel.org>; Tue, 01 Jun 2021 02:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lTj0e2ix7Em5ReRBGmBE8UcFjJXaGmDtfxA9DwPKs3Y=;
        b=K9jrJMcHigV8XkFbpqID+Ou/wvQUhqdO+fJlRckVCbEmnLTSXd2Rv1kVCE0NLDGMlE
         ygdiwz1Ny/L4bUTfYjYwrU5+0P+BGcZXxlOOL+s4TOKhw0f8tS0RbYEj4wwwlQpFOBTf
         VscT2+iv9JFvnycSMpF/p8JGJi7ck/M5oRI4erO33Q3x1WNzk9Wfn4TcpH/yQgOWWKd4
         x+Kg4PE5e9xkHREn1afjEP9qCr7xJRfM+E6csqzBYTfqwXfJ+bGZb5Q4DaYXaPaBkbMc
         2xGSMbIFMCabFv4T2lu/eOkQ6rtQXipECI7jGXmnHlm6Gs6WjBpLexquD7qBrPwWozVc
         dR0Q==
X-Gm-Message-State: AOAM533jzFonDDYFMnSBsuqM2yLKUdce9XdmIognK4HF0GLA8AlAkNLG
        EJzOj+AhIt7N+6ytByeM/Oxa8uIY+aWtH/uBdfX68/LZzeju0JO8geBaqLQYoVT7sUG05ovNgyn
        e74aqZqFTp601PTdDt/jC+9xjPcv3MiGII1Wgpf0N3/Tq+vRB+TznTZ1Kf0l2uOgZmJ509g==
X-Received: by 2002:a05:600c:47c4:: with SMTP id l4mr3421532wmo.145.1622538138427;
        Tue, 01 Jun 2021 02:02:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzye8Yw+0bLOb0SBvbHwXC4HYmyiMFfH3IyzfuxKInF6JuzngzXM+aezXKoW/iZU7+Z69Ow5A==
X-Received: by 2002:a05:600c:47c4:: with SMTP id l4mr3421493wmo.145.1622538138179;
        Tue, 01 Jun 2021 02:02:18 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id 11sm17960058wmo.24.2021.06.01.02.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 02:02:17 -0700 (PDT)
From:   David Hildenbrand <david@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20210531122959.23499-1-rppt@kernel.org>
 <20210531122959.23499-2-rppt@kernel.org>
 <1efc386c-2cb4-164f-7194-497f142f969f@redhat.com>
Organization: Red Hat
Subject: Re: [RFC/RFT PATCH 1/5] s390: make crashk_res resource a child of
 "System RAM"
Message-ID: <f6cd0c41-d7e2-65f5-94eb-9a21514df799@redhat.com>
Date:   Tue, 1 Jun 2021 11:02:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1efc386c-2cb4-164f-7194-497f142f969f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01.06.21 10:45, David Hildenbrand wrote:
> On 31.05.21 14:29, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> Commit 4e042af463f8 ("s390/kexec: fix crash on resize of reserved memory")
>> added a comment that says "crash kernel resource should not be part of the
>> System RAM resource" but never explained why. As it looks from the code in
>> the kernel and in kexec there is no actual reason for that.
> 
> Are you sure?
> 
> Looking at kexec-tools: kexec/arch/s390/kexec-s390.c
> 
> get_memory_ranges_s390() wants "System RAM" and Crash kernel only with
> "with_crashk=1". Your patch would change that. "Crash kernel" would
> always be included if you make it a child of "System RAM".
> 
> Further, get_memory_ranges() and is_crashkernel_mem_reserved() look out
> for "Crash kernel\n" via parse_iomem_single().
> 
> However, parse_iomem_single() does not care about ranges that start with
> spaces IIRC via
>     sscanf(line, "%llx-%llx : %n" ...

I think I'm wrong about that one because I read

"Input white-space characters (as specified by the isspace function) are 
skipped, unless the specification includes a [ , c , or n specifier"

So having it as a child won't affect parse_iomem_single().

-- 
Thanks,

David / dhildenb


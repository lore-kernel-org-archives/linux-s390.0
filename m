Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3683CC47071
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 19:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKPTXp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 14:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKPTXo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 14:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405518D
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700162620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=JGaaonn2PlS/Bf+1agE3/lohv/E1v+K4KZ0xTLwaQWA=;
        b=RmKFbsRwrVexahM49ac5uCfoMfQmvLZV53Apx0b1zW4VevSSLZi757FRHjL04nS0deO6XE
        ESkI/y5O4AB14A2UAOdNUR3mIVvnDX24otyoSxtMCPbk5RtZhrsDs6TPj9SKUcKh7FG07O
        IiqlT3ddy79NCGDs4Gld08FkdRNtGPk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-jrHtTQ_OPve5J-pzQqbMTQ-1; Thu, 16 Nov 2023 14:23:38 -0500
X-MC-Unique: jrHtTQ_OPve5J-pzQqbMTQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32fd5f7b674so524854f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 11:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162617; x=1700767417;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JGaaonn2PlS/Bf+1agE3/lohv/E1v+K4KZ0xTLwaQWA=;
        b=xGtsExKTlcFwupjw4E1w9JbRUb1AIZOEtutcfd95V7mA5awXvPG+lnSJ+unbRgLY1N
         OG2/+4acHtZoqxB4DkEjEqK9xsMTehTrf7KUhtwaWk6OMNPnyzZIW22OLFaADy3skCo4
         w/O+dd94RxhO41svR94ZQJhuba0usKDB/KtBWhyo+Nyc0NF1MKIdYE4sbaZ+vx7zeA/O
         AwO604IrVGMkL91X1sGcC5NKrbRJSgw+S8Uxzmu7dU3uBzfv4sy92S/Xp2X9J5P8rgR9
         2VxqlAglsdxUtDa6tuAfz5qgDW7mRm8MbDTsNpHCl1qXJt1bhradDp6Cw9mYGHKKsnyA
         W+Xg==
X-Gm-Message-State: AOJu0Yx6TR1Ex7bdgqCZ9pymtowlf97r99AC7oB3xqmR1chKj8s2mAlA
        SL9KNGXEUBvH1P5D0IAviBV/yURCNumeXiGlBat9L2oWuWCspBP5ckT7AXMMcxElN1v0i9p1ZCK
        CQslcJf/bKtBkyVA9xrymQkNi1isWUg==
X-Received: by 2002:a05:6000:1a89:b0:32f:7bee:f300 with SMTP id f9-20020a0560001a8900b0032f7beef300mr13588844wry.4.1700162617361;
        Thu, 16 Nov 2023 11:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqzRdudRp5HRIcihjZfxFtR1oTJNGSDyIV83/QesXbsvLV2zANxxqjuybAlwaxJDVeUztSEg==
X-Received: by 2002:a05:6000:1a89:b0:32f:7bee:f300 with SMTP id f9-20020a0560001a8900b0032f7beef300mr13588828wry.4.1700162616972;
        Thu, 16 Nov 2023 11:23:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id u30-20020adfa19e000000b0032da022855fsm169709wru.111.2023.11.16.11.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 11:23:36 -0800 (PST)
Message-ID: <a9ca9b75-1410-445f-9e73-2db02acff1ed@redhat.com>
Date:   Thu, 16 Nov 2023 20:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE
 memory notifiers
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-7-sumanthk@linux.ibm.com>
 <458da84d-3838-4c5d-abda-1aebba676186@redhat.com>
 <ZVTTs2H6DgNGFPkF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <dfa5eb84-270e-4c6b-b9a1-3bb66beed6a4@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dfa5eb84-270e-4c6b-b9a1-3bb66beed6a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>>>
>>> Maybe s390x should just provide a dedicate interface to add these memory
>>> blocks instead of adding them during boot and then relying on the old way of
>>> using online/offline set them online/offline.
>>
>> Existing behavior:
>> The current 'lsmem -a' command displays both online and standby memory.
>>
>> interface changes:
>> If a new interface is introduced and standby memory is no longer listed,
>> the following consequences might occur:
>>
>> 1. Running 'lsmem -a' would only show online memory, potentially leading
>>      to user complaints.
> 
> That's why the new, clean way of doing it will require a world switch.
> If the admin wants the benefits of altmap/memmap allocation, it can be
> enabled.

BTW, thinking about it, I guess one could teach lsmem (and maybe chmem) 
to consult additional interfaces on s390x to show standby memory that's 
not added to the system yet.

-- 
Cheers,

David / dhildenb


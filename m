Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E8C47092
	for <linux-s390@archiver.kernel.org>; Tue,  1 Jun 2021 08:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F2960FDA
	for <linux-s390@archiver.kernel.org>; Tue,  1 Jun 2021 08:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhFAIr2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233656AbhFAIrU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Jun 2021 04:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622537138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ei1+7YPTwhcGwSC6x5usnbU/cNlmjtRYkQNi6UDFTrc=;
        b=EkJhtoONb6k8ZLDNDIAdPVTlgBlWdVE2M2uF60nvXfXnMQucj4l2m8Qmn6iUvJzoV6pLuw
        uXb5R3JA/pDjQdM2pIKir6rnLgUmu5Csi80b7NIAbGKeR8neOhOSev5B089vY3oW3kRi/A
        FgCEeItGeDXPGrbZBz/vOIujyyTE/+8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-t7Cv83hcOKeQzv7TrFVDTw-1; Tue, 01 Jun 2021 04:45:37 -0400
X-MC-Unique: t7Cv83hcOKeQzv7TrFVDTw-1
Received: by mail-wm1-f70.google.com with SMTP id r15-20020a05600c35cfb029017cc4b1e9faso846652wmq.8
        for <linux-s390@vger.kernel.org>; Tue, 01 Jun 2021 01:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ei1+7YPTwhcGwSC6x5usnbU/cNlmjtRYkQNi6UDFTrc=;
        b=hGgwr36F/PkdBNb1zP4G5/HFmEgIZ4x/cK9i+QXT/eOJsqC+5Wev6E/S5pIZy6CzTA
         zbbXmCu4T2EIae+SxTZdAepQuCoNjUq7tEIET6AyhERzJcWzAxo8MANA8RliBO6OhWCp
         ThLr3E/4Bu8BXzleZl9hDdgHeuk3jn/QhxMvZt2yehtf0fxypTqcwuA8sbAexgud65Bg
         9hbyJVEG0BsYo1WkK4kCC9VnnizTSp+hI+j21ElP1a9DhbGhd18meoAqiwrjjMqSQRfF
         uHKcWhUdBr2uoDdxHyDl7donXrx2N+VCqQCtp0yhadst75NSyRCUh6ab96G0ZClWEfNM
         pzFQ==
X-Gm-Message-State: AOAM530o70MdHK/D9sAmeMjGnorGnp2WZMju1ca5V5R4J/+sGELV9BO8
        0ULs8gqKykq0qcGFgqoUveOtdLcqJvv3ooS+QAQC7nmjY2I7CDRjwApgsLKynJUGSZeeqp4dqy+
        BqLAHkIVar9gb0TQl3F7vycgSO6G++uZA2xEvZY4bDiE1K0BvLYhYgy0TnXi847xNR2c41A==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr3376734wmm.138.1622537136581;
        Tue, 01 Jun 2021 01:45:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw71orUED6J0M5xRL2FPbrXf1zLtQk15md+bXCGp928W5f5vqEbcF2SNwRqRon22LUBP3L6NQ==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr3376705wmm.138.1622537136338;
        Tue, 01 Jun 2021 01:45:36 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id e26sm16961562wmh.39.2021.06.01.01.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:45:36 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC/RFT PATCH 1/5] s390: make crashk_res resource a child of
 "System RAM"
Message-ID: <1efc386c-2cb4-164f-7194-497f142f969f@redhat.com>
Date:   Tue, 1 Jun 2021 10:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531122959.23499-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 31.05.21 14:29, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Commit 4e042af463f8 ("s390/kexec: fix crash on resize of reserved memory")
> added a comment that says "crash kernel resource should not be part of the
> System RAM resource" but never explained why. As it looks from the code in
> the kernel and in kexec there is no actual reason for that.

Are you sure?

Looking at kexec-tools: kexec/arch/s390/kexec-s390.c

get_memory_ranges_s390() wants "System RAM" and Crash kernel only with 
"with_crashk=1". Your patch would change that. "Crash kernel" would 
always be included if you make it a child of "System RAM".

Further, get_memory_ranges() and is_crashkernel_mem_reserved() look out 
for "Crash kernel\n" via parse_iomem_single().

However, parse_iomem_single() does not care about ranges that start with 
spaces IIRC via
   sscanf(line, "%llx-%llx : %n" ...

So once you make "Crash kernel" a child of "System RAM", kexec-tools 
would break if I'm not completely wrong.

-- 
Thanks,

David / dhildenb


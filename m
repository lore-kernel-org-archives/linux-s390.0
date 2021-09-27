Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B8C4332F
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CAB60FF2
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhI0PIr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235064AbhI0PIq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 11:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632755227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2YLjPWLjDxhksfVJJ0b+TgzS3sQ4uenpZKkXE6cLl8=;
        b=Vuq9HxLgQlfj9bP7NfiSyHCmpHTUMswo7Ijerr+14A94Ln9wkpFBqxZEBlQjirzTHX0T/d
        r4KL5Y0EAK1vuIv09zmr1VmIvGMzCm2RfXRCo0yf0ZF6KU/IgVAYuXVzncZWmeQy+UicuJ
        0wjd0vXR85f6FqtqNqeZIbrSe0fcia8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-lqAba_-SPlaIjI48PciRWA-1; Mon, 27 Sep 2021 11:07:06 -0400
X-MC-Unique: lqAba_-SPlaIjI48PciRWA-1
Received: by mail-wm1-f72.google.com with SMTP id 70-20020a1c0149000000b0030b7dd84d81so360693wmb.3
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 08:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H2YLjPWLjDxhksfVJJ0b+TgzS3sQ4uenpZKkXE6cLl8=;
        b=eCQ9xjqFh+gq0MyH2QEnY3tCXLsVk+QFrt0S3TbbZ98Eytk785yvL+SO5AUD6EHBu4
         oMfJxD+CqWHJaIMIKcVAvt+AO4+y6CsRaHAq+TnT7kud8b2iNsOYR8Uq6jinYnvUfIT4
         FiFOyPm9CpC3NSLFOTuwzZocf8p5zdmOMS2TQQ9q77as4tcz2pqNR6D9ITlwTEX2U0si
         WvlIRhR2cSjInYVJ6M/pa+k4eAY5c5AbrfxraCRkdnCZFWMAseSeFVT+nA+qkfMwuec+
         bx42AMwGLnbnTfuTjg9Q8hA42czRA0Imm6PdmQ++d+jExrJvmN1Rcz2irAYJ9TBHF0jU
         gnaw==
X-Gm-Message-State: AOAM5310RAz+tIScg5k+vIRMf4D84wkGNlasUkKS4PhFagdbXqJ+H/nf
        2PUL62i1PEIC0N0d1q1KLWQPhX0YLpJd2AwOZ2I3gisEjdcyFim94bmTACnL36PHKHueToaZdK3
        Tx0uwLn07MMfXRm4XARQvuw==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr361568wrd.87.1632755224888;
        Mon, 27 Sep 2021 08:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy5wlKXLyU5BWf9WD/reu/rSzNLdsCLGLJ2WCZuEX7Xkvd9O/Z0HH1Erkz7+dZr/KU55FrDA==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr361519wrd.87.1632755224672;
        Mon, 27 Sep 2021 08:07:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id f9sm284908wmf.3.2021.09.27.08.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:07:04 -0700 (PDT)
Subject: Re: [PATCH v1 0/4] mm/memory_hotplug: full support for
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jianyong Wu <Jianyong.Wu@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
References: <20210927150518.8607-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d7d4ec92-7b9c-f466-6d3c-cfdd162d1dbf@redhat.com>
Date:   Mon, 27 Sep 2021 17:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210927150518.8607-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Intended subject was "[PATCH v1 0/4] mm/memory_hotplug: full support for 
add_memory_driver_managed() with CONFIG_ARCH_KEEP_MEMBLOCK"

-- 
Thanks,

David / dhildenb


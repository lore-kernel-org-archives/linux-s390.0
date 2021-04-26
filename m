Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F34C433B4
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636FD61263
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 12:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDZM4O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232575AbhDZM4N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 08:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619441732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E96iHRi0pDB8Gx/hvOHUwMH9SmXwt6oYBpOC2eqrBwY=;
        b=OO1Td3aTs9YYwKsU1jea9R0RALIKi2eD3xF8JzUFa3F/udo0PtyzqaiihzoBHivb7wpgBv
        GezSQ4m82RA6B+88C17f8K7lnujB/xUlpBiJd9XCfHX7GsX+hEcTtfhjiEFuU3w3w0oyKA
        8C4CHUMUi0whaZiQnQNYZ7MR2bPK2Kw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-mpJz2BicPs2VRCrxyGp91A-1; Mon, 26 Apr 2021 08:55:30 -0400
X-MC-Unique: mpJz2BicPs2VRCrxyGp91A-1
Received: by mail-ed1-f72.google.com with SMTP id cz7-20020a0564021ca7b02903853d41d8adso13692300edb.17
        for <linux-s390@vger.kernel.org>; Mon, 26 Apr 2021 05:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E96iHRi0pDB8Gx/hvOHUwMH9SmXwt6oYBpOC2eqrBwY=;
        b=Bvi3g4RXDjnFwabvr4WmwVc13jxKHYhPwAjv27e2S9EXXWGi6r5RPY1XW916W/5CEe
         fo7X8JxdFJ4oosbXTJUZFri75+Oh0anhdZ8rzugzyxJZpTcOe9E9G0ATj5usKWzKHxG7
         +hRmCdIsyufI67xgcM1aVwndV1f308eXqrw7qBVGWZcY+cemgJ9QLwkiUSig2ct6ctr4
         LQm6WTbWoR6HEVVe0xbfJbhIMiVP+x0ZqxAhn+S5QpLMwn1EVx/8aFE3MP+iEmfp6cCL
         MydM8UN5XSbohMOoE2eBDN4q6SaDINACiVHJUn2dKmircJS+SJDqBGv8EtK/P0EEAFVp
         ppgQ==
X-Gm-Message-State: AOAM5330Kb3hVEOGa4JZ2xe4dlWzi0m9jYX6lAn7aGrKmvD1crXVnw7g
        wKL7pdAyTpq+mjmMbg6gE8vbqhigewrzLzPMxkDh1iz0bR3Im5MeLteXwnrtfxbkfsXHgegC6Fd
        rL5fgo53Hmjozn2cr3Y2SRQ==
X-Received: by 2002:a17:906:64f:: with SMTP id t15mr18008542ejb.411.1619441728513;
        Mon, 26 Apr 2021 05:55:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTtmFyrhUELiEp1Slv3Dv1f/poXDpkq6nkg7FLSZqKNS3iFCBG4GlPkVuX75QtDDae6M/k8A==
X-Received: by 2002:a17:906:64f:: with SMTP id t15mr18008528ejb.411.1619441728303;
        Mon, 26 Apr 2021 05:55:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id la24sm12007107ejb.71.2021.04.26.05.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 05:55:27 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] KVM: my debug patch queue
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Will Deacon <will@kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Jim Mattson <jmattson@google.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>
References: <20210401135451.1004564-1-mlevitsk@redhat.com>
 <cb7f918c-932f-d558-76ec-801ed8ed1f62@redhat.com>
 <6d7146021f3435330b42f2e1b917d4b5dea00edc.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afba4cd8-72d3-ae18-df22-92be3b8eb321@redhat.com>
Date:   Mon, 26 Apr 2021 14:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6d7146021f3435330b42f2e1b917d4b5dea00edc.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 26/04/21 14:43, Maxim Levitsky wrote:
> On Fri, 2021-04-02 at 10:38 -0700, Paolo Bonzini wrote:
>> On 01/04/21 15:54, Maxim Levitsky wrote:
>>> Hi!
>>>
>>> I would like to publish two debug features which were needed for other stuff
>>> I work on.
>>>
>>> One is the reworked lx-symbols script which now actually works on at least
>>> gdb 9.1 (gdb 9.2 was reported to fail to load the debug symbols from the kernel
>>> for some reason, not related to this patch) and upstream qemu.
>>
>> Queued patches 2-5 for now.  6 is okay but it needs a selftest. (e.g.
>> using KVM_VCPU_SET_EVENTS) and the correct name for the constant.
> Do you mean to add a kvm-unit-test or to add a test to kernel's kvm unit tests
> for this?

selftests is used for those in the kernel.  "Unit test" can mean both, 
but usually it means kvm-unit-tests because they're easier to write.

Paolo


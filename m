Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7572DC47099
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 07:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4AB61415
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 07:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFDH0W (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhFDH0V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Jun 2021 03:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622791475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElFb664kDca3zTUpMXZCL5Csjp2/nyoNDD9HukhmOHM=;
        b=TnlVERX2WCccv73rRj+yMV72uhH/2GHU7sl8HB55t/ERJoXUzRYdL/CuKMoJrLWVT78foe
        XFg/BBEKf6L66s5ompGQJrLedD+9pEWksjvkh/xoghLGBf6cL0dryFAkhNicq74W/M5dOg
        2TuKJjL2eZ7HY8FgemWzln8LNQavm6k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-p_qk7EQXOu-7sYDd3Pw65Q-1; Fri, 04 Jun 2021 03:24:33 -0400
X-MC-Unique: p_qk7EQXOu-7sYDd3Pw65Q-1
Received: by mail-ej1-f71.google.com with SMTP id b8-20020a170906d108b02903fa10388224so3051658ejz.18
        for <linux-s390@vger.kernel.org>; Fri, 04 Jun 2021 00:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ElFb664kDca3zTUpMXZCL5Csjp2/nyoNDD9HukhmOHM=;
        b=h4o4PYS78wvyv4p32YAgRixMMqrlpix/I7U8OvJAuNpMHPDBfh8/btm+ZO59ierAss
         8a+J4WqDd2/dB753l9JsWPjH3repSf/rDZL5IRsgI3a2SwoCJG0ekRL1SprC3YrAg9zL
         scpx77xek2LBJY2N/5aQTnCGKG43c/8NyDMw6MwdNC7Y0k3la+zWIQdvBIa8g/tGAY04
         NEd1LoAtXubEDSGWBSoGZSqL3/mA+PHq7tTzDepJsRBop7DXntnBdG12F7sN4BI4Ijbp
         LBZ+ReBLP/Hctrqyfw2YoLmZVswSPbpTAVqAZoBVfr6ffMSHvq00Y8qF4aFRXJRF7pn7
         DA5A==
X-Gm-Message-State: AOAM530iSX6ytWiZxp12O4Cyy2vBSE2rT5dnoQn2ebvTmLow22oWKBBP
        6lRUXB9JIEtmEcmCpyHUV8rsTZNQAB5qEWbwqN91hWweuG6JI1XrhH122r1dFkt9VZAH5ENWCNo
        iAjLwtIYXNHFQ/j9S+/ckAQ==
X-Received: by 2002:a17:906:1401:: with SMTP id p1mr2849908ejc.526.1622791472783;
        Fri, 04 Jun 2021 00:24:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf6cQzWkBIEpZuWDj8mD3YKNJZw3J7U1/Ic7+UpRFaWTIKLqYoDPaxKjav78eW5CkReqQfnw==
X-Received: by 2002:a17:906:1401:: with SMTP id p1mr2849903ejc.526.1622791472650;
        Fri, 04 Jun 2021 00:24:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id nc26sm2296091ejc.106.2021.06.04.00.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 00:24:32 -0700 (PDT)
Subject: Re: [RFC][PATCH] kvm: add suspend pm-notifier
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20210603164315.682994-1-senozhatsky@chromium.org>
 <87a6o614dn.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4b4e872-4b22-82b7-57fc-65a7d10482c0@redhat.com>
Date:   Fri, 4 Jun 2021 09:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87a6o614dn.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/06/21 09:21, Vitaly Kuznetsov wrote:
>>   
>>   	preempt_notifier_inc();
>> +	kvm_init_pm_notifier(kvm);
>>   
> You've probably thought it through and I didn't but wouldn't it be
> easier to have one global pm_notifier call for KVM which would go
> through the list of VMs instead of registering/deregistering a
> pm_notifier call for every created/destroyed VM?

That raises questions on the locking, i.e. if we can we take the 
kvm_lock safely from the notifier.

Paolo


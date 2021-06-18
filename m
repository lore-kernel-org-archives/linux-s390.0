Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F0C49361
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA707601FF
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 08:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhFRIjo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233129AbhFRIjm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 04:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624005453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzqa8rS1pmB4o6NDr4muJNg1165tCr6NUIhZ4XLKVno=;
        b=DmUkyx/3SwWQMaCfpCXL9x0hAwNZMEpWlMsp/wOFG15jYa1UAYr/Uq6Q4DlHqWS5ekhhld
        l1yAZkMEMFzEW3fbgOdF1F5EFn0nFychof812WcleUoHLcMzZ4ifphYUXoNzt2sJUxL1BB
        8jhpD7PkzM2xyYvqqxpQ+AiZaE9Whzk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-kjZ1jqmsMhy3DxruyknvdA-1; Fri, 18 Jun 2021 04:37:32 -0400
X-MC-Unique: kjZ1jqmsMhy3DxruyknvdA-1
Received: by mail-ed1-f69.google.com with SMTP id x12-20020a05640226ccb0290393aaa6e811so3137228edd.19
        for <linux-s390@vger.kernel.org>; Fri, 18 Jun 2021 01:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wzqa8rS1pmB4o6NDr4muJNg1165tCr6NUIhZ4XLKVno=;
        b=eD967IO1y/7RBL1ams14QgpJ80krhGgJhhlxnewRrnlOpApJpFtFJqGhdpn0DnLm3+
         APk74a8vNtJd4eVm6cmi8cB1C92I+5Pox8ujRyBUoLRJD/jWRG2uV9EMKU0fDgLVgG37
         qYX7hoyO2RrSbmdZd2J1dKH9JncyFd5OBKtqCBzITSslxWumLsfgu68JsF0M4+W9kcFd
         3qx8CDA8x529pGnNp4G68dMKApsutRgYFTxb3jO+vVFqpv/9DCjHprqCCph2o+ovwtmQ
         /gjTwghwWfmDwLHjImmlFXqcUp/p2wLUJDlqbBLveswHVFgtT5BYseVIE04UoEgoI0+r
         COCg==
X-Gm-Message-State: AOAM5330lH66bkPET+RxbZ69FUMC1sYJ+Y+/jB8Omv0FMYiOZhGDQRg3
        8223Wcn0UdM+GiQt3JNu2Iqh8J7x3V3XVP7OHk2cbgSQly7SCAfsrJX9X/9p1vg7poi0jWtMY5T
        VXPrTxkVo8yCQMQxpfcvU0w==
X-Received: by 2002:a17:907:2135:: with SMTP id qo21mr10007153ejb.385.1624005450985;
        Fri, 18 Jun 2021 01:37:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGqTUCCnmlm2i4BwK6ow8EEW5K1lZq6PRO7ZAfVpPo/7FV7YEyqCjtEH5lpza698HypRTM1w==
X-Received: by 2002:a17:907:2135:: with SMTP id qo21mr10007135ejb.385.1624005450841;
        Fri, 18 Jun 2021 01:37:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id df20sm5460460edb.76.2021.06.18.01.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:37:30 -0700 (PDT)
Subject: Re: [PATCH v11 5/7] KVM: stats: Add documentation for binary
 statistics interface
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-6-jingzhangos@google.com>
 <YMxE8pUrbQkwlpbD@kroah.com>
 <0036c55a-72d6-7b5c-a6fd-3a285476e522@redhat.com>
 <YMxZ2Z9s5YRvhetZ@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8f1fada-a7b7-0f41-c57f-7164a8211d68@redhat.com>
Date:   Fri, 18 Jun 2021 10:37:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMxZ2Z9s5YRvhetZ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/06/21 10:31, Greg KH wrote:
> Ok, it's your maintenance burden, not mine, I was just suggesting a way
> to make it easier :)
> 
> I'll not complain about this anymore...

I wish there was a way to keep them in sync without either sacrificing 
the quality of the documentation or reading kvm.h 100 times, I would 
jump on it!

Paolo


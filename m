Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95157C433E0
	for <linux-s390@archiver.kernel.org>; Sat, 13 Mar 2021 09:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FCF64F1D
	for <linux-s390@archiver.kernel.org>; Sat, 13 Mar 2021 09:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhCMJf4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 13 Mar 2021 04:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232431AbhCMJf3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 13 Mar 2021 04:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615628129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEXvJoFIMtu03gnrQoXoMyZklbH+XrN6f9pUvJEic0Q=;
        b=IqKwB+G8k6cGJvIvuY229izFBrxVHACs5b+xyVTWxcvEKld4aw+XrRw6lk8D1z/W9Ka97n
        ASOGyBN3lLae0zxFYjUNXPEWvPebkB/Ej4XaOk84DsMFbhmoL7JjPWV99+5C0PLmH/NlyZ
        K9uNxCE1M7BIue1tEDUp0+AggD3fXKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-y8Hg8QrPPDyeb-kliOaddQ-1; Sat, 13 Mar 2021 04:35:24 -0500
X-MC-Unique: y8Hg8QrPPDyeb-kliOaddQ-1
Received: by mail-wr1-f69.google.com with SMTP id y5so12367619wrp.2
        for <linux-s390@vger.kernel.org>; Sat, 13 Mar 2021 01:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEXvJoFIMtu03gnrQoXoMyZklbH+XrN6f9pUvJEic0Q=;
        b=lhgEK8ybiRWy1+0tgCbBa0EmlgcE1nHclZFEqJ9TEiuTerhOIEIVTGj75/Be/pt0C+
         7GbQPyN9PaN+zspB+njDybF5BL8aROisHfWaU0oopBWGJpZjaajTISlE9BwNTI5FdSJJ
         KDusmEgaymJNPfrgSl58sH+TzzrSNiaO6jMbCLdrAdyOnMIjazGqUUzW7L9LBdIaCj9L
         X02PLyXmRKyufbIy9IyQY4MT5TrU//si7+ePGguagt/l/lJG9//ktbLJK9s3i4eDk7Kj
         YvcMpU1OJh5oDfVXgKQ2pSJi5VBrIwEjzO1+BwkcdnrDckOPPvV0J0p/4jhPlYfNh0i5
         7Uuw==
X-Gm-Message-State: AOAM530eplebm3sq4n/8liVJpNEp530BMard7LE4qCvvtzGlc8/MSOVs
        BzpHg+zlvxCXc8EhWpZEilVLLhfoE89rRv+t5cFRX9vKqiznCrcc9wgiUrWIFFOr0pvX0YNYWXR
        MKiDMlbtTdrKmBTyRw0/TXg==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr17111378wmc.184.1615628123494;
        Sat, 13 Mar 2021 01:35:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZPtEFloConQy5tT04Uy7VF5TWLNu7KM1ZAXfW/KGrUv9L+W1l/kfjlKPOTxYm+VdwnnAdmg==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr17111339wmc.184.1615628123265;
        Sat, 13 Mar 2021 01:35:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id b17sm11575008wrt.17.2021.03.13.01.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 01:35:22 -0800 (PST)
To:     Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20210310003024.2026253-1-jingzhangos@google.com>
 <20210310003024.2026253-4-jingzhangos@google.com>
 <bb03107c-a413-50da-e228-d338dd471fb3@redhat.com>
 <CAAdAUtjj52+cAhD4KUzAaqrMSJXHD0g=ecQNG-a92Mqn3BCxiQ@mail.gmail.com>
 <ac7462de-1531-5428-5dca-4e3dfb897000@redhat.com>
 <CAAdAUtjV67hx5BAd31-RG6tjgfZ6tdyu_yLhkbR0d-3qm59mMA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 3/4] KVM: stats: Add ioctl commands to pull statistics
 in binary format
Message-ID: <01a4619a-b36c-c08e-ff6e-7f8bc4d32771@redhat.com>
Date:   Sat, 13 Mar 2021 10:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAdAUtjV67hx5BAd31-RG6tjgfZ6tdyu_yLhkbR0d-3qm59mMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/03/21 23:27, Jing Zhang wrote:
>>>> 4 bytes flags (always zero)
> Could you give some potential use for this flag?

No idea, honestly.  It probably would signal the presence of more fields 
after "offset of the first stat value".  In general it's better to leave 
some room for extension.

>>>> 4 bytes number of statistics
>>>> 4 bytes offset of the first stat description
>>>> 4 bytes offset of the first stat value
>>>> stat descriptions:
>>>>     - 4 bytes for the type (for now always zero: uint64_t)
> Potential use for this type? Should we move this outside descriptor? Since
> all stats probably have the same size.

Yes, all stats should be 8 bytes.  But for example:

- 0 = uint64_t

- 1 = int64_t

- 0x80000000 | n: enum with n different values, which are stored after 
the name

>>>>     - 4 bytes for the flags (for now always zero)
> Potential use for this flag?

Looking back at Emanuele's statsfs, it could be:

- bit 0: can be cleared (by writing eight zero bytes in the statistics' 
offset)

- bit 1: cumulative value (count of events, can only grow) vs. 
instantaneous value (can go up or down)

This is currently stored in the debugfs mode, so we can already use 
these flags.

Paolo


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A196C48BE5
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041BD6140F
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 11:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhFQLsV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230269AbhFQLsU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 07:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623930373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ujv31ni+pedAzRqkqN94IhUeHH6igQoDkhQGmN9rbYg=;
        b=M6L1mTafPswJKarRnC+9Rg9l27Jrnsm2dzFzftOWOU3J6x3FYItDzIioiE1I95G+3C9zZ5
        QgGhMN/D5n7yalKArgMLAYiO3P2lac2c9pHsKyRJ9QV4Gu1fhEtLMibrOY4GjKDdKL8JeV
        GuJyY2yx5BcwDSFHUYo6BGu/vLEkr6M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-MWu9rGg0MkmKNxEXVlgWtw-1; Thu, 17 Jun 2021 07:46:11 -0400
X-MC-Unique: MWu9rGg0MkmKNxEXVlgWtw-1
Received: by mail-ej1-f69.google.com with SMTP id j26-20020a170906411ab02904774cb499f8so1789785ejk.6
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 04:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ujv31ni+pedAzRqkqN94IhUeHH6igQoDkhQGmN9rbYg=;
        b=cLFkuvo6UnMSK3wIYxOU0DwcZbCW/1UCGKz7nYWR0d37rJOIAditIRosa7gttBTdUw
         AwvKN242fgXza8uq256nCKaDvfAJwAYTeJjvlDI9s0Xcg/zz1gJv+WMVP10JDdBM0gJ6
         vqqOsBMmikjh+bPlLCAJYvppBINSqFO8kAy44XHSYbEQRhf0J3df1R7AuOzI4jms6hKt
         VQqvlY32Vev7hqbvG8ubu1uXw/OaiYOkgieZxiZflM0sYtj0DhgMNH8NnVu9ICSSwxlm
         B4DDQHPZktbqAvgi2wqaKnqdxd5VnG7aye4f5S3pkrUPAuKZOQV7IA5mp3dG3N5M+oxZ
         mwkA==
X-Gm-Message-State: AOAM533AuewccRy7rEeArssbrGIGc9YOK+9E64Nzt1JW3NUQmGz3h81w
        eX/cyjTIGwF3b4m67aiuVxJwfYuIZJrC95B87r7SmEmw6+hJ2RusA24aKJAdsuVYHFS16mPu8g+
        5HK38XloSfFXOQaYon2JbcQ==
X-Received: by 2002:aa7:cf0d:: with SMTP id a13mr5826449edy.384.1623930370623;
        Thu, 17 Jun 2021 04:46:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGp0u6bbKTpBWAweRlzIakuy+NTS2L7DG9uaEaAYNed1OyNxc+QE79jbRlb3hr0uHlxKTUpw==
X-Received: by 2002:aa7:cf0d:: with SMTP id a13mr5826434edy.384.1623930370434;
        Thu, 17 Jun 2021 04:46:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t14sm1472804edr.36.2021.06.17.04.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 04:46:09 -0700 (PDT)
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
 <YMrkGZzPrt0jA1iP@kroah.com>
 <0d959828-da89-bceb-f7cc-35622a60c431@redhat.com>
 <YMs1Pwf+nSQsfVUW@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <348aa108-076b-04dd-9fd2-e840a7a85f5d@redhat.com>
Date:   Thu, 17 Jun 2021 13:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMs1Pwf+nSQsfVUW@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/06/21 13:42, Greg KH wrote:
> On Thu, Jun 17, 2021 at 01:29:22PM +0200, Paolo Bonzini wrote:
>> On 17/06/21 07:56, Greg KH wrote:
>>> On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
>>>> +string starts at the end of ``struct kvm_stats_desc``.
>>>> +The maximum length (including trailing '\0') is indicated by ``name_size``
>>>> +in ``struct kvm_stats_header``.
>>>
>>> I thought we were replacing [0] arrays with [], are you sure you should
>>> be declaring this as [0]?  Same for all structures in this document (and
>>> code).
>>
>> In C code [0] is a bit more flexible than [].  I think in this particular
>> case [] won't work due to how the structures are declared. In the
>> documentation [] is certainly clearer.
> 
> Look at all of the patches that Gustavo has been doing all over the tree
> for this work, you do not want to make him do this again here.
> 
> Gustavo, is [0] ok for fields like these?

I should be able to get back to KVM stuff later today, I'll check myself 
if [] can be applied and reply.  I had queued an early version of these 
for my local build to play with them but I haven't been able to do a 
complete review.

Paolo


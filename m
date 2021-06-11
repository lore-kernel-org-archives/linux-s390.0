Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B593FC48BD1
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 12:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960EF613CD
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 12:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFKMGH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 08:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231420AbhFKMGE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Jun 2021 08:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623413046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJDmCGSzSoN+SjlCljTi/drpSsUmCLU82T+0nPdBIYI=;
        b=QRS9kZ27PpeWh3COWmFcpV2kCZVJZCvmbpw3mCxHa1NBiUv8rUGk4usKEHfqmqoS3l9ghM
        Qw2pdE6qsHoCilReOhuH5KDb8v2m1tyGK2NJUHJ9mLcmVBtbxCu3savKG+sGf5k2NMfwtr
        LEHjxktf/tf6pSLL35VaMQh2Aa6s19M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-TZbQ7NH7M72lSSeyAodGtw-1; Fri, 11 Jun 2021 08:04:03 -0400
X-MC-Unique: TZbQ7NH7M72lSSeyAodGtw-1
Received: by mail-wm1-f72.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso4355872wmf.8
        for <linux-s390@vger.kernel.org>; Fri, 11 Jun 2021 05:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJDmCGSzSoN+SjlCljTi/drpSsUmCLU82T+0nPdBIYI=;
        b=I9QO/JxzUo3acfsE43JLdFPZ2WmbDiI36IkAVIU6tOSNuiBYnmcrG3AR0YO2J6u3Mc
         vTI9oPmhhBSTNUhz6ihLaZYPtS/LhA/HbGGngMKCBtmVMXmOnGfjnwg7igaI160WR/Hk
         ZNJIxklBZIPomTWpMNgQm89LFWPavTO+k3GYaGIdZh4Z78nmvYnawP6ZJDUO1Uf5I2dw
         AMjzJW/WzsBF6aH4IbE9CcR5Nt7Nxn51laoMd7vh8dSCuo72I23JQXUBMnk2hGUxVQoY
         Een91s80kgMJgDzaI8h526uB8/TJKvBkscO+UpdBQSJytT2ocjoTgghzTN1d8hbsP9MX
         1esQ==
X-Gm-Message-State: AOAM530HsuZhZmonjvd9cckhGcFv3E+E+xLGPZjfOqqcrgZLm6YihyR4
        5+oE1aP3UcJJbMGrNHZnLm3nXBBvUwZnL8PfJ12mDttQ7woEnVOE1pXpl+UIZcVPLVJpSV9UTIs
        R/C5Dg/yyMvTr3f7kRJFUPg==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr3607777wmh.21.1623413042162;
        Fri, 11 Jun 2021 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG2XIC2YxHXVTDi+gO8yJwV9JxmgIYE7VFZU1/ddoPOqjwHeITDdMBlqBjpf4Ks7p+wpwf+g==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr3607733wmh.21.1623413041887;
        Fri, 11 Jun 2021 05:04:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o20sm11859481wms.3.2021.06.11.05.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 05:04:01 -0700 (PDT)
Subject: Re: [PATCH v7 1/4] KVM: stats: Separate generic stats from
 architecture specific ones
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-2-jingzhangos@google.com>
 <03f3fa03-6f61-7864-4867-3dc332a9d6f3@de.ibm.com>
 <bdd315f7-0615-af69-90c3-1e5646f3e259@redhat.com>
 <c0173386-0c37-73c0-736a-e904636b6c94@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5199e63-762d-a731-7ef2-c2af3a8cb0c3@redhat.com>
Date:   Fri, 11 Jun 2021 14:03:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c0173386-0c37-73c0-736a-e904636b6c94@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/06/21 14:00, Christian Borntraeger wrote:
> What is the semantics of remote_tlb_flush?

I always interpreted it as "number of times the KVM page table 
management code needed other CPUs to learn about new page tables". 
Whether the broadcast is done in software or hardware shouldn't matter; 
either way I suppose there is still some traffic on the bus involved.

ARM is also not updating the stat, I'll send a patch for that.

Paolo

> For the host:
> We usually do not do remote TLB flushes in the "IPI with a flush 
> executed on the remote CPU" sense.
> We do have instructions that invalidates table entries and it will take 
> care of remote TLBs as well (IPTE and IDTE and CRDTE).
> This is nice, but on the other side an operating system MUST use these 
> instruction if the page table might be in use by any CPU. If not, you 
> can get a delayed access exception machine check if the hardware detect 
> a TLB/page table incosistency.
> Only if you can guarantee that nobody has this page table attached you 
> can also use a normal store + tlb flush instruction.
> 
> For the guest (and I guess thats what we care about here?) TLB flushes 
> are almost completely handled by hardware. There is only the set prefix 
> instruction that is handled by KVM and this flushes the cpu local cache.


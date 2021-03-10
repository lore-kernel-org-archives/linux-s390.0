Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1222AC433E6
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 16:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6F464EFC
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 16:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCJQD5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Mar 2021 11:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231366AbhCJQDs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Mar 2021 11:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615392228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6LZWP2vn4gZYNN60dpd9pTIeb1KCd0er7xtszZkk6U=;
        b=bhKXKhxw+ZSn/71Tksjz1NmcU1+mwOomex78JYC/oYUjKLGc3teEQ8M2d+jR61pb6M2IGb
        OoWJjeBzLF/a5NOAqjYcvbSH26haJKbdVJR9rJVHIUIB+LHW09EOoahiJZU6YRlQFmhM5C
        VVnJ/7symILjjKRlE4F0qBcEISc1YSQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-86Mrjk_ZObq94m_CJoSnRA-1; Wed, 10 Mar 2021 11:03:46 -0500
X-MC-Unique: 86Mrjk_ZObq94m_CJoSnRA-1
Received: by mail-ed1-f71.google.com with SMTP id w18so5802272edu.5
        for <linux-s390@vger.kernel.org>; Wed, 10 Mar 2021 08:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T6LZWP2vn4gZYNN60dpd9pTIeb1KCd0er7xtszZkk6U=;
        b=M6Kn7Jd6dGLC5g0Lt5ylXJZhuVCkJm94obTR0T+tVKi9Q0lZ2b7yPOLMuwaftQkJM7
         uttx2QkcceQhmIw39fmuUDQoBImKONH5mh/0NtIlaERskvKioL96rHISS6W/eLxOP1bS
         GOdjrLNep2ygUnOms4G78ixF6O1a87dBCyq+29xmHDqwAOM2hTWSv7qPuaaaCRF2j78c
         8EK+srWfz8wbdqUAhd7XlU7Ll2CqJv8a2yP8HXYaftBb6TTtBM4IFssfbxelD4COgw/P
         fwAZnVNvKAkcReixO/4qZOS1eihKuVgs10qj2BZ/PH8GV6G9abJRZ/FjvGDYYBllrHWE
         wP9A==
X-Gm-Message-State: AOAM530zt04H8MBrLmfVgTFcxwxjrlzddKzQX2gkZGU7tv2uIN3RowWT
        6YVwZo6Wp2IswHKi4f7BItZzYNXOgMCllnD5pjJeVWnaoH3u9u9fAjPd2nnq3j6OFYeerwBVM95
        PSG/CQ/XplDXYyCmNq7drYQ==
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr4365533ejb.445.1615392225074;
        Wed, 10 Mar 2021 08:03:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1V5iKaTO/Dprgp6gE22d8iEwpMy8ZGDfQA++8bp2mD+TtXAT0OFzpxwvgV6mj5ydH3tp6rw==
X-Received: by 2002:a17:906:c0c8:: with SMTP id bn8mr4365501ejb.445.1615392224882;
        Wed, 10 Mar 2021 08:03:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k9sm8884545edn.68.2021.03.10.08.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 08:03:44 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] KVM: stats: Add ioctl commands to pull statistics
 in binary format
To:     Marc Zyngier <maz@kernel.org>, Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
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
 <875z1zxb11.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a475d935-e404-93dd-4c6d-a5f8038d8f4d@redhat.com>
Date:   Wed, 10 Mar 2021 17:03:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <875z1zxb11.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/03/21 16:51, Marc Zyngier wrote:
>> +	kvm_for_each_vcpu(j, vcpu, kvm) {
>> +		pdata = data + VM_STAT_COUNT;
>> +		for (i = 0; i < VCPU_STAT_COUNT; i++, pdata++)
>> +			*pdata += *((u64 *)&vcpu->stat + i);
> Do you really need the in-kernel copy? Why not directly organise the
> data structures in a way that would allow a bulk copy using
> copy_to_user()?

The result is built by summing per-vCPU counters, so that the counter 
updates are fast and do not require a lock.  So consistency basically 
cannot be guaranteed.

Paolo


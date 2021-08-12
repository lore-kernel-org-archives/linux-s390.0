Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8635FC432BE
	for <linux-s390@archiver.kernel.org>; Thu, 12 Aug 2021 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF5D60D07
	for <linux-s390@archiver.kernel.org>; Thu, 12 Aug 2021 15:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhHLPlx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 Aug 2021 11:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237792AbhHLPlx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Aug 2021 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628782887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVAySSNkRIQjjk+QH2YkijF+uGWoxw5I4DLvZClTw1U=;
        b=D134bOSUHTTA0PBGBrfxeua3cjVaITA/aBeygqqG9zTT1sBhyUKi2w0KPInxk3bKwqOzda
        u1EV3dEohJvWbbo8vwT6klqVzAk0hvI/pwYaAxSyJm/zBxIB/ODa88m6P0j4NYOD9d2vrb
        uM+rN2JHSIrzqz2iA+75RisxeW/qbCg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-paCbPDOsPemL6gGMHp8l0w-1; Thu, 12 Aug 2021 11:41:26 -0400
X-MC-Unique: paCbPDOsPemL6gGMHp8l0w-1
Received: by mail-ej1-f71.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso1973957ejc.22
        for <linux-s390@vger.kernel.org>; Thu, 12 Aug 2021 08:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wVAySSNkRIQjjk+QH2YkijF+uGWoxw5I4DLvZClTw1U=;
        b=o53FPRYJCttsQNqeI/asEkVqBPGSaHmARzPepN0idxk0+orrSlQ2G87maZUMRkY7hF
         n84LyD7Tw0tu+UPSCulGJo+WuX7V/sN+6PbPxX6pbJNDnTJa2g27T5aRD8wXuK7PF2Sj
         KnRF9J+gXC22Rfrgq7lBRlBKJVzQf/CbUolwZl4oT5/LswK1MmI4yUsz5RDyPcqsSEKl
         0w6kGZTo36FrUyEANBc53DmDCzK1YzEklvfz41TQ10dr200NdlGm1jSlwdcHGzlTnNEg
         U6Y3KrQgHV79AfD8rhDKf86F2SZBEsCRjY5gtscClisq+FJfsZ9mVixvSip3y+reQvcS
         1Rlg==
X-Gm-Message-State: AOAM530BMKJnEti96fA3doSYWJ/FuaXS+fFDYggaCKkAniUerRH61tKY
        mFo4o+GzcDrQVUlBYtzVjTuU9NSUWM2BgAX+g+aJ+LBI5sbmSL403poqjnKzBwenlIVXeeOaJhR
        e/PkVs+lUnd2/wsAR9H1N90TiBsYZcjzGOKbInmOHgBClVi4PEa9MnaXMInNJFKTpQKOEP+hwTQ
        ==
X-Received: by 2002:a50:ef11:: with SMTP id m17mr6095928eds.233.1628782885080;
        Thu, 12 Aug 2021 08:41:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbkauFimraFjcUcxW/s5naeDzEHblJnwTGW5kN8SFMxVNVXXtWI2AkXQ1TgeG7maJbDTkRTw==
X-Received: by 2002:a50:ef11:: with SMTP id m17mr6095860eds.233.1628782884809;
        Thu, 12 Aug 2021 08:41:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s18sm988134ejh.12.2021.08.12.08.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:41:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] KVM: Refactor kvm_arch_vcpu_fault() to return a
 struct page pointer
To:     David Hildenbrand <david@redhat.com>,
        Hou Wenlong <houwenlong93@linux.alibaba.com>,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <YRQcZqCWwVH8bCGc@google.com>
 <1c510b24fc1d7cbae8aa4b69c0799ebd32e65b82.1628739116.git.houwenlong93@linux.alibaba.com>
 <98adbd3c-ec6f-5689-1686-2a8a7909951a@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d29447d4-a1b4-7f12-7bbc-8dc24cb38b72@redhat.com>
Date:   Thu, 12 Aug 2021 17:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <98adbd3c-ec6f-5689-1686-2a8a7909951a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/08/21 11:04, David Hildenbrand wrote:
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> But at the same time I wonder if we should just get rid of 
> CONFIG_KVM_S390_UCONTROL and consequently kvm_arch_vcpu_fault().
> 
> In practice CONFIG_KVM_S390_UCONTROL, is never enabled in any reasonable 
> kernel build and consequently it's never tested; further, exposing the 
> sie_block to user space allows user space to generate random SIE 
> validity intercepts.
> 
> CONFIG_KVM_S390_UCONTROL feels like something that should just be 
> maintained out of tree by someone who really needs to hack deep into hw 
> virtualization for testing purposes etc.

I have no preference either way.  It should definitely have selftests, 
but in x86 land there are some features that are not covered by QEMU and 
were nevertheless accepted upstream with selftests.

Paolo


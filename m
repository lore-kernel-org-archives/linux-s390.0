Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25592C3DA79
	for <linux-s390@archiver.kernel.org>; Thu, 29 Dec 2022 20:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiL2UxM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiL2UxL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Dec 2022 15:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD3B4BA
        for <linux-s390@vger.kernel.org>; Thu, 29 Dec 2022 12:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672347148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DeG05ASAQvY/FceYSGJdKCGQ3OFwx25lz4jlpRPWbnU=;
        b=CyydvGwzPP3fLVYWpVliXmXQqCrkO5vFWqD2G/eF6WnvrzLE9bE4odPOFEByCJPXx1zK7N
        3CW4NLlm4xL0AqHnTqMhsk9cWBJ6Uuhsic1loBCpqEVeOVsFEOTwngBg+tn14ERoLM33Ac
        yUygSuFg7+aLVxGsIqRVpizKmEoGM14=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-gWqlI88BMJy9rdxm8PCrYA-1; Thu, 29 Dec 2022 15:52:27 -0500
X-MC-Unique: gWqlI88BMJy9rdxm8PCrYA-1
Received: by mail-ed1-f69.google.com with SMTP id v4-20020a056402348400b0046cbbc786bdso13344858edc.7
        for <linux-s390@vger.kernel.org>; Thu, 29 Dec 2022 12:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeG05ASAQvY/FceYSGJdKCGQ3OFwx25lz4jlpRPWbnU=;
        b=UsgAfE8sG1igRNvmgUxtIvEDUeNDiLxL2ipaJdf/W++nX+Xt6E48sgUcuJ8A7MF8dW
         M7dE3eT/RQyKCBn5ZzZm/7oww2+o6Nh1M17n9fsLf/H8JuHMtGzCP65+gj06+70RL9OV
         OvAxhHsbtxLUpfSI/9WaE/jgT9S+vOnbzg0WzLVON8Zrc565edgDulSbRpjYoSN6VCZ0
         NUp4xVXjsyy33XBSxAkbQdJ91ZMpxRBhdZrMNc5r0AbSoBcP6TImEMbtn+B5Sa7NedPU
         tC3c0gN5POsRJR1mneKK68tUBgs6RepATXg+ChTNUpc/m/VZJwyG+fPc/6mq6keTubJn
         f50Q==
X-Gm-Message-State: AFqh2kov1dr3KaKXW8b351IsexxAI3+Z7387o7vzobaeUv7NRmY2Cpko
        1cbrQvIlBNnmdmxih+V+8mi2CakoSe3p3xXdXl80zr+PwiY9VIHWKkLcrCT7zdTuonMAlV0kNYM
        Zl9A5pWVKmUPmzM68ZQvZrA==
X-Received: by 2002:a17:907:6f09:b0:7c1:37:6d5e with SMTP id sy9-20020a1709076f0900b007c100376d5emr4872270ejc.2.1672347146329;
        Thu, 29 Dec 2022 12:52:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuAZx8SHyajJmJ++QT23AGJAvs5IxosEfN11APvih7Pbj5KPIpkonmPHiwyMLfqMEbO8Dqn3Q==
X-Received: by 2002:a17:907:6f09:b0:7c1:37:6d5e with SMTP id sy9-20020a1709076f0900b007c100376d5emr4872244ejc.2.1672347146101;
        Thu, 29 Dec 2022 12:52:26 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::529? ([2001:b07:6468:f312::529])
        by smtp.googlemail.com with ESMTPSA id 23-20020a170906301700b0084c90164a56sm1096571ejz.29.2022.12.29.12.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:52:25 -0800 (PST)
Message-ID: <4d73d1b9-2c28-ab6a-2963-579bcc7a9e67@redhat.com>
Date:   Thu, 29 Dec 2022 21:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 00/50] KVM: Rework kvm_init() and hardware enabling
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221227130249.1650197-1-pbonzini@redhat.com>
 <9acea262dec3511e9cf63081506f0bd7@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9acea262dec3511e9cf63081506f0bd7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/28/22 12:22, Marc Zyngier wrote:
> 
>> Queued, thanks.  I will leave this in kvm/queue after testing everything
>> else and moving it to kvm/next; this way, we can wait for test results
>> on other architectures.
> 
> Can you please make this a topic branch, and if possible based
> on a released -rc? It would make it a lot easier for everyone.

This is now refs/heads/kvm-hw-enable-refactor in 
https://git.kernel.org/pub/scm/virt/kvm/kvm.git.

The commits for this series start at hash fc471e831016.

Paolo


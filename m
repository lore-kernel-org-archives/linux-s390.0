Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43CDC4332F
	for <linux-s390@archiver.kernel.org>; Thu,  3 Nov 2022 07:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiKCHUS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 3 Nov 2022 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiKCHUN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 03:20:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D61F6405
        for <linux-s390@vger.kernel.org>; Thu,  3 Nov 2022 00:20:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cl5so1279956wrb.9
        for <linux-s390@vger.kernel.org>; Thu, 03 Nov 2022 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWamQQEiXwuUaXnbl6PlP555HrcaEY3+l7Gw0jB534c=;
        b=eMrmoHwsidAITYv+vZDTWUffj0xdVr6f9Irj4fYthgmDb2BtaKGEsFELQu2H6bnkWP
         kvYw40kYqV8j7+KID6Jv8TSwG2Jdrk3L2i6NZZnW1qKtWYQv3oDxv2zGF+cGC9qJEynl
         Q3HGYurZ4Dh8OnDMCMVGhftsWYYclQysAxS0McddFHROl75oHtCo1tssLi3inAUUaVcx
         fUR6nDRn+ryNrHgMilhwWNuUUGNT/fA+7xVLj81AQOwbU9CL+I5tsAtyXoOgw2iEFCeq
         61/G+FvjBXJZUKkwTCZRxbrU1QIQmLSBOvOReMSizUzMvu13QKzBhMJ0mgPECH0jRV1d
         jpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWamQQEiXwuUaXnbl6PlP555HrcaEY3+l7Gw0jB534c=;
        b=7W3nvSI6xyRA0fLX96bCjlqbDKi7mWduZkk+lyuPKakTXPEh/MWYOYBsHI9FvM5Sj3
         by+PK2ufNu7XSQruESOnyrDcYpkKpev4VpQdXDGwPdkoQZDZ8Bc9vO0b4Ds88MeLJMTb
         Q9xftx30DdQaUJzc2pR8qqABTLWRCATF7k/afKR5TIt0SS9Vzhkd49h9p73kbNXWxHq0
         DDI+hnxkVJtH8UT5dor9jRuJIGTW7kHkiifeXHGTyk7SZIgqtfzGiHRSR/e8xXkWzJrF
         Bq028VuyEX9X94JmAFmqbkQKXeiVsn8I7IUAtuj6AwXVgd34I581BC14qPzc0YIsXQQr
         BKZQ==
X-Gm-Message-State: ACrzQf1V0GSRdYXQEwdV5EJBJH3Wi2bV4zdYT5CDzSIAc6go9zplmGse
        f7aiXR3kYjlCZn0krGBFhvXwOQ==
X-Google-Smtp-Source: AMsMyM6CSjH/RTBpmDd/QhMZZkOx7oc3nNeJrTJLnMoKwCsW0evNR4jvL0bJpuI6uqT433DOly9rxA==
X-Received: by 2002:a5d:5744:0:b0:236:5c21:177f with SMTP id q4-20020a5d5744000000b002365c21177fmr17331121wrw.449.1667460007685;
        Thu, 03 Nov 2022 00:20:07 -0700 (PDT)
Received: from [192.168.11.175] (216.red-88-29-181.dynamicip.rima-tde.net. [88.29.181.216])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b003cf57329221sm5884991wmb.14.2022.11.03.00.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 00:20:07 -0700 (PDT)
Message-ID: <3a2d1d5e-b105-11ed-413b-4ad2dbba058e@linaro.org>
Date:   Thu, 3 Nov 2022 08:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 30/44] KVM: Drop kvm_arch_check_processor_compat() hook
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-31-seanjc@google.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221102231911.3107438-31-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 3/11/22 00:18, Sean Christopherson wrote:
> Drop kvm_arch_check_processor_compat() and its support code now that all
> architecture implementations are nops.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/arm64/kvm/arm.c       |  7 +------
>   arch/mips/kvm/mips.c       |  7 +------
>   arch/powerpc/kvm/book3s.c  |  2 +-
>   arch/powerpc/kvm/e500.c    |  2 +-
>   arch/powerpc/kvm/e500mc.c  |  2 +-
>   arch/powerpc/kvm/powerpc.c |  5 -----
>   arch/riscv/kvm/main.c      |  7 +------
>   arch/s390/kvm/kvm-s390.c   |  7 +------
>   arch/x86/kvm/svm/svm.c     |  4 ++--
>   arch/x86/kvm/vmx/vmx.c     |  4 ++--
>   arch/x86/kvm/x86.c         |  5 -----
>   include/linux/kvm_host.h   |  4 +---
>   virt/kvm/kvm_main.c        | 24 +-----------------------
>   13 files changed, 13 insertions(+), 67 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


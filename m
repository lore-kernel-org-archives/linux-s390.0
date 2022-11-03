Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307B4C4332F
	for <linux-s390@archiver.kernel.org>; Thu,  3 Nov 2022 14:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiKCOEB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiKCODc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 10:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CC1759F
        for <linux-s390@vger.kernel.org>; Thu,  3 Nov 2022 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gp3ZE1TCS6qUf/W2wfyFuvz85/MTtwzsFfwWgQFj3ps=;
        b=dh5KjP84J/0HXiAK63MsJRSA8YFlBEw8pNy/YxaPV3Dg4QeF2tKsEPFvZRKZXZO3ZFTBDK
        Tuk3TZHRxiXACi6QJRfYWxpDOEwHwyOsAgWe12MjXnVtI24JWplM27DfI30Ck7KctT1G95
        3yc430Mw8QOB543h9Ns8FzKPxELRlMc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-JSaPzdaHMIyEk4glDvRq-g-1; Thu, 03 Nov 2022 10:01:32 -0400
X-MC-Unique: JSaPzdaHMIyEk4glDvRq-g-1
Received: by mail-ej1-f70.google.com with SMTP id hc43-20020a17090716ab00b0078e28567ffbso1311230ejc.15
        for <linux-s390@vger.kernel.org>; Thu, 03 Nov 2022 07:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp3ZE1TCS6qUf/W2wfyFuvz85/MTtwzsFfwWgQFj3ps=;
        b=RBLarXmIUyiXwUGObkGhopY2rss5bty7uCwQOk5B76rv0J2Tj08PWrTYf1sNIKWaNy
         V0ZhEKVrY96kZeTnqZs86oO8GOQ/74hPXcphMqiGice+xcn+BSMNPE9BoZrVAhNtv9wZ
         aH6CJQDwQktbLEBxe8ZbrV998pZHuv3zgYdG6yRl4nUMXYDBS/jWI8SC9ZD7q8ufA1To
         gjHP0hDdl4bxQNLsLn7MdNUrQYm27/GjKB4Ecbt+LroCb6HNsdohlFle6yiIosEjTrYl
         6w4riQhg9ERFlGQFu0+ZjkHcLLd1axIs0jBpOBJJw1RoAn8jrIYXvp6q5385GHo9P/BS
         EqbQ==
X-Gm-Message-State: ACrzQf3tnsmUUcJ+AownqhtNqTn3i77fNj/R78YjNtuYAJVfNBXRN+6C
        XADZHQFB60D122dO+2G/vZT9jWy/ist+O7O1V7ngRXaqB/I8+6OOjwEa1+PgJZjj1oDpHH69ZjI
        A/RAM1eeouJaEr4afWWKNrw==
X-Received: by 2002:a17:907:7e9e:b0:7ad:bc80:c003 with SMTP id qb30-20020a1709077e9e00b007adbc80c003mr25375209ejc.198.1667484090921;
        Thu, 03 Nov 2022 07:01:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM573p4EUrag9CU7KGeV5DPwqVdO4hG3cdn9PAejBOFdAvPNF2Pfj2lgSHDnk+0puoAwMgBkew==
X-Received: by 2002:a17:907:7e9e:b0:7ad:bc80:c003 with SMTP id qb30-20020a1709077e9e00b007adbc80c003mr25374580ejc.198.1667484084861;
        Thu, 03 Nov 2022 07:01:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id a7-20020a17090640c700b007305d408b3dsm532188ejk.78.2022.11.03.07.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:01:23 -0700 (PDT)
Message-ID: <d641088f-87d9-da77-7e98-92d1a9de6493@redhat.com>
Date:   Thu, 3 Nov 2022 15:01:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 10/44] KVM: VMX: Clean up eVMCS enabling if KVM
 initialization fails
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
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
 <20221102231911.3107438-11-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221102231911.3107438-11-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/3/22 00:18, Sean Christopherson wrote:
> +static void hv_cleanup_evmcs(void)

This needs to be __init.

Paolo


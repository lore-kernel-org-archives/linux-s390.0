Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25FAC4332F
	for <linux-s390@archiver.kernel.org>; Thu, 10 Nov 2022 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiKJQu6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiKJQuj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Nov 2022 11:50:39 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6BA195
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 08:50:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k22so2722648pfd.3
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 08:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngpTqFXA20Qov7vlYrPcJjUI8sUR/quxgJrGzBa7LTQ=;
        b=dFHHoN/Nh+VXrE9JsY3e3+fkRaRAvb1aGnzgeGfgDdwTgSMupLwM8ROA3+W4pYGjY0
         5rtK6lElI+DgF0DyaiLvpiaAorCWCegKieghDDMY6o0ECE7iPV/tCP64EmRRyb1QKnLg
         h1cjN79kb5l9jgix2MCBmxfqZYQuwhlkODvDz7ZvaH4sxe61Ml97iSmSMtvAoCeE4p6S
         zdFuv8u4MZbd4uwMLlGMYvkNsSjoXRG5kz2GxfEgOPys7+fCqRAsVr0dupEjPva4LkLJ
         QEyjxBRtbWEN1lQAedlvI4TNbWVV6gyxLgVr0x17HRSOYZcACGBuRj0/yzFNApiBrJr+
         O6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngpTqFXA20Qov7vlYrPcJjUI8sUR/quxgJrGzBa7LTQ=;
        b=xq91SOuZYTQ1sUpoSdOfFZrOIi5LEbuwbgUXw36Ju4K2qIjaEqarTplTlbMXyWnnOf
         3soKHCPLN28KzoExiAo2Rc8++goAzUm5kw8SMqj/+zMn6lgVrFrHL2hfBLJHk8lxkakI
         y0eGLUP2fA4tHd1WTOdEYc/hzG3dDFkc/hDEbpkndA/Se2H8h0/U4aFNxh51u3IQ48rb
         oXDghK48lwsUHtikjmuMsXWH41u5FvbhjHHgpm/hJHw69PKIwhbDxF7qedO0fqAxOxEn
         ngkn6LTqx+B8tqI+PqIDEoGo8nhNKg2yfEWBY7oopPYjGPhi00xtqXuulgWzGHZRMZhX
         LMqw==
X-Gm-Message-State: ACrzQf2qdXJ3SCm/6tes8bjt/ab161xbn8znEWznaeZjjzWvOtCjxhh6
        Rbh9+bp6HLMZLoRObWx20fz7Ug==
X-Google-Smtp-Source: AMsMyM41GjMawKBCP5Kop4vnrwekEGW/LOSR6lYqiErYbTmquFxjglLK4Ryhg/mdPPwnXrGhT3xNoQ==
X-Received: by 2002:aa7:8d08:0:b0:56b:a4f6:e030 with SMTP id j8-20020aa78d08000000b0056ba4f6e030mr3031241pfe.85.1668099036440;
        Thu, 10 Nov 2022 08:50:36 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b00186f81bb3f0sm11518667plx.122.2022.11.10.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:50:35 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:50:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Robert Hoo <robert.hu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
        James Morse <james.morse@arm.com>,
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
Subject: Re: [PATCH 32/44] KVM: x86: Unify pr_fmt to use module name for all
 KVM modules
Message-ID: <Y20r2NR9MaBbOGLn@google.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-33-seanjc@google.com>
 <ff0e8701d02ee161d064f92c8b742c2cc061bce0.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0e8701d02ee161d064f92c8b742c2cc061bce0.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 10, 2022, Robert Hoo wrote:
> After this patch set, still find some printk()s left in arch/x86/kvm/*,
> consider clean all of them up?

Hmm, yeah, I suppose at this point it makes sense to tack on a patch to clean
them up.

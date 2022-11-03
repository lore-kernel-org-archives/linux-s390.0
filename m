Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81785C433FE
	for <linux-s390@archiver.kernel.org>; Thu,  3 Nov 2022 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKCR6z (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiKCR6y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 13:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2C1B9F2
        for <linux-s390@vger.kernel.org>; Thu,  3 Nov 2022 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667498283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqxXm7t2WOic9y4ISYxOwK8KmYTr1cBIHzcg/Vydbzs=;
        b=jWZhqk8Op8xpXKAf/bD9sAMgGMuTwu77yjU+nJdXulwU4p/Bfp6uw+TcRz7WB71gAZvASb
        xezkYofgI8ZsVM5gbZ0j+wpUAv+gawAp797zb9ETmY4AU7jgzuPzDBRg4Sk4Qjyj/2W2Hp
        cNkIKN7w1FI5U5aIlp+PMpdAlVEifUw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-I4OftvqDNcqp0hd-3wMqFw-1; Thu, 03 Nov 2022 13:58:01 -0400
X-MC-Unique: I4OftvqDNcqp0hd-3wMqFw-1
Received: by mail-ed1-f70.google.com with SMTP id z15-20020a05640240cf00b00461b253c220so1906283edb.3
        for <linux-s390@vger.kernel.org>; Thu, 03 Nov 2022 10:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqxXm7t2WOic9y4ISYxOwK8KmYTr1cBIHzcg/Vydbzs=;
        b=1UT35mIoFuWEmNMqgpZ4XWY5yfnD9liGTor6WtsVMHQ3Rh6boHcjP783YCP+vgVRTT
         cqh0zp/dbMsSMwHvP9fzqCvJ1uEP+f1amHI/0JwPz3j7VajbotjUT4vYWNu7nBfd0ySZ
         O5NKiwaUPX+t5L7b+wbou04IVCAad4PuKXdK/vu7TpKbX4YLE3BnJgluD+CoG5fll0ra
         22+NsOOiVqIokSdtpc6zNvxkjIWtjjt3cxAQx8hqjWj7zBFHKR7s00LK7SDDEp0wF6C/
         UuJ/xoLA8A83wh8Fo2nJFDx2E4eO8oJDRWjkzHnpy/fx+F0XPA1UJ71mxXsAb8T0JRzV
         n0hA==
X-Gm-Message-State: ACrzQf0qz3Ol8YUyl9xpSZK5TM6yDslJJvDkpiKs4gATzZ6ycHttEzHw
        NLhDS1FWKvGMtDB+35jMAweERXZMfL7NG4yE6h+Wdl/T6EbfsorkjJEk5kRyLluQdl/o55T/XjG
        dwbpVh96qo2T9SpAG3IA8MA==
X-Received: by 2002:a17:907:a087:b0:7ad:a2ec:1afa with SMTP id hu7-20020a170907a08700b007ada2ec1afamr30061858ejc.151.1667498280032;
        Thu, 03 Nov 2022 10:58:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6QZmNq5hCph1jlllZl0PdTQdpFjKynjhfU4TqqXsTy2ri356CZrCrEtJkVH+I+gMfL+O9fNA==
X-Received: by 2002:a17:907:a087:b0:7ad:a2ec:1afa with SMTP id hu7-20020a170907a08700b007ada2ec1afamr30061831ejc.151.1667498279805;
        Thu, 03 Nov 2022 10:57:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id l3-20020a170907914300b0078d76ee7543sm734215ejs.222.2022.11.03.10.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:57:58 -0700 (PDT)
Message-ID: <1fd2e729-6e46-b0bf-d89e-f5d1b4dbde77@redhat.com>
Date:   Thu, 3 Nov 2022 18:57:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 36/44] KVM: x86: Do compatibility checks when onlining CPU
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
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
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-37-seanjc@google.com>
 <23bfd709-f99a-5a74-e4b9-1381b88453f1@redhat.com>
 <Y2P+E+631c0TNcK7@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y2P+E+631c0TNcK7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/3/22 18:44, Sean Christopherson wrote:
>>> Do compatibility checks when enabling hardware to effectively add
>>> compatibility checks when onlining a CPU.  Abort enabling, i.e. the
>>> online process, if the (hotplugged) CPU is incompatible with the known
>>> good setup.
>>
>> This paragraph is not true with this patch being before "KVM: Rename and
>> move CPUHP_AP_KVM_STARTING to ONLINE section".
>
> Argh, good eyes.  Getting the ordering correct in this series has been quite the
> struggle.  Assuming there are no subtle dependencies between x86 and common KVM,
> the ordering should be something like this:

It's not a problem to keep the ordering in this v1, just fix the commit 
message like "Do compatibility checks when enabling hardware to 
effectively add compatibility checks on CPU hotplug.  For now KVM is 
using a STARTING hook, which makes it impossible to abort the hotplug if 
the new CPU is incompatible with the known good setup; switching to an 
ONLINE hook will fix this."

Paolo

>    KVM: Opt out of generic hardware enabling on s390 and PPC
>    KVM: Register syscore (suspend/resume) ops early in kvm_init()
>    KVM: x86: Do compatibility checks when onlining CPU
>    KVM: SVM: Check for SVM support in CPU compatibility checks
>    KVM: VMX: Shuffle support checks and hardware enabling code around
>    KVM: x86: Do VMX/SVM support checks directly in vendor code
>    KVM: x86: Unify pr_fmt to use module name for all KVM modules
>    KVM: x86: Use KBUILD_MODNAME to specify vendor module name
>    KVM: Make hardware_enable_failed a local variable in the "enable all" path
>    KVM: Use a per-CPU variable to track which CPUs have enabled virtualization
>    KVM: Remove on_each_cpu(hardware_disable_nolock) in kvm_exit()
>    KVM: Drop kvm_count_lock and instead protect kvm_usage_count with kvm_lock
>    KVM: Disable CPU hotplug during hardware enabling
>    KVM: Rename and move CPUHP_AP_KVM_STARTING to ONLINE section
>    KVM: Drop kvm_arch_check_processor_compat() hook
> 


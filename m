Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D5C3DA7A
	for <linux-s390@archiver.kernel.org>; Wed, 28 Dec 2022 12:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiL1MAE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Dec 2022 07:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiL1L7b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Dec 2022 06:59:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E011466
        for <linux-s390@vger.kernel.org>; Wed, 28 Dec 2022 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672228721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYdiyUW7v3jDVb1QwzZWNab9jTsMpMxmysun3BoXT8E=;
        b=BUmrbtzLHXKgoS2cqq0PXGvKWAC5e997bHYtEwEZOPPY6zk7DsT/+SPsXE6A6fPtiiXYhA
        uyHReXcNu9XqL42bARoWjCMgaenQqa8jNDHYzG9cijSu0VK/eSeq7ZmFHbXk8Cha1R6yly
        zEs0Zs6zSvzH6xkrIgVz+EL76A54CIw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-cZ7LkFTYNtuJ_1g7njptDQ-1; Wed, 28 Dec 2022 06:58:39 -0500
X-MC-Unique: cZ7LkFTYNtuJ_1g7njptDQ-1
Received: by mail-ed1-f72.google.com with SMTP id h18-20020a05640250d200b004758e655ebeso10970832edb.11
        for <linux-s390@vger.kernel.org>; Wed, 28 Dec 2022 03:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYdiyUW7v3jDVb1QwzZWNab9jTsMpMxmysun3BoXT8E=;
        b=uPzNL6Ms05lkVpjqUnP/7mvmRitgna0Tpun7oynjskSVwfK5YcIJR7fCKLw5DglJu2
         q+l5qqo3XlVuKgT8HkTk4BCYUOyoPjWswpf8eQAeRxzED20dWKCtJg1wJOhC5iT9UO2z
         hez+WBPwoLAnTqNnzpaLcYhAAhURToeuOTq4jVUR4sGATKGsueRYoeL2AStwYiSjMtvD
         uojor4lvSNUtnc0HBgolgiVz6qrBJewm/GSW1vMQ3w+n3jWpedhcjhJjzwdMXWRx/ZZR
         s2+A9qRWK44Sh2W6P0kpL4GruORYbSePQlVEGgL9DWDIlNq2stMgvme2s280KHbTBwle
         Iydg==
X-Gm-Message-State: AFqh2kqb9oOT9xlvaIKnCSbZFGPlQdfmrNexivYsR4V3/aGpApkdhEM6
        Y2sb8ej7V/48WjP3s4Dqticye3FwyZOT5JGXBhQtO3hnQknvHcYIuKNlnwdqU3gdWpVt1vXrUIv
        pJR7RfMiwe6Q4ym+cBRP2nQ==
X-Received: by 2002:aa7:de15:0:b0:483:30d7:f9ac with SMTP id h21-20020aa7de15000000b0048330d7f9acmr12028241edv.19.1672228718678;
        Wed, 28 Dec 2022 03:58:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtrIO5srJBbY8oizuyf5Q39Hr1tveD2PqIx/4KuqYlJNhV9zI7izo96N6ps5dxKil3bsWjXNA==
X-Received: by 2002:aa7:de15:0:b0:483:30d7:f9ac with SMTP id h21-20020aa7de15000000b0048330d7f9acmr12028204edv.19.1672228718422;
        Wed, 28 Dec 2022 03:58:38 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id h25-20020aa7de19000000b00463b9d47e1fsm7031261edv.71.2022.12.28.03.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 03:58:37 -0800 (PST)
Message-ID: <55a31d67-b9d0-1a62-1c60-f86b48a34a8b@redhat.com>
Date:   Wed, 28 Dec 2022 12:58:33 +0100
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

Yes, I will (it will be based on 6.2-rc1 + pull request for rc2 that I'm 
preparing + x86 changes that this conflicts with).

Paolo


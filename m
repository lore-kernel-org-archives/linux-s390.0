Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E8C433B4
	for <linux-s390@archiver.kernel.org>; Mon, 19 Apr 2021 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9086108B
	for <linux-s390@archiver.kernel.org>; Mon, 19 Apr 2021 11:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhDSLTD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233486AbhDSLTB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Apr 2021 07:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618831111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCzp3qZIdr4u0FyN9JADLtQu47gdCQ0CxNrxY5TVo9Q=;
        b=hqH5z56A+2KAdcG0ulL8wAr6i+LU9GQxwyulGAD2m9k/c4kK0Rn58ugRuSfoAAGXvmj1vI
        FmZyCj265NKhxQ+RWn1NEnIIlB+WJAZMoRYMl3UMO3NdY1u4nvEb3e1BlYshUJ0YJuWwfy
        BhWO8TjSMIElIeRDVHxRc8gPlbFrSeY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-mv7Fw5jVN4GJWlEFkShbKw-1; Mon, 19 Apr 2021 07:18:29 -0400
X-MC-Unique: mv7Fw5jVN4GJWlEFkShbKw-1
Received: by mail-ed1-f70.google.com with SMTP id p16-20020a0564021550b029038522733b66so2923056edx.11
        for <linux-s390@vger.kernel.org>; Mon, 19 Apr 2021 04:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WCzp3qZIdr4u0FyN9JADLtQu47gdCQ0CxNrxY5TVo9Q=;
        b=IJp8pQXsE+FeQhM+U5El9Fw4wWdyr1WncFfBE6fKL2PKx31hcaT6IGjE2JxXVqmz0U
         e23ESSrzhI7+rvatI9B2cVFNmdwRSUtNmSeYTdKi139ovsKvqI4c0OwjtgvHdlCqThNx
         HNWg5Te7uWi5wDClL7pp/54Ner9ad7f/mbcd9C9Nyo9tgUhKn9LlczhYnDLGd1LYNqan
         aXV3V1Iym3GqYlW2k0GaaTIylkEdsgBtTp8nnFKCLX0/yaxHCD6YCMpDaSXidNJ6h8ut
         748hcPJ/JXElJlGJYMDIY4vkQO92sN9LczLKwQTp+0TjMxzB5jK8B80v5O+koBHajePX
         83Hg==
X-Gm-Message-State: AOAM533sgXxd/iwGtRtWn9KKNbG/9aRdwtQs4XU4Cw0+mWHoCq1ECXC2
        FXSbU1Sce2AMSslzbqwTR0pKdGrlsGsPx+o1r50/enxHoX1akZGOB+0R+mQvJUneDIreXrSrtP2
        Nw5ZMG1kgVcZ7+WPZA9VAJg==
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr21657015ejh.97.1618831108546;
        Mon, 19 Apr 2021 04:18:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqu63LOpqckc/b1y9M3cEHioz8UWECwAeoDEKHsVXD1WCUxtmmwnesWctc6sXbp3BngiuQvA==
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr21656990ejh.97.1618831108376;
        Mon, 19 Apr 2021 04:18:28 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.160])
        by smtp.gmail.com with ESMTPSA id ck29sm12468881edb.47.2021.04.19.04.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 04:18:27 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] KVM: selftests: Add selftest for KVM statistics
 data binary interface
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        David Rientjes <rientjes@google.com>
References: <20210415151741.1607806-1-jingzhangos@google.com>
 <20210415151741.1607806-5-jingzhangos@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <9f2a8873-c2c2-ec84-58b4-7c90c59d1d25@redhat.com>
Date:   Mon, 19 Apr 2021 13:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415151741.1607806-5-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jing,

> +int vm_stats_test(struct kvm_vm *vm)
> +{
> +	ssize_t ret;
> +	int i, stats_fd, err = -1;
> +	size_t size_desc, size_data = 0;
> +	struct kvm_stats_header header;
> +	struct kvm_stats_desc *stats_desc, *pdesc;
> +	struct kvm_vm_stats_data *stats_data;
> +
> +	// Get fd for VM stats

Another small nitpick: comments should go in /* */ format

Thank you,
Emanuele


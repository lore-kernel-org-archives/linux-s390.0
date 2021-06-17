Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF1C2B9F4
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C876D611BE
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 15:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhFQPb0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231661AbhFQPb0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 11:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623943758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJAYrboxNY4R4lDYsyxGAHwG1E3b8kp8BFkfADBjg3E=;
        b=i9rv6DaaSfYsRhlr9FXhBk16VVzj43OPh1P2Wa2F+igE1O3waKEhNxyNbNLAkkdLjIGgF5
        JbSFtQRBEgpm4z4O9vjebTYP75AVQy3uQRLBkBwz/Q4VVOr9NcqxcoraPr+0f927wAMsjc
        dSMRJ8brab2kfJau3hCNTUXB6gfqKHc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-j8Zghb4MNGa1jpT-s06sDg-1; Thu, 17 Jun 2021 11:29:16 -0400
X-MC-Unique: j8Zghb4MNGa1jpT-s06sDg-1
Received: by mail-ed1-f72.google.com with SMTP id cb4-20020a0564020b64b02903947455afa5so1787806edb.9
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 08:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJAYrboxNY4R4lDYsyxGAHwG1E3b8kp8BFkfADBjg3E=;
        b=hepgTL+zHrfOCiTrKpSO8uH1ogFWad9/2kY9PWOgNbfLNW3zHpH8d7KxK++xJyIcv7
         wm4dos0/OWYEdYN+cZejCMLVM9EqiLfYwM27CAenlaq5qiNunguuEav3MSXVH/SOlWWM
         jo83+vE7MCUfB+DqNmO9sWDv0NuOhvb7Qua9qHijqMAZ6tNi6py2YhShWt4XYdE51FIV
         6ukhAMeL2lhLSTfkLV1KXNLmDGrza0ImkFqugy8Iuxlood6Ue4aTswj/kvf7SAqu1EhU
         yRqfKuKn8j2WTDe8SHXwclcKvN+EJJzAizEu6qqbScRsj94mz0mMXk4l5Qctf/KttxrG
         xMgw==
X-Gm-Message-State: AOAM532JXq2ZgSI9Jwi+UWAfkeTpGi/4g929zELVRozqkv7rhDY8s/UG
        0AmejHMSvLnv7dOxLwO7BMAcT6aeJZqeFoWaWaGMq3nWM52JpXF+fG/5lQGJztDK8hQC5YBx5Qt
        tpdVwE7rydWA/WgsBmM5GPA==
X-Received: by 2002:a17:906:3c44:: with SMTP id i4mr5844957ejg.135.1623943755563;
        Thu, 17 Jun 2021 08:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwguprspLdKxfz1gQFsWZ9pANB4xL5Og2GYXcQQiXXJdl05NURoTWq9llwpGLS30bGiJxoGJQ==
X-Received: by 2002:a17:906:3c44:: with SMTP id i4mr5844929ejg.135.1623943755347;
        Thu, 17 Jun 2021 08:29:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z19sm4485528edc.90.2021.06.17.08.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 08:29:14 -0700 (PDT)
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary stats
 data
To:     Jing Zhang <jingzhangos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-3-jingzhangos@google.com>
 <YMr4rArKvj3obDEM@kroah.com>
 <CAAdAUtiiQ0304vWR3Zm2XUKz374W4LY3=qdrFZCsQ27VkqMn9A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ae75b1b-4cba-d06f-625b-35b42f11ac03@redhat.com>
Date:   Thu, 17 Jun 2021 17:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAAdAUtiiQ0304vWR3Zm2XUKz374W4LY3=qdrFZCsQ27VkqMn9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/06/21 16:56, Jing Zhang wrote:
> Actually, it is really not easy to separate this change into two patches even by
> following Paolo's suggestion. And it would be a surprise to userspace to see
> only VM stats, no VCPU stats.

That does not matter.  Having two or three patches is useful because it 
makes review easier; they will never appear separately in a release.

Paolo


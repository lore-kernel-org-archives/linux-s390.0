Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188A8C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  5 Oct 2022 06:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJEGcp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Oct 2022 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJEGcn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Oct 2022 02:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A217437D
        for <linux-s390@vger.kernel.org>; Tue,  4 Oct 2022 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664951562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2fZF5NpPxB+zfptp/E3otmQs3yA+XxyrCxE6wqs+1E=;
        b=DYIdmskBmaXyqyncXZ6GhzNjF4X+XjLQyZKXpc1SME/rs4Mn4MCPrrZ63x4HL67RjnqnsI
        uh8E1sjMqKlMw9yhpq1XBefg8JN5FHpfp6D80MeE9uw7bk6ztslKGOOv3sQ1e+2vP4QOQG
        LQX244R/NXeUSxce5QYwnciRJfApn2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-FZEr6HgLP1mYlX2G1626Yw-1; Wed, 05 Oct 2022 02:32:37 -0400
X-MC-Unique: FZEr6HgLP1mYlX2G1626Yw-1
Received: by mail-wm1-f71.google.com with SMTP id r8-20020a1c4408000000b003be06269377so278508wma.6
        for <linux-s390@vger.kernel.org>; Tue, 04 Oct 2022 23:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=i2fZF5NpPxB+zfptp/E3otmQs3yA+XxyrCxE6wqs+1E=;
        b=4YgNy0PfN+Fq6JdkunGgUWD3vpJ/0VmLsEJKjB0A/6bgm/HY0uFRvjV2/rd/crvy7W
         5JzXoqFKOrVcVgM1XgEdrzkZ267lFpb+Yw0zCNHB9AYEQcTEmFZRr93z7mOH1Iwg4/aV
         1n8kME6mnkcvDFVSdb31unbJ8hXYQeiecgdCAGXVN7fu0WWgp4X8P7SaR5j5P0tY8vsM
         if4YEAbqnX9Vgbpkq0VRt3kusc3sj/XY3a7buyhEVwpL9VLTAPjsuPxGyPjhJFMfOsSn
         /b99L9sYmeBqpdtH+HS3cD/JGlvR06F3v7DOa0dbmcY4aZuwuKHTUyKBpcCzOnRcV66i
         C1fg==
X-Gm-Message-State: ACrzQf3gROrqYWefOFwLROhmURgmVHow2dd6nXT7tjNEhAUVirjHfD8P
        Xt+kX16fpmGvoZRxgm/53DiU2gGIu5r+ZRhJYpe4dy2Hucusn/4dXGiT7Qy1n1VECnahMAoUD+x
        w1f9ZNkohaLLb9gnTZp7PhQ==
X-Received: by 2002:a05:600c:1549:b0:3b4:8fd7:af4 with SMTP id f9-20020a05600c154900b003b48fd70af4mr2124932wmg.100.1664951556628;
        Tue, 04 Oct 2022 23:32:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6oN6PV4QL5PeEwB3AulW8hy8JRxoJitj3BA4H8xzN2l786Y0utSyQ0xn5AhPGpmYJfRD5rnQ==
X-Received: by 2002:a05:600c:1549:b0:3b4:8fd7:af4 with SMTP id f9-20020a05600c154900b003b48fd70af4mr2124913wmg.100.1664951556442;
        Tue, 04 Oct 2022 23:32:36 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-249.web.vodafone.de. [109.43.177.249])
        by smtp.gmail.com with ESMTPSA id s16-20020a1cf210000000b003a5f3f5883dsm997040wmc.17.2022.10.04.23.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 23:32:35 -0700 (PDT)
Message-ID: <37197cfe-d109-332f-089b-266d7e8e23f8@redhat.com>
Date:   Wed, 5 Oct 2022 08:32:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
 <20220930210751.225873-3-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220930210751.225873-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> User space can use the MEM_OP ioctl to make storage key checked reads
> and writes to the guest, however, it has no way of performing atomic,
> key checked, accesses to the guest.
> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> mode. For now, support this mode for absolute accesses only.
> 
> This mode can be use, for example, to set the device-state-change
> indicator and the adapter-local-summary indicator atomically.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> The return value of MEM_OP is:
>    0 on success,
>    < 0 on generic error (e.g. -EFAULT or -ENOMEM),
>    > 0 if an exception occurred while walking the page tables
> A cmpxchg failing because the old value doesn't match is neither an
> error nor an exception, so the question is how best to signal that
> condition. This is not strictly necessary since user space can compare
> the value of old after the MEM_OP with the value it set. If they're
> different the cmpxchg failed. It might be a better user interface if
> there is an easier way to see if the cmpxchg failed.
> This patch sets the cmpxchg flag bit to 0 on a successful cmpxchg.
> This way you can compare against a constant instead of the old old
> value.
> This has the disadvantage of being a bit weird, other suggestions
> welcome.

This also breaks the old API of defining the ioctl as _IOW only ... with 
your change to the flags field, it effectively gets IOWR instead.

Maybe it would be better to put all the new logic into a new struct and only 
pass a pointer to that struct in kvm_s390_mem_op, so that the ioctl stays 
IOW ? ... or maybe even introduce a completely new ioctl for this 
functionality instead?

  Thomas


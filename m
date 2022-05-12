Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEBFC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 12 May 2022 13:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354324AbiELNWZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 May 2022 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354317AbiELNWY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 May 2022 09:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AE6F541B5
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652361741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGoOIUCJGa4SaOfudTG7yQQEUS0BOq99bUpZYAujLo0=;
        b=WOjP8MdPqu3LOsfahT82zc8xugEfFIT7nCLCVDa+gNXt75X+itV3ea4MPbXhUbiGFqNn1R
        gopb+V303EGReu1GRKgJA866a/gKyvlz3Iaduty4afXgHptcI2kUeRUl/c+y6typ1h2tzH
        ac7lB01acVU5UNs6HuDLMrlR6EY+rR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-T_nAhSk3NPWilPckr5RXCQ-1; Thu, 12 May 2022 09:22:20 -0400
X-MC-Unique: T_nAhSk3NPWilPckr5RXCQ-1
Received: by mail-wm1-f72.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so1661166wmh.9
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 06:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=iGoOIUCJGa4SaOfudTG7yQQEUS0BOq99bUpZYAujLo0=;
        b=M2JcGHXpRHHOsWdDT4nptPPoTcnmzNWdEe+pTUWvZA4YoPmbY0AOEeR62THQ7mE4wj
         RZoO3L18Ptfo53bZzeeT+/FyXy84l+z/nF22jDp4TAsdCv0XINGnl/MwB7JB0Hh6N8M1
         9e71boT+EpOnJDyL3pUCIPReIOZuX4fHvtYZixftIcpSI27W5IRGLwdlR2Rf82rWQwZn
         Yq2dkOqAKtYLh8x0V4vVweH6SzIF4PNE0z3RzfrcbDAZueaEW4lorpv7sMywvmUFt+0T
         cFhk3Eie6g/ijf/7VKSJ8HoyyuvGUNgs4b6G2+umcuOm2yAcoEBD9o3ly5tZD7YZtv61
         shzA==
X-Gm-Message-State: AOAM532F0pqwBIBs4pQNFdm7G1vJor3HNO3YLBYd4+L/vU8tYu9JCDvQ
        74JA/QhatZer8E8AHJUWcrmdIk9ADoI6eKOFCqEaOazQwFZ4WoZgf+MpOekK0rsv+d+vWNCX10b
        xFdhrDcEdFFrnK/cP3WPZaw==
X-Received: by 2002:a5d:5746:0:b0:20c:dbc2:397d with SMTP id q6-20020a5d5746000000b0020cdbc2397dmr7981049wrw.658.1652361739078;
        Thu, 12 May 2022 06:22:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+hXYu6vzpLOJq39B+H7C8rDVvQP/gQANCQfbt9DiMWxcg2qD5+fl3H5Fdy+4EFw8qj6gfWw==
X-Received: by 2002:a5d:5746:0:b0:20c:dbc2:397d with SMTP id q6-20020a5d5746000000b0020cdbc2397dmr7981034wrw.658.1652361738823;
        Thu, 12 May 2022 06:22:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d408b000000b0020c9520a940sm4946313wrp.54.2022.05.12.06.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:22:18 -0700 (PDT)
Message-ID: <77f6f5e7-5945-c478-0e41-affed62252eb@redhat.com>
Date:   Thu, 12 May 2022 15:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220512131019.2594948-1-scgl@linux.ibm.com>
 <20220512131019.2594948-2-scgl@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/2] KVM: s390: Don't indicate suppression on dirtying,
 failing memop
In-Reply-To: <20220512131019.2594948-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12.05.22 15:10, Janis Schoetterl-Glausch wrote:
> If user space uses a memop to emulate an instruction and that
> memop fails, the execution of the instruction ends.
> Instruction execution can end in different ways, one of which is
> suppression, which requires that the instruction execute like a no-op.
> A writing memop that spans multiple pages and fails due to key
> protection may have modified guest memory, as a result, the likely
> correct ending is termination. Therefore, do not indicate a
> suppressing instruction ending in this case.

I think that is possibly problematic handling.

In TCG we stumbled in similar issues in the past for MVC when crossing
page boundaries. Failing after modifying the first page already
seriously broke some user space, because the guest would retry the
instruction after fixing up the fault reason on the second page: if
source and destination operands overlap, you'll be in trouble because
the input parameters already changed.

For this reason, in TCG we make sure that all accesses are valid before
starting modifications.

See target/s390x/tcg/mem_helper.c:do_helper_mvc with access_prepare()
and friends as an example.

Now, I don't know how to tackle that for KVM, I just wanted to raise
awareness that injecting an interrupt after modifying page content is
possible dodgy and dangerous.

-- 
Thanks,

David / dhildenb


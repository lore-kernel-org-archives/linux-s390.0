Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69270C32771
	for <linux-s390@archiver.kernel.org>; Wed, 17 Aug 2022 14:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiHQOAF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbiHQN7g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Aug 2022 09:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DCE9751D
        for <linux-s390@vger.kernel.org>; Wed, 17 Aug 2022 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660744773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjJQXLKx4ownQ6qGKVOGjVgQPT8Sm/znLzneF+4NcgY=;
        b=OSn1J1axthkpnrX2URgbqXEuWPfKXfnIItSnXzeQbQrHtzWjNub45OFtL1yBQsJts4Epm4
        2zTmr3V6flLcuQwDLkElDzuCQ7mZn/Ty37mRilXMBUAKrLz6vc3xlybrmBc26IU9glGmz4
        L90w8kPUVQsLnKvUJo0WzCamo+WvjHI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-8kvpJ3SrMXuKaAPE9ooxyQ-1; Wed, 17 Aug 2022 09:59:32 -0400
X-MC-Unique: 8kvpJ3SrMXuKaAPE9ooxyQ-1
Received: by mail-pf1-f197.google.com with SMTP id t9-20020a056a00138900b0052dc8a1b97dso5025971pfg.2
        for <linux-s390@vger.kernel.org>; Wed, 17 Aug 2022 06:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KjJQXLKx4ownQ6qGKVOGjVgQPT8Sm/znLzneF+4NcgY=;
        b=CKVFMVWTB5D9JZThO2nCc0bJgCHECzptpzBidd85Cveba3p1ofdJPx7h+HeusnDW9q
         Rzh1SETfaR3/ErXKZad0V5Kd94gIVXsCfpb1DMXul18gDuH2Fuh4zg6QRCggRh0cXkoA
         scb/qRX8lp9fYKKxPPZ/20H8ggygLyXp7GXOpBkrCTNeuQJ0gBc34P4otIftTsVnsUWm
         GfV2EUaOTNjw3dg/R92gIEu/aneRZ2Ry+ZOPJ49TQCbsD33if2gMPCEzx2qvrknSzNUi
         SzcOPS5a5w3H0NvEkcV6B8+DAabKG/R+aViJNIHQ9NLfBDdhKPdO579Azoonvj8wFpcs
         jX8w==
X-Gm-Message-State: ACgBeo3O7VeA1FH7XjS5h5vu+BArLRbPkee1apbeot4Qroy5n3a1uduj
        CS2Y+TVsi7bzLcoFUvwpOms/59V8qtCRyu23Zu59UxYbszCVPbYlswrgjuZW0Q9qL5NCWNjfLgr
        saPfm1V3nbmWhvI0WU2H2wA==
X-Received: by 2002:a63:1909:0:b0:421:948e:f88 with SMTP id z9-20020a631909000000b00421948e0f88mr21339520pgl.607.1660744770945;
        Wed, 17 Aug 2022 06:59:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR637QmCodmX2czSDlZ/JVgAIWks5zJd8OVatW/iyct60lWHwBBWKGyAHgYAh9M7gPYym1n1zg==
X-Received: by 2002:a63:1909:0:b0:421:948e:f88 with SMTP id z9-20020a631909000000b00421948e0f88mr21339504pgl.607.1660744770624;
        Wed, 17 Aug 2022 06:59:30 -0700 (PDT)
Received: from [10.211.55.14] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id v63-20020a622f42000000b005289627ae6asm10447794pfv.187.2022.08.17.06.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:59:30 -0700 (PDT)
Message-ID: <c434a873-6bd2-d681-6713-1183260ce640@redhat.com>
Date:   Wed, 17 Aug 2022 09:59:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: s390/nospec: add an option to use thunk-extern
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <8569429d-57f8-a0cf-8b17-1291f6973d32@redhat.com>
 <cover.thread-d13b6c.your-ad-here.call-01656331067-ext-4899@work.hours>
 <ad6a926e-eed1-a5e2-9f8b-0ea1599bbaed@redhat.com>
 <CAPQ7N1RFyZRCJZc84UxjSQj44ksa6f6ib5B=dVwoqMU9_=s8QA@mail.gmail.com>
 <e853268a-3e0a-3a88-331b-53c74e8796d6@redhat.com>
 <2db2140b-ce07-f066-bcc2-981a53849bbb@linux.ibm.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <2db2140b-ce07-f066-bcc2-981a53849bbb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 7/17/22 09:11, Sumanth Korikkar wrote:
> Hi Joe,
> 
> c4e789572557 ("s390/nospec: build expoline.o for modules_prepare
> target") is now in linux.git.
> 
> Note: arch/s390/lib/expoline.o is moved to
> arch/s390/lib/expoline/expoline.o. This means kernel-devel package in
> fedora should also include this updated file path.
> 

To follow up on the last part:

* Mon Aug 15 2022 Fedora Kernel Team <kernel-team@fedoraproject.org>
[6.0.0-0.rc1.12]
...
- kernel.spec.template: update (s390x) expoline.o path (Joe Lawrence)


-- 
Joe


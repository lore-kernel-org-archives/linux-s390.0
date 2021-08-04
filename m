Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1659C4338F
	for <linux-s390@archiver.kernel.org>; Wed,  4 Aug 2021 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC9F60F0F
	for <linux-s390@archiver.kernel.org>; Wed,  4 Aug 2021 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbhHDPUr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbhHDPUr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Aug 2021 11:20:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97618C061798
        for <linux-s390@vger.kernel.org>; Wed,  4 Aug 2021 08:20:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nh14so3479219pjb.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Aug 2021 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RWLUsd9wW8sGCnVRrE5+sg3Qkd9Ol+XAfTVsr7LwnM=;
        b=NFgN5IYn2Vc2ekeEfbf/QnKdOoeA2LaMG+2BgycMseD12qrmsvzmW5VsirBjhvvuPD
         7cTQawCcs21Yf/aN56UZqtNxDQnmxjYeDF4O2mFHzAH2373A3GXqT7JmwfbW0hABt3f5
         owE0w3uzPePiPS2T6TsXfO0CYn86OZRZPFx1Kwp9uIaPxq++AYCR6jOKXaVWHjdTNV5F
         pve0Iq7lPREWZKKZFP2UzcBtDGCzTG7d382Q1qJYPnM4JSokCaF6z5Awf7h2lKVFxs5b
         6ccpD8wijq2xzBfIFo6okAPHHt6rJwojBU/Siq7OMD3p89lwMJamA1itND56RNHEnLe0
         6Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RWLUsd9wW8sGCnVRrE5+sg3Qkd9Ol+XAfTVsr7LwnM=;
        b=GThdOTkROZa41DXK6wEtnPp8x8RMplpneaBF31IGo23HZfXxKc6eeZGk5riJrSuWob
         YxPbFYY9Q1b5S/XVLsLV46wG5J5kLdF+iDmkZ/L5Xa2yBu9FflMwYaTWSCcNOvcjF/7O
         3WqGJHvbuAYrw8JV5G4NedbZEFdscmtuxNvp3BGm3ZxNuufPrry/sHSHCj02DyQ3cXao
         N8n5SUS7kOXy8aGy0GAxgGe5usUZ/p72ioPNL29H4iZIQLIQN4oxsn5Aqz88u14Md1D+
         jNw5Pxo3z67Ih4wbsAsl4+zb2BLU5Nwv7nZnfC/OKHA58RGrxLuEpTf7+qTZdvgRAne+
         O32A==
X-Gm-Message-State: AOAM532nMR5Cr4LkBjFdEqLUi58Mh4OzxKLEmMTSOVs1DDbl7h64rUBI
        DUnqWGK8oPTehd539azSiBDL9Q==
X-Google-Smtp-Source: ABdhPJwcJ4hyPPfP/k1nPZ8Ia9IBQZKBD+/Q3mVg49T0J0X3RI7CrJDA3HiekN9ahr4gmeK0oNQ8zA==
X-Received: by 2002:a17:90a:a389:: with SMTP id x9mr10106227pjp.167.1628090433951;
        Wed, 04 Aug 2021 08:20:33 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 198sm3304580pfu.32.2021.08.04.08.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:20:33 -0700 (PDT)
Subject: Re: [PATCH 0/1] s390/dasd: fix use after free
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210804151800.4031761-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6a0a7a3-9c8d-4114-6408-bded5f75071d@kernel.dk>
Date:   Wed, 4 Aug 2021 09:20:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804151800.4031761-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 8/4/21 9:17 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes an use after free error in
> the DASD driver.
> 
> Stefan Haberland (1):
>   s390/dasd: fix use after free in dasd path handling
> 
>  drivers/s390/block/dasd_eckd.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Jens Axboe


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FC6C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 20:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbiBWUNw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbiBWUNu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Feb 2022 15:13:50 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32D4CD54
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 12:13:22 -0800 (PST)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D91F03FC9F
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 20:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645647200;
        bh=iwWa9JcbVhEYFFR9LsmnA7bsxJWJbrU0gOV0sfgjYeA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=cI/tJAvy+59rX/HeN0ACfqpYH5S3izKFMYoFoFAgkbOSW5iIvD8tW4zj1SbRaccEb
         jCDS62WhBfKKaAjAIpAD05STZpNB5yss5fyENkCEFadTAaT8qNANQ4I7y62ylKgKSj
         bIRR6DMN/7Xi0OsqknNjCOQSHMPz8IOcl2Fn1oMyMONhPtMibRmCVJmXMQYlPIf6it
         Z2tF91HFd6mBVj5imC/U54rO6FfirhYvha4IZ1w4H3CaMSlkil/MwNHyJHH436MBRq
         qO8zkcpx3eXDBUeJxNCuF9tczD6T2qe6D7YCzOwTa/+GKQeN0yqAaY4c259htijkBB
         rz/3ukAoTfC6g==
Received: by mail-lj1-f200.google.com with SMTP id d23-20020a05651c089700b002463e31a5ffso5443795ljq.3
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 12:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iwWa9JcbVhEYFFR9LsmnA7bsxJWJbrU0gOV0sfgjYeA=;
        b=MBGFRkmLLBfWFRC4OlO8Y30/4v1JEv+ZVjoKio15A2aC3fNFPWlISIYtcVsTaY4h5/
         9qBs2DxcX5spHNM8wbPMOLxFSS3iiiDSnC3xwe2AvU5h7avReCz++YqO64uz7QlQbr4G
         ykaI/wPQ2ia3+gWQbkJ/dfSsArOASFN64VGhNcviC0Ws2w717ysP8MUNdD8HPSWmbStS
         gCic9gUaKBrpMuTgE/orSSqV8me7Y4T4eZpamPzoo5+C+sKpJqVLIJPYInzvnCVUFP7l
         hiCKRUJ3wEKCxCfiMVLfMD4Yi2kQb+mgmcmigR2XbsXDvymXs7X4lb96mjejM8BFPjeN
         GB1w==
X-Gm-Message-State: AOAM530qr4lkY1pFNsKgH0HdCIB79rLMEsY2iQ42huUaMuoskDRvtZCB
        lE8q+dhJetLFUyI/T9ngAkZ+yIl913sjRZAa0PbQxOpSPmkyIJA9j/caNw2BNiRbc2jxqqSvVZn
        ZnR3CqeJUV5qwWKqvFNKBnx3MJ12duuVHbEHQF7E=
X-Received: by 2002:a50:d4d2:0:b0:410:9fa2:60d6 with SMTP id e18-20020a50d4d2000000b004109fa260d6mr1046063edj.35.1645647190015;
        Wed, 23 Feb 2022 12:13:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz26puqYUhlyjvmoVu/kDMW076CFmPiGqR/4gF9iezSP9z6kTJySAPUmRGeoBQCBAPnogL/Qg==
X-Received: by 2002:a50:d4d2:0:b0:410:9fa2:60d6 with SMTP id e18-20020a50d4d2000000b004109fa260d6mr1046041edj.35.1645647189826;
        Wed, 23 Feb 2022 12:13:09 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ee30sm359292edb.4.2022.02.23.12.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:13:09 -0800 (PST)
Message-ID: <ab308509-0f81-6f6b-7b94-0ac1086de53a@canonical.com>
Date:   Wed, 23 Feb 2022 21:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 07/11] spi: use helper for safer setting of
 driver_override
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
 <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
 <YhaTWiSQl6pTVxqC@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YhaTWiSQl6pTVxqC@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23/02/2022 21:04, Mark Brown wrote:
> On Wed, Feb 23, 2022 at 08:14:37PM +0100, Krzysztof Kozlowski wrote:
> 
>> Remove also "const" from the definition of spi_device.driver_override,
>> because it is not correct.  The SPI driver already treats it as
>> dynamic, not const, memory.
> 
> We don't modify the string do we, we just allocate a new one?

Actually you're right - the SPI and VDPA implementations operate on
"const char *". The others do not, so I can convert them to "const char
*". Thanks!

Best regards,
Krzysztof

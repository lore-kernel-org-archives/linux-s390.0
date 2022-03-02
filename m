Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13155C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  2 Mar 2022 11:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiCBLCR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbiCBLCL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Mar 2022 06:02:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7316E554
        for <linux-s390@vger.kernel.org>; Wed,  2 Mar 2022 03:01:28 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 384D93F5FB
        for <linux-s390@vger.kernel.org>; Wed,  2 Mar 2022 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646218884;
        bh=Si9sQ7yLz6JK6Nen6lACTBVX2ecHMiwS0ByLXYRxjJA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UvQfb4Fc7UYN94ZRM3XmGkSl3meiRwHAnbQ6471vmkzOb21aZAcYzRFJHEgJn4WMe
         UxU5q2/8i+5BewU9zGyVvGK7dSOHbheBltQD8XwyiwL6svN2/LD082FEKdjvOwnqCA
         mNqS+Ja4ioMcO0hKZCXfo8jA4yLipDL7X6hgVFx5KUs689vjWkTAX48CcfiOgL0z1w
         6oNf+TWa5mb0h4dkc1V+mLUgItZWn6sW6cZXz5hD2fyAjV2qF1EFVvphatlWtPVTvo
         1HpC+cN0z/vZjg3mofA96hWSelTnsj4l0+rwds6ZM11RuGLGJSMalz+QXodI1fc6GG
         m9NNhO4IZAFTw==
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so761780edw.23
        for <linux-s390@vger.kernel.org>; Wed, 02 Mar 2022 03:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Si9sQ7yLz6JK6Nen6lACTBVX2ecHMiwS0ByLXYRxjJA=;
        b=GoUSBWRzLA0o1EBqWGPR7Cc9up6VLj3frbuYlj6U6CPahjFJ9JeZQnrU+D6Qm79ZH9
         wJDSrYMQ1P7XTj6KFNZX5tR4z5LIH2i3+hqsZ2rG0/36kgglVHUeu0qxINPwlSduV/Bq
         bCN1f99VSo90b907wXCfXPKT6kKF/GYlFLKeNZaAg5KqTMSVgdrhOI8p6qdWHJNN9lDY
         t0k8Ev8PTfSqb9ljSfM46jFjm4ideoTTHHnmHDrvICtbLOsbbcf8zICopogyNY/ibR7b
         QHsc0iWiEJpt+BCAHGMXOdX2YjTZEZVG6zs0B6huJJYg412ZMDZKqkmtkj/OvOKhabUk
         9URQ==
X-Gm-Message-State: AOAM531/U2/S/QH82ffTDyksei5WCxkd5Uz3yPeo7O7JmcO2S9k3FTvx
        H/mt20ApnigmrdZ8Dfv522A+qkkBrzIB+poXn43Vi78Fnt+DjO+E3XbW4LbgNbZgxyrIGwWAbsI
        OSA98TT5v6E9q9WI6KxTlk+tHEQduc4P4Pqxk168=
X-Received: by 2002:a05:6402:369a:b0:413:81b5:7b64 with SMTP id ej26-20020a056402369a00b0041381b57b64mr22935769edb.163.1646218881639;
        Wed, 02 Mar 2022 03:01:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaXIpVKlG8abGyix74I9rTqmFoJz7zygw3QnLROE8hwqkRWj9/wBCxZT5ACGsypW51MBpi7Q==
X-Received: by 2002:a05:6402:369a:b0:413:81b5:7b64 with SMTP id ej26-20020a056402369a00b0041381b57b64mr22935729edb.163.1646218881424;
        Wed, 02 Mar 2022 03:01:21 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id et3-20020a170907294300b006d6534ef273sm5617821ejc.156.2022.03.02.03.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 03:01:20 -0800 (PST)
Message-ID: <22099da9-fad0-a5fb-f45a-484635ca485f@canonical.com>
Date:   Wed, 2 Mar 2022 12:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 06/11] s390: cio: Use driver_set_override() instead of
 open-coding
Content-Language: en-US
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135214.145599-7-krzysztof.kozlowski@canonical.com>
 <b2295eba-722a-67e2-baae-20dac9d72625@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <b2295eba-722a-67e2-baae-20dac9d72625@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/03/2022 17:01, Vineeth Vijayan wrote:
> 
> On 2/27/22 14:52, Krzysztof Kozlowski wrote:
>> Use a helper for seting driver_override to reduce amount of duplicated
>> code. Make the driver_override field const char, because it is not
>> modified by the core and it matches other subsystems.
> s/seting/setting/
> 
> Also could you please change the title to start with "s390/cio:"
> instead of "s390 : cio"
> 

Sure, thanks for review!


Best regards,
Krzysztof

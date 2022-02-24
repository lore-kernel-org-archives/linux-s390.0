Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F5C4332F
	for <linux-s390@archiver.kernel.org>; Thu, 24 Feb 2022 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiBXIoC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiBXIn7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Feb 2022 03:43:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC954F8C
        for <linux-s390@vger.kernel.org>; Thu, 24 Feb 2022 00:43:30 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 630433FCA5
        for <linux-s390@vger.kernel.org>; Thu, 24 Feb 2022 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645692209;
        bh=Dcj0D0zPsXPEVS1eNhpQqfPztDcGavIHA1/tOM5ybJI=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=HFh0Y9pMIxRq5ATVBhCxUCMvCBmhEuT2J1x8IA9I1hRcjfUFLJ+cp597KAp3zOUgP
         vRdOdBgcQGCVReH3DKjSyI1TxGo6mx2HfG8N4sC5HODgarLKzu3Wos/G3VZDtLSPeA
         FNC5P1gUeGiNC6KLcbXbhCAij1ZHvsIY9yuDV0Ph35VJivEt5nyaSbg16QMVceq8KI
         0rWfD9Nkq9OZQn266uM2aehGeEXjL8hV6UFTjDEBNUY3lKF3KrKUzeb2hTFUqA5OG6
         CN3stpeR857YSdEBEByLaqX/uLvw3zx0kYBw+bc7j+24CL+n3xL/n2xmFCnkiETQ3e
         GJZbmVLuJvbgQ==
Received: by mail-wr1-f72.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so82658wrw.9
        for <linux-s390@vger.kernel.org>; Thu, 24 Feb 2022 00:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Dcj0D0zPsXPEVS1eNhpQqfPztDcGavIHA1/tOM5ybJI=;
        b=E/N+QbEm4iFaFJ+8RxPixyxO0CdGWuldh/qrYqKZtcG7044HC5mxZ8NYQ1JEtzJZ2n
         9PyJwQepaUzCpppo9jeIGMZJIMmOJV9nBGmSymiZcmmavK5W0ZZhhFjRyZrDJM+o9j/j
         GpXcL4q8Ywjl/t5OHkhyXzwqXr4Ki1XS+TExxDcyy0ynS0+ZdaoqmmViKTTCEMohI9AB
         8UwErJjk2fTVkr8gm0+G9jRYc3fZc3Ha1uQHZuYMM9GrOvthlThVlnaK2vqrXnPa9g+e
         Fg/PnG3xVf2ut6ARsN598WZ5jvHkUiUdEWZed/jdXFqrPazy2B/z4b8t12Rb22xWGlX7
         hYrA==
X-Gm-Message-State: AOAM530DIWT76qc37bIQoWNDIF/Lr9fGN2xRKrDXMInXvAcwL18EFUmO
        r065tculj8vM4bnu8WaITGTsra4gECxTHtKh0pEC5lXvQZqhesmRTEi/9PWvdpLJz+3BoHpsTh4
        7pzBC6vw1F9FomYGwYztY7J2rV1ZV22RErKDaCew=
X-Received: by 2002:a05:6402:2744:b0:404:ba60:fec6 with SMTP id z4-20020a056402274400b00404ba60fec6mr1261654edd.235.1645692198574;
        Thu, 24 Feb 2022 00:43:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyR9ltyboSTjtHA8dcoqW8jhNMCdSS02AQooqb5CLRWmWM576orT/UQwLqy77zZSpmBsHCJBQ==
X-Received: by 2002:a05:6402:2744:b0:404:ba60:fec6 with SMTP id z4-20020a056402274400b00404ba60fec6mr1261610edd.235.1645692198343;
        Thu, 24 Feb 2022 00:43:18 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id 16sm1006988eji.94.2022.02.24.00.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:43:17 -0800 (PST)
Message-ID: <cd89539b-92b8-0376-03c2-1a9268721b92@canonical.com>
Date:   Thu, 24 Feb 2022 09:43:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 01/11] driver: platform: add and use helper for safer
 setting of driver_override
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        Mark Brown <broonie@kernel.org>,
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
References: <20220223215342.GA155282@bhelgaas>
 <bc4f3314-46f2-72a8-f25c-c9774d987ca1@canonical.com>
In-Reply-To: <bc4f3314-46f2-72a8-f25c-c9774d987ca1@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24/02/2022 08:47, Krzysztof Kozlowski wrote:
> On 23/02/2022 22:53, Bjorn Helgaas wrote:
>> On Wed, Feb 23, 2022 at 08:13:00PM +0100, Krzysztof Kozlowski wrote:
>>> Several core drivers and buses expect that driver_override is a
>>> dynamically allocated memory thus later they can kfree() it.
>>> ...
>>
>>> + * set_driver_override() - Helper to set or clear driver override.
>>
>> Doesn't match actual function name.
> 
> Good point. I wonder why build W=1 did not complain... I need to check.
> 

I see why - I missed kerneldoc /** opener.


Best regards,
Krzysztof

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDB3C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 24 Feb 2022 07:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiBXHsK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Feb 2022 02:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiBXHsI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Feb 2022 02:48:08 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C700916E7C1
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 23:47:38 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD3DF3FCA4
        for <linux-s390@vger.kernel.org>; Thu, 24 Feb 2022 07:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645688856;
        bh=Zs4sP9i99NlTTPrJcg2NREY6h9bovqrYIvzZODv1Ymc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Cao6kvMNvROcd/Yk9x4TLSOKijk7yt5dLtd8VTiSWTUP0vo+d2/EpXGE3lwHmWkh1
         GstjZKIyXOtuR9tKqbJS7iiSGS139u+cPwLVlkODo8tXqgHT6Iv84n+x0RrcXBYEAR
         J/3Mzw9D8xaoeN+uXtu8TMLwdi5xpX0ZFm0skd18EW/NxHnZhLU1Nq13CFS1gyyvOz
         nkgtlv5R3hLMeKS2GVFjKHgmeoLWR8gtbp9OQr5lNhLNnRlgMbLOYiOn7S9PgAqf/F
         IJEWG4MTf3vpphM3ycPaeSeRSYeMqveUdL/aqP/fgzRrxr2NMhP+AH8G7UolqlqpSA
         e9m1v/cqlqc8Q==
Received: by mail-wm1-f70.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso502339wml.1
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 23:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zs4sP9i99NlTTPrJcg2NREY6h9bovqrYIvzZODv1Ymc=;
        b=GcwCntX1143DdRB+RiXxIfxi+nEBi2YB7RpuJkI68xX+New6il46e/1pgt5fo1Jdkd
         t9gqzv3WkW2y9f0Q7mzhxottZEQl7htEXeBq1HeptijVgelGxqujCDkgzn7AiKIHlHxG
         4Bu6fMVPJedK4PcVuXQI/M1yzqNG1x/Shdys7MgyYRHt0INMewOFrrIO25oJfFwellmk
         hRLK94N1umPzN5TmQ0oSobEdfji+FfMowZNn3dr+D9jRol6AzINVzqSVeX/uzCMLcndb
         Mux7KEFWK9jIxbXYWwpU7MpHk3rXXRQqAeqf37iJVwYWCb/Y0VzzQ7rs5gOt34K/1eW5
         Ou+A==
X-Gm-Message-State: AOAM530oyThTVbUWjShn9fTl8H7cDKy+r1Kue76J7hVrJqzKzE4cIoHm
        MAvR0RidZbk+rgsKmU5+hHrUB+psUU2sx/oyTjhLO9RRO6DRLTCAkap84rrZ/0Ak+8mqAZq9uu+
        RNS5071Lj1zKAGiTTNyOUjJguio/DPG89q98Sl40=
X-Received: by 2002:a17:906:aed4:b0:6ba:6d27:ac7 with SMTP id me20-20020a170906aed400b006ba6d270ac7mr1258032ejb.33.1645688844790;
        Wed, 23 Feb 2022 23:47:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUYNmN/4hZMQwnBoVYe/1HJVh2ik7cDwSx+7g3/XCwKJDGgQtwwmTKf8PpD7KGJnApbTtGHA==
X-Received: by 2002:a17:906:aed4:b0:6ba:6d27:ac7 with SMTP id me20-20020a170906aed400b006ba6d270ac7mr1258017ejb.33.1645688844569;
        Wed, 23 Feb 2022 23:47:24 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v30sm942368ejv.76.2022.02.23.23.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 23:47:24 -0800 (PST)
Message-ID: <bc4f3314-46f2-72a8-f25c-c9774d987ca1@canonical.com>
Date:   Thu, 24 Feb 2022 08:47:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 01/11] driver: platform: add and use helper for safer
 setting of driver_override
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223215342.GA155282@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23/02/2022 22:53, Bjorn Helgaas wrote:
> On Wed, Feb 23, 2022 at 08:13:00PM +0100, Krzysztof Kozlowski wrote:
>> Several core drivers and buses expect that driver_override is a
>> dynamically allocated memory thus later they can kfree() it.
>> ...
> 
>> + * set_driver_override() - Helper to set or clear driver override.
> 
> Doesn't match actual function name.

Good point. I wonder why build W=1 did not complain... I need to check.

> 
>> + * @dev: Device to change
>> + * @override: Address of string to change (e.g. &device->driver_override);
>> + *            The contents will be freed and hold newly allocated override.
>> + * @s: NULL terminated string, new driver name to force a match, pass empty
>> + *     string to clear it
>> + *
>> + * Helper to setr or clear driver override in a device, intended for the cases
>> + * when the driver_override field is allocated by driver/bus code.
> 
> s/setr/set/

Right. Thanks for checking.

> 
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +int driver_set_override(struct device *dev, char **override, const char *s)
>> +{


Best regards,
Krzysztof

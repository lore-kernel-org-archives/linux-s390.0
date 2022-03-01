Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF60C4332F
	for <linux-s390@archiver.kernel.org>; Tue,  1 Mar 2022 08:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiCAIuX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiCAIuW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Mar 2022 03:50:22 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE28931C
        for <linux-s390@vger.kernel.org>; Tue,  1 Mar 2022 00:49:40 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2994F3FCAE
        for <linux-s390@vger.kernel.org>; Tue,  1 Mar 2022 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646124579;
        bh=i5oNvJtWT2nQMVMnHuzSOVOeJhkbSN882hqbqowwmW8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jebjNoKtCS7jmesdrzmRvtboDgQ506vp1BdQaR6s9FLPQaFYlkkuGcD+L6TAICE2c
         90WL26IpLvhIkAuXEyxKJhkU/0j71bjbFo/wOIujFvN5AztHqdF576349u7f3Yzvi7
         3HEb7+VRii6+ApCHCw/BtRD407/Yj5r5j43AcuZLpAeudfnc1ugQ6speUVWol32XFo
         pDO/k9rxP1QRt1bI0R0UsxNy9ymKz4X/zk93EzAGYzgM5UD0s51pnjlvid+TzsaR5Q
         4yP4VyokNRyviXu1YzfAgALpVrvi6cqe5Qm4oxwy5EnaDYz9q5oLWHLcpAeGPhWft0
         bnll7kj54xBxA==
Received: by mail-ej1-f72.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so6484702ejk.16
        for <linux-s390@vger.kernel.org>; Tue, 01 Mar 2022 00:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i5oNvJtWT2nQMVMnHuzSOVOeJhkbSN882hqbqowwmW8=;
        b=oKugpodLrcmH+xZFrh5M6y9/0B0KBkMqng3pe5FXfSLzuuezvt3SMiaxZVNBEeIZf5
         To1K+T1LK73lE9PnZOTWWf/KpnBK60BkG5II6laLah/XbyaUg12pTla5pEeIFVw+N24d
         sTeQd+6YEeZoep7mgZ50WaZRs4jWo4AxRpR5ZrD2V4ZWluWLPN5lCBBDGd7L97XM0NZM
         ABabrjCOsn9TGj1+iD8LzlZXwrZ0qrittji4ire+jNx3vZRWZY7AXRdwj3mbzt3x2aWf
         AapQqMin1It+JYVtzmXm+wtU+qmMWwQm6rOOhu8bJxqUNaK6tNFZbrRyfumGAkUxLflU
         cbaw==
X-Gm-Message-State: AOAM5300USbcIsLQZF4p1A2+M4xm3qsZoMWc31OhufDP4hY/s3ydrOL0
        FMkc0fKPCkqmIqRK9M+4pB6/nVwEl3akhXH+MPnl/SyDMBGqXHNXdDATj8sc7gSgPilY8ovMQR8
        KZw6vfQwEoB+z3srU8nary9c/flR2UIzbPnDoLUA=
X-Received: by 2002:aa7:db47:0:b0:413:7649:c2bb with SMTP id n7-20020aa7db47000000b004137649c2bbmr18696641edt.123.1646124577530;
        Tue, 01 Mar 2022 00:49:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0Ji57X8BPtLBdo02/7Aw5hrJyfazNqZcwT3ns08IlVBGD/uW7vhmHoqEKLaS5kqGFV7Hlhw==
X-Received: by 2002:aa7:db47:0:b0:413:7649:c2bb with SMTP id n7-20020aa7db47000000b004137649c2bbmr18696608edt.123.1646124577357;
        Tue, 01 Mar 2022 00:49:37 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id y14-20020a50eb8e000000b00410a2e7798dsm6893213edr.38.2022.03.01.00.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:49:36 -0800 (PST)
Message-ID: <40d9b2ad-2f8a-42c8-54cf-b22e24d78538@canonical.com>
Date:   Tue, 1 Mar 2022 09:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 01/11] driver: platform: Add helper for safer setting
 of driver_override
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
References: <20220228200326.GA516164@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220228200326.GA516164@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/02/2022 21:03, Bjorn Helgaas wrote:
> On Sun, Feb 27, 2022 at 02:52:04PM +0100, Krzysztof Kozlowski wrote:
>> Several core drivers and buses expect that driver_override is a
>> dynamically allocated memory thus later they can kfree() it.
> 
>> +int driver_set_override(struct device *dev, const char **override,
>> +			const char *s, size_t len)
>> +{
>> +	const char *new, *old;
>> +	char *cp;
>> +
>> +	if (!dev || !override || !s)
>> +		return -EINVAL;
>> +
>> +	/* We need to keep extra room for a newline */
> 
> It would help a lot to extend this comment with a hint about where the
> room for a newline is needed.  It was confusing even before, but it's
> much more so now that the check is in a completely different file than
> the "show" functions that need the space.
> 

Indeed, this needs explanation.


Best regards,
Krzysztof

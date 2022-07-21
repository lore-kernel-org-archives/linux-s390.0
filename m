Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1ECCA48D
	for <linux-s390@archiver.kernel.org>; Thu, 21 Jul 2022 13:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiGUNns (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGUNnF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Jul 2022 09:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E9D88322A
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658410976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB2t6MCwiJG1ExNDB+Ljjom6WV2GQK9LC4WD3rPXQFM=;
        b=fXvmKeLkfzCXm3DBNYj1xxQ9hjbpKGte7IC400SdwiCML46Sm0LqFrLFkdh8e7+ctl6+1L
        jLKDhMB+/2hJyk8MCXRgrd7Jv/DLZaCeW9RByZILKTv7s350P/XzLbtjRf9BjGzAuLe0Za
        Yet+MQ5Yz5+hqYK9OMUVahXvDh000VY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-2fUMqjdgN3OXvZ_8lfEAqA-1; Thu, 21 Jul 2022 09:42:48 -0400
X-MC-Unique: 2fUMqjdgN3OXvZ_8lfEAqA-1
Received: by mail-wm1-f72.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so1038034wma.4
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 06:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eB2t6MCwiJG1ExNDB+Ljjom6WV2GQK9LC4WD3rPXQFM=;
        b=bxFKY8Ded5xpq8M1MjxXVSwqA3IsHxa4IBQ2yLqM/xXHT2sL2yqcR0dVTOpZ3qFB+D
         dM+avywaGa2A/8mxk+KIh8wGNCdRlN4Y99DxcIC5BYqAPzb46d1B447W+h89bW8yAV6I
         dCdfq/XSd9hSyQ4O16vTrlzlPFS2wI/eJCPIrlzSqNMksyjmNXYLbaFmDGd0FAvnA7vg
         R4jbi1Q6S/5O9QXpjVsPhpub9E/HoDg8WTOmKNikLL2HP8AKQdYtv4Hv3ky/q8sUlaS1
         DckzzKEu5QQL3l6gzxh+1RZpUz0TjgUOCuGBDddFLGCv/TymU+ElxGonsUzYlmG5P6wN
         jF9Q==
X-Gm-Message-State: AJIora8TyKCmhCOZnEji1GnC5eFouL3mg8r00QsfMY2GM/fGV8KhksDn
        mMxEeR+3ffhnCrjY3lpwGgiQuInbkAopznu47RnClv06eCLEg/cm/YHFkI+Ckx8WwfXVgEB5tVE
        yAuaL5w+ymfGgfUB5Gzkyug==
X-Received: by 2002:a7b:c314:0:b0:3a0:5750:1b4a with SMTP id k20-20020a7bc314000000b003a057501b4amr8321580wmj.20.1658410967532;
        Thu, 21 Jul 2022 06:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ug2ArlCJqt7J1dKmM5rfPnxaF/fjypmxrD5aWpELpC2SRJSk58l4vg/VOciBPY0TDmY3lVgw==
X-Received: by 2002:a7b:c314:0:b0:3a0:5750:1b4a with SMTP id k20-20020a7bc314000000b003a057501b4amr8321560wmj.20.1658410967327;
        Thu, 21 Jul 2022 06:42:47 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-217.web.vodafone.de. [109.43.179.217])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm1893473wmd.36.2022.07.21.06.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:42:46 -0700 (PDT)
Message-ID: <163212be-f3b2-ca68-d28b-df4cf4039bc3@redhat.com>
Date:   Thu, 21 Jul 2022 15:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] s390x: intercept: make sure all output lines are
 unique
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, qemu-s390x@nongnu.org
Cc:     frankja@linux.ibm.com
References: <20220721133002.142897-1-imbrenda@linux.ibm.com>
 <20220721133002.142897-3-imbrenda@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220721133002.142897-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/07/2022 15.30, Claudio Imbrenda wrote:
> The intercept test has the same output line twice for two different
> testcases.
> 
> Fix this by adding report_prefix_push() as appropriate.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   s390x/intercept.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


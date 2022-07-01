Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F2DC43334
	for <linux-s390@archiver.kernel.org>; Fri,  1 Jul 2022 00:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiGAAAd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Jun 2022 20:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGAAAc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jun 2022 20:00:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F95599F1
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 17:00:28 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k15so777271iok.5
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 17:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PAlUtN7SL9XFXUbrECixMis635HqzUUk73c0sMI7wYQ=;
        b=DfCQu91v2qJm2MCzhcjWTkOT0huxiIQlwiVZG5YzaTebf7Tsp0l6inrI7eLwxnLfcp
         JlzvwikYppEaqvHZ8OOKoLOWlA48NEpZU1qT350aXgMNMAFcKQvJfm7Vsp8vgzUsVNdq
         0A0/687El+GnlHIf6Kt3F4csRQPHJQcE3kIwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAlUtN7SL9XFXUbrECixMis635HqzUUk73c0sMI7wYQ=;
        b=Kr9Gx68HFWkEEvk5rE8VGf5Pz/dy+9atwzhUbBYumODr1WGinYHiEshDMQUAdpDfEu
         8xpNHRxk5RuLE0sDPGOKFxemxG5sEC5jEKnzvEEBlYJdhiEvcLGiPe9bnGMhswkV4VUa
         o5GQiEh/4+1b2ia4VswYkXPgirUi1cfQ1cMDulTr8+9gBmA1IvH6HWmstvxK1DDtHAeA
         f0oxcpqbiOKoNRiWdv7CH3FywGSIHVRIUll13ALgs3cxHJF+7T3of0Yluxvaa2zTlBxw
         o5ugjeuuOaw9Y9njcLsw62+SWcWO5L1tFoT2xwTxcH8nCymisvnIl9sxe9N2xuQV1PiB
         b7pQ==
X-Gm-Message-State: AJIora/hPaFtkiE/vSOoLg2aOwCg27h2tQC9quR4WHfoaVyBS1bsqP7S
        ZbUWBEM+Atg7sjGJsJOQPzeNog==
X-Google-Smtp-Source: AGRyM1uSw8B+vZBkRjINHHYqtDGj7eh6OecWI5/rZOo1JZbRK/1RZMWA/BuiiXZfsp/eTd53J4KbaQ==
X-Received: by 2002:a5d:890d:0:b0:668:afd6:5477 with SMTP id b13-20020a5d890d000000b00668afd65477mr6274571ion.195.1656633628037;
        Thu, 30 Jun 2022 17:00:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k6-20020a02cb46000000b00331743a983asm7798694jap.179.2022.06.30.17.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 17:00:27 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add tools/testing/crypto/chacha20-s390/
To:     Siddh Raman Pant <code@siddh.me>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220628064621.14427-1-code@siddh.me>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <390aca1b-3b48-e0c1-07a1-ec8c29f0b8af@linuxfoundation.org>
Date:   Thu, 30 Jun 2022 18:00:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220628064621.14427-1-code@siddh.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 6/28/22 12:46 AM, Siddh Raman Pant wrote:
> This adds the maintainers' information for the
> s390 ChaCha20 self-test module.
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe5daf141501..0fcacd715b1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17438,6 +17438,14 @@ F:	Documentation/s390/
>   F:	arch/s390/
>   F:	drivers/s390/
>   
> +S390 CHACHA20 SELFTEST
> +M:	Vladis Dronov <vdronov@redhat.com>
> +M:	Herbert Xu <herbert@gondor.apana.org.au>
> +R:	Harald Freudenberger <freude@linux.ibm.com>
> +L:	linux-s390@vger.kernel.org
> +S:	Supported
> +F:	tools/testing/crypto/chacha20-s390/
> +
>   S390 COMMON I/O LAYER
>   M:	Vineeth Vijayan <vneethv@linux.ibm.com>
>   M:	Peter Oberparleiter <oberpar@linux.ibm.com>
> 

Doesn't look like you cc'ed the maintainers - please do and resend.

thanks,
-- Shuah

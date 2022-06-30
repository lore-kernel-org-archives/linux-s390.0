Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F40C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 30 Jun 2022 17:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiF3R4M (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiF3R4K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jun 2022 13:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 856DD37AAE
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656611768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hutr3rlRIoBI0yHWIgB4iXy7e3e90UBk0hpHVegM/w=;
        b=XbTYmF+pAx190tswN6jMBMPV9pAAA1kWEf/6OSTbs5NAtcCGgH13DD7buMGxlJhcptOII7
        7PX/WD9P9SbNsCHtCUq3pMbaRKJYfqXDf9tZIg47wclaFPpNJk7h5AI29WZ8gxSwNyU9hx
        eqqYzL68iPBLN2Lg6jPzgNNTYfaVY1w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-7Addm35LPwOiaxf_HwRLYg-1; Thu, 30 Jun 2022 13:56:01 -0400
X-MC-Unique: 7Addm35LPwOiaxf_HwRLYg-1
Received: by mail-wm1-f69.google.com with SMTP id n18-20020a05600c501200b003a050cc39a0so4399012wmr.7
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 10:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3hutr3rlRIoBI0yHWIgB4iXy7e3e90UBk0hpHVegM/w=;
        b=6OWqvqlpn8IMGy91FAxo7o+MfmV8SBeQCIj9JXRSjEQM1FU/EQft/xfImiOt2O/d/d
         miPO8yM9oHyiOLcSJaTXcR/9XfJQ0QV8HDsypb4L3EXXVGfUD3tsDmGDD4GsJzDKBTda
         0EGI6SjmfAwyb5f7JVgvHuEbKm7n6l5tN+DMl0Lu0//uaXf5ZwmJ03QRoyQluwP1Ewwk
         AHxOdchX9WXbgo9fAw8V4DTccJYoKDFE9cI+NTSdMWwuGW7qBqfgISd1HaGzIDZFcsf4
         ooys2KQoh/KdP8+KxKw0TJc7bV/gL0Vw7lRX1+eBhWOx753kRY3EoPlVruwTP37D+bh7
         zFsQ==
X-Gm-Message-State: AJIora+syVu5I7xapVEEFVGxLRzd8ES2piyI/b+WK425U3IntQSXQHpi
        83kRVxQ27EUV0oq9keGnE0M4dMML4bWLqafywRYT0XWIrgCAiIAgrbu3Ccwp3Vh8PicAMswY+g4
        BoJbm3Ud7MmsXrBKGTH7JWg==
X-Received: by 2002:a05:6000:88:b0:21d:2d0d:e1e4 with SMTP id m8-20020a056000008800b0021d2d0de1e4mr8410479wrx.525.1656611760466;
        Thu, 30 Jun 2022 10:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vpQnXc+h+ne+5eOxK2vvakOSnNeImuvCM3KprOYxuahjkKyMa8chy2G0Xz2+2m9A4k1eV01Q==
X-Received: by 2002:a05:6000:88:b0:21d:2d0d:e1e4 with SMTP id m8-20020a056000008800b0021d2d0de1e4mr8410452wrx.525.1656611760139;
        Thu, 30 Jun 2022 10:56:00 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-66.web.vodafone.de. [109.43.179.66])
        by smtp.gmail.com with ESMTPSA id m12-20020adfe0cc000000b0021d4155cd6fsm1328964wri.53.2022.06.30.10.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:55:59 -0700 (PDT)
Message-ID: <1dd3c230-da8e-023d-59b4-8c455c4a4836@redhat.com>
Date:   Thu, 30 Jun 2022 19:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [kvm-unit-tests PATCH v1 2/3] s390x: add extint loop test
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220630113059.229221-1-nrb@linux.ibm.com>
 <20220630113059.229221-3-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220630113059.229221-3-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/06/2022 13.30, Nico Boehr wrote:
> The CPU timer interrupt stays pending as long as the CPU timer value is
> negative. This can lead to interruption loops when the ext_new_psw mask
> has external interrupts enabled.
> 
> QEMU is able to detect this situation and panic the guest, so add a test
> for it.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/Makefile      |  1 +
>   s390x/extint-loop.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>   s390x/unittests.cfg |  4 +++
>   3 files changed, 69 insertions(+)
>   create mode 100644 s390x/extint-loop.c

Reviewed-by: Thomas Huth <thuth@redhat.com>


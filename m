Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC315C07E95
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 07:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB60561357
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 07:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhGDHua (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGDHu3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 4 Jul 2021 03:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625384874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2QZWUksOoTjx73EYiROtjmd+mxZplTS5TZg9mRj4g0=;
        b=GVxb6AFApVPLxNCx8SX3dsZd+cDbOSE6kMI2j31XL5F/K8+JbOmpHwDJSCUBPX86OyTtf/
        bcJfJekVPN8Q9dOm6NxMnqubBRVNJ1rT95B6sdba0oxZ+CbPkB0gdny2e7OeKqyyq/Bd7j
        40roePpAgV6WxW1L3h4AjGNzKHZbUZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-fN_4XOOGNii1xwynX-xHng-1; Sun, 04 Jul 2021 03:47:53 -0400
X-MC-Unique: fN_4XOOGNii1xwynX-xHng-1
Received: by mail-wr1-f71.google.com with SMTP id u13-20020a5d6dad0000b029012e76845945so3294704wrs.11
        for <linux-s390@vger.kernel.org>; Sun, 04 Jul 2021 00:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2QZWUksOoTjx73EYiROtjmd+mxZplTS5TZg9mRj4g0=;
        b=JMYtGULWaIA5QE24/5NpOj9+ibN5E1vXr1iYEVNJj62kYF4RCd+7EriyqF9ytnqicV
         xbQ/IHOzV9lItfQudYB5CzSHys+Wuti/5UCIc5n7bZW0EjPf0GaPwcPkVveWkvVBnAkA
         FbR0QIFveNahtvvCv4jsIdSeb3oW0/USunTF3IxFdGuXr1aFI25NDnDp5l7kCI7B1yRH
         xyzlXG1sC5QkTqNT1sDzeSUgI0danqPx00dZBbG1++bLFEcQRQ28Gdj9rg1FlfR53sWA
         NMAs3/2hAy7qSJJGj+rgxMWt/okTI1ax1aCFObGu+SbsSLJkO0GAy51L+tUKKY/a0smD
         7vLg==
X-Gm-Message-State: AOAM531+s8aawoG2drtLDFHAE6K5Xt0G6vw8NPpi53LcW8PQZMdOtdaW
        YjcNhIh8+xnaJGnmq+FnCtzHoetb6ZHM8SXANrGBvh3drgxdy37iMSGpf/06hL6qGtZsA7VV0PT
        JhpC+eXqKFlefgQhld/BVtQ==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr9047883wrp.16.1625384872061;
        Sun, 04 Jul 2021 00:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEkaoLKqVQpoHqg0xR5+a4fuPkf+KKWvPySuhByQzTCUMeuUQNKUB3BDYiHo3dPiqVOznI5Q==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr9047862wrp.16.1625384871907;
        Sun, 04 Jul 2021 00:47:51 -0700 (PDT)
Received: from thuth.remote.csb (p5791d89b.dip0.t-ipconnect.de. [87.145.216.155])
        by smtp.gmail.com with ESMTPSA id a9sm8750588wrv.37.2021.07.04.00.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 00:47:51 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/5] s390x: sie: Add missing includes
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210629133322.19193-1-frankja@linux.ibm.com>
 <20210629133322.19193-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <1fdf3f12-987f-7452-0f72-ef2999c218cb@redhat.com>
Date:   Sun, 4 Jul 2021 09:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629133322.19193-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/06/2021 15.33, Janosch Frank wrote:
> arch_def.h is needed for struct psw.
> stdint.h is needed for the uint*_t types.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/sie.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
> index db30d61..b4bb78c 100644
> --- a/lib/s390x/sie.h
> +++ b/lib/s390x/sie.h
> @@ -2,6 +2,9 @@
>   #ifndef _S390X_SIE_H_
>   #define _S390X_SIE_H_
>   
> +#include <stdint.h>
> +#include <asm/arch_def.h>
> +
>   #define CPUSTAT_STOPPED    0x80000000
>   #define CPUSTAT_WAIT       0x10000000
>   #define CPUSTAT_ECALL_PEND 0x08000000
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


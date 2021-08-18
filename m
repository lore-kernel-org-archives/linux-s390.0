Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25687C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006C6604D7
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 09:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHRJbd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233150AbhHRJbZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 05:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629279051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5co6SUgFv+sYfd3AIqoYyrmZWFs0jZYGZn1SyDwPzA=;
        b=IX5d1q/4wT5zGGjsx1zHPBedYcRh16zbbd6zxMpusoq5B+SJ/lTJ5lDt0zjwg/MpJloWXU
        gzksN1eX7jiQAjrCr+epzGmlxjc8FZ4YzSGp9ThTE6MfUY+T4Y3AIDs68Z4z8kpNFuPngt
        ZeiMEPwQJtb/dU2fUWne1M/vscG58kQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-yKDKwS6TPJmLnXB-q3Thvw-1; Wed, 18 Aug 2021 05:30:50 -0400
X-MC-Unique: yKDKwS6TPJmLnXB-q3Thvw-1
Received: by mail-ed1-f70.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so723773edr.16
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 02:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5co6SUgFv+sYfd3AIqoYyrmZWFs0jZYGZn1SyDwPzA=;
        b=qf0Z4F68dcwnF+irR9YwOzs/WvyMFMTubhGL2dMBfSbG2jGhHC/tI7l8FSHZfnSn7s
         JIDUxsq3Zlw+T/LPTKXNglELDylic1wCOmTm93zkzdXBxTrnb78Tojzy1lZ/GVPu5lGt
         wLfpslZXGkI3jKy40LulZycq+ZdpwtTHx/Z7KO+CsqOoViJngEd4qA3tNekRiufvmeZX
         nxqpVOTwKc8/3PlG+Tb+bTUr7G1eZNyPr7jSkJJ85cYRjid8o/f89fG9sEKOvMX9jxmq
         bFU3ZQK1LLRxpvXOZTwDrMh5VNeOjqBEE70WJUdesVyUM9HNomJERfx8P/0LGBo74P3C
         an8g==
X-Gm-Message-State: AOAM531Pm7kiIkgQvsuUediJmcA5Z4rekdylZrzLPzZpJwFy+jSh1I4G
        cbrW/rrb4mMIf3gkajEfxsXRUjJ1WP+GChCHWwL64UtvVj6NOIJIu2m1GL45r+DvVh3Roz5h1bY
        2LCgmiLyjTTZqB72/OfyV3g==
X-Received: by 2002:a05:6402:4412:: with SMTP id y18mr9191915eda.364.1629279048887;
        Wed, 18 Aug 2021 02:30:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWeeuBo6KB/pXYwy7SoP5LoIwsAbzuEL2C9i4LEj2h7EFL43n1ykmf5K/Dmz15yNBIghj6jg==
X-Received: by 2002:a05:6402:4412:: with SMTP id y18mr9191905eda.364.1629279048755;
        Wed, 18 Aug 2021 02:30:48 -0700 (PDT)
Received: from thuth.remote.csb (pd9e83070.dip0.t-ipconnect.de. [217.232.48.112])
        by smtp.gmail.com with ESMTPSA id c9sm2262703ede.40.2021.08.18.02.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 02:30:48 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 8/8] lib: s390x: uv: Add rc 0x100 query
 error handling
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210813073615.32837-1-frankja@linux.ibm.com>
 <20210813073615.32837-9-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <182d9128-89a4-7ae0-1e2b-ba1df17cc706@redhat.com>
Date:   Wed, 18 Aug 2021 11:30:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210813073615.32837-9-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/08/2021 09.36, Janosch Frank wrote:
> Let's not get bitten by an extension of the query struct and handle
> the rc 0x100 error properly which does indicate that the UV has more
> data for us.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/uv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/uv.c b/lib/s390x/uv.c
> index fd9de944..c5c69c47 100644
> --- a/lib/s390x/uv.c
> +++ b/lib/s390x/uv.c
> @@ -49,6 +49,8 @@ int uv_setup(void)
>   	if (!test_facility(158))
>   		return 0;
>   
> -	assert(!uv_call(0, (u64)&uvcb_qui));
> +	uv_call(0, (u64)&uvcb_qui);
> +
> +	assert(uvcb_qui.header.rc == 1 || uvcb_qui.header.rc == 0x100);

Don't you want to continue to check the return code of the uv_call() function?

  Thomas


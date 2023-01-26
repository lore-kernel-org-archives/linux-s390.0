Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DD3C54EED
	for <linux-s390@archiver.kernel.org>; Thu, 26 Jan 2023 06:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjAZGjq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Jan 2023 01:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjAZGjp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Jan 2023 01:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6566F4FC2B
        for <linux-s390@vger.kernel.org>; Wed, 25 Jan 2023 22:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674715137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwnaW40wODo/RPJeJh2TlciTsJYMAL7AVIWQnJnbBqw=;
        b=SnU3S1hGb+tn0O3MZ1cVMNdRVsvcGpJVOr7ybG3UeB6mGplFspwjjiBOJb7QShMq0cZwcI
        EQhtQxXfHD9LZbwuUBjGYX9vB5CnV5cqcKCxcDMfnQt8y+wXLm/LoEjxT4z86rb64MVeLI
        nTjzQn92U4M871wABFRozT6xsyyBcp8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-6ZLkS4wBNz-bUP9Sv8iIXg-1; Thu, 26 Jan 2023 01:38:55 -0500
X-MC-Unique: 6ZLkS4wBNz-bUP9Sv8iIXg-1
Received: by mail-qk1-f199.google.com with SMTP id u10-20020a05620a0c4a00b00705e77d6207so519266qki.5
        for <linux-s390@vger.kernel.org>; Wed, 25 Jan 2023 22:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwnaW40wODo/RPJeJh2TlciTsJYMAL7AVIWQnJnbBqw=;
        b=eThhMqhWpTBahN2P7yyCAkNk2GO/QPospU1DSNh7LyLhBQe1u6iwGbm5z+LwgYXUAX
         4syUAXgNyE/1v+PryZ/9xFe7VJEn3UOOeAKtuWRnenpeUnK5xRiX+b6XLdfZB2mP3ytm
         IYzakij1HKzSPFUCbacUcPs2KM9fvNRBYC/eV1bP8tXBHmIOS1Ust04kyMo+AmINkrN9
         qX7OUMYIzQ0+QrWCg99kR4YMIAQ/v/LnHUKcXl/7zIaQUom9MWIsWHcYNsQm1CnlSASQ
         M2ngz9cdzI+r8UzmlWRuT7F/40X/C+jR8iVZplp8hWT0J4G90VpToOC+4Ze+2A6SZljk
         ImIQ==
X-Gm-Message-State: AFqh2kqP4+5SenOZB7JtoXm5UG2AgOKNn55KIF/iw2ocblk9U36KZ+h2
        KjGITbcNpeDPmBrUcTptl2sBEYarxrQjisDzKPBCq6PMvCnVG39FPqwXHC5lXzQ5O4lHdM8KkeS
        kUv8rdFsQ3G279Y7okpBczw==
X-Received: by 2002:a05:622a:1aa5:b0:3b6:a1fd:19cd with SMTP id s37-20020a05622a1aa500b003b6a1fd19cdmr41574770qtc.46.1674715134723;
        Wed, 25 Jan 2023 22:38:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuf7UjZI2ffXZKoGViT9PivCgdjta/q3yUMmhqaU7OtGXYv4rT+XOka9LZmTzNCFQdUCAdNYA==
X-Received: by 2002:a05:622a:1aa5:b0:3b6:a1fd:19cd with SMTP id s37-20020a05622a1aa500b003b6a1fd19cdmr41574753qtc.46.1674715134495;
        Wed, 25 Jan 2023 22:38:54 -0800 (PST)
Received: from [192.168.8.105] (tmo-064-101.customers.d1-online.com. [80.187.64.101])
        by smtp.gmail.com with ESMTPSA id x8-20020ac84d48000000b003b63b8df24asm247352qtv.36.2023.01.25.22.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 22:38:53 -0800 (PST)
Message-ID: <957489fb-8080-8806-6ddf-8687da469a43@redhat.com>
Date:   Thu, 26 Jan 2023 07:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 07/14] KVM: s390: selftest: memop: Fix integer literal
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-8-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230125212608.1860251-8-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25/01/2023 22.26, Janis Schoetterl-Glausch wrote:
> The address is a 64 bit value, specifying a 32 bit value can crash the
> guest. In this case things worked out with -O2 but not -O0.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Fixes: 1bb873495a9e ("KVM: s390: selftests: Add more copy memop tests")
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 3ec501881c7c..55b856c4d656 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -514,7 +514,7 @@ static void guest_copy_key_fetch_prot_override(void)
>   	GUEST_SYNC(STAGE_INITED);
>   	set_storage_key_range(0, PAGE_SIZE, 0x18);
>   	set_storage_key_range((void *)last_page_addr, PAGE_SIZE, 0x0);
> -	asm volatile ("sske %[key],%[addr]\n" :: [addr] "r"(0), [key] "r"(0x18) : "cc");
> +	asm volatile ("sske %[key],%[addr]\n" :: [addr] "r"(0L), [key] "r"(0x18) : "cc");
>   	GUEST_SYNC(STAGE_SKEYS_SET);
>   
>   	for (;;) {

Reviewed-by: Thomas Huth <thuth@redhat.com>


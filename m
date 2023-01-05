Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD3C3DA7D
	for <linux-s390@archiver.kernel.org>; Thu,  5 Jan 2023 10:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjAEKGy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 Jan 2023 05:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjAEKGx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Jan 2023 05:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942513CE4
        for <linux-s390@vger.kernel.org>; Thu,  5 Jan 2023 02:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672913167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KoUWBAnd6FL/mfG+yeIEH93rjbYXLkBdS2xnTNfB3pY=;
        b=Sxk4Ed6X7aTCI67G8c2ObfpBT7XS/TncZN9Px5LCZeb9raYyfs/MRIRG1MNTBEmMv/vxbc
        MYNP1pPPLAo87+occxJvJfvDGjiLXfJ6cos7pTTffT1f+VoLTtKhjVT2V4jV3uzz0KKtR4
        uknZUrAQ1KIvXIeyix2kFdi9Dt3KlBY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-NhQeHayPOE6FSyWrmxsm3Q-1; Thu, 05 Jan 2023 05:06:03 -0500
X-MC-Unique: NhQeHayPOE6FSyWrmxsm3Q-1
Received: by mail-wm1-f72.google.com with SMTP id l31-20020a05600c1d1f00b003d9720d2a0eso778304wms.7
        for <linux-s390@vger.kernel.org>; Thu, 05 Jan 2023 02:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoUWBAnd6FL/mfG+yeIEH93rjbYXLkBdS2xnTNfB3pY=;
        b=LK1P57U44vitpzolMEPucjZBtsNIPn2I3oerkgx+0B/WFUiN3HFqH5tJw4t7AHeyp8
         RD+uR7JFR77HhbNQBFu//lWw7lEqy4+0ugS8dM+YUSSONol2VSYIGNqFyCngbUgwHYJC
         2emzWhBJhOYO+wq1mtZGYYUCH9G97RuIbQHq/JO4XRxeHMOAGBJHJ3Sel8r/3VAR8/ew
         PcKi+lBs72i0hskKO0Ym2XqjSNWCFiaxuzXG9NOM5zAlJxZKx91gLhmjJ3GimX5N2tqu
         zaZQAZ5X4azx/LONzjWalLiuETiA7i527lz8pFaJ3LG91acbaLNCRUJaBUJe8TgY+78O
         13Pw==
X-Gm-Message-State: AFqh2kqb0UDEZNe+ZNgTZpg9VXmA4kGWsJjtxBeWfO6fOeNFbt4J7o/D
        iUzjBFh1spFAcu1jEzAbl8lnGvRHcXDGpYltMpkE0EEM2l8bRAn1wbDTQOOl01ALxb00W6xd3dm
        VLnhtaOe/16uA20RDjuUXaA==
X-Received: by 2002:adf:da43:0:b0:250:779a:7391 with SMTP id r3-20020adfda43000000b00250779a7391mr29791936wrl.47.1672913162374;
        Thu, 05 Jan 2023 02:06:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXslGiIC8LlWUvexD9DQVF/QXglT71Bff5vDHiNPVqNKVgctXDR1uE8+JWvwz1ZoveMRfeRsFA==
X-Received: by 2002:adf:da43:0:b0:250:779a:7391 with SMTP id r3-20020adfda43000000b00250779a7391mr29791923wrl.47.1672913162195;
        Thu, 05 Jan 2023 02:06:02 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-176-239.web.vodafone.de. [109.43.176.239])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b002709e616fa2sm36058437wru.64.2023.01.05.02.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 02:06:01 -0800 (PST)
Message-ID: <6aac5837-221b-9f1a-347d-a44156c07bcb@redhat.com>
Date:   Thu, 5 Jan 2023 11:05:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [kvm-unit-tests PATCH v1] s390x: Fix integer literal in skey.c
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20230104175950.731988-1-nsg@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230104175950.731988-1-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/01/2023 18.59, Nina Schoetterl-Glausch wrote:
> The code is a 64bit number of which the upper 48 bits must be 0.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   s390x/skey.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/skey.c b/s390x/skey.c
> index 1167e4d3..7c7a8090 100644
> --- a/s390x/skey.c
> +++ b/s390x/skey.c
> @@ -320,7 +320,7 @@ static void test_diag_308(void)
>   		"lr	%[response],%%r3\n"
>   		: [response] "=d" (response)
>   		: [ipib] "d" (ipib),
> -		  [code] "d" (5)
> +		  [code] "d" (5L)
>   		: "%r2", "%r3"
>   	);
>   	report(response == 0x402, "no exception on fetch, response: invalid IPIB");
> 
> base-commit: 73d9d850f1c2c9f0df321967e67acda0d2c305ea

Thanks, I've pushed it directly as a trivial fix.

  Thomas


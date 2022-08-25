Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA94C04AA5
	for <linux-s390@archiver.kernel.org>; Thu, 25 Aug 2022 10:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiHYK5n (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbiHYK5m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Aug 2022 06:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BCAAB05B
        for <linux-s390@vger.kernel.org>; Thu, 25 Aug 2022 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661425060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgkUPi66b10fN5eQZBnFXaFmcWUym3wJVA23CZaFxu4=;
        b=cqyCu5O4X3ijb7c01ZM0M0RpDpbkHPAcdnGPjPz0MruE5oN1ODt8wdgyoK6tHWkaOc/GdB
        0S+SYGkqUtHUCvb6c44XyhL9tirycoon3Zyd6mStwo3EE/9cC0kLw27s/IUmFmhN+m3fy5
        1SQFvmUmNy/Dn4cAxJfBJ4kn4FM/L44=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-2m-e4uAjMuykP0cOEa8jTw-1; Thu, 25 Aug 2022 06:57:39 -0400
X-MC-Unique: 2m-e4uAjMuykP0cOEa8jTw-1
Received: by mail-wm1-f69.google.com with SMTP id n7-20020a1c2707000000b003a638356355so8586093wmn.2
        for <linux-s390@vger.kernel.org>; Thu, 25 Aug 2022 03:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FgkUPi66b10fN5eQZBnFXaFmcWUym3wJVA23CZaFxu4=;
        b=ShL13zWUesdPvFbs18x+t+ga5BXxzdugcQcQhOKW1IAlGowXxQmpiIK3LuS/JUJlwu
         5YTCeYuZ5zQDqfr+dAx2I6cX0vrSAjRv6GZaw0bS1Ur7w0wbtOOzNMm8aAd80lp7NuO4
         Ltv6qwcyMekMvpRf5g8gK5awXPE+HnjwYdPeBAiftUC6qseSuQfAWE2wWiCiXA4mm/mp
         QFCNxhOoYSEUeyP/VcPUctF7xIQjyJh7eGoyOmIx0mMrZHjcIrKFGaBW3+NGROu6dPk1
         haJ8vWmDwVc+XMLlJUVAZWDBMeU08xciPKFyByeFbbpK66ep0rRlPQtysNz32fEy3a5r
         2ggg==
X-Gm-Message-State: ACgBeo2UmUXVXZc74DtQOzVQ63xeuyMd/hQhI4LczcObeyw1cDWJqsbr
        mDWoY33+Lr6GbvcTqwfuQ6PEBIGUFFLeX1aygI30WfUwtHPuASIMrI93Um+IzB/SmIlncc4S+Ie
        3WqLan7Sp7jXmTbTnOjXO/A==
X-Received: by 2002:a05:6000:2ce:b0:225:2c5f:3ba8 with SMTP id o14-20020a05600002ce00b002252c5f3ba8mr1973299wry.138.1661425058020;
        Thu, 25 Aug 2022 03:57:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4MPhxbX3iYKcYN/4G9jyTlonkLAJjSJnnY4kJ7uM8Qb+IgchW5/oA+oejFBrsj734XrIpU0A==
X-Received: by 2002:a05:6000:2ce:b0:225:2c5f:3ba8 with SMTP id o14-20020a05600002ce00b002252c5f3ba8mr1973288wry.138.1661425057757;
        Thu, 25 Aug 2022 03:57:37 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-177.web.vodafone.de. [109.43.177.177])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003a5c2abc412sm5691360wmq.44.2022.08.25.03.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 03:57:37 -0700 (PDT)
Message-ID: <f7d86779-f67e-19eb-5ba1-da586ab6c6ef@redhat.com>
Date:   Thu, 25 Aug 2022 12:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220705111707.3772070-1-scgl@linux.ibm.com>
 <d5b7dea2-3a43-a018-1474-1bb47ca9a6ff@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Add strict mode to specification
 exception interpretation test
In-Reply-To: <d5b7dea2-3a43-a018-1474-1bb47ca9a6ff@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25/08/2022 09.37, Janosch Frank wrote:
> On 7/5/22 13:17, Janis Schoetterl-Glausch wrote:
>> While specification exception interpretation is not required to occur,
>> it can be useful for automatic regression testing to fail the test if it
>> does not occur.
>> Add a `--strict` argument to enable this.
>> `--strict` takes a list of machine types (as reported by STIDP)
>> for which to enable strict mode, for example
>> `--strict 3931,8562,8561,3907,3906,2965,2964`
>> will enable it for models z16 - z13.
>> Alternatively, strict mode can be enabled for all but the listed machine
>> types by prefixing the list with a `!`, for example
>> `--strict 
>> !1090,1091,2064,2066,2084,2086,2094,2096,2097,2098,2817,2818,2827,2828`
>> will enable it for z/Architecture models except those older than z13.
>> `--strict !` will enable it always.
>>
>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> 
> GCC 11.2.0 isn't happy
> 
> s390x/spec_ex-sie.c: In function ‘test_spec_ex_sie’:
> s390x/spec_ex-sie.c:70:17: error: format not a string literal and no format 
> arguments [-Werror=format-security]
>     70 |                 report(vm.sblk->gpsw.addr == 0xdeadbeee, msg);
>        |                 ^~~~~~
> s390x/spec_ex-sie.c:72:17: error: format not a string literal and no format 
> arguments [-Werror=format-security]
>     72 |                 report_info(msg);
>        |                 ^~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [<builtin>: s390x/spec_ex-sie.o] Error 1

Too bad that GCC isn't smart enough to see that it is a constant string... I 
guess we have to add an artifical "%s" format string here now?

> I have to page in the discussion again to know how this fits into the 
> picture. Either that or Thomas tells me it's exactly what he wants and I'll 
> add it to my queue once the compile problem has been fixed one way or another.

The point was that we wanted to use this k-u-t to automatically test a 
backport of the related kernel commit. Without the strict mode that is not 
possible since the test does not fail if the kernel backport is missing.

I just also noticed that I never replied to this v3 ... so FWIW, code looks 
fine to me (with the "%s" fixup on top of it), thus:

Reviewed-by: Thomas Huth <thuth@redhat.com>


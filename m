Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB6C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 27 Apr 2022 11:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiD0LTo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiD0LTn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Apr 2022 07:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E242525584
        for <linux-s390@vger.kernel.org>; Wed, 27 Apr 2022 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651058190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lD82ZVw7R4oth33emnzGpEKoVzB0nYZ0rQFbNb3eTlM=;
        b=NRoXLlfxpq2FqefA2A4WiN8d2SSj97YJTPSoAmE0CHNzunAexYhKHWjtmJuu+TJospk609
        x3XqmtvfTAREslhV/vRF84kVzZ/JU5CuoYWqDk26LjB2Zu/7DNyjzWXHlyUPws6vTwqxuE
        dVODnhZbr62LQh6+xOJ/LtQyD516NU8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-FtS8_JymPwGPPgbyowmz_Q-1; Wed, 27 Apr 2022 07:16:29 -0400
X-MC-Unique: FtS8_JymPwGPPgbyowmz_Q-1
Received: by mail-wr1-f72.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso622378wrb.13
        for <linux-s390@vger.kernel.org>; Wed, 27 Apr 2022 04:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lD82ZVw7R4oth33emnzGpEKoVzB0nYZ0rQFbNb3eTlM=;
        b=wpvruViPHwvkf5tGVXWIvhJJ731QsumxwWKOED0eAIuaYLJyJeMAn3Qr4JbkX8kKvU
         zHd8QQx5Uh0R9cwkDdCwGrB8TtWmgm6GRpFVFn5OKlMg6zh/LpXxnzWoyWSPb6lm6KoJ
         KcVzmfZJtmzDGzBNiHx0KkZ+R87dRYBgTEDST8Eirl1/9wy7GYfYGl+pZepH6drQQqKM
         KZ0JMGqtmwsQRinNs8pHMZxDtaKScExW20Qu3/oNBbGOt1i0gsztRT1NWtUVR5dbtAL3
         Cn1TH/DT973mTr3f798UmSv8APq/dJYZ2WcIGUUOcPkqZe3nPnkJ+OrP6Ii87i47DZXW
         djQQ==
X-Gm-Message-State: AOAM532NBiu+QurZuBdEW/MPFJbeHzonjY3xDkIfgEryQPJSz1OcNvTj
        KKi4xuap1vmxbG3fWrXPLUNlReu7uPnxNeG/d69hiqEz23YIHETDhqWy7xQaTYMZ0MF+CMK3Q39
        YkpIFQI1QsGA1hJYSvV6htA==
X-Received: by 2002:a05:600c:4e46:b0:393:f5fb:b3df with SMTP id e6-20020a05600c4e4600b00393f5fbb3dfmr7752885wmq.80.1651058188362;
        Wed, 27 Apr 2022 04:16:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH1Fyr7B5E9RCV/fty2KDzccN4Lj9Zik1drFAwE6YYWr5qOXc6O2hNlJCxc0Nrr/lGkUOHpw==
X-Received: by 2002:a05:600c:4e46:b0:393:f5fb:b3df with SMTP id e6-20020a05600c4e4600b00393f5fbb3dfmr7752871wmq.80.1651058188143;
        Wed, 27 Apr 2022 04:16:28 -0700 (PDT)
Received: from [10.33.192.232] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b00393e5967f08sm1319895wms.45.2022.04.27.04.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 04:16:27 -0700 (PDT)
Message-ID: <d6116a9c-ac9d-4473-a1e4-e524f4706f18@redhat.com>
Date:   Wed, 27 Apr 2022 13:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [kvm-unit-tests PATCH v6 3/3] Disable s390x skey test in GitLab
 CI
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220427100611.2119860-1-scgl@linux.ibm.com>
 <20220427100611.2119860-4-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220427100611.2119860-4-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 27/04/2022 12.06, Janis Schoetterl-Glausch wrote:
> The test cases newly added to skey.c require kernel 5.18.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   .gitlab-ci.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 4f3049d8..e5768f1d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -166,7 +166,7 @@ s390x-kvm:
>     - ./configure --arch=s390x
>     - make -j$(nproc)
>     - ACCEL=kvm ./run_tests.sh
> -      selftest-setup intercept emulator sieve sthyi skey diag10 diag308 pfmf
> +      selftest-setup intercept emulator sieve sthyi diag10 diag308 pfmf
>         cmm vector gs iep cpumodel diag288 stsi sclp-1g sclp-3g css skrf sie
>         | tee results.txt
>     - grep -q PASS results.txt && ! grep -q FAIL results.txt

Reviewed-by: Thomas Huth <thuth@redhat.com>


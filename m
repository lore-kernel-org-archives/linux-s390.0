Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E35C77B73
	for <linux-s390@archiver.kernel.org>; Wed, 31 May 2023 11:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjEaLSr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 May 2023 07:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjEaLSo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 31 May 2023 07:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC521AE
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685531865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3T2nAmOrVmwcKXZ6sK7jHxoUUbFeEl+9AVbRgRYZ+/4=;
        b=eZKaeJBu5aS5nCa7NW1SvEH3BimNj2qmXGrx4Hj7EWe9QMbNOx+IDaaXib3mU5N7zCFCYH
        wFnyxZ2NNKLThnR+t7y7F+RTZIazTxnNs5jW/RnQtqs9Gj3/09ZfveoOoJwvQErY9+Ti6f
        P31OX69+7776pik8GHtwBXZ7kK4120k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-qEpDJQ2dN9SnAWAV_CwXPQ-1; Wed, 31 May 2023 07:17:43 -0400
X-MC-Unique: qEpDJQ2dN9SnAWAV_CwXPQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f60911a417so25612815e9.2
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 04:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531863; x=1688123863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3T2nAmOrVmwcKXZ6sK7jHxoUUbFeEl+9AVbRgRYZ+/4=;
        b=A2DXiTTxM164/pKrYL71jMc4e3nNWHuGIXqRzlYrl/10GFsy2fZAuamykGg5uqH60Y
         IY25jn9/xuMoZoQ17npA6IIk8CRyOeL+tziJygBTOjQiN/l9kNvLm8AvGr4eVD2fCQPf
         iNiFzRzqW/CACWuQy+jZr/48HguHzOc4dLmpHyZIpdulDKNv3AV+IL5Sa7NRSgpIlxjd
         2a2cirruI6Gfq6uxA8p6I5H9l9E8AzZfFgFjxAwM0lEijhG7hKBzOy61J6FcjHieFoxi
         ZaZ0NGYL5kkruUdAcC7HhCiu2L6Iyoh62cASCYlfNoGPMlEaM5A68rrAsJIL6SibRecH
         pb5w==
X-Gm-Message-State: AC+VfDxRzpEKpA/US13dJ8LmB1Zj7SQte+0RCkKX/rwk2D5ByWgE74Fm
        sFbfFUEJdnc+48gYAmxT8WWQEgbdVQT9QOCoz+b/yzv1vF/raoZ79efGIzhPevxz8UJM4zmMb8h
        ojcs8JmySIHOcMcRUOIGfuA==
X-Received: by 2002:a05:600c:2150:b0:3f6:e59:c04c with SMTP id v16-20020a05600c215000b003f60e59c04cmr4328174wml.24.1685531862834;
        Wed, 31 May 2023 04:17:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wYQ7AnW0Wf8Dqmh35rHKhfQbb3NA2hCURHLgqKb9xwnuVEQb92wXEeryHObSYyBuM7U3A3A==
X-Received: by 2002:a05:600c:2150:b0:3f6:e59:c04c with SMTP id v16-20020a05600c215000b003f60e59c04cmr4328163wml.24.1685531862574;
        Wed, 31 May 2023 04:17:42 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003f4268f51f5sm20577594wmj.0.2023.05.31.04.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 04:17:42 -0700 (PDT)
Message-ID: <66a9a0da-30c0-2894-5a57-c746af48a4ea@redhat.com>
Date:   Wed, 31 May 2023 13:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [kvm-unit-tests PATCH v1] runtime: don't run pv-host tests when
 gen-se-header is unavailable
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, pbonzini@redhat.com,
        andrew.jones@linux.dev, david@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230531103227.1385324-1-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531103227.1385324-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 31/05/2023 12.32, Nico Boehr wrote:
> When the gen-se-header tool is not given as an argument to configure,
> all tests which act as a PV host will not be built by the makefiles.
> 
> run_tests.sh will fail when a test binary is missing. This means
> when we add the pv-host tests to unittest.cfg we will have FAILs when
> gen-se-header is missing.
> 
> Since it is desirable to have the tests in unittest.cfg, add a new group
> pv-host which designates tests that act as a PV host. These will only
> run if the gen-se-header tool is available.
> 
> The pv-host group is currently not used, but will be with Janoschs
> series "s390x: Add PV SIE intercepts and ipl tests" here:
> https://lore.kernel.org/all/20230502115931.86280-1-frankja@linux.ibm.com/
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   scripts/runtime.bash | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/runtime.bash b/scripts/runtime.bash
> index 07b62b0e1fe7..486dbeda8179 100644
> --- a/scripts/runtime.bash
> +++ b/scripts/runtime.bash
> @@ -98,6 +98,11 @@ function run()
>           return
>       fi
>   
> +    if [ -z "$GEN_SE_HEADER" ] && find_word "pv-host" "$groups"; then
> +        print_result "SKIP" $testname "" "no gen-se-header available for pv-host test"
> +        return
> +    fi


Reviewed-by: Thomas Huth <thuth@redhat.com>


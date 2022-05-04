Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA4BC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  4 May 2022 13:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbiEDN1e (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 May 2022 09:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbiEDN1d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 May 2022 09:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 964B4293
        for <linux-s390@vger.kernel.org>; Wed,  4 May 2022 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651670635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uB9pU3WVk0i1LuRdtZkceOYySjC3eD7Y4gfvJ3CK6XQ=;
        b=XWX5r759Z+3WbkgnSXDYwu6Bun1zf6EuyFhhSx0Iu4YhzVFqDQkv4CyJBRLFow+RTgm5nC
        whcuy2BUNPBPxHn8G8KTEL0uBfcJTH+e3wLAH1YZIVs2ZSusxLBa1sb3ItCOGP02+5EFHK
        neibyO1wkAT7T9+rgv+m7T9ZBIy4yxA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-RgmG9Vi1OlWoCMk8VQIfcA-1; Wed, 04 May 2022 09:23:54 -0400
X-MC-Unique: RgmG9Vi1OlWoCMk8VQIfcA-1
Received: by mail-wr1-f70.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso365704wrd.16
        for <linux-s390@vger.kernel.org>; Wed, 04 May 2022 06:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uB9pU3WVk0i1LuRdtZkceOYySjC3eD7Y4gfvJ3CK6XQ=;
        b=4v2Bxw7qLhyGkTabWznvJdzkQ5ly5MzPe6A1hnw+QWS19CT+4Gx1b7aPLHuQ3V1JVG
         WRzq3Ibyz8mMsEW1nL/4zIuUpvpS2S2VrvUxQALBKU3vF7RGMYPx7UMBFI8S5JSv/aJO
         K5EB90RfLCyTTycP+Zcm/Ve84w1BZ079OFl5oTkUVx07khnsCzp7EmhWrQr6z9ULhD9s
         pZYn239HV/gYPOi6DDEwZxh+KoD0LUsDN6a+2vId+ekjTvAlv48nDhREu9JShABtWCoJ
         ilGEhTgUBDIpOI2Fka6zXEjmcVzJjPpZiSCrdysNCw15X05yDzaCWph963u5T4vgCWGE
         bgsg==
X-Gm-Message-State: AOAM533Vb3c83grtm5Ab3rwqKk+Ib6MtfSIH7xjijvn1hHFTdJ1lu2Lu
        Kve/e7fpYRdDXKXT9wVs/4O854CWtLtCj6QItnoKtVbRLNIfwNl19QOIHxhwp0fpomqPKOm5Vke
        DEZKpWVLTdzaRm0AhWdQEMQ==
X-Received: by 2002:adf:dd92:0:b0:20a:d831:222f with SMTP id x18-20020adfdd92000000b0020ad831222fmr15769067wrl.401.1651670633213;
        Wed, 04 May 2022 06:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvpC4eWO+EkcHxIjmYLwcOyVO824hC0NLRSv7y0o2o3UBKigLcRd1t3LvZPdAjJYDFVkO8tA==
X-Received: by 2002:adf:dd92:0:b0:20a:d831:222f with SMTP id x18-20020adfdd92000000b0020ad831222fmr15769057wrl.401.1651670633035;
        Wed, 04 May 2022 06:23:53 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id c29-20020adfa31d000000b0020c66310845sm6627973wrb.55.2022.05.04.06.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 06:23:52 -0700 (PDT)
Message-ID: <a5b2fc92-6d7a-54c9-9fcc-dd9b137c4c40@redhat.com>
Date:   Wed, 4 May 2022 15:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [kvm-unit-tests PATCH v7 1/3] s390x: Give name to return value of
 tprot()
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220502154101.3663941-1-scgl@linux.ibm.com>
 <20220502154101.3663941-2-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220502154101.3663941-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 02/05/2022 17.40, Janis Schoetterl-Glausch wrote:
> Improve readability by making the return value of tprot() an enum.
> 
> No functional change intended.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 11 +++++++++--
>   lib/s390x/sclp.c         |  6 +++---
>   s390x/tprot.c            | 24 ++++++++++++------------
>   3 files changed, 24 insertions(+), 17 deletions(-)

Looks fine!

Reviewed-by: Thomas Huth <thuth@redhat.com>


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D83CC43217
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 08:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiDLI11 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380137AbiDLIVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 04:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5448330F54
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649749770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OG+b8XR8kIG1NTnOndyXW6RIWuaIfi44i3pndShsMQ8=;
        b=AdkudwlrVVsQWbakqCBhGFi0LgcNuKyV4WUiSP1ToF/Pq42uap4GrLwujytcDHhJv/M6XV
        7bVUVX9KUgGxzW3c16x/uBiDTDzfNT5XZJJ9vmWLsUzSwhs3NQWWEI6K2CH5hUDCOBM4eo
        AkshhZN8u39CuFHC8FYV67/IWsheIEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-jAH2PI2XPnmrNhENKAvlcw-1; Tue, 12 Apr 2022 03:49:29 -0400
X-MC-Unique: jAH2PI2XPnmrNhENKAvlcw-1
Received: by mail-wm1-f72.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so930415wmp.3
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 00:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OG+b8XR8kIG1NTnOndyXW6RIWuaIfi44i3pndShsMQ8=;
        b=UJZa/zXU3b06q9lQslXdmxPjXq+WbHc73COzxjOH9RFF+WIBjPbR841EFgU1hPV27r
         4ah0sSrcRTSU3IuIGHj4gwgJXk29za2l8dbCkpOpgRQO8Yw7qaqRqHT7fTUtX98Vh7qJ
         0nJ5t0Bhu9/wtnQUEe5v54YQEaj55R7BhpZu5ChJaOvbpI2+FNZhhi5TU4S5bybEC532
         ZAyS/37+wtWcG/Jau9DUwA5Kg6uY21+GWS4rVc1fOChxa3Mic9eByOtlwi2Vd9oePuO0
         HaVJvOM2l7tGXpa5McaR/v6cvYoVAq2lNaiXbISudWNC1PgSNGVlJpGR3W/hwSQO6E1S
         gB/g==
X-Gm-Message-State: AOAM53335ElPpYnPoAhw/v9a5PHpNryWvLInvrcFXIuUK73S/LhsdApg
        kDqERVEze/s4fMK6TbnOoXj60r/DAaBbV8E+XICFQfY4X1Fr6UzpeSgLlGhyvTRWYqayOkSqvU2
        u6KDVm6q/bOYTsNKdit6y9g==
X-Received: by 2002:a1c:7519:0:b0:38e:6bc6:ec7f with SMTP id o25-20020a1c7519000000b0038e6bc6ec7fmr2856341wmc.53.1649749768199;
        Tue, 12 Apr 2022 00:49:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9Frwsa5AmU5trCGWjKgeNe3CigmzaFCanXNtpBZpPhgAf3HVbRSAYp4kZYEZxQqArgH+vVg==
X-Received: by 2002:a1c:7519:0:b0:38e:6bc6:ec7f with SMTP id o25-20020a1c7519000000b0038e6bc6ec7fmr2856325wmc.53.1649749767989;
        Tue, 12 Apr 2022 00:49:27 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm1597083wmq.46.2022.04.12.00.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:49:27 -0700 (PDT)
Message-ID: <9e87f40c-3270-ebc3-7afe-13a3489940d1@redhat.com>
Date:   Tue, 12 Apr 2022 09:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH v1 4/4] s390x: add selftest for migration
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220411100750.2868587-1-nrb@linux.ibm.com>
 <20220411100750.2868587-5-nrb@linux.ibm.com>
 <5073d0fc-1017-5be6-2ec5-2709be14c93c@redhat.com>
 <4b7a793f9ab64eb6c5375a12844006bc86c0c752.camel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <4b7a793f9ab64eb6c5375a12844006bc86c0c752.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/04/2022 09.41, Nico Boehr wrote:
> On Mon, 2022-04-11 at 17:30 +0200, Thomas Huth wrote:
>> Thanks for tackling this!
>>
>> Having written powerpc/sprs.c in the past, I've got one question /
>> request:
>>
>> Could we turn this into a "real" test immediately? E.g. write a sane
>> value
>> to all control registers that are currently not in use by the k-u-t
>> before
>> migration, and then check whether the values are still in there after
>> migration? Maybe also some vector registers and the "guarded storage
>> control"?
>> ... or is this rather something for a later update?
> 
> My plan was to first add the infrastructure for migration tests
> including the selftest and then later one by one add "real" tests.
> 
> But if you think it is preferable, I can extend the scope and add some
> inital "real" tests in this series.

I think a simple test that checks some register values should not be too 
hard to implement, so I'd prefer that instead of this simple selftest ... 
but if you're too short in time right now, I also won't insist.

  Thomas


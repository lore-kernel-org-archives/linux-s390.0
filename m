Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B046C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 11 Apr 2022 13:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiDKNdH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346504AbiDKNdF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Apr 2022 09:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC05B3BA6C
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649683849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wYuQwCwBuMvv4GuQmTlOIcD0Aef3LCA6p6M6pCQq0jw=;
        b=NHu9u2xLlTgzeWgPuyeyIG52SfofXEMyU0T+Wl7vZSxByXCOVu0uH7c6UnBq0v7TS2T+yP
        J919+VP4RqVk2BFCVEksJmeBNakQMm6RSJC2kSn2PN/qZwO9FqqXfr0maMOJyY+AFl5c+0
        YOfr5BA26H+oeoyN5j+5HEiF3pC5RP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-H9lvwFnbPe-gs7FKAGt5lw-1; Mon, 11 Apr 2022 09:30:48 -0400
X-MC-Unique: H9lvwFnbPe-gs7FKAGt5lw-1
Received: by mail-wm1-f70.google.com with SMTP id q25-20020a1ce919000000b0038ead791083so4136338wmc.6
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 06:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wYuQwCwBuMvv4GuQmTlOIcD0Aef3LCA6p6M6pCQq0jw=;
        b=GpIcnpXKIRlNEoo2hmm8g8L1VJScxjwLutCQ7KGUDrrerzA91lWA2HqNutPfjPZYF4
         qkF2O1IQuC/CVZL/0CIx2XtRouCL1jzIVpkg1oFbHj0CAaLGigoIBAEoHuvf1ykh7Hto
         iN0Lktn6pXtsFOONbIAOXoW7N9UXSN+aBv2UyEz8W9tZuYNL3Nfv2UfJ1SIri/Cl8WGM
         kph3Tnh/XE5STFW8M+MUW5Tmm7dnkvEsxjGKGnIQeoqOLj+e6FBdG3ltHWn+LU8cOZ4/
         Hvrp9aARN3erA9cOON/u0ZUXWgFjs8VYLLqMO4QPemioBEXnYDjeq/xUMD7OFPt1rimC
         jMqA==
X-Gm-Message-State: AOAM531djjo8W88rE78kfoTVcb/84eRb8kr/v4RPhXjZI5nBbWhsp2P7
        biS4Mf5kJ7a8PUQ9Cdnw4PBdCLEFQn23EoDg8RK57JShVDB0WAhKOXOLmuC1QglgZb7q+n1NDI4
        nbQZI77FFwudLU7shAzzsJw==
X-Received: by 2002:a5d:4702:0:b0:206:b8d:3dce with SMTP id y2-20020a5d4702000000b002060b8d3dcemr25197099wrq.646.1649683847637;
        Mon, 11 Apr 2022 06:30:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH1IMm0yQS1HQxAAJ7UDv/oLR6k19JoMRWq5/dXl7LYLPG8zJgObfrGCcRPNr0kaMyhoSBEA==
X-Received: by 2002:a5d:4702:0:b0:206:b8d:3dce with SMTP id y2-20020a5d4702000000b002060b8d3dcemr25197086wrq.646.1649683847399;
        Mon, 11 Apr 2022 06:30:47 -0700 (PDT)
Received: from [192.168.42.76] (dynamic-046-114-150-143.46.114.pool.telefonica.de. [46.114.150.143])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm23248726wms.26.2022.04.11.06.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:30:46 -0700 (PDT)
Message-ID: <4dd6a7a4-82c5-d3e7-7f0b-ebabce4b54c2@redhat.com>
Date:   Mon, 11 Apr 2022 15:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH v2 1/9] lib: s390x: hardware: Add
 host_is_qemu() function
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com
References: <20220407084421.2811-1-frankja@linux.ibm.com>
 <20220407084421.2811-2-frankja@linux.ibm.com>
 <814e7115c178c3dc6613c3935a7c81a29d72c19a.camel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <814e7115c178c3dc6613c3935a7c81a29d72c19a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/04/2022 13.46, Nico Boehr wrote:
> On Thu, 2022-04-07 at 08:44 +0000, Janosch Frank wrote:
>> In the future we'll likely need to check if we're hosted on QEMU so
>> let's make this as easy as possible by providing a dedicated
>> function.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> 
> Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
> 
> We could also adjust the check we already have in s390x/epsw.c to use
> the new function, but also fine to leave as-is.

I'd suggest to fix it: It has the same "goto done" + prefix_pop problem that 
we recently saw in another patch, too.

  Thomas



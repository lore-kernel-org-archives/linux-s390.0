Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5278C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6066126A
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 15:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhJEP5O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233705AbhJEP5O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 11:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633449323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Knrgx1p0E4Syq4cv3Q9wXGfwnzsMCY1cNYGxXsf45qU=;
        b=U/RltBQhxICZ//iEEh/JtjA3TWc6iP49XwuTE2kbfjX1ULVtjPortjw77FMfnI35YeyfbU
        ymqBQRU5ST66RZPAtCgrI0kbPYLfvP/y6bR5Gh+YbZ4dQB0cwTQNmsDn2M42Y49ELoy2Gs
        eAjSphMvugfSnE5oU704Hz1/eB5gHb4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-Vk6z663XNl6kyNv5gEIfbA-1; Tue, 05 Oct 2021 11:55:22 -0400
X-MC-Unique: Vk6z663XNl6kyNv5gEIfbA-1
Received: by mail-wr1-f71.google.com with SMTP id m17-20020adffa11000000b00160c1ac74e9so186323wrr.9
        for <linux-s390@vger.kernel.org>; Tue, 05 Oct 2021 08:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Knrgx1p0E4Syq4cv3Q9wXGfwnzsMCY1cNYGxXsf45qU=;
        b=DJkFpPulU5A3LMzSki6sbQ9TP5cNKn4I0JzF1YSMlnFmGbYh4OPU4Km7+7q60gxLei
         RIe+PB7viFpZOEt0I9VV/j7L1dcEABfWiZ21C3Mwt1+31gBvkxYx1CoX/zRMtIOS4a6d
         DrXk8yt9kQh6XJC/cSqmO87ZzfwZZ4oBV0cff5keY/odPo9A4yb61vE5kpjdUeHWCCMy
         o4csMRJccyauPK4J5s5L1jAMsq3QVAwC5Yan7sU4pcYjG4aYn/UYFXCOrxmCaEDDi6cZ
         zNsy0O3rE8KgcUX5EWwB/hLpQ7BXOLN32ZZz0PorO0AScaDOcy63C6tm/FO4V7NiB1Zr
         Sl+g==
X-Gm-Message-State: AOAM530zM+R10rCO5OmZCsjSJVSdFFNlDJVaXzixkWl0GJmj9elRRjA4
        9Gl4RPhYTUrn5UHhnAGOCU7hHFfIMfU6ZqQA8PeVtMa+RSUCVf1PHMaFeWzZ6VrE9DRX9af9Rcq
        QerLrhq+hmrpoYEbbXZkFnAnYO3iMXZetiZ5WUCdG3sKzlfn1WFB6taLIelVzsbfB2iwr0w==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr22077821wri.74.1633449320965;
        Tue, 05 Oct 2021 08:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkx/b64SdlXraxRD5U/8/X/FIi8ODqBzjeS0JNxqNXS+psNHgWCHfWG9+BO7th6t0E8e7bGA==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr22077784wri.74.1633449320676;
        Tue, 05 Oct 2021 08:55:20 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id i1sm19158556wrb.93.2021.10.05.08.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 08:55:20 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH] s390x: remove myself as reviewer
To:     Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20211005154114.173511-1-cohuck@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <a1163106-f9b9-d733-3701-2d0a08acb612@redhat.com>
Date:   Tue, 5 Oct 2021 17:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005154114.173511-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/10/2021 17.41, Cornelia Huck wrote:
> I don't really have time anymore to spend on s390x reviews
> here, so don't raise false expectations. There are enough
> capable people listed already :)
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fc01a5d54a1..590c0a4fd922 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -87,7 +87,6 @@ S390X
>   M: Thomas Huth <thuth@redhat.com>
>   M: Janosch Frank <frankja@linux.ibm.com>
>   S: Supported
> -R: Cornelia Huck <cohuck@redhat.com>
>   R: Claudio Imbrenda <imbrenda@linux.ibm.com>
>   R: David Hildenbrand <david@redhat.com>
>   L: kvm@vger.kernel.org

Applied.

Thank you very much for your contributions, Cornelia!

  Thomas


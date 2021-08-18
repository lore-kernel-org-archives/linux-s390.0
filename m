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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A15C432BE
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE7460FDA
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 07:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhHRHql (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 03:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239077AbhHRHqh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 03:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629272763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCowTlaMQAD68xtCnxiOgZAAhU7pcJc15uXzKgwx1gA=;
        b=H/MEy0B+hJJrBr0LdAYdm/NQw7n4iKjMtW7HL044VrrW7viEvrjh1GBW8f8VTG/opoHuXl
        coUbapr8z0wwE8GDxkQriTqoKmRwE84t9QRkqeEP8BsM5U38yesuoMZXW/XfoPRjaX0o/l
        wgCJj7Bh2Crf33a6phh4O0yJPrJ4vz0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-e6zgzjgJMI2urZQ576-N9g-1; Wed, 18 Aug 2021 03:46:02 -0400
X-MC-Unique: e6zgzjgJMI2urZQ576-N9g-1
Received: by mail-ej1-f71.google.com with SMTP id gv53-20020a1709072bf500b005c0428ef7e7so534468ejc.21
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 00:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WCowTlaMQAD68xtCnxiOgZAAhU7pcJc15uXzKgwx1gA=;
        b=RD9/XPxc5U+me/SFScr9re6Z2gdLOBt7myjIpBCXiF0WAGFfuJvF7iAAOSF4PPCpdB
         +fCBwsWzy0Db3ZhZvb4VHSTiTDmDF8O9/eo0MBvNZh2HWaIGzm9HAigGpnxtXWiBUAr/
         nVWOne4H8sKBOf0GCjYkvw+e6jc9bFckA6p1KlS3xF9OZyBZVc8QW6+9b/dIY5RFh36q
         hp6irmOM9Xa5EXxoad/FRSQJ/KGi5QWS+IIzaiEhm4GFcH/BOefqbKqZwnNHdumHgyFX
         4W/k6MSF68/47jwcj2jAHyfsEj5KGTUT1gNeRuqaCI+Bai5YTOY0DWgve0COOaZcb90D
         4yJQ==
X-Gm-Message-State: AOAM531udWyrBsL5iSzJQiqRxs4Ua9X1uHX3x+67LaxUybW/AuT1LLHR
        SjsK4pu20rI86qr3TQBsp/8NiNOj3TSpvwCacZ44+8WIRQ+NOIPX65KFJ7DEhdgeyJbJLMlqRgZ
        73akHg5FOrqURKpShelpgcQ==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr8764964edt.18.1629272760827;
        Wed, 18 Aug 2021 00:46:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhDmLt+U3d68thSr+ArCpDO4Vg0vRAT+H0A6FI4PylM3dlwrN11JjJ5ZfPGFw43nLyFFFuHw==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr8764954edt.18.1629272760698;
        Wed, 18 Aug 2021 00:46:00 -0700 (PDT)
Received: from thuth.remote.csb (pd9e83070.dip0.t-ipconnect.de. [217.232.48.112])
        by smtp.gmail.com with ESMTPSA id v8sm1667329ejy.79.2021.08.18.00.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:46:00 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 2/4] s390x: lib: Simplify stsi_get_fc
 and move it to library
To:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, kvm@vger.kernel.org, cohuck@redhat.com,
        imbrenda@linux.ibm.com, david@redhat.com
References: <1628612544-25130-1-git-send-email-pmorel@linux.ibm.com>
 <1628612544-25130-3-git-send-email-pmorel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <887680c1-f5e7-0fdb-2195-e501e607c905@redhat.com>
Date:   Wed, 18 Aug 2021 09:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628612544-25130-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/08/2021 18.22, Pierre Morel wrote:
> stsi_get_fc is now needed in multiple tests.
> 
> As it does not need to store information but only returns
> the machine level, suppress the address parameter.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 16 ++++++++++++++++
>   s390x/stsi.c             | 20 ++------------------
>   2 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


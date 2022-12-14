Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42039C4332F
	for <linux-s390@archiver.kernel.org>; Wed, 14 Dec 2022 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiLNJYM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Dec 2022 04:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNJYJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Dec 2022 04:24:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE161EC71
        for <linux-s390@vger.kernel.org>; Wed, 14 Dec 2022 01:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671009801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7575zCJt/W+bOCfmNqE0fJaW9dUNr74ly+FhAEM/HvY=;
        b=gX/zBXPIfQJzCKqaW8LkVMy30dA7neW04DpfOOEx3y60kr0efAUkEvz3gqErKtiA7Qg5/8
        8r6BCV74j8+lAAk9gaUWmub1F7//1XBHQtCCt3CgyvYCcryAGbhRAdJJ/8Ji3l78KvQvKL
        uq/ucl9jHh8Tqi1H4CmC9dbhdOoB/uo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-298-jCJ3dJI-OCeICseduK1NyA-1; Wed, 14 Dec 2022 04:23:12 -0500
X-MC-Unique: jCJ3dJI-OCeICseduK1NyA-1
Received: by mail-wm1-f71.google.com with SMTP id p14-20020a05600c204e00b003cf4cce4da5so3941461wmg.0
        for <linux-s390@vger.kernel.org>; Wed, 14 Dec 2022 01:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7575zCJt/W+bOCfmNqE0fJaW9dUNr74ly+FhAEM/HvY=;
        b=tgGi2cESKIUtgicR+IcAb8a+ehcI5kSuP5mUTS6qgNqjSI1195JqwLxHMUhVehF1AC
         mdDUfNNGEOTO8rhyVGHSzx0n7EUE1bTfxqAkU3a1tLRj2PLqGxLQ5MZ50PNzsEsGziQ5
         MZhCgKcBZhld4HvZgO7ddlYjHBZ4OXdC5yzWywcAJIqaBcEkLEwqGW6DjNNSZZXkuYvY
         L+0vAb0bPesP8F3Un2w6gCJ2yjXZZZZ1XhSlrR2kzXvPZ2XynI8kdfeWuq0hM+Qk5r0e
         FvOTkB3GW1aUcSdeHvSjC7Gw5KXgOVAOI1jf2Fel4XdGrpVpE8+IAia3hPm09loH9Zf5
         6aEQ==
X-Gm-Message-State: ANoB5pn5yzj1mBJGc5EqAT8CZ3H2YgffYdy0x4RqaBotpdRjThMdDQQ1
        FLDVaOvBK4R08/P45vN26t3MXKM9wN0qb96cF5fHd5ChoVSDSLFeFN/Jh03lz4gMqVLHdJXHWkM
        Rri9uy7DSa9xbc4Z2Ord3Tg==
X-Received: by 2002:a05:6000:1f81:b0:250:22e4:b8a6 with SMTP id bw1-20020a0560001f8100b0025022e4b8a6mr5865919wrb.39.1671009791739;
        Wed, 14 Dec 2022 01:23:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5BsrFQrZiqcKQNGodRXeWHRfYLzojFhTjRKPMU8We633YCGl8jewbotKhhnFGoVJScipq0ng==
X-Received: by 2002:a05:6000:1f81:b0:250:22e4:b8a6 with SMTP id bw1-20020a0560001f8100b0025022e4b8a6mr5865908wrb.39.1671009791515;
        Wed, 14 Dec 2022 01:23:11 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-178-56.web.vodafone.de. [109.43.178.56])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b00242271fd2besm2257482wrv.89.2022.12.14.01.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:23:10 -0800 (PST)
Message-ID: <4e8cc757-13e2-3be4-fea2-3ef3dcd0688d@redhat.com>
Date:   Wed, 14 Dec 2022 10:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 4/9] KVM: s390: selftest: memop: Replace macros by
 functions
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
References: <20221213165405.2953539-1-scgl@linux.ibm.com>
 <20221213165405.2953539-5-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20221213165405.2953539-5-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/12/2022 17.54, Janis Schoetterl-Glausch wrote:
> Replace the DEFAULT_* test helpers by functions, as they don't
> need the exta flexibility.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 82 +++++++++++------------
>   1 file changed, 39 insertions(+), 43 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC6C43334
	for <linux-s390@archiver.kernel.org>; Wed,  6 Jul 2022 10:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiGFK4o (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Jul 2022 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiGFK4m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jul 2022 06:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D635C27CCD
        for <linux-s390@vger.kernel.org>; Wed,  6 Jul 2022 03:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657105000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/wJBIQMjQXHihYW5LMkQtlLCNLD2Wr07KvMl7IsHW4=;
        b=h8mUllfxzdLTYnN22VAW1cSesUZ9YTSmbPhU8olOj0j0KsePcRNyuDx84Im5qetcxNHwf9
        43ghmHb6BvktvZR4RGTg0Qp5HCPo+VQ98v+fdDp7UM3vQwxcXcSO/gOAJV9k4V08tgb+pr
        bXHPGbujkID6E1J5alVnbc3aHLorKo8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-LMMVFpU2OlOWh6o-h0r6NA-1; Wed, 06 Jul 2022 06:56:37 -0400
X-MC-Unique: LMMVFpU2OlOWh6o-h0r6NA-1
Received: by mail-wr1-f72.google.com with SMTP id q12-20020adfab0c000000b0021d6dcb51e8so1559906wrc.13
        for <linux-s390@vger.kernel.org>; Wed, 06 Jul 2022 03:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z/wJBIQMjQXHihYW5LMkQtlLCNLD2Wr07KvMl7IsHW4=;
        b=okEMX3Q8KT88qwmUQ+g3B+gKIw0PuSGpj7zubPVT7W4gwBjFtgPb5V3IcDjNashAl0
         fuJlldHN0Ezy1oDntO/+CDQPb/6hNOQ83weTezzWwWo+N5UjxdvSYRZuaiHAvDfGL+um
         FBi0NRy6KxM+M6oAZqQVmR380tiYGqtgK5MYSf15ZofkS4rju40YggpXBeIXgXnvkKaw
         wDqF+ebSU0ZIl9apDkC+AJvCsch871KnIJGi3z9lqiOGU7T68bjNkQu97TLcuJaHxP1e
         1r0xn23pS/YJ/E1MCxdLk8P0Rz4DaGrieZZLcZPB5Iht4HEFPGPcOOh7GlxUAEN42H1n
         IQxA==
X-Gm-Message-State: AJIora/IxScHUX9WouosLOW35zdEkFH6VUG4hfYKaTLz49NO/xrPLK4w
        V3FaaAQU4TdU6mIsyoLSPiZ8MRvDHxuhUqnavhL57D/RfBQ+2HOds8LLvCXrTobgh1tO3+QXxWj
        WPTd0oq3THw6u1d/ddIGjUw==
X-Received: by 2002:adf:d845:0:b0:21d:7aad:4802 with SMTP id k5-20020adfd845000000b0021d7aad4802mr3960295wrl.298.1657104996676;
        Wed, 06 Jul 2022 03:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVRo3xdQzziMgNyy3w+U0LX+6pVPdWBhaUjBqu26EhEo4yp8pMXXkY8E7GbEjBz4b071ZXcw==
X-Received: by 2002:adf:d845:0:b0:21d:7aad:4802 with SMTP id k5-20020adfd845000000b0021d7aad4802mr3960271wrl.298.1657104996459;
        Wed, 06 Jul 2022 03:56:36 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-21.web.vodafone.de. [109.43.176.21])
        by smtp.gmail.com with ESMTPSA id r11-20020adfce8b000000b0021d77625d90sm3176005wrn.79.2022.07.06.03.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 03:56:36 -0700 (PDT)
Message-ID: <932d0d05-5518-da8b-ef9f-986cf6b613e0@redhat.com>
Date:   Wed, 6 Jul 2022 12:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] s390x: split migration test into vector and gs test
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220704133002.791395-1-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220704133002.791395-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/07/2022 15.30, Nico Boehr wrote:
> Since we now have a few more migration tests, let's split migration.c
> into two files for vector and gs facilities. Since guarded-storage and vector
> facilities can be en-/disabled independant of each other, this simplifies the
> code a bit and makes it clear what the scope of the tests is.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/Makefile                         |   3 +-
>   s390x/migration-gs.c                   | 122 +++++++++++++++++++++++++
>   s390x/{migration.c => migration-vec.c} |  54 +----------
>   s390x/unittests.cfg                    |  15 ++-
>   4 files changed, 136 insertions(+), 58 deletions(-)
>   create mode 100644 s390x/migration-gs.c
>   rename s390x/{migration.c => migration-vec.c} (77%)

Makes sense.

Acked-by: Thomas Huth <thuth@redhat.com>

PS: Please have a look at the end of the README.md file to see how to set a 
better default subjectprefix for k-u-t patches. Thanks!


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E397C38A2D
	for <linux-s390@archiver.kernel.org>; Tue,  5 Apr 2022 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354006AbiDEKKg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351809AbiDEKDU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Apr 2022 06:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2CA7C7AB
        for <linux-s390@vger.kernel.org>; Tue,  5 Apr 2022 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649152344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YV3h6IbH3R7bzysIjqVSxtvZ2NxYhrSDn1NoU0aTwAU=;
        b=doItOHkOxD/j2h0rWHIOXf8Z76WrhDsUHzuiCdb3BXmzX9wgExT55xaPgX6p7g9B+Lejmp
        KCKmmM+XfhLq8FhF6in3K5OZHsIKIYQFp3V+vNmPpX50mtkf2GG703TjDnlc1h6IWgc8le
        bInNUH+htZ6ga1vO7VOfVLl/0MahKcw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-4BxNM0SfMQ2e3ZCmYk33NQ-1; Tue, 05 Apr 2022 05:52:23 -0400
X-MC-Unique: 4BxNM0SfMQ2e3ZCmYk33NQ-1
Received: by mail-wr1-f71.google.com with SMTP id e4-20020adfa444000000b002060b7347f8so1450289wra.6
        for <linux-s390@vger.kernel.org>; Tue, 05 Apr 2022 02:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YV3h6IbH3R7bzysIjqVSxtvZ2NxYhrSDn1NoU0aTwAU=;
        b=QYTkwqexb26moawQd4WQ1EDHrSZZbzyceq0T3p1379oIJuvqdlkrUnqE9nGTRrZM7u
         q3ez9Pc8ttaqq37Vy1trSCD21l9ZqYSE1zi3QVexbXNhaLVjZtuLCoTFR71jq7Q0HHtV
         VkbtZwrIH2cvqcrP+lBmG1lwe6RB5aDvJD8bW+RSyf5Ptfl0NUFpTYxfYmwtPZMrGd87
         GRpMPAKLMD1loMreVBz215jjGLXGEXiWksJs795Qf329KrF1NOqbj3XMmg3sScdnUnJq
         WK1pPhcOXQgT+ESQvbiUcaFOq60r9LmypWNCXVPCTqG3UEX0l+CYBRX8qX2zzL3DFvBh
         lT6Q==
X-Gm-Message-State: AOAM531QazKYoYO7t6/F1iUJHbo6wwyBNLf31YsnhjGy8SKLomBjuPdc
        rl+H9ZfmkzEB0pHYxUY/3cDt3Znte+BIHO9a7mJ73uucVyQWY+NGKenEOM7zCs7beP2Jy40gUbH
        6pYRetp0v9m4GeYIDdoyRmQ==
X-Received: by 2002:a5d:54ca:0:b0:206:13ed:ea88 with SMTP id x10-20020a5d54ca000000b0020613edea88mr2016291wrv.167.1649152341995;
        Tue, 05 Apr 2022 02:52:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZnsvVWPr2Wavl4feEsY3PORr1u038rOu8MEtGNDFMvYXOGoPfp0TfEKhEP/6HHOyeVpUwPQ==
X-Received: by 2002:a5d:54ca:0:b0:206:13ed:ea88 with SMTP id x10-20020a5d54ca000000b0020613edea88mr2016280wrv.167.1649152341842;
        Tue, 05 Apr 2022 02:52:21 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d53cc000000b00205a0ee9c74sm11158783wrw.89.2022.04.05.02.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:52:21 -0700 (PDT)
Message-ID: <5a99151d-f09e-b5ab-4397-2a0b97e42e41@redhat.com>
Date:   Tue, 5 Apr 2022 11:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH 3/8] s390x: pfmf: Initialize pfmf_r1 union
 on declaration
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nrb@linux.ibm.com, seiden@linux.ibm.com
References: <20220405075225.15903-1-frankja@linux.ibm.com>
 <20220405075225.15903-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220405075225.15903-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/04/2022 09.52, Janosch Frank wrote:
> Let's make this test look a bit nicer.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/pfmf.c | 39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


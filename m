Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8DDC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCE260FF2
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhI0PYy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235141AbhI0PYx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 11:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632756195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLWgq8Ps/oPC0mSTai3jxd98yGz66LpC4GDoo6xBDEs=;
        b=iwYSfjdH3OinvZrmOhR6tWw40DJa1zUKqyhnRBZQfBi/mCN4ZSw/T0YDI7/volBjYIPXzj
        zwgiNC6bijZL6UEyiUnh8AW/a9jQOqTUN3u/W7ZuFv6op19ZBvRDp+U8bOsluvORix6ZfJ
        5Qx1NkWIShUAid5y8B1W7Z+WZczjamI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-gf59wmIaOo6rJvHZ6EamdA-1; Mon, 27 Sep 2021 11:23:13 -0400
X-MC-Unique: gf59wmIaOo6rJvHZ6EamdA-1
Received: by mail-wm1-f71.google.com with SMTP id 70-20020a1c0149000000b0030b7dd84d81so382032wmb.3
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 08:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eLWgq8Ps/oPC0mSTai3jxd98yGz66LpC4GDoo6xBDEs=;
        b=CtLFqNwyJBCrAPM9T8hSdmC9NVrDc4YDXdvt1LxNPes7RkLR92hqlOny9C6L1c+BRK
         poDGhZVxxL+Bz7U+6FK5vNDlOaLw9aX43CEhvkICiWHpUIBhXzdSrk6d3T4+YFtmU+WW
         68xDlN5+WhGapZlvzcQtnmc+uzuDLit6l9dDCCuRn/bgq8IOOWZ0q1bJX0ZzJyPbIOG9
         bP6xJQl3tUrlyksbQFEGwUPq+OyBpdfI1a2xtRUxeNlZFinM4EIi9nzwlsnXLJZLdbZf
         mGMwt42rlcv8wzNdIl9vVSwRQdFE77PK8c3+BIQ66/tYY1DHX5YFAVYQ1hBUJqSm8sEJ
         dWMw==
X-Gm-Message-State: AOAM532lYkUwAaeqh5IccRnXRGgYtKVpA+ISBbbQZ11AMBoYQ/eb/71j
        yx0HD6OYyWG6md1DQUNSdtxHin24LSPhmMkrmExRcNrAOL5o7dFKKnygYAYNz3Q1qJ3YO5y6IVk
        efrYq53vj184JyyKv/gm3FQ==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr469655wrd.31.1632756192686;
        Mon, 27 Sep 2021 08:23:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoCeroNbPDA6VQiSsS1ULi7TPyMIHuwuGZwhFzsewiOr1FOuGcN0xSMBN0CmlOtCNhO9bSWA==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr469639wrd.31.1632756192571;
        Mon, 27 Sep 2021 08:23:12 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id q3sm15270622wmc.25.2021.09.27.08.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:23:12 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/9] s390x: pfmf: Fix 1MB handling
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, linux-s390@vger.kernel.org, seiden@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210922071811.1913-1-frankja@linux.ibm.com>
 <20210922071811.1913-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <3826d85d-6a3f-4674-800e-1866eb80cdab@redhat.com>
Date:   Mon, 27 Sep 2021 17:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922071811.1913-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2021 09.18, Janosch Frank wrote:
> On everything larger than 4k pfmf will update the address in GR2 when
> it's interrupted so we should loop on pfmf and not trust that it
> doesn't get interrupted.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/pfmf.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>


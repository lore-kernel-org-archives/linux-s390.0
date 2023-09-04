Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A91C83F2C
	for <linux-s390@archiver.kernel.org>; Mon,  4 Sep 2023 09:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjIDJuq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Sep 2023 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIDJup (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Sep 2023 05:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557011D
        for <linux-s390@vger.kernel.org>; Mon,  4 Sep 2023 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693821001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GBK+++3DmyVfbTlMHxqD/SiwodzazSVJ3fOLKjraPE=;
        b=AEtekDcme+LgHprXYB89V/z/ctqe9xMt7WE1l7JF5ZJGYjNbIBLBK0YDmIKLWqoJaebd0R
        IBuMKb+d30FASOfVpGVUW/YLCtiVnEpkBDguSr+Ls0LpxFwKx5ANZtMX89jkzK8sW++WuD
        VgOezsgaS99qtiLgtj+/UO15pFN1YVk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-2PCEdy7ZO1-K-ATEbFKAPA-1; Mon, 04 Sep 2023 05:49:59 -0400
X-MC-Unique: 2PCEdy7ZO1-K-ATEbFKAPA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso8519965e9.1
        for <linux-s390@vger.kernel.org>; Mon, 04 Sep 2023 02:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693820998; x=1694425798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GBK+++3DmyVfbTlMHxqD/SiwodzazSVJ3fOLKjraPE=;
        b=K6UF9zxgkc6MFzmgrjfA86fjW9U15JpPQ5BNA2EEgyayHyevQHn6IwDcwZmXF2g2is
         Oljez18K+apoYDOGDmTxLv6/GQ3gBHk4C1BaQ0rVkvWokUkhItqCxvleP9zweCGC7M4N
         k1tqFZOHyJsRiXTxpOboppXWHNzul5Ucc8WVj2AJDMoP0W4z+Oa2uhOibVgQzxCIN6+c
         tWQyW55ABF5J+wDn2yppthwvKQUMB/1YjW7IOSuyndJyS5JgyjHh3Nv0hNp408B16e2S
         Hbr7wQE1USMQ1rLoBbDDUyVuxuBQYC4paDP6PgcwhzQ9u0hkCDVfqEuJS+MnKWlg196g
         MMTw==
X-Gm-Message-State: AOJu0YyZavtF8J3fQ8vOLR7hN4SjTVark/K2Kxsi4qa1o3tUgOnzycz6
        lTwS6aCS9av5wy8OpUGuhEAlcBZ6QKx8+fxNUAha2omIdWs4cJGnGqn84L0WuCZpU4M2XJI2Wnj
        asTktgo4z2y4PDdSUUPSrsGzE8Y0vObP6
X-Received: by 2002:a7b:c7cc:0:b0:3fe:c7fe:206e with SMTP id z12-20020a7bc7cc000000b003fec7fe206emr6268928wmk.16.1693820998675;
        Mon, 04 Sep 2023 02:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDY5qZxtKjv7rRsKpuuk9dy61SBGRElvZ0/wJTMHqNE5lVas01adwKpcMZzr6/mUVc6i9Peg==
X-Received: by 2002:a7b:c7cc:0:b0:3fe:c7fe:206e with SMTP id z12-20020a7bc7cc000000b003fec7fe206emr6268914wmk.16.1693820998370;
        Mon, 04 Sep 2023 02:49:58 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003fe1630a8f0sm16489470wmg.24.2023.09.04.02.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:49:57 -0700 (PDT)
Message-ID: <bc1418ce-5f40-c84b-973d-d81281eda682@redhat.com>
Date:   Mon, 4 Sep 2023 11:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [kvm-unit-tests PATCH v6 1/8] lib: s390x: introduce bitfield for
 PSW mask
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904082318.1465055-1-nrb@linux.ibm.com>
 <20230904082318.1465055-2-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230904082318.1465055-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/09/2023 10.22, Nico Boehr wrote:
> Changing the PSW mask is currently little clumsy, since there is only the
> PSW_MASK_* defines. This makes it hard to change e.g. only the address
> space in the current PSW without a lot of bit fiddling.
> 
> Introduce a bitfield for the PSW mask. This makes this kind of
> modifications much simpler and easier to read.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 26 +++++++++++++++++++++++++-
>   s390x/selftest.c         | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


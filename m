Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52301C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 26 Apr 2022 14:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351606AbiDZO22 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348555AbiDZO21 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Apr 2022 10:28:27 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B411BEB4;
        Tue, 26 Apr 2022 07:25:18 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id t6so22288428wra.4;
        Tue, 26 Apr 2022 07:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=N3rGspRTI08F0a6/PTNqrr9OkLopYK/vTV7LBZQ6ul7Qtw1M1ZjWuU4WBBN97fKbxi
         2WP1+uMyHQlPFpVx+CN1fETiMi/nvjqsrT32ACuOA5CNtGaUlIG8dtrPhl2I9XeR9Tgt
         sDblG/q9hb8uLlgWspF41wtpYjByPnVymUWTXdh26cHamCM+kgwcetw6syJ8W9HVSZfT
         m2v9y8xT8V5CUCMNP8MalYoxz1XrcTL/poxEGKjnFuzBIzIOUQZcG60WTDfErsm1j6lR
         XOUuVWioOdn6sjAYX0087d94RcBq3KjFumDdY4Lk90ONiqMJRXEyJn8uLitBtag6g+aV
         VQYQ==
X-Gm-Message-State: AOAM530ha+LLppiKCyV0ZYCMELB5w1UsJqxHiLTjOnfRxNRIbzSraSHA
        3kSX9Vs2wg9DpqU6p5sam9E=
X-Google-Smtp-Source: ABdhPJx+tGjrozc2v+hkDAQGkKaaKd6tvj25GGtU09S+2P3NV6/kZmjHHHaKsKLq0MduUfwGvhoEcw==
X-Received: by 2002:a05:6000:1a8d:b0:20a:ab7c:efb1 with SMTP id f13-20020a0560001a8d00b0020aab7cefb1mr18901071wry.716.1650983116938;
        Tue, 26 Apr 2022 07:25:16 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c1c2700b00393ee3deaf1sm5525786wms.9.2022.04.26.07.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 07:25:16 -0700 (PDT)
Message-ID: <c658f5cc-7b9a-84ee-ac22-cefc03e3dbf2@grimberg.me>
Date:   Tue, 26 Apr 2022 17:25:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/11] nvme: remove a spurious clear of discard_alignment
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        dm-devel@redhat.com
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-10-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220418045314.360785-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

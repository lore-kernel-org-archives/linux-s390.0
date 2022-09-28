Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC3C6FA8E
	for <linux-s390@archiver.kernel.org>; Wed, 28 Sep 2022 14:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiI1O5A (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiI1O45 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Sep 2022 10:56:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF03187F82
        for <linux-s390@vger.kernel.org>; Wed, 28 Sep 2022 07:56:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f23so11974762plr.6
        for <linux-s390@vger.kernel.org>; Wed, 28 Sep 2022 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Evbxzhf/pidjDLKsn2x4GwyfLG+kx9sCzYCgU3SIOzs=;
        b=BM1130YISbPJoEOXY/XCelyXBLiqKFFgWlZ1zO9bWO4yWVB1jy5NiSl6zC8Zw0ZnOq
         yMxwa7RbWXozsdZod//bJcczi+DGoI/EzIZR9FbULZO6zL7C58GSqcICXa3CPQR0vKPw
         4CHlme+4OT/d9WAfN5O62gcyqDnYhpMeZVhfwDF/HF+WFbVZ2dYsxQicpeu17iolJmEV
         670OH3TniBwAS+zuM27lg/z2oFkWxiQiQvSw+y+e5eZRmuvY53kiMxPbmAGlTMIjNMhJ
         1CZ1YZtp2DloLEmy133y1rEWxV7rdG0iVflGez8uxfBkiHfwhpj0mN3tQCTzsK77Q42b
         RnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Evbxzhf/pidjDLKsn2x4GwyfLG+kx9sCzYCgU3SIOzs=;
        b=Gv876BIeSRQEtdqGwb7IRVeXsAy79Bcq5v9tRUXQnZl5cVHso/fPuGP4ogd83dzaYW
         A9DZmR/7gl8Wy/q3NFLZ1CZXYwSVZpMmtx++NqAMHWrDQpmxNwe6RHiF9AGMkN3poIKh
         DL3pI0mKmqLFI0VdFOIUYWuje1dhOKJ5bTHBUx4MBaO9LIvBfgQ9jzRzwK72G5heORSK
         YPDmV93rhGWXvVVMW6sUQQZp3DOMiVou7vV0R5r/2OXIpkaNQZtwal2UByXDCE6rixro
         hqoL70U47OzU66HL/8r3YEG9w60p06lJTxlR8Xva3VqQ9kSUU/2331MyTEG8+4RcBZGh
         yi1w==
X-Gm-Message-State: ACrzQf1bEoj8Qf5DtubgLgoOJdGaNoiA+jJPu5982Z/ARDCwQO1yyoi+
        XWCHaABqxqB5mb6kaXYSogj6Hntu1xFLWQ==
X-Google-Smtp-Source: AMsMyM6ocIj7PO1ySCSvMbUGBqoq5MSHPeCi/XmsKI1HBbCZRFlkoveHIhm/K4wkMWZA9bp4faDdcg==
X-Received: by 2002:a17:90b:4b88:b0:202:e381:e643 with SMTP id lr8-20020a17090b4b8800b00202e381e643mr10825059pjb.148.1664377014372;
        Wed, 28 Sep 2022 07:56:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001782751833bsm3863908plg.223.2022.09.28.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:56:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220928143945.1687114-1-sth@linux.ibm.com>
References: <20220928143945.1687114-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390/dasd: use blk_mq_alloc_disk
Message-Id: <166437701324.16288.5697183698335314295.b4-ty@kernel.dk>
Date:   Wed, 28 Sep 2022 08:56:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 28 Sep 2022 16:39:44 +0200, Stefan Haberland wrote:
> please apply the following patch that improves the queue allocation.
> Will you still take it for-next?
> 
> regards,
> Stefan
> 
> Christoph Hellwig (1):
>   s390/dasd: use blk_mq_alloc_disk
> 
> [...]

Applied, thanks!

[1/1] s390/dasd: use blk_mq_alloc_disk
      commit: c68f4f4e296b6011032b4f88d0ce72eb72a6bb07

Best regards,
-- 
Jens Axboe



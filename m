Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB9C7EE29
	for <linux-s390@archiver.kernel.org>; Fri,  9 Jun 2023 17:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFIRgN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Jun 2023 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFIRgL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Jun 2023 13:36:11 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E383AAD
        for <linux-s390@vger.kernel.org>; Fri,  9 Jun 2023 10:36:05 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so863855ab.1
        for <linux-s390@vger.kernel.org>; Fri, 09 Jun 2023 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686332165; x=1688924165;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elYWTHuitKVMi7wO2Aaxy/qmAgn7vpTmax6bBeAbe2o=;
        b=XWTLKjV5bT9tIWkvd6UdKXKDdcSNnBsTDWHev9b33oy4rRWOGlTHbtgyc5Jbduvpln
         Et2+k7hQfZPaP+NxfadmEibLHUqQvWLDvEaVX3ESMOfzarDg0zuN+1jEcmG6Dg/tVZp9
         g6urAs1kQh5zyqPeUwxZKk0LRd2j+NQQx7tthPq5MfJ14wEySahiAHj4BwUpVdbOJGAA
         BVywRs48rET3AUPB8/5N08cUyGaBdwasuKynASUXHLAKeOEDNZp7eHA25hqH6MLRwew1
         DTeUGR2K8C7P3Kpx3r1u0eEOhIsoOt+/JMZSVxCGPHXq8BTnuikWGbISPlarpD8X6W0L
         pE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332165; x=1688924165;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elYWTHuitKVMi7wO2Aaxy/qmAgn7vpTmax6bBeAbe2o=;
        b=SPxKn08vn8wQ4f1NYMPwO1qSE8JN8OqFhMBhL4WT4xXPicmTQ4vtjkvjQah331E3gg
         rKIRHJlAvHxLalCdZ0aitI6+uaBFIeE+NZ0/oGQwjP0GVLZNjHTzT5d2qhclsXpzbUaU
         wBZ3H+pnzziYZd4wKH65zA4RhzxiBXLhDCT0Ey6zVZX3CitVxU31vfK2baz70TDYDU4I
         mYri10I28wp39BIWmAFe+UfaGjVho7LAppw3FYVjVkEum1n6shFGj2x8EblaJCdwYz6A
         vjhNpupeQCRIRVzQsdQP/+Z3SLpV8MPiqmFxf08bXB/695PmsTjMRQZd4wG4pvejlNiz
         57yg==
X-Gm-Message-State: AC+VfDwwPYRkS3S0v3FXwkMF4PK5W4LRycrSGvSStibmrqWU+Y69sg8H
        h9luA2X41MLXL5fKmtYzErU97vUXQqMTwfv6UBI=
X-Google-Smtp-Source: ACHHUZ6TcSVRL7JtrdHOsrKxJOzAySE2XN5tlCVlKsqRqPOwCwtSv7xEojKQHLIeDwp3lPQcQ2r69w==
X-Received: by 2002:a05:6e02:188a:b0:33b:583d:1273 with SMTP id o10-20020a056e02188a00b0033b583d1273mr1878335ilu.1.1686332165029;
        Fri, 09 Jun 2023 10:36:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e13-20020a02a50d000000b0040fad7eb910sm1063429jam.176.2023.06.09.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:36:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230609153750.1258763-1-sth@linux.ibm.com>
References: <20230609153750.1258763-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390/dasd: fix locking error
Message-Id: <168633216394.624591.12554905661891516522.b4-ty@kernel.dk>
Date:   Fri, 09 Jun 2023 11:36:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On Fri, 09 Jun 2023 17:37:49 +0200, Stefan Haberland wrote:
> please apply the following patch that fixes a locking error in the DASD
> driver. Thanks.
> 
> Jan Höppner (1):
>   s390/dasd: Use correct lock while counting channel queue length
> 
> drivers/s390/block/dasd_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Applied, thanks!

[1/1] s390/dasd: Use correct lock while counting channel queue length
      commit: ccc45cb4e7271c74dbb27776ae8f73d84557f5c6

Best regards,
-- 
Jens Axboe




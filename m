Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CFEC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 19 Oct 2021 12:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6598861360
	for <linux-s390@archiver.kernel.org>; Tue, 19 Oct 2021 12:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhJSMUW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhJSMUV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Oct 2021 08:20:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1AC06161C
        for <linux-s390@vger.kernel.org>; Tue, 19 Oct 2021 05:18:09 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i6so913903ila.12
        for <linux-s390@vger.kernel.org>; Tue, 19 Oct 2021 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+u6Zw+sZeymRMtbHbtGbZtKzgW0EhyLBdVB1VY/1pQs=;
        b=Tb48ymzvjxLTClrHNJYA4D2dVJ8Ztfbhzy0Ie48bKme14dbHEk7NHzUlD4CtsOuTVh
         JgNzHEVLQhxIsPLhyJX7Z/VzlReaLnFXc1kKfHdgzt2BBNgXuoe+ZF4bik430vu4puMl
         I+VMmrKJgTvifkJbrey0kcq4cSbLwlRG2Hgmwgr+LEzoG7E29CJqi0uqRCgehTOMKsrq
         Jh6TX2smlG382jHo0pR4VfMS1s4K5fB1q8nrd8S+Dn/GnVyVBFeUcEAXY/7qL1iaBQvm
         mo2ph9WGKLDLbO76XEykkT73n30KhxsNtReurXqJLhHlkq4NYNbpzmPgymF9ctR4BHQv
         4WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+u6Zw+sZeymRMtbHbtGbZtKzgW0EhyLBdVB1VY/1pQs=;
        b=hhuU3psMX1uSwM80iXg/O0aKxfiA1XS6rUpkrnWVDa0YmPKz12lvkvjYe7HZ11F08o
         9UCvCxy5UZzELjucHdI/Jrxw0PwOpBuAtf/yiDZCDE9USPC/+mAFV8SXMDM+QUfAAyZM
         Lr9diONkT19+hikhggxkoZTk40w/9W5V8VlA4X+ZYHKK4UCsKXbi0MwyqnbDHsqrvmQA
         5DNtgyezNWzajxM/0KQfl6s0tl27YNhZVnc4zusdVo+MC0np9R0t7kqwWpJU6zsrWfNt
         kqEPqDPr2Y2YhVSgoX4Eyls1FODdyYl/SVSTaBB6YFCMRkB1tTp/MCL8+N9qgdueF9Ju
         Opkw==
X-Gm-Message-State: AOAM5337Q7GJljOqcChPmeg6iqj6jjQlI03xFIUV4Xzlq3kdXXvCK4SH
        2KkHRPThpU40ioG47wsTdfV9pw==
X-Google-Smtp-Source: ABdhPJwdq2OzbwJ+5kSgKNQu/1r0vmMuOrQGPUlHM7JK+ER+0G+nwVQiAnqSrEK4pLXtvo4sGlmmaw==
X-Received: by 2002:a92:de47:: with SMTP id e7mr11929867ilr.282.1634645888670;
        Tue, 19 Oct 2021 05:18:08 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o14sm8393559ilq.81.2021.10.19.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:18:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-block@vger.kernel.org
Subject: Re: more bdev_nr_sectors / bdev_nr_bytes conversions
Date:   Tue, 19 Oct 2021 06:18:05 -0600
Message-Id: <163464587890.599826.15140587721963730407.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019062024.2171074-1-hch@lst.de>
References: <20211019062024.2171074-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 19 Oct 2021 08:20:21 +0200, Christoph Hellwig wrote:
> these somehow slipped into a different branch, so here is another
> small batch.
> 
> Diffstat:
>  ioctl.c          |   20 ++++++++------------
>  partitions/efi.c |    2 +-
>  partitions/ibm.c |   19 ++++++++++---------
>  3 files changed, 19 insertions(+), 22 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] block/ioctl: use bdev_nr_sectors and bdev_nr_bytes
      commit: 946e99373037be4841e8b42dcd136e03093c9fd5
[2/3] partitions/efi: use bdev_nr_bytes instead of open coding it
      commit: f9831b885709978ed9d16833ceeb3a2ec174a2d2
[3/3] partitions/ibm: use bdev_nr_sectors instead of open coding it
      commit: 97eeb5fc14cc4b2091df8b841a07a1ac69f2d762

Best regards,
-- 
Jens Axboe



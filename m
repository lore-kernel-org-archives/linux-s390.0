Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ED9C4332F
	for <linux-s390@archiver.kernel.org>; Wed, 23 Nov 2022 17:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiKWRiA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiKWRh7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Nov 2022 12:37:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC14F197
        for <linux-s390@vger.kernel.org>; Wed, 23 Nov 2022 09:37:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w129so1596157pfb.5
        for <linux-s390@vger.kernel.org>; Wed, 23 Nov 2022 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY04rkAqQg+LcFZFljoj2jQg2j6k6tFscaZzKB+qmQs=;
        b=IuueqrXRu353XBYY9Qn7gvfk44k+GBw5Ss7jlJ/bF0B9vkuJIfvnODpEWxIYdYex5w
         0o/2acYnpCXR7ss/cqC13b0NKB9I96L07TpMwS6tsvBDyooEB/uPjlvgNsn/aHLrBbYq
         40B+Kg5YrGtMgS8QzM1Ps5PdH3ZxP0ivdNekXAgb08qOfu6IcjCDfuNs21V6K6SPN3bP
         z4zzwFkW1U5UR2RldvN4/+VPyB8gosYH1Tcw5eB58kt2QIpTb4gtGY9irYLoHS/FuGQ1
         hiAB3HMIuABAfm5y9UvpmY3XegzyteCdIj3tz5dNaXUCjeIlVUughFy5M0lLF9PORsy/
         LCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY04rkAqQg+LcFZFljoj2jQg2j6k6tFscaZzKB+qmQs=;
        b=NqGHO84dW6pi77rz/qM3HAL+INIfWSisX6sr4Qj1AQGyuW5+/f6Z9Hf7r3Gi5tw23u
         Pf11TJHbCHvuqrewfJ0flGFoPv7QQMDZYh+y4pzR78dBeo51FID88IH4rEViOT53bOF+
         WGKc56BjE1OcgEUxRNq61Ynn1OSmmWR1VKX290v3ZNDteNYg7z7IrTxBA8B9ipIeK9N8
         AWsZxBMb7P5R7OL9F9auH2S9D7beGma49i4+Y3Qajc0xL4mUt/NyDyfs0wLQB/u9Z1vo
         LMhq0unsR1v9Z6IXrHNqL2PrpIzz+qaQCQ/OPVHbrGCLo1ojQyi0QzjDY0wklPIXK9ff
         jYVw==
X-Gm-Message-State: ANoB5pkJXbhyPm+0x4o93EoDeS4MNBhpo5P/1ovKjYAWksVt7Ad3N/Bc
        LwyG22PJHEiJ1SQwXXaZLjc5HuJrYmLvNg==
X-Google-Smtp-Source: AA0mqf7+MSCUgLX2sGUTAfXjtFyINTLe+nLCLeUp7NNTUBqOATQ7ZwwWBQpXuHXX6hPbjorO0hfVfA==
X-Received: by 2002:a62:1715:0:b0:574:684c:e41e with SMTP id 21-20020a621715000000b00574684ce41emr2456342pfx.72.1669225075881;
        Wed, 23 Nov 2022 09:37:55 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:4a4b:9d2c:aa9c:d2b:66c9:e23f])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090a130f00b00212daa68b7csm1675899pja.44.2022.11.23.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:37:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20221123160719.3002694-1-sth@linux.ibm.com>
References: <20221123160719.3002694-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/4] s390/dasd: fix out of bound access and other fixes
Message-Id: <166922507445.2259.6403259573928080506.b4-ty@kernel.dk>
Date:   Wed, 23 Nov 2022 10:37:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 23 Nov 2022 17:07:15 +0100, Stefan Haberland wrote:
> please apply the following patches that:
> 
>  - fix an out of bound access
>  - fix a possible IO error on non-IBM storage
>  - fix a typo
>  - improve debug data for error scenarios
> 
> [...]

Applied, thanks!

[1/4] s390/dasd: Fix spelling mistake "Ivalid" -> "Invalid"
      commit: 4ba5f0c36cfdda68347269c02961cd90f8443ace
[2/4] s390/dasd: increase printing of debug data payload
      commit: b49e648fcca7e420c4ad670a548e19f0e8531c30
[3/4] s390/dasd: fix no record found for raw_track_access
      commit: 590ce6d96d6a224b470a3862c33a483d5022bfdb
[4/4] s390/dasd: fix possible buffer overflow in copy_pair_show
      commit: 7e8a05b47ba7200f333eefd19979eeb4d273ceec

Best regards,
-- 
Jens Axboe



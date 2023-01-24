Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B854C54E94
	for <linux-s390@archiver.kernel.org>; Tue, 24 Jan 2023 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjAXS1h (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjAXS1g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Jan 2023 13:27:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD74DBE7
        for <linux-s390@vger.kernel.org>; Tue, 24 Jan 2023 10:27:35 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z31so8713979pfw.4
        for <linux-s390@vger.kernel.org>; Tue, 24 Jan 2023 10:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uuCaVekZfkeqai5+tH1XcWnNEAthexu4ES7NdxZb1w=;
        b=0CQWYnWDevNhrRMRt79Csp8uujkrtXG9LJvL4xcplkj5RuqhEHNNH+h2PR4eHxahWD
         ckiol8pJr5N95Y4z0SOk+dQhSE+fsrOAJ424qkp6vWsxCkxyBkiqrRfBJxQHy+rBELuw
         KdN2BCRcFEhjJpwTHINv5Z8Dj+EZ+rDa/rVQNUCuB7WW/UIkY6hFZ9K6L1RXtutRLwPC
         Q0yEVv2n3Pe1LFGvSQFcUVQIFACknflCPc5bPu1OwCNUtbqOHJ7GnwTyFd1igb0ETedz
         aMyLM8njl7hVa7Bk91wqhA0GJ4/mUlAaFV/MCSTIF/w1Jp45kB9riYrXwex/FhZi+T7A
         RS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uuCaVekZfkeqai5+tH1XcWnNEAthexu4ES7NdxZb1w=;
        b=EhqAaH8oXoZEvHpDM4XaneT79fU/wtvuywGKe6SkH3xRTp3diQYb8bL+qlx3ajrLVG
         Ge3Oygmwg28eC5eITERBD5+HX4G5rm9DUfwLqvDrSRP7BYso/pynhP6hxYwYNHXG1C+1
         DXd8GTJGoiKIFXBh618ZYlPb5MKD5PK49kAi+e7i2yYXCv3JqMFbcogoyioUfHorMx+7
         lCxTOhG6u0f5LRFzlve6JXcGjTTx6YAiBkRcgEKWm80LG3mxME9mhoqy5gJdytjbYxWh
         vzljZYei/FxjyGNykcBkFiG9dXqPNsscrewHBhZorMxarAV1yRFISHPcBiC9Hpq2mP7J
         3hqg==
X-Gm-Message-State: AFqh2kqT6Cg0Zds8eBrNKYV/ffGpq96wJrQLR7uyHGDSK/9EQyQC4mvB
        xj/GhgCvheqbVV3Kj25vCyewawQgIljoLfPt
X-Google-Smtp-Source: AMrXdXttIr5KYxH5dqKuhEcvWg6vVguxQirpQYJnlHgIYD5FvkqQheaGLMPMeFvcN7pfdlzMyU8/Jg==
X-Received: by 2002:aa7:9ad9:0:b0:582:4a5e:b1ec with SMTP id x25-20020aa79ad9000000b005824a5eb1ecmr6677607pfp.2.1674584854965;
        Tue, 24 Jan 2023 10:27:34 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a7-20020a62d407000000b0058c8bf500bcsm1909451pfh.72.2023.01.24.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 10:27:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20230123075356.60847-1-hch@lst.de>
References: <20230123075356.60847-1-hch@lst.de>
Subject: Re: [PATCH] s390/dcssblk:: don't call bio_split_to_limits
Message-Id: <167458485388.330803.7271674092697042392.b4-ty@kernel.dk>
Date:   Tue, 24 Jan 2023 11:27:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On Mon, 23 Jan 2023 08:53:56 +0100, Christoph Hellwig wrote:
> s390 iterates over the bio using bio_for_each_segment and doesn't need
> any bio splitting.
> 
> 

Applied, thanks!

[1/1] s390/dcssblk:: don't call bio_split_to_limits
      commit: a2aea8f56f9ee995aeabeb633b708024a3be5281

Best regards,
-- 
Jens Axboe




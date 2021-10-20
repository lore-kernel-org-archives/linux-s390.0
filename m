Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE41C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BD86138D
	for <linux-s390@archiver.kernel.org>; Wed, 20 Oct 2021 14:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhJTONH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhJTONH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Oct 2021 10:13:07 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96132C061749
        for <linux-s390@vger.kernel.org>; Wed, 20 Oct 2021 07:10:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so6278127otb.1
        for <linux-s390@vger.kernel.org>; Wed, 20 Oct 2021 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwwXvtu1JuRXan9acu6rA91PNQ2tvb7gHdWKmp6i7XI=;
        b=vUZB1MHttsHU4KeVvT2tp2DlaEolytMNDY7I7gpmhlXmqT13Uq6tP4ZUwCeRG0i7qV
         R9BlDSoKCsOtp7E3+AJ70yaBMBkfYEsN+QoZphok8rkFykjUtsyJf3lpGuCmzPVErf7w
         wIktR/xrLE0tE0pr32RVdFmRxAsC/7Xz7aMTXgHHURp3ccztHmaOnEdXKfNkuvhFOH6z
         St5lJy3Z3b6nHkGxRtoiy/F4uJ80Pwduoclr0s5aLW0VHFlH8aLW88hshWCmN91gTU1I
         8LpYDqh7UzDSZhGxi7b9VwrYY1FLFsBKoS7KUe3i5RJgFdUEvnWuoT1x6AcNu4rGCgPD
         Efkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwwXvtu1JuRXan9acu6rA91PNQ2tvb7gHdWKmp6i7XI=;
        b=NPkB6Dr03GB6TDLOR9b0HRMDxgzcFYy8aWY8ZqQbDu/05GpDWnjgqjAQw0dhDYiL/w
         K4P14dWDNmdqPkFwLquimeJAI9gq250JuhM//3eg9Vrog9Zjq8nTknz57cXucWtR9uaN
         9eQReB/MHlcoRvYcsH+ZxOtD2JapfGigWxpYGcWaJQB2WaEjhRVd9Czr0rQuRiBzqFjM
         NUlgBVE7PU6QlGhCv/nmRdp4+/+D4KmcHZOnT8eZiTS5ncubEjEiUD+9iNWTypGAGqBP
         cREx6VmcPqdPUAkHVDXzntyev72zl9r1Ik0YsrOUkYSMp5vcG/D+m20QkCj9jOyPDn6/
         +mdw==
X-Gm-Message-State: AOAM533z3OaMyPNkqyIpBcPo4x4QXnbekdoD+Y8dtkIzVlPRGXQFl3Wq
        4BvreRytHfbaxYzPAj1NbNzRzw==
X-Google-Smtp-Source: ABdhPJywtoaZOCnIbWk8E+tfUStTYS0FtnLlCQ530+/FZxjdU02twrTwh9GtwcWgwP68t4hGrh+5Sw==
X-Received: by 2002:a05:6830:2424:: with SMTP id k4mr100719ots.210.1634739051908;
        Wed, 20 Oct 2021 07:10:51 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c3sm499546otr.42.2021.10.20.07.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:10:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/7] s390/dasd: cleanup and small fixes
Date:   Wed, 20 Oct 2021 08:10:48 -0600
Message-Id: <163473904605.733616.14248179151724257187.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020115124.1735254-1-sth@linux.ibm.com>
References: <20211020115124.1735254-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 20 Oct 2021 13:51:17 +0200, Stefan Haberland wrote:
> please apply this patchset for the upcomming merge window.
> There is some code cleanup and some smaller fixes.
> 
> Best regards,
> Stefan
> 
> Heiko Carstens (2):
>   s390/dasd: handle request magic consistently as unsigned int
>   s390/dasd: fix kernel doc comment
> 
> [...]

Applied, thanks!

[1/7] s390/dasd: handle request magic consistently as unsigned int
      commit: 169bbdacaa473a2f3abd3ab8170e1c7795931560
[2/7] s390/dasd: fix kernel doc comment
      commit: 10c78e53eea3d9359d4e2a0a4a17a73aacd85497
[3/7] s390/dasd: split up dasd_eckd_read_conf
      commit: 23596961b43752be871ea3a5756c7267f8140cff
[4/7] s390/dasd: move dasd_eckd_read_fc_security
      commit: 74e2f2110258d5cb5f3bcbf3f9813d523eb049b9
[5/7] s390/dasd: summarize dasd configuration data in a separate structure
      commit: 542e30ce8e6e1104e99c78a520a821b05b6ea98b
[6/7] s390/dasd: fix missing path conf_data after failed allocation
      commit: 9dffede0115e96d0ff0a07e4382569a9c6dba735
[7/7] s390/dasd: fix possibly missed path verification
      commit: a8e5d491dfc184c6b78cbb7f44107b01229c9df2

Best regards,
-- 
Jens Axboe



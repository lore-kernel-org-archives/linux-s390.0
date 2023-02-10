Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D3C05027
	for <linux-s390@archiver.kernel.org>; Fri, 10 Feb 2023 00:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBJAGA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Feb 2023 19:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBJAF7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Feb 2023 19:05:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A7485AD
        for <linux-s390@vger.kernel.org>; Thu,  9 Feb 2023 16:05:58 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v23so4786138plo.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Feb 2023 16:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hra9M/6sDrSMfRhctOu8H0bjjFmaSFx3pmX7jU8q+uU=;
        b=fJMNnbI9NOEX5Xh9S450ocdu8n4Wwc0ODspPLKhRENbn0dKn41KH1Tr90q1eODe52G
         KWtr7OYjSy7cVKa7vnqXlRlwXvapqykIuX/5uJl/uwJlsrZEhK/clSn8Fa1nW/znYI3U
         wutXLhkNwhn9PSvVAYd2J9pWlFukWhiQDoR+DNfcKxs/igbABQAk0WMpB//ld0i/etcb
         kXxGIKvpM81YRmGGqw7eOmFrbpBCq9bfc5BRzLV+nknT/2kFz5JDuIhyE7YdCSrZmVOr
         nHRq56N28l3aioVRDsdbEDrSmNh6J2v7hoxuS6t9+PPsYcYyLfrOUHQv+SvxXXCXhrRQ
         1QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hra9M/6sDrSMfRhctOu8H0bjjFmaSFx3pmX7jU8q+uU=;
        b=IT3YssbRXg90IH0sA6KDS2vBwfaHhxCzZYy7Jh8NADK0KXgw+qB77OkRZpixWiZaVG
         uNXAytV//OjlCAHuEXf50Y8AZiSIHxmkjvZQrtfiGK4+7OJoBv1KNx5VqJG91AIMDqNp
         KdL4jB6dfTbfJaGw/G/9bFUIlM23wNSqP6m9MotZC/4oYaQfAN8V1RGNH3409/faKuFX
         7skaA9ZihKpc0fsx+DxLxcfdbrfmdMNwzRsZoOTJVNwQPKaGYuXsefKrmFk2N7EZeW5T
         Isc3SiTxw7TWzVFNM+maE9MN4XF+cuOutuwGSx5xaMfwhO6ryRrv0TGMfyBLWzyvvwLv
         j38g==
X-Gm-Message-State: AO0yUKUVrGvWY+bSt74lzWfJAAJyvlnaUdErlXz1VACXuNqYIlIMZ7S5
        7WwxbqzPR6C1AUhzLeycy1+3iQ==
X-Google-Smtp-Source: AK7set/HOfDwnBGVxxKKGuL4oK62TB0VJw//XjZXmW/7z00Nuh/KuM+Cd3aPDucEoWnDAcOynPVmqA==
X-Received: by 2002:a17:903:2286:b0:19a:723a:8405 with SMTP id b6-20020a170903228600b0019a723a8405mr208701plh.6.1675987557756;
        Thu, 09 Feb 2023 16:05:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s1-20020a63af41000000b004f1e73b073bsm1831517pgo.26.2023.02.09.16.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 16:05:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Qiheng Lin <linqiheng@huawei.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230210000253.1644903-1-sth@linux.ibm.com>
References: <20230210000253.1644903-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: patches
Message-Id: <167598755656.7194.16272906680345697326.b4-ty@kernel.dk>
Date:   Thu, 09 Feb 2023 17:05:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On Fri, 10 Feb 2023 01:02:51 +0100, Stefan Haberland wrote:
> please apply the following patches for the next merge window that:
>  - sort out physical and virtual pointers
>  - fix a potential memleak in dasd_eckd_init
> 
> Thanks.
> 
> Alexander Gordeev (1):
>   s390/dasd: sort out physical vs virtual pointers usage
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: sort out physical vs virtual pointers usage
      commit: b87c52e431adfe2dfe8634216b317b4a952aa9fc
[2/2] s390/dasd: Fix potential memleak in dasd_eckd_init()
      commit: 460e9bed82e49db1b823dcb4e421783854d86c40

Best regards,
-- 
Jens Axboe




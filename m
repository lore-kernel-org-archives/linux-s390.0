Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDDBC77B75
	for <linux-s390@archiver.kernel.org>; Sat, 20 May 2023 02:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjETCEq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 May 2023 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjETCEg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 May 2023 22:04:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19DD19F
        for <linux-s390@vger.kernel.org>; Fri, 19 May 2023 19:04:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2f3dd990so75458b3a.0
        for <linux-s390@vger.kernel.org>; Fri, 19 May 2023 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684548275; x=1687140275;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGe9Nc9BeHNizvKK3VU+pxhVmUWR1oWUAke0/9k7WD8=;
        b=tHEb028/KUxUSaTgpPc/28suUZxYWjjsyaHnRg3w5QMOJ2k1NF9aMJSdHcT66Z8DUa
         1HPxXliERGuRNqFTtFcPXH776hkBWvo0kSVKh0ByZ1znsQ+njYwluKts5GSIRLqLyNin
         sXHJBPuO+InJazgz1+6nQrvx+gZ/AdZMwuGA8sRp1GvSDSGUiE1IL0l9hMoQkg06VIR1
         o9U2IqVW+ynmIP8EeHGqiCoh+R/fx+tL6XjwcV3rBBv2Wupfb+gN1c5FT2Le/xDXunh6
         wpp3lfZ4fJAr71fXPwJzz+lqMMYFpXlXz5hTs2B1dq5vKA8SPd0aoPD0a1WwYBvZICPO
         ogmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684548275; x=1687140275;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGe9Nc9BeHNizvKK3VU+pxhVmUWR1oWUAke0/9k7WD8=;
        b=XjoaVAS7V+rt2SIcVq720nTymkVxtsIf93KcjfYCRciNiGQ/9pYm5kzqJXKKocC03Q
         PNZiydINQk7uFjbeMa7HQTxhhrUJGDOx+kSskD4udEmE0AHv07qPUjepefEVPRQUGeeE
         qIt3G9osEr3faNgRSr9xmoQVV34DPSQvVz2jRycKyl8uSMs9WZsvOHM4QcixFXNUXDCk
         wsS/pJNv9IhZtUlk4GCu2SnIOjrRi7At+DxCvAf7pys3yEAKacFyG1apdsG2IqqVV3QG
         raw7xjqVasUb/lwTvHjN+H4keTeflxY/YtVC9hUx7v32ptb5oFFztu4KU7d7rrx+VqXB
         jftg==
X-Gm-Message-State: AC+VfDw5YDVD5cZvtXN5FvOquWgvYptFu8lhW1seyPZ4HalyPd75UmGL
        PHbFqVHFxGVxqjhhFKXoOsIYOw==
X-Google-Smtp-Source: ACHHUZ420I8w5cMEDjcCKCeXDVBNGiVE3EUeucCB9hocGT8LtryZcSkmqV/Sy+qNY042k6HbwpO34A==
X-Received: by 2002:a17:902:d506:b0:1ae:4a37:d5af with SMTP id b6-20020a170902d50600b001ae4a37d5afmr4903713plg.0.1684548275053;
        Fri, 19 May 2023 19:04:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ac706dd98bsm298922plg.35.2023.05.19.19.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:04:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230519102340.3854819-1-sth@linux.ibm.com>
References: <20230519102340.3854819-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390/dasd: fix command reject error on ESE devices
Message-Id: <168454827323.386102.15092676317625303889.b4-ty@kernel.dk>
Date:   Fri, 19 May 2023 20:04:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On Fri, 19 May 2023 12:23:39 +0200, Stefan Haberland wrote:
> please apply the following patch that fixes formatting a thin provisioned
> device in a copy relation.
> 
> Thanks.
> 
> Stefan Haberland (1):
>   s390/dasd: fix command reject error on ESE devices
> 
> [...]

Applied, thanks!

[1/1] s390/dasd: fix command reject error on ESE devices
      commit: c99bff34290f1b994073557b754aff86e4c7b22e

Best regards,
-- 
Jens Axboe




Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D52E7B61E
	for <linux-s390@archiver.kernel.org>; Wed,  4 Oct 2023 14:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbjJDOEX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 Oct 2023 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242725AbjJDOEX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Oct 2023 10:04:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A5A1
        for <linux-s390@vger.kernel.org>; Wed,  4 Oct 2023 07:04:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fc0068cb5so30649439f.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Oct 2023 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696428259; x=1697033059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2i3fB/UYXC5PIy7oYWrHTtw2bsbeZErmFNrShMLGQQ=;
        b=cpQGrA2lsDSQY5TD3IcaRlxZKf//4lEPWOOvFx71Ck+Xv9bBhIQ0n96gs4L9rLHVQ2
         WPym5In1SygJ1zgIzjTQutJY2wIFpJbdjiP11RZwoyb4LaYG/eO2qgscucla4xoOUYD/
         ZyQ9h3iJanpj16HIEu+GTu7YX8YegyIrHe2n7yq2a3xpR9oP2DiveW/Xxtc95n4O5CxS
         tOZSvx/5f2AUzZPz9lRGUHGixwSbC8jEGiWVSGfK/CBxqD+SfKookOQFsNp9BoeDEdeS
         pLKNHcnPyTBN+4y0Q/OXIDBsdJfu5Cb/0J642YHFereNRlJZHGHXLU5pKMwb3OgzgGCz
         OTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428259; x=1697033059;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2i3fB/UYXC5PIy7oYWrHTtw2bsbeZErmFNrShMLGQQ=;
        b=HS1n5pcQb678p3w66XNxnPOmmH1QUl86fzd77PIoPmUN+zSIUvySIuXinLOBuiExgZ
         yJAVamPTAb7LECruRiAkK0uXQfhzHhAcEhmo8fhwoUt/xTXQnm3sMP3w89mY+2Q/YHBG
         kJJfChCGYFoqwd2qXutkEyfsiL70lxcz23RfI3MJFSmGWGODEtrS0J4qtwzCEdQI2tpW
         IwPUw6vLmjCiYf5ZcC83AYTQCCbF4y5HJfn3vX4FM2qC12hUSEiRot919ytsKMdlqBBb
         8omFrCKRSwnDwrPYLMsf8loibdgSz3ZudvNQBwE9zxkago2IVPYhM30rF+jHHz5+Pah3
         LUZA==
X-Gm-Message-State: AOJu0YxbinBbLTR9BV1g1CE5fm0+yCJUNa+qrBBFyPiuYBWPKx0pBicJ
        eeIb5W3njSDzKDDR/TcYwUZ4djiNUtW4I43Ye+c=
X-Google-Smtp-Source: AGHT+IHiCeH1dV7jGG3AkasLWqhf82ApIRFTwbqFlvWBYliWncBehI9V1S48qxNGNNiVKuO83co61w==
X-Received: by 2002:a92:d9c4:0:b0:349:4e1f:e9a0 with SMTP id n4-20020a92d9c4000000b003494e1fe9a0mr2275198ilq.2.1696428259076;
        Wed, 04 Oct 2023 07:04:19 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p8-20020a92c108000000b003513b7613f3sm1017826ile.3.2023.10.04.07.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:04:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230915131001.697070-1-sth@linux.ibm.com>
References: <20230915131001.697070-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/3] partitions/ibm: Replace strncpy() and cleanups
Message-Id: <169642825818.2101612.3161798541112268960.b4-ty@kernel.dk>
Date:   Wed, 04 Oct 2023 08:04:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On Fri, 15 Sep 2023 15:09:58 +0200, Stefan Haberland wrote:
> please apply the following patches for the next merge window that remove
> strncpy() from DASD partition detection. This includes some cleanups that
> should increase readability of the code.
> 
> This is based on the discussion started with the patches by Justin Stitt:
> https://lore.kernel.org/linux-s390/20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com/
> https://lore.kernel.org/linux-s390/20230823-strncpy-block-partitions-cmdline-ibm-v2-1-40c77f7182fc@google.com/
> 
> [...]

Applied, thanks!

[1/3] partitions/ibm: Remove unnecessary memset
      commit: d323c1a9477a82843795f10fb23f1634cea44007
[2/3] partitions/ibm: Replace strncpy() and improve readability
      commit: f5f43aae6f336ae436759144a31879375e65ed28
[3/3] partitions/ibm: Introduce defines for magic string length values
      commit: a31281acc4a4e051a0bf2f1d3556ba4deea4d2a0

Best regards,
-- 
Jens Axboe




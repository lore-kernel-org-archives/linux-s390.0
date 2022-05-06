Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F1AC433F5
	for <linux-s390@archiver.kernel.org>; Fri,  6 May 2022 02:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388283AbiEFCMZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 22:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiEFCMY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 22:12:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74365EDEF
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 19:08:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v11so5113398pff.6
        for <linux-s390@vger.kernel.org>; Thu, 05 May 2022 19:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=X21XiDb8yzYRhMfkoQesaQpAxwMWfr6V+3k+J4kSHT4=;
        b=L4I8Ud8vSkZ2l3QiiFW2VOZxbVW2zlLG96lgULMUUNplPCS/RR7nR90OuzqWnbb/K6
         jy3herpNsQgQchP5OIB6ElEOb0Jj5wTGl6ymmJ5vVqmiw7bl+Az0kfglXRZ/3hmr5CRL
         ur8ZEn3o8EH6MXPynZWaPC5R90WF2nO9O/57LkzHxZ+c3RRot1ew3GnXWc7oC8Cxh7oK
         ixqVPku4Yv9RJPXnyVi4aLDh0yKf6a7QqbEjbFUO41ptJw+oY3nLAR0OkjPimZDpKJ01
         G4uwKgsl7QaEozKS5jCXMJ8FK79QcWFJnANCpUHb/oAxQ9VWIH+w+732hx7mUDrPJJkR
         MCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=X21XiDb8yzYRhMfkoQesaQpAxwMWfr6V+3k+J4kSHT4=;
        b=ETUiL/FMzQSxtNiwNj+ITZXnoUWu4ENxz6NQrpp1DN3juMaYnG5MjbagJwjKk4NV/x
         XX+ZP75es+nVjRiVUbwFeUVjXVlA/HiFFV2d/GZbMlYLQdW/oJfkUMA+h+j9sEm0ukW4
         Eg85G49OKZB42uaaB/IcI8uF+OIv0QXTTcH1BElD2F9/QsYXNh/dQnTXzQqzzvfGso5/
         OXBAWLm4kM7VP/LkI45dQijBDkK7CWIG6WB1CatEKOSRP6b8HvyaS57qrLhSf+HzbpgN
         GkM0IWF4dE+1TlrkDHNTrX3gw8UfYoeGS0u8NeQtxOMvrH90D5tFJJbqP0FtqTuoZYrd
         72KQ==
X-Gm-Message-State: AOAM530JnnCS8ObXTKOMX5K26cOJqHGekKJpyCBmWUrCRcvh3Nd9EV5y
        Hhfz/BSDgBMD6R28bgHuwgVNpQ==
X-Google-Smtp-Source: ABdhPJxF8kuJo835tgVp4qFOw0UQVC02A2RpJhfbQusVB9d7Z0sDsTDaMxKZrlgHg+Q028s5VOouQw==
X-Received: by 2002:a65:490d:0:b0:39e:58cb:b1eb with SMTP id p13-20020a65490d000000b0039e58cbb1ebmr928132pgs.390.1651802922385;
        Thu, 05 May 2022 19:08:42 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0015e8d4eb234sm313170plg.126.2022.05.05.19.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 19:08:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     sth@linux.ibm.com
Cc:     gor@linux.ibm.com, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com
In-Reply-To: <20220505141733.1989450-1-sth@linux.ibm.com>
References: <20220505141733.1989450-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/5] s390/dasd: data corruption fixes for thin provisioning
Message-Id: <165180292107.362372.5956159894859295300.b4-ty@kernel.dk>
Date:   Thu, 05 May 2022 20:08:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 5 May 2022 16:17:28 +0200, Stefan Haberland wrote:
> please apply the following patches. There are 4 patches to fix potential
> data corruption on thin provisioned DASD devices and one cosmetic patch.
> 
> Haowen Bai (1):
>   s390/dasd: Use kzalloc instead of kmalloc/memset
> 
> Jan Höppner (2):
>   s390/dasd: Fix read for ESE with blksize < 4k
>   s390/dasd: Fix read inconsistency for ESE DASD devices
> 
> [...]

Applied, thanks!

[1/5] s390/dasd: fix data corruption for ESE devices
      commit: 5b53a405e4658580e1faf7c217db3f55a21ba849
[2/5] s390/dasd: prevent double format of tracks for ESE devices
      commit: 71f3871657370dbbaf942a1c758f64e49a36c70f
[3/5] s390/dasd: Fix read for ESE with blksize < 4k
      commit: cd68c48ea15c85f1577a442dc4c285e112ff1b37
[4/5] s390/dasd: Fix read inconsistency for ESE DASD devices
      commit: b9c10f68e23c13f56685559a0d6fdaca9f838324
[5/5] s390/dasd: Use kzalloc instead of kmalloc/memset
      commit: f1c8781ac9d87650ccf45a354c0bbfa3f9230371

Best regards,
-- 
Jens Axboe



Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2CC433B4
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C277610F8
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 16:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhDHQZD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhDHQY7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Apr 2021 12:24:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D0C061763
        for <linux-s390@vger.kernel.org>; Thu,  8 Apr 2021 09:24:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso3474486pji.3
        for <linux-s390@vger.kernel.org>; Thu, 08 Apr 2021 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9qVeCK4vS6vpZSzxYALrDHb+JmD6zco2ydcMgklB9rg=;
        b=wNp+cuWAbmf8tZP6jrJbqvDhJuh/FUfrnYS2kMItEnzQ2TQU1RcIcRaePIlrhLWrsI
         Tj3vBPNwrrUVGbuQZeg77q1LhEoMbU0MSL3qRxQG31vn9jbm+dkR1uVbijNhMcD2cnl+
         E5FV99t8zy2wMDGNQjJyhnudM435VSeK+8hm0wHBDREUImk6w3fZ+QdCLHEUOW5dV7Eh
         QZiS60pPxxwJp9lF8wh90B/TXlUxGdjGXBEAPaHIjsDTLrPQn8eDY/DmAbS6KvMFm2k7
         HKG8UkhPhkJFO8aLyd1jG9D/kDJbOgNiCR0NHQjZbTnBbhlfszS6VckC7Wr3x0xpRXsA
         r9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9qVeCK4vS6vpZSzxYALrDHb+JmD6zco2ydcMgklB9rg=;
        b=On1VKg+ysdKS4t/5J+e3lVMGeA/WKvckFtSkCZ3IUQcgc15zKoKK7siPWgGu4LavLG
         0j4FQwa3xXyQt6/SdRJlKYvVlLhXXcjyritu8GgfKXjTeIBq4mG5pHkA+lX007tIIyz2
         MSG/evwX5kXZ0Jta1qKInweb6dalYHreQCXW8pe9Rleq3A+vWxp5VGvQrA+fQ4QQ6OG8
         /RftzJwiwvqaCcgCKv5GOJWSDxtlvbCVIlg+2oJNZyUQJ4bm/RWdYedpOQjwt9AdANH3
         Lst/dheN8WJ41/XonrgR/v5Gm3z3/CqMIV/DPdsoL9Cdsi/BTmqeS8r/4pGMVmiVrcxo
         jJyQ==
X-Gm-Message-State: AOAM530C9mjNseXZgShJqu8HIdwp3bWtpKTwj6FMwLGTr1Ma0zJyZNDx
        lC2dQwE0h2ZoUOHqSVCDfzEBFvtMpgan3Q==
X-Google-Smtp-Source: ABdhPJz+1lWdnJ8vpxYUdzLO/CmMzDE28rZDhEp3J+v+oMy62Y+cZQfIXzEP597lMYyyoCVPmZHQIA==
X-Received: by 2002:a17:90a:f3c5:: with SMTP id ha5mr9471466pjb.54.1617899087246;
        Thu, 08 Apr 2021 09:24:47 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id v135sm25742226pgb.82.2021.04.08.09.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:24:46 -0700 (PDT)
Subject: Re: partition iteration simplifications
To:     Christoph Hellwig <hch@lst.de>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210406062303.811835-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30ca9cf8-b15f-d50a-288f-a43eed1cb20a@kernel.dk>
Date:   Thu, 8 Apr 2021 10:24:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/6/21 12:22 AM, Christoph Hellwig wrote:
> Hi all,
> 
> with the switch to an xarray for storing the partitions of a gendisk we
> can now use the xarray iterators for iterating over the partitions and don't
> really need the disk_part_iter_* scheme.  Also clean up the teardown of
> partitions where I think we have a (very unlikely to hit) race currently.

Applied, thanks.

-- 
Jens Axboe


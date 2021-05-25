Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B65EC2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401D861249
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhEYSzr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYSzr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 May 2021 14:55:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279BBC061574
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 11:54:16 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w2so446348ilo.7
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dv2ynAk0e0j4ABap5LyrOWTO8mSQEIfMbBNW1vXhUIU=;
        b=fAu9RsPKECVBFIwMotcagPLUyEHuxfp5Y3dy/lk7L0LQtxFAbhu1Yq0KdwYPo3G0Qd
         I1o1HSGJY+c3ZAYJcehtkE1wTB5Yy0qf7D+OQWEpFvhH0NipTxfe88xvlOhsX62PRIN4
         RQsGmK+qrvo3gtRgBI1CUVQ1x0JX0GsRp2qrqIDcH72Ep7AU/yP2PUhYeuyyVa5MIPtl
         mfedRidkJz325Pd0FOOrhm3aJqKJi29XSVFVmAyJHlfmQu23FwNgNy2lwrW5ockRLgoc
         72hmfBe9I+vZXebzqw441gILdQmwd1nzct22jfEyTnXM7qRc4JQF5NwVTiOHMkAdPEDN
         Qy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dv2ynAk0e0j4ABap5LyrOWTO8mSQEIfMbBNW1vXhUIU=;
        b=aDN2LVMaCLW+uvLCX4Mr9itjji4C2YPhQgCYvCiMtU0MmaacmJZ9ym3MGy9rgl5Uzh
         DRc0lpTWXN0iG3gQrWEdbmI+rLP/zCAjs2jmMZqKTKul1wtP2ReEtLqweUV081oAANcA
         aTtDeSiEpP6p7l/2Jpbk472eeEuGPd62BwSEovMRZttHWsj6AKN62YnIEpq33FR66C5i
         4s6me94VW1d+a76cMB1es2N3en83HuVc0ZXnFaati0zpDEVREDC26ZDKqDFTqqpCoeFn
         OIhfdGuiNbD+2EkynkyH++NgE4YpUM15VBbSR+6zHh0uRJhwgnfum8OK8H0okS8aCCyr
         MiJw==
X-Gm-Message-State: AOAM533BXpcXvPlzL88e0ZVNl6VZvgIIm2PngnPSXGdilZZ2AJBO+tRi
        2SPWxauX+F217oxKWs40dxWi9A==
X-Google-Smtp-Source: ABdhPJxMIsiRpGZNoEoY8UBeLDfP1Nr4kSAwOLtXiavBUWZwL3TfAJzcMmGFOZQf9QcORnK25HV0QQ==
X-Received: by 2002:a05:6e02:587:: with SMTP id c7mr22716661ils.24.1621968855390;
        Tue, 25 May 2021 11:54:15 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a19sm13852802ila.31.2021.05.25.11.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 11:54:14 -0700 (PDT)
Subject: Re: [PATCH 0/1] s390/dasd: fix kernel panic due to missing discipline
 function
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210525125006.157531-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2b5d28e-bf85-bafe-65d4-bba0c92a5382@kernel.dk>
Date:   Tue, 25 May 2021 12:54:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210525125006.157531-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/25/21 6:50 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes a kernel panic in the DASD
> device driver.
> 
> Stefan Haberland (1):
>   s390/dasd: add missing discipline function
> 
>  drivers/s390/block/dasd_diag.c | 8 +++++++-
>  drivers/s390/block/dasd_fba.c  | 8 +++++++-
>  drivers/s390/block/dasd_int.h  | 1 -
>  3 files changed, 14 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Jens Axboe


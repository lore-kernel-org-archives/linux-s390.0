Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D81C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 23 Jun 2022 15:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiFWPPt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFWPPt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Jun 2022 11:15:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3E43A5E0
        for <linux-s390@vger.kernel.org>; Thu, 23 Jun 2022 08:15:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e63so17941229pgc.5
        for <linux-s390@vger.kernel.org>; Thu, 23 Jun 2022 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Itay7Y2xxargq/J6Y/NurU6/Z+HFhZkczjPHvFJ5w4k=;
        b=QRTrJBy4cdY9/GL2IfCMWoERkieO1ztaHrelylTalu+w6fND9Ru7WTU/7L5ili5jVQ
         VmZQTyzxUR6mg3t0KwRzEpjkIDMLQU1j/CS4+v0VA8aK6Q0fkXK7bw6b6ve8hAPyj0XW
         AyGiMzRxvi8U8zP/b9b8nXZN4EehwGiJlp5Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Itay7Y2xxargq/J6Y/NurU6/Z+HFhZkczjPHvFJ5w4k=;
        b=2yaj6b/jc4Um3FpcVt+mUn8hcVZNqsVbZUFAXwr2cZ33Ibq+s2AwMueyrqbC8AbalP
         VoJyZsuSEY3wb1gdhD3Aaob0+D7pbbfUxyR4xhHc+n3p4yzPO7jKw4cVZyIVI6FV5Qfv
         WozT1bmEVCUNxXFT690fmLtLfraVC8RM6IK5KtuLbx3OVpXNx3YohCv+ZEI+163lyz+0
         YqrWvhpxVaDIier0y0fK4gAv9LFaC/2KL8OhvnA22jLKAcIHUb9+Jri59nlYyPMM9Zu2
         K0moKB6QCEkrSYnJ7DnRtMnklDj8sTwiu3ub+FqPG6SPH2AyuDJjDMjfmUycsyUyas0v
         kRdg==
X-Gm-Message-State: AJIora+th8DYkvA4Hn2GliYdAZu0MntZA8gJMGdz2a7k9V05BpfBMDKY
        3PJjBL/hMYdjW2K2QMb3OS2fuw==
X-Google-Smtp-Source: AGRyM1twFv4L8nR2YdNrvbFQ2Ymi/KFdsUtfmdfENtOYdNtCP5sVA1YaYvN6GkAKRUHQTy0exGde+w==
X-Received: by 2002:a63:698a:0:b0:40c:4714:2425 with SMTP id e132-20020a63698a000000b0040c47142425mr7858173pgc.548.1655997348116;
        Thu, 23 Jun 2022 08:15:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090331d400b001641047544bsm14938197ple.103.2022.06.23.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:15:47 -0700 (PDT)
Date:   Thu, 23 Jun 2022 08:15:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        oberpar@linux.ibm.com, bjorn.andersson@linaro.org,
        liaoyu15@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Fix typo in comments
Message-ID: <202206230815.08ED0F225@keescook>
References: <20220622142713.14187-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622142713.14187-1-jiangjian@cdjrlc.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 22, 2022 at 10:27:13PM +0800, Jiang Jian wrote:
> Remove the repeated word 'and' from comments
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08317C11F67
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67F4613FA
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 15:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhGAP36 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhGAP36 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 11:29:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20459C061762
        for <linux-s390@vger.kernel.org>; Thu,  1 Jul 2021 08:27:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 11so7714170oid.3
        for <linux-s390@vger.kernel.org>; Thu, 01 Jul 2021 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UEhd9RW/Z//Yet4PSyZVFj89an0siciakTKupP0jjUk=;
        b=v3OXxJDVG1j62VuzMZjNsHSSpeT1teaZCCWItyiwvKSMkgQSsaRL811BqZPMmc7uMP
         F91WhYOFkhKm5y30GSCdh7fwOirS/dtTUYhc0MMoMegpXDOqYP90ampyUTOtvtVqcL5/
         oxvHF2o2opf7IulvvbB2bV/mBE1LxCvcmvWykWY1rS5d74Ljh12kJYpZeJGOp3qwRfEs
         w4r2oQuvVsigwCDVo97pwLzRzIEjxGFwmuh0KAvOKlxguzhTKLMLDJcn6hFTGraVMObx
         CKXUAx0XIppnaZB20rwfltyFlqO/A6FD2MY3NnmTxRiPbtEYZ96Ffg7vfCZMHJ8qVNiB
         Ctsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UEhd9RW/Z//Yet4PSyZVFj89an0siciakTKupP0jjUk=;
        b=jaYbwv0OEXfPJJFLL9hRGGGZkHvD6lg90evgIyFIzyZnPcyWhVl2m9AD4RiB/RdFW4
         PSzcRDI/Ht2TcjZQVUHndAsGAqOUB7F7Ed8eibTH5JBBxdOvpRBHZB7grhuFVY41/K9b
         69ejRLGDLGdBF7FGQ6nUpfZuYpcBFOkxzMbjym3kaFF596onGwjgD8IxzE5n3WbboNu9
         RX3L1UpRbz4q78fZ1nad7tIJWrYg7HH4c2xxXBDL66hpEXt+9+p/84T3kxe92gf1HhR5
         xC89emq3/lFRgFbUC+EHDwwXo5j1mc1+mGgAD/Q0hH+D+WikA9se5/uxFiF5lbpJcqnL
         Q96A==
X-Gm-Message-State: AOAM531VkIaIlyleOX7hMDh7/ktL+dcbepK0pOjpZzCHMVyI/hip6gCX
        8TKl/u3baGAvLVsPBuqL+e76/w==
X-Google-Smtp-Source: ABdhPJzyVbaQUppYRSCuQuMpUwGsXrurdANk3sq/OBkyeTgk4oBz0yyQ+0EjqnLVYcEX2yLeBdUSig==
X-Received: by 2002:aca:4f83:: with SMTP id d125mr26685oib.117.1625153247479;
        Thu, 01 Jul 2021 08:27:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id m3sm8928otf.12.2021.07.01.08.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 08:27:26 -0700 (PDT)
Subject: Re: [PATCH 0/2] s390/dasd patches
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
References: <20210701142221.3408680-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <356adced-0e30-ac75-b3d5-83eebb292816@kernel.dk>
Date:   Thu, 1 Jul 2021 09:27:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210701142221.3408680-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 7/1/21 8:22 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following two patches that unexport a DASD symbol and improve a DASD structure.
> 
> 
> Christoph Hellwig (1):
>   dasd: unexport dasd_set_target_state
> 
> Kees Cook (1):
>   s390/dasd: Avoid field over-reading memcpy()
> 
>  drivers/s390/block/dasd.c      | 1 -
>  drivers/s390/block/dasd_eckd.c | 2 +-
>  drivers/s390/block/dasd_eckd.h | 6 ++++--
>  3 files changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Jens Axboe


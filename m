Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E32DC433ED
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 15:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EB6610FA
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 15:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhD1Pt6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbhD1Ptk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Apr 2021 11:49:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E6C061573
        for <linux-s390@vger.kernel.org>; Wed, 28 Apr 2021 08:48:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y32so45012148pga.11
        for <linux-s390@vger.kernel.org>; Wed, 28 Apr 2021 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tORliflyGiTlxpgw1Xju92EFVYS+y5dZFyWLyquG+EM=;
        b=PAlsmS21gCUe34ubxq/kYTGGg8YPYXdQ1HUnOaCiH+axMpr6gi+sk+JGiXGVtJdrGT
         JnMijmrnJipN2jKTSMhLdsfhZ0JnkgnBuicN7UrCK1F+s2czuifgdyuQM1C74qZum1uG
         XXWYqTg4yn5lg9wCujgMoU2YreLpiV+QzhyOxsxEhMZyPjIF3gE/7qtmpzGz49gXmmtl
         6bGT553GXKyP7oqUMQEJTOMEFoVjcMntQtYP2dBujyfw550Df2b1xvfzbRAf31wZoBNM
         S3HLP3bJgy6QE0eHN1KiPdwz24VWsm0mO0pv2d0k54J5GqbQvKhHh6gd+Gp4l3xtnd72
         zzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tORliflyGiTlxpgw1Xju92EFVYS+y5dZFyWLyquG+EM=;
        b=RDYeMFZRXyM2RPUP1HOUB+NTAONqnKbgfL1cz54gESQxLfDGnDsXQ7GKRxmDMhWpae
         zSoYrdDRsViSNM6Id1+vUWxFbSBAGmuC5zn/Bcq1z5BUrG8Eh7+fgGyLfVANTtejVBfi
         R+sOKFPLLpNiTZODUwWZt3/fviswRF9gPxTywflrcweU79/NhT08skLFjw/mHnddR+Jc
         DmTCUJ1TxQUpdUdP6QRNf7CWlHBeGxoQXX4Y4dyojLmLQak6JG9aZzRnsFYXkQX83ARo
         cR8/0VjMgqH0JTQ6LcFCQs7C4/7sXo/6jgy8+UhnWrLHzUiIk2sYD5q9atCCKxCR+5sA
         mpag==
X-Gm-Message-State: AOAM533S0mgl0KzI1oUxKEk2lJC8aDabM5qg4/XSpWTlYyyNB3I+Ja3n
        skKiHDw5f1xR6GrtDNXEmzLVVg==
X-Google-Smtp-Source: ABdhPJzEJ4Y/U6MqAkTlFXMn+B7exGAdQyHi3xVmOJ3pNV+7kxqLyP+Upr/X5mcNM4PQ/tfoWuShZQ==
X-Received: by 2002:a63:b515:: with SMTP id y21mr28034069pge.253.1619624932865;
        Wed, 28 Apr 2021 08:48:52 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t19sm113326pgv.75.2021.04.28.08.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 08:48:52 -0700 (PDT)
Subject: Re: [PATCH 0/1] spelling fixes
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
References: <20210428153521.2050899-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b11397f8-b1d2-f525-e6ac-de9826bd0c63@kernel.dk>
Date:   Wed, 28 Apr 2021 09:48:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428153521.2050899-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/28/21 9:35 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes the spelling of some comments.
> Thanks!

Applied, thanks.

-- 
Jens Axboe


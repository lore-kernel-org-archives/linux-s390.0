Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8888C433E0
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 14:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3346507E
	for <linux-s390@archiver.kernel.org>; Tue, 16 Mar 2021 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhCPObn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhCPObW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Mar 2021 10:31:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C16C06174A
        for <linux-s390@vger.kernel.org>; Tue, 16 Mar 2021 07:31:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g27so37386065iox.2
        for <linux-s390@vger.kernel.org>; Tue, 16 Mar 2021 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QBrTqmbWkT3m4ogzCMY8L/5RjpVs2Bwj4VfzNovCHcY=;
        b=WZ4wdj4zQdq/AoWbRfvpsRKEyQjHIw6AZKzfcuM/wQxFzYQ4UfalEnV7KA+QdeohGD
         h6yNwu/xq8jddKxh8DmaW2xinj7JlQPKPSRVxhXjPafMr9s5/aStzxufxfNt3YKxnumN
         02Z8E3ecZdPMzgd2NUWYQzKJQwykg8+DfgRVbpz0UnoA81gSPQgyCI0reU4qiM6Lgen8
         ho4OLCSzKuQDuZd2tykgvV1imXVx5+V4k6GDX8j6ITpju3by/DFoXTYX61w/IJq8vp+9
         TBGVIgyXSmj5Mrtr8IRzsaTNupnQ1EQfhFjgBbT/EN1JOl3YN3VwPHwSMP3zMLg7PJFt
         T1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QBrTqmbWkT3m4ogzCMY8L/5RjpVs2Bwj4VfzNovCHcY=;
        b=EzucTXST6KpYOkND0mPMl1P8Fa1RBkxJqWzKzgbDh5GtTjjKxsin7naBsi++8tFNRd
         Ix8HvtRcsD1j+/vFlKSHBugBe0YdGTTTsn8LmUUqll1OGdfTttH3+w2mBVOZ+NcZmo2z
         nL9Oa/BmEO/15GsGoSVHj4w+RkkgiMRZs9N8tFDp6GfMMT4du2L1ZvwE5NU+H4822eGV
         gpviqyMz1j4bpzAflRsqS9ZY8aUCFnC9MVFzl/FXwKM++r06oGhJ+01Hjr6FITo9yQxV
         UpQJhOKBRuimxkjT0+BJ7+iMic+T+ffipFD8tpVqZGX71olVHnHFOhn8jPDQc7p3EVyx
         SeNw==
X-Gm-Message-State: AOAM531ZRg/rmg6m3coXiuZS+l9gvTKt2i/9Cr6z34+2XBggvWff6LME
        kPuaBNW8E9OSJJw5LbqlAkPiUmak/4jh2g==
X-Google-Smtp-Source: ABdhPJwJDINYIHtGv7AA1OeehO1lScr+eKoDb0C97yp6l13rjNlzdpEMTq/xFiWltriuJcdffftGTw==
X-Received: by 2002:a5d:938e:: with SMTP id c14mr3640584iol.88.1615905081657;
        Tue, 16 Mar 2021 07:31:21 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a16sm9550081ild.82.2021.03.16.07.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:31:21 -0700 (PDT)
Subject: Re: [PATCH 0/2] s390/dasd: cleanup patches
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
References: <20210316094513.2601218-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b19c6de8-5d97-2ce1-5e48-c73e713f69fb@kernel.dk>
Date:   Tue, 16 Mar 2021 08:31:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316094513.2601218-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 3/16/21 3:45 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following DASD cleanup patches for 5.13.
> They apply on you for-next branch.

Applied, thanks.

-- 
Jens Axboe


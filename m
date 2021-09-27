Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A720C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0022560FED
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhI0WeD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbhI0WeC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Sep 2021 18:34:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D9C06176A
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 15:32:21 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q205so24802536iod.8
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UmxU11hST5wQMMsZTOdrPPgQ47TLPa20pybe++XQYM=;
        b=DYK0QeVSPErU0fdUHY9fTGU4W7LYS3OpstW7jKN2zQIGz6Fg75r2GHQ3mNhW9RIn1l
         +/XX+0IaT+QuP2WnY1RDSSQe/LzU370EV/dACbM1CoHg6kWxfp4JKYe9NsSJNOZspcJv
         79kSmVRSpqY6HusQwOsl5Cca71RoZZnxCQ7faeNT+onSgNJoOacMUCqYfldqMMFZnJn1
         op2n2nb0dzUlxGLwnR76PnSZAQEAPJSGaPxLjQP0iN7EFQdPXw6p08Wye3gAirxio6qw
         Ay8cPI17oe8ngWi6HmVYmshTvXlSdR08xlvJOMOinmATWt5vmC9kQdW4ky3oHMIbMIRb
         tKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UmxU11hST5wQMMsZTOdrPPgQ47TLPa20pybe++XQYM=;
        b=grW+0xcDutE1z9yFeFCMOJnm8AgHnwm7UGvYa6cbxcMoJwy1k02bI3ZuQwTK1TkrX+
         9EnaB9jZTge1ogzhkW/jaeF1vqTnlAEFf7/daxnUNMa2fVtzMP9VFV0swAWq/SdliI23
         eVZClFLV3nxoVg/MIhvnUQLX2jRg/nxO1N1IfYP+8lvUkc68cxA0fkDecUClbMq9SwDC
         NIpqGjnyXwQ4pFDKcoRRwH7GRXssi7ujXGVLNzQXlTQRvRNxqqDWfAk4pfOaLanPjPEz
         UBBbPfDOklL+KcVyHUHULbobzsEWecBfFmg7Fp32UtUNWVUge5YGQmZFyxgwnGcfOrcl
         eZfA==
X-Gm-Message-State: AOAM533AXU1RoWAqmNJm4ZpR/KRfPh21XCsv51Y9Rzs4uJuJjy5VhVzi
        pvCnHFyWojlzKnSKU4rcCN8OOQ==
X-Google-Smtp-Source: ABdhPJzCRspGfuZEaibKYg9STMBXwDX6ihxLpFk5STZ/wJRDMFJCRfEhMCvkyfG9LlSO8u6kMpd4Fg==
X-Received: by 2002:a02:3f4f:: with SMTP id c15mr1841581jaf.1.1632781940669;
        Mon, 27 Sep 2021 15:32:20 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p4sm9291645ilj.26.2021.09.27.15.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:32:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] block: 5th batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com, hare@suse.de,
        maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        colin.king@canonical.com, shubhankarvk@gmail.com,
        baijiaju1990@gmail.com, trix@redhat.com,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, oberpar@linux.ibm.com,
        tj@kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210927220232.1071926-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25afa23b-52af-9b79-8bd8-5e31da62c291@kernel.dk>
Date:   Mon, 27 Sep 2021 16:32:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220232.1071926-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 9/27/21 4:02 PM, Luis Chamberlain wrote:
> This is the 5th series of driver conversions for add_disk() error
> handling. This set along with the entire 7th set of patches can be
> found on my 20210927-for-axboe-add-disk-error-handling branch [0].

Applied 1-2.

-- 
Jens Axboe


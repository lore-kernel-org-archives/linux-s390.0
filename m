Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5C9C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 12 Aug 2021 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D396109D
	for <linux-s390@archiver.kernel.org>; Thu, 12 Aug 2021 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhHLQvw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbhHLQvw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Aug 2021 12:51:52 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7156C0613D9
        for <linux-s390@vger.kernel.org>; Thu, 12 Aug 2021 09:51:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so8503642otl.9
        for <linux-s390@vger.kernel.org>; Thu, 12 Aug 2021 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ny72dvyv02gs52BODIXbqFAvUcs0ppK7k7vDL5+fmKc=;
        b=lGNAjICNx3vvf1yMVz0aI7CQek+tBGtccOO5YclAlos8J8uO2FuaOnGuBKQnorAHaM
         Z19xWfK6P8799ph/A4dQ/1oW0106jB/+t7Vq6XAD8sB7LJ+fj3SfBmKcuPrFvpyBTSUo
         Nqsjf3+7Y9zK+gv4drQuEtiF187GIPNNYKp159ix//sRalbYXuV3IXJImDWQCD5CO8Cu
         q/Ic5DjFctOOkRxYaQ6JmxfxUiG24ILQJ/DuI72ipRbbkapa0s2JE6MouOHtE4G6XgJu
         CGZ81hgsaq7ljm30bG7/NTpV5l9SqjNuyhXW9QVE5stkLv+AJ589w/oT9q+W0yb1jnwW
         Qadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ny72dvyv02gs52BODIXbqFAvUcs0ppK7k7vDL5+fmKc=;
        b=Ar1OVOLLiEcLax/VeWwSeFhhCj2ntp9ggOl9sIKxyGGoaUobJXPEfslZGtak+kPass
         ImNRuxCLKorOxHSOi9WQO2N0VO4z7Aqg10AG5a1Reykwe6gYsu2c5OwreOGhk7Xrgdby
         2T6+edTsAFfKUfaL2DeQV4TL0VqRrMKBL3ewtXBLkzwo60dCPNpa7UfvH/NvlISq6qF8
         4O3nzoMhDQ6BaKCJ6NDn3AMq2cLcnXwt3/myWrbuwKIe9kVq0bLP/F4UNJh3AbDIGHby
         WPN5LSz0PAQB4wbpmRtBLr2c98WZQ9kpExx5ABMqK0Kf1p8GSTfuRS+eXXqJ0k8Gp1k1
         bi3A==
X-Gm-Message-State: AOAM532Oj7pTNDmObUgGz5ocvZ0SDtekVgmA34DSKFDb7kwjAguUtY2Z
        n1vSoiAdYgOup7T6mQbl3QmJEg==
X-Google-Smtp-Source: ABdhPJzLc/kCLGijT6QbBhtFUlVP/yIuX/FFPTJY0ez8pAiOiuUy+sOQkVIfCU1WEJ3z6VKbgyW8eg==
X-Received: by 2002:a9d:175:: with SMTP id 108mr4326252otu.366.1628787086179;
        Thu, 12 Aug 2021 09:51:26 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y33sm709603ota.66.2021.08.12.09.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:51:25 -0700 (PDT)
Subject: Re: pass a gendisk instead of block_device in the partitioning code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <20210810154512.1809898-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b8b6257-7bb6-9167-483e-153ab082d80f@kernel.dk>
Date:   Thu, 12 Aug 2021 10:51:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810154512.1809898-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 8/10/21 9:45 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series passes the gendisk instead of the block_device when operating
> on the whole device in the partition code.

Applied, thanks.

-- 
Jens Axboe


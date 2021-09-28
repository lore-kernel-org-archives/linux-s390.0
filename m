Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FCC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1E861058
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 12:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbhI1M3w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbhI1M3w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Sep 2021 08:29:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB531C061575
        for <linux-s390@vger.kernel.org>; Tue, 28 Sep 2021 05:28:12 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r75so27093085iod.7
        for <linux-s390@vger.kernel.org>; Tue, 28 Sep 2021 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUW2/IJFZY83nPJmflQgcvtOV5+nVA8I+eyXlqMJPRU=;
        b=3rbyBzZUI4kM0wtWn3uTCiL+iFQn37kynJEfwzTuvV788lRHsOgrxQX//6Ptwtyvhm
         PRk4feijU3wh94ty5i1N66Ig+sABpOoZVeSM47DP356owZxXG4KVg3Qk+fU5UpN7qjXC
         jeSW+Bttk5kETwDV3GWvC4MYYvgsuJqIuQTZDyroLwERBzQS4FN9yhIxNHryOdoEOwa3
         o/15DNQGaey/vFs6hguKBx6L7zxTznRm9cJa3vz3CKspK4BMmY/hSPddKOKPDaXtB5dT
         Z+Mr9kmkrhnMk9UXoVcl7QPhre4NUeznnkriL3TH5rbTeZtGvIvFfgKW43pdABZ6Z0cz
         KdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUW2/IJFZY83nPJmflQgcvtOV5+nVA8I+eyXlqMJPRU=;
        b=w/KhzAti2N31khQ5hW1OonIVUHNtnOpkuL9PvaNTBJDCj9KteSt77Yb/4ST0SpPmo1
         Bn0P66Qco6MjCyzJuTOInaD9w1f8iihJ5c+wLGueDuo3AnYw6xJdSJYz9QInD6jn/8qr
         fT8LKiqHXQHdBRoagw0hhg+TpF5/SYgf1DQVOfvh2Zx8/lC5ZHLEsGCiD23XFj07vvFG
         18ptmMfnygZuF7UApj4jX9BZRJyBR1t+LuVXnNUi+cUbsH1cRTgNvxNXbqSlE7Ety8ML
         sUjm/ejpsNEigDXxFTbZvdbFm5tume+2ZdXS3GJopb4JNvREmmKTao5lkd8+kZuRs4qP
         kJSA==
X-Gm-Message-State: AOAM532aCNtG3Z2mLjnCJHrJDCJxJmdT4lHg9KuPE1gf12dutfPjfLhU
        MZlHCB95dlaP0B9UY1/6+dietQ==
X-Google-Smtp-Source: ABdhPJwPZLFitXCog7R4G/mZxZzFOE8+azMCqbj1uCZcF9QhbMc4aOBoMdp9+4PWoLOwgLvLP0Uqqg==
X-Received: by 2002:a6b:5114:: with SMTP id f20mr3764704iob.97.1632832092364;
        Tue, 28 Sep 2021 05:28:12 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm856634ile.20.2021.09.28.05.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:28:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] block: 5th batch of add_disk() error handling
 conversions
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com, hare@suse.de,
        maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        colin.king@canonical.com, shubhankarvk@gmail.com,
        baijiaju1990@gmail.com, trix@redhat.com,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, oberpar@linux.ibm.com, tj@kernel.org,
        linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210927220232.1071926-1-mcgrof@kernel.org>
 <25afa23b-52af-9b79-8bd8-5e31da62c291@kernel.dk> <YVLV3s66GVVSQ+tj@osiris>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bfd9f85a-d6fb-c05a-5ec3-2e15ee08062d@kernel.dk>
Date:   Tue, 28 Sep 2021 06:28:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YVLV3s66GVVSQ+tj@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 9/28/21 2:44 AM, Heiko Carstens wrote:
> On Mon, Sep 27, 2021 at 04:32:17PM -0600, Jens Axboe wrote:
>> On 9/27/21 4:02 PM, Luis Chamberlain wrote:
>>> This is the 5th series of driver conversions for add_disk() error
>>> handling. This set along with the entire 7th set of patches can be
>>> found on my 20210927-for-axboe-add-disk-error-handling branch [0].
>>
>> Applied 1-2.
> 
> Hmm.. naturally I would have expected that the dasd patch also would
> go via block tree. But let's not spend too much time figuring out what
> gets routed where.
> Applied 4-6. Thanks!

I left the ones that have active maintainers for them to pick. Unless
someone has already acked/reviwed it, in which case I picked it up.
I've got no problems picking them up directly, but unless it's been
reviewed by the maintainer, I prefer if they either do so or pick
them up.

-- 
Jens Axboe


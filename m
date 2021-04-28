Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F18CC43460
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 09:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C79761186
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 09:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhD1JbA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237745AbhD1Ja7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 05:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619602214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqTFXF2fuJIOfJHntKSB5UWeiLgURFuvM9psymb7+ag=;
        b=jMMwTl8m/u4ByyDLeNxaJMxKgoZaxT2GJHgxyLaPBz2V/omcNs/2RM/QuE4GK7J3STAZXn
        psbU48luiM2qwnavzT0ZzKpglIGzY50DCAMZ2QZa3aFWFjHfoLiJnD3/ZJ/ajbprR2poxw
        0amrHrVoX0KlvnN2iE3Gp7Idcha8afg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-ALII2XVgOlSbF4FHMVj99g-1; Wed, 28 Apr 2021 05:30:12 -0400
X-MC-Unique: ALII2XVgOlSbF4FHMVj99g-1
Received: by mail-wm1-f69.google.com with SMTP id n67-20020a1c59460000b0290114d1a03f5bso4908205wmb.6
        for <linux-s390@vger.kernel.org>; Wed, 28 Apr 2021 02:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqTFXF2fuJIOfJHntKSB5UWeiLgURFuvM9psymb7+ag=;
        b=gcyEhZ5MYexNd/hvxMDWl5aaYFLJZOGT8ZXSF6fLYW1qeTD1zx3bDImj5U3FW4Ay05
         VqE1r9NEe/Zmg9iTBB84zQDFSYNj0TQKAZ4boygsbfBAQ6rGG5oB8qYULobKovmk+TwI
         ozBc5HLKFAcZMonyfDoQCFkwVLcsFx3AZ0nIqEIQpXytt5fP+3oKq2BDpRFIEvNWDroc
         5Hi5lHHXXEfEaPBb+MtKeS2ehYHOaE8NExiWfPh4fMjeYsvH/su21yXDxOd8rUrsbe4z
         n+3zGmcJ7F8s786EmR/J5Hfy/7oV8czAiyVp+mng+k5t8mVhz9+dmoBnUk0KFC/Mwjsy
         8GrA==
X-Gm-Message-State: AOAM531lHlT9DDR9BlYOY0Mm/4/ZoaecKyYkvpCD9T+JJstkoAjwuoCA
        A9vepYcG++J8djMA4/jAWhkY1K+SBmcVnM997q5Y+9H9agr/EpCj3xiq3r6bgtyY1Kus640ELf8
        eNSrhehZ0kiPMdVaYLN86kQ==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr34503129wre.183.1619602211012;
        Wed, 28 Apr 2021 02:30:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0jbStDFMnERnBlV0S856/OfSAKHul1X6SZy3ljW6qhVlQyQMN4lvCOKyPwHGz88y85+Lmww==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr34503101wre.183.1619602210812;
        Wed, 28 Apr 2021 02:30:10 -0700 (PDT)
Received: from thuth.remote.csb (pd9e839c7.dip0.t-ipconnect.de. [217.232.57.199])
        by smtp.gmail.com with ESMTPSA id k188sm7328698wmf.18.2021.04.28.02.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:30:10 -0700 (PDT)
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, cohuck@redhat.com
References: <20210428082442.321327-1-thuth@redhat.com>
 <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
Message-ID: <6e44cc81-fe19-f75b-972f-5c4707f2410f@redhat.com>
Date:   Wed, 28 Apr 2021 11:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/04/2021 10.31, Christian Borntraeger wrote:
> On 28.04.21 10:24, Thomas Huth wrote:
>> In former times, the virtio-console code had to be compiled into
>> the kernel since the old guest virtio transport had some hard de-
>> pendencies. But since the old virtio transport has been removed in
>> commit 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport"),
>> we do not have this limitation anymore.
>> Commit bb533ec8bacd ("s390/config: do not select VIRTIO_CONSOLE via
>> Kconfig") then also lifted the hard setting in the Kconfig system, so
>> we can finally switch the CONFIG_VIRTIO_CONSOLE knob to compile this
>> driver as a module now, making it more flexible for the user to only
>> load it if it is really required.
> 
> Isnt that a distro specific decision? I would be perfectly fine to have
> this change in Fedora, Redhat and co.

Sure, I'll try to get it changed there, too.

> Not so sure about defconfig.
> We often use the defconfig in our CI and development things to have a
> kernel config that boots up fine, even without a ramdisk. I agree that
> virtio console is no longer really the most important console but does
> it really hurt?

Well, it's about a default configuration that should be fine for most users. 
I don't think that anybody really uses virtio-console in a ramdisk already 
... or are you really doing that in your CI? If so, then please disregard my 
patch.

Otherwise, I think compiling this as a module is the better choice, since 
most people won't use this at all during run-time, or maybe just use it for 
thing like communicating with the QEMU guest agent, but this is then 
certainly not required during boot up yet and thus the "m" should be fine, too.

> Is any distro using the defconfig unmodified?

Most likely don't. But it's a template for new configs, so we should use 
good defaults here.

  Thomas


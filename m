Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3320E7490C
	for <linux-s390@archiver.kernel.org>; Mon,  2 Oct 2023 19:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjJBTPo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Oct 2023 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjJBTPn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Oct 2023 15:15:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44ACB8
        for <linux-s390@vger.kernel.org>; Mon,  2 Oct 2023 12:15:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79f95439795so78226739f.0
        for <linux-s390@vger.kernel.org>; Mon, 02 Oct 2023 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696274138; x=1696878938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wfpu0g7eWR/bD6NFg1Hw3uuA6aj8ndONfL3cIV4EkSU=;
        b=LD0D5C1hAgd9cfGzjB0woiGA7f3wRstHNDJpX0bwrw2c3u9EVsmqdm0tv5Re980i/c
         Vsbd6JZ3PZcukzNx/mTB5KSLFOc1pnGBtrszLr31CzPiB6ggWixhRbX9ayte+CzTEsS0
         H9y0OhJ8ZMW2x5QRXfVanglwbIxUO5d70UtQJbeRbFjqRvE07xx5Iulfd56FUNWXS81/
         N8GQ3nh89nPUbMDU/ipiXqkLvyKpr4YcbBINy7nfTGRyxwKLe/BT/E7GGdxllXXgtx/y
         GuafTq3EThpbNs8kmBfMPKWmx/NPgUDjGo0yzkqeoDLrCT2dKSpkifkeP/GxsEtfYyGa
         +rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274138; x=1696878938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfpu0g7eWR/bD6NFg1Hw3uuA6aj8ndONfL3cIV4EkSU=;
        b=kBpbb0+t9AK9I4sKF9INs7ekWMktvICKW5cGRemnoRTkhgEw0SdrqyyW/1jZo3WaxM
         X2m06x6IZukUBaK5BE9MpRmWRk7rjr0BhV0JWBWaSKlVETuxy/JCW0dFxIrgEn6TEZLu
         17PKW64fq/iMqobtBxxRmYeJlWrw537XWZqSoqH5Wblwt+O3wK9r6SHnWtK4rtjNnfsU
         K0tnCcq7njaVsSRMg4cl0dd4TCVFTl7XF2OZulxw59UxdTc735qiTeB7tkukB+QUaKFB
         2hRCw4CBtQ/6AnyecNWJcjN/LDVaCwF62zReLCxeIIw+r1269NELJYjfPE6db9bvTtxQ
         na6A==
X-Gm-Message-State: AOJu0YyBVAtrgCb06k/RRRlzYBdgHixVp6fg6FNAkLzPk6PY9wG0NxV6
        fsr+W8Uiqt1aM/UxQPBKMpeVsg==
X-Google-Smtp-Source: AGHT+IHuLrLT0lmZmHDMHS0OHH96XERxHL7pJTE9KoIBXxmJHQADQKTERwsFpskdzZvEU4f1iF1V2A==
X-Received: by 2002:a05:6e02:1d93:b0:351:2053:f4a with SMTP id h19-20020a056e021d9300b0035120530f4amr485145ila.3.1696274138264;
        Mon, 02 Oct 2023 12:15:38 -0700 (PDT)
Received: from ?IPV6:2605:a601:adae:4500:71c9:1cd3:823e:b180? ([2605:a601:adae:4500:71c9:1cd3:823e:b180])
        by smtp.gmail.com with ESMTPSA id w5-20020a056638030500b0043a1fe337b9sm7192769jap.170.2023.10.02.12.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:15:37 -0700 (PDT)
Message-ID: <3a5e1f6e-5fa9-46ea-8828-ca4679bf0c77@sifive.com>
Date:   Mon, 2 Oct 2023 14:15:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] nbd: call blk_mark_disk_dead in
 nbd_clear_sock_ioctl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Wouter Verhelst <w@uter.be>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-8-hch@lst.de>
 <79af9398-167f-440e-a493-390dc4ccbd85@sifive.com>
 <20230925074838.GA28522@lst.de> <ZRmoHaSojk6ra5OU@pc220518.home.grep.be>
 <20231002062159.GB1140@lst.de>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231002062159.GB1140@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2023-10-02 1:21 AM, Christoph Hellwig wrote:
> On Sun, Oct 01, 2023 at 07:10:53PM +0200, Wouter Verhelst wrote:
>>> So what are the semantics of clearing the socket?
>>>
>>> The <= 6.5 behavior of invalidating fs caches, but not actually marking
>>> the fs shutdown is pretty broken, especially if this expects to resurrect
>>> the device and thus the file system later on.
>>
>> nbd-client -d calls
>>
>> ioctl(nbd, NBD_DISCONNECT);
>> ioctl(nbd, NBD_CLEAR_SOCK);
>>
>> (error handling removed for clarity)
>>
>> where "nbd" is the file handle to the nbd device. This expects that the
>> device is cleared and that then the device can be reused for a different
>> connection, much like "losetup -d". Expecting that the next connection
>> would talk to the same file system is wrong.
> 
> So a fs shutdown seems like a the right thing.  So I'm a little confused
> on what actualy broke here.

I'm not too familiar with the block subsystem, but my understanding is that
blk_mark_disk_dead(nbd->disk) is permanent -- there is no way to un-mark a disk
as dead. So this makes the device (e.g. /dev/nbd0) permanently unusable after
the call to ioctl(nbd, NBD_CLEAR_SOCK).

Like Wouter said, the semantics should be similar to a loop device, where the
same block device can be reused after being disconnected. That was why I
suggested disk_force_media_change() as called from __loop_clr_fd(). The loop
driver doesn't call blk_mark_disk_dead() anywhere.

Regards,
Samuel


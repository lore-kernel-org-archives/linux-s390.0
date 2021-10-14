Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A076C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 14 Oct 2021 13:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E85B610CC
	for <linux-s390@archiver.kernel.org>; Thu, 14 Oct 2021 13:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJNNex (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230257AbhJNNew (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Oct 2021 09:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634218367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHpcQuHVzP61PCLL+Fjiwo05Qr91Fn/iL+o/xLumkPU=;
        b=CF7zYOruocKaSFrU4eecH9sMNA6hUIKV4m4RW50Hsq8bXj1ybI+OkTrs3joj/FGkfOMBFZ
        hdH6tk/v29fknKRW5T74YMAqLU4seDXtcmB+vWHp4J1zRKByLwB1Fy/XIFowtHNGh5uwoW
        yOfmWg7M+9pYzV5K2LsNerm4+ZJV8qw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-AFvB9jmpO8CLTpdd01wyng-1; Thu, 14 Oct 2021 09:32:46 -0400
X-MC-Unique: AFvB9jmpO8CLTpdd01wyng-1
Received: by mail-ed1-f71.google.com with SMTP id l10-20020a056402230a00b003db6977b694so5125398eda.23
        for <linux-s390@vger.kernel.org>; Thu, 14 Oct 2021 06:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NHpcQuHVzP61PCLL+Fjiwo05Qr91Fn/iL+o/xLumkPU=;
        b=lPHsBzhj3jdHYm7vgNZeA0wlLKZCzcbx0/Cio0aWfXqlTWeoG8tRxlwGA8cwnXgEB/
         0/EdAz2gY/arkznnpOJLH4sO7ZulJK1BspceIQvwyp4k+bgNjBW0qoUDjp4pM92cfQsY
         VOo8Sw5Q97ZMEWtXN98yOb6yuM9xDQBU2qYyE3zF3wzvrreDzlm+PrSG+vInOXEflszc
         08zeGusjvqdn9vAflafLxem/P1PiJ3myyo9IZl1himBpaH+L5gnkI3taNgKIf1zTpfjB
         b9dy7OiZ3MCKX+G8VP/D05W0x5/v2U93+E/0AKreXlSPMylzrFHtVPSnZnllAKJkWeU2
         gjXA==
X-Gm-Message-State: AOAM530fT8cC57qNdI1S5Q/nY7oJFcuAY6rHkFs2yu3tCa4udXrjsoJx
        oQCF4O3pXdgguvG2BAgh9IOJHeJIGyy0IG1Ov5L25Oq8ZLsae7UJCM6dELSr0jGismKobDak+C6
        kZ5YdIyQ0RLjFKbo6k1/52w==
X-Received: by 2002:a50:e085:: with SMTP id f5mr8826463edl.9.1634218365238;
        Thu, 14 Oct 2021 06:32:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrQieYC+gxWyiqle7AAtsptB3GOiT9Cj3s4p5h6SCMnmi+plkM5D/gwwv7wJhtJDbDDRPZjQ==
X-Received: by 2002:a50:e085:: with SMTP id f5mr8826434edl.9.1634218365017;
        Thu, 14 Oct 2021 06:32:45 -0700 (PDT)
Received: from thuth.remote.csb (p549d10d7.dip0.t-ipconnect.de. [84.157.16.215])
        by smtp.gmail.com with ESMTPSA id r3sm2173907edo.59.2021.10.14.06.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 06:32:44 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 2/3] lib: s390x: snippet.h: Add a few
 constants that will make our life easier
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com
References: <20211014125107.2877-1-frankja@linux.ibm.com>
 <20211014125107.2877-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <7a919ec3-e790-aad1-edd5-463148b5fc37@redhat.com>
Date:   Thu, 14 Oct 2021 15:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014125107.2877-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/10/2021 14.51, Janosch Frank wrote:
> The variable names for the snippet objects are of gigantic length so
> let's define a few macros to make them easier to read.
> 
> Also add a standard PSW which should be used to start the snippet.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/snippet.h | 34 ++++++++++++++++++++++++++++++++++
>   s390x/mvpg-sie.c    | 13 ++++++-------
>   2 files changed, 40 insertions(+), 7 deletions(-)
>   create mode 100644 lib/s390x/snippet.h

Reviewed-by: Thomas Huth <thuth@redhat.com>


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C2C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369D760E0C
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhJGJPQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232604AbhJGJPP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 05:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633598001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6xWksNQxoEXfwg6tFpy/wzo4JRJNCvclfH22DUGY4E=;
        b=KkwylZvsvdLs9aWRSqQ+sjTtykc13hgDBdVMRqojCEJJcxx+zRHa4Q3Ro6eOcxBNLUiAPU
        4KhXjrl4ibNFsAVuw0CuupgDZexUkLKxeS6tjLzuMqgd5MhngHm0yDNcwwAekgLX5kHZTL
        PMjLOFYs3kw9HYkgxvvWefND/dxJXcs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-bnruum67NDicNvnO-ubLeQ-1; Thu, 07 Oct 2021 05:13:19 -0400
X-MC-Unique: bnruum67NDicNvnO-ubLeQ-1
Received: by mail-wr1-f72.google.com with SMTP id s18-20020adfbc12000000b00160b2d4d5ebso4183532wrg.7
        for <linux-s390@vger.kernel.org>; Thu, 07 Oct 2021 02:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p6xWksNQxoEXfwg6tFpy/wzo4JRJNCvclfH22DUGY4E=;
        b=rfkXD2FYMptNFpx0UzusCGLFHcw3SXVp52huP55zpqWyZshaU6XZhn57oBmVx81FKl
         I54RgkWmRh14Eq21I5Hazy5GW3vg3o40Qnq8lokJtmiZDoLbDDkRG/xQBZUmC/PCXwGb
         oNIxmrsKnpFOXxTzl2jJHQI+7yYfmkRS0YmCTfPNGzbjMAXQSkg+cQ/LZ0033Nrkfq6K
         iKwLIYf1fNpee//tt/Bo7hrcnGfwmsP4P9b5lNnDo2YTnvRTiwCvI3LAs7UoS5N44YQz
         s4qQoFmmN9ZlIt3NzBC3YMSTqSKQtIJgE/pneYDwIR6jQuqXtWnnfLv0txqs5xd1Cj0A
         H3+A==
X-Gm-Message-State: AOAM532se2SQjGKv0UDskgqz3pDYt25yC1n409366iQh+gBTYefOgj6X
        ISd3BTOyLzyi5BIvj3yW70sSEsl7uNF+4C/EMGzsw0UKvZ/L9/uVkwuzEvrb7n2v+Ij1j+DoGfV
        cNWcGpU4xrxx5m2GrJ4swnw==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr3785913wrd.340.1633597998114;
        Thu, 07 Oct 2021 02:13:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPzCotQqXgoiOprZwOPA4N5NmPi1N04Ol14kHOuwFWyEINDsoKzDLuPf0JZUMGzKHSwWR/jw==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr3785892wrd.340.1633597997949;
        Thu, 07 Oct 2021 02:13:17 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id r18sm17528012wrs.47.2021.10.07.02.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 02:13:17 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v3 8/9] s390x: snippets: Set stackptr and
 stacktop in cstart.S
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com, scgl@linux.ibm.com
References: <20211007085027.13050-1-frankja@linux.ibm.com>
 <20211007085027.13050-9-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <39c39816-146e-6715-fe22-0f56bd943d6f@redhat.com>
Date:   Thu, 7 Oct 2021 11:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007085027.13050-9-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/10/2021 10.50, Janosch Frank wrote:
> We have a stack, so why not define it and be a step closer to include
> the lib into the snippets.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/snippets/c/cstart.S | 2 +-
>   s390x/snippets/c/flat.lds | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/snippets/c/cstart.S b/s390x/snippets/c/cstart.S
> index a1754808..031a6b83 100644
> --- a/s390x/snippets/c/cstart.S
> +++ b/s390x/snippets/c/cstart.S
> @@ -17,7 +17,7 @@ start:
>   	xgr \i,\i
>   	.endr
>   	/* 0x3000 is the stack page for now */
> -	lghi	%r15, 0x4000 - 160
> +	lghi	%r15, stackptr

I already wanted to ask you to replace the magic value 0x4000 here ... great 
to see that you already did it :-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


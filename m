Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33649C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 10:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357624AbiDLKMc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384160AbiDLIjZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 04:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39CCE237FC
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649750751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRz8VjSH1qSjZ4cp0lB46Ds2dFD0SLl2/TdMcFrMbKc=;
        b=hSuUkKNKcLPp29pfqAdwsDE4wlnARHNsBvVskw1T7/ZdOXach9TzyZzng+Y86fgcM83qsY
        64oOZBeoaAwzcRhkgvse+sTmxVygoqqg/mENAtlYy1sJQkDnJN+XJwGUUV/jiHcgf0PhOh
        MdJY0y4BRA5JXwgB29bRR3FjauP3uH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-TIx6mSg2M5STU5GtQEGwEw-1; Tue, 12 Apr 2022 04:05:50 -0400
X-MC-Unique: TIx6mSg2M5STU5GtQEGwEw-1
Received: by mail-wm1-f71.google.com with SMTP id 10-20020a1c020a000000b0038ece714a1fso53992wmc.1
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 01:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bRz8VjSH1qSjZ4cp0lB46Ds2dFD0SLl2/TdMcFrMbKc=;
        b=elbV7H0J9mOeeMBByYitNqm9pv2UKAP+vlM7H5rKIuPTPuiWldaOD4+wdIDwsKQkNK
         VvGeQOsfMtz60Secc2GjHhPbBuXeauGcWyv6NDXc9tjgYQkzqTZN6zPUjYJM8euUh+x3
         5KesNY5y0iRma++ufjssX1JWfc/VPbOxzq/BmtCLgWsra7bwwqtiDvVkFNKRQIoJoqW6
         u5JVb5GW75ZamVNCRnNvBZjcAXS51XWw//dJ8WFVw+JB6w2PKFL6zDxgG8NIGOkUj1JG
         Y/XE1TW/beDvPbMB6UC+VKUkTOrStcwT0ZLdebMrtO9rWuNsinzjyzruXj3mWsMESvNQ
         s0ZA==
X-Gm-Message-State: AOAM530wVRi8Y4qKzGuGpX4d8A5kGqveijUmAf1G2pWnO+TwfLqEx3Zq
        MnPmQ0v8GZdlCufWwuj3LPNot+Lg7HzIjyKnmHS5V1nmkli0nTDDeZWOTjSJ4wT/BHeBrbDPOvv
        GSPoTv752lLmV95MrzA8OvA==
X-Received: by 2002:adf:dfc2:0:b0:1f0:262a:d831 with SMTP id q2-20020adfdfc2000000b001f0262ad831mr27546410wrn.589.1649750748990;
        Tue, 12 Apr 2022 01:05:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7nqevoJ6F4/MqLgRJopZdu/HIcObXx7C5G8q98MDXMtbREMekakN7wjiTcdoUS6pqVD//3Q==
X-Received: by 2002:adf:dfc2:0:b0:1f0:262a:d831 with SMTP id q2-20020adfdfc2000000b001f0262ad831mr27546396wrn.589.1649750748779;
        Tue, 12 Apr 2022 01:05:48 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k124-20020a1ca182000000b0038eb706c030sm1679212wme.39.2022.04.12.01.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:05:48 -0700 (PDT)
Message-ID: <138a93d7-efa4-c2e1-85fc-c041c03ac45f@redhat.com>
Date:   Tue, 12 Apr 2022 10:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH v1 2/4] s390x: add support for migration
 tests
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220411100750.2868587-1-nrb@linux.ibm.com>
 <20220411100750.2868587-3-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220411100750.2868587-3-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/04/2022 12.07, Nico Boehr wrote:
> Now that we have SCLP console read support, run our tests with migration_cmd, so
> we can get migration support on s390x.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/run | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/run b/s390x/run
> index 064ecd1b337a..2bcdabbaa14f 100755
> --- a/s390x/run
> +++ b/s390x/run
> @@ -25,7 +25,7 @@ M+=",accel=$ACCEL"
>   command="$qemu -nodefaults -nographic $M"
>   command+=" -chardev stdio,id=con0 -device sclpconsole,chardev=con0"
>   command+=" -kernel"
> -command="$(timeout_cmd) $command"
> +command="$(migration_cmd) $(timeout_cmd) $command"
>   
>   # We return the exit code via stdout, not via the QEMU return code
>   run_qemu_status $command "$@"

Reviewed-by: Thomas Huth <thuth@redhat.com>


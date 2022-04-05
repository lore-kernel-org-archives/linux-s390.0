Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C0C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Apr 2022 09:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiDEJBD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiDEIm0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Apr 2022 04:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3E21E037
        for <linux-s390@vger.kernel.org>; Tue,  5 Apr 2022 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649147695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4AOGqJjZfmSt5BOdEAZNsUMBvrmi8UMagaCyd1GV6o=;
        b=TcO3NCx4NZ3fsc68xWu7kSka3AOC9SlTLvRJCm0HqgD6XqCSG1XmX32htf9D7oenbChlzr
        vUOOMSvSDsPkWcrlgmgoQVvqpNHvRyrkQ1gAWTJ2cEM6TZ50cnbpjoH7d6Ed2QtSJmoNbJ
        TaRmsJEymIfn4DWnzW5Ov+Mpwd+jrIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-V4nEy7zHOiCV8FBwaDtV3A-1; Tue, 05 Apr 2022 04:34:54 -0400
X-MC-Unique: V4nEy7zHOiCV8FBwaDtV3A-1
Received: by mail-wr1-f71.google.com with SMTP id q15-20020adfab0f000000b002060c75e65aso1353421wrc.5
        for <linux-s390@vger.kernel.org>; Tue, 05 Apr 2022 01:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4AOGqJjZfmSt5BOdEAZNsUMBvrmi8UMagaCyd1GV6o=;
        b=5fAa0gmYifubQZJO1Y/f3u3KVECvnlyZQnq/i+VqHVJGewOAhYiJpaCf7HG/y+TrxI
         UjZ3NRZ1L6IzgXkyYxmPK+QM/zBr4873Is4udkkXSloZk0Fgz5j6n7A2SunvUEgMFi9z
         gCCJ70VGiQF1ikazbeWjsL2OoQ2KfwiueJeTmGyb2mWgK1zuwMVfYE5j06ubXVtdIYX+
         iGbVWyewmGJzqMabyHvL1s9fPosHY7OpGB/AbXviX/6Pf197VkKQ30MuR3YbFqaFnp1u
         H/LDYBnnq2MFpe0li7R2aSI7zBIAKVMPOePAnTbfN2DZvAHb5kkuADCveueFL4x1rjW/
         2rBg==
X-Gm-Message-State: AOAM533Vuk4xpTDDlgrazGdeW++fAvDmbxLBbzNdMEqWkcpK+TVrCvqt
        vw+BDTAOvPPv7sOZ1L1+A+VDcaa5UYQDtujt/deNL+jW8fsh5JJ3svL9AVIUe1XkAODu25VIhlo
        8XKZjkJJL7JDKARO9abPWpQ==
X-Received: by 2002:a05:6000:388:b0:204:445:6a56 with SMTP id u8-20020a056000038800b0020404456a56mr1756917wrf.372.1649147693279;
        Tue, 05 Apr 2022 01:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQDf/kBQ9A/ofnoHOszDl6yu89JqO25KE7DqKpQ/1rdCMUVuXy2oBRGYoin4CzQpVRx9WVmA==
X-Received: by 2002:a05:6000:388:b0:204:445:6a56 with SMTP id u8-20020a056000038800b0020404456a56mr1756906wrf.372.1649147693048;
        Tue, 05 Apr 2022 01:34:53 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0038e389ab62esm2653163wms.9.2022.04.05.01.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 01:34:52 -0700 (PDT)
Message-ID: <4affb1dc-b9c8-224b-4800-6cb24d197a04@redhat.com>
Date:   Tue, 5 Apr 2022 10:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH 1/8] s390x: css: Skip if we're not run by
 qemu
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nrb@linux.ibm.com, seiden@linux.ibm.com
References: <20220405075225.15903-1-frankja@linux.ibm.com>
 <20220405075225.15903-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220405075225.15903-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/04/2022 09.52, Janosch Frank wrote:
> There's no guarantee that we even find a device at the address we're
> testing for if we're not running under QEMU.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/css.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/css.c b/s390x/css.c
> index a333e55a..52d35f49 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -15,6 +15,7 @@
>   #include <interrupt.h>
>   #include <asm/arch_def.h>
>   #include <alloc_page.h>
> +#include <hardware.h>
>   
>   #include <malloc_io.h>
>   #include <css.h>
> @@ -641,6 +642,12 @@ int main(int argc, char *argv[])
>   {
>   	int i;
>   
> +	/* There's no guarantee where our devices are without qemu */
> +	if (detect_host() != HOST_IS_KVM && detect_host() != HOST_IS_TCG) {
> +		report_skip("Not running under QEMU");
> +		goto done;
> +	}
> +
>   	report_prefix_push("Channel Subsystem");

Prefix gets pushed after the if-statement (where you jump to "done" via 
goto) ...

>   	enable_io_isc(0x80 >> IO_SCH_ISC);
>   	for (i = 0; tests[i].name; i++) {
> @@ -648,7 +655,8 @@ int main(int argc, char *argv[])
>   		tests[i].func();
>   		report_prefix_pop();
>   	}
> -	report_prefix_pop();
>   
> +done:
> +	report_prefix_pop();

... but here it gets popped in the case of "goto done", too.
==> Please either move the if-statement or the "done" label.

  Thomas


>   	return report_summary();
>   }


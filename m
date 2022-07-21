Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9BCC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 21 Jul 2022 12:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiGUMPz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGUMPz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Jul 2022 08:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A922D7FE5D
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658405753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlNc9n1fWwFyGkTTnJTXKq0eSOBEo14Xu9eIJGaW+eE=;
        b=ce1tZ+/1sAchlWibaAPM+X+BTG3iUBfU1oH27UIEiCA1oQKxTsRiKkZF5qW7wOFI+x9kd6
        5MWYRMKrBkkPxvrJrnPy2CVNBayBwMS3vBrkOPkkxtYi50nXDP7XENzARZmBQ7kp30RRXu
        oDCZzbZBmTsTg0iong6qDAlpaO0tob0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-10SwM7-tPJGDoUU3sTfW5A-1; Thu, 21 Jul 2022 08:15:52 -0400
X-MC-Unique: 10SwM7-tPJGDoUU3sTfW5A-1
Received: by mail-wm1-f72.google.com with SMTP id c62-20020a1c3541000000b003a30d86cb2dso2724239wma.5
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 05:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MlNc9n1fWwFyGkTTnJTXKq0eSOBEo14Xu9eIJGaW+eE=;
        b=AzQIr9NC/zvJzcSmFeYg34GGk1PdBuyzNAWYAU+HAdjv23Rjk/rppTGjKAedtmuvH3
         OR81+wjPfW51nOh9OybAmEOFE17gsLqk6QmAuKvPW8k+Bk7muiRsy+YTiJqu0bb7gEOA
         w6Kqi+UBM3SvXdUD+mQUgJ9FIoxnazB9d5yXl14jducA1uIO8ym1xCetlvVGznIW2jdc
         xynRCTQ6RKj/y67Aby0mrsByAaw3iXqHzqPVZKmg/zdt8qZDz7Flq022NwGZ1fu81flt
         BLipMvVK9BrPcdviWgFqDc21bnPSxXiS6EPZ4ty0ytUOu3DBhH77C3/3/iXkvlpscrOF
         eSmg==
X-Gm-Message-State: AJIora8UXsP9WCxfbjLV6sxZ/v/97CwFzzgvuIXTlZLkUamEVJ/udy2x
        1bvQH/29k4z0o3asYsazGt3iBw63/weyNEITxD4HU2v7UVNlIpFWlsyX7VRECskivgpnIn4letR
        8ezYmZgCXNepp56xh+YQVcg==
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id a6-20020adffb86000000b0021e3cc8a917mr10084335wrr.538.1658405751256;
        Thu, 21 Jul 2022 05:15:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEfV+Y4MmsVwCxdufVaD98uQsWP39lN2lswSNi4VCBH6RHHbzQn31qR8ld5PovVsrM4d86oQ==
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id a6-20020adffb86000000b0021e3cc8a917mr10084320wrr.538.1658405751047;
        Thu, 21 Jul 2022 05:15:51 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-217.web.vodafone.de. [109.43.179.217])
        by smtp.gmail.com with ESMTPSA id y11-20020a5d4acb000000b0021e57963c4asm1020715wrs.77.2022.07.21.05.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 05:15:50 -0700 (PDT)
Message-ID: <e43f4951-049b-7ec9-aefa-2f3731bd74da@redhat.com>
Date:   Thu, 21 Jul 2022 14:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] s390x: intercept: fence one test when using TCG
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, qemu-s390x@nongnu.org
Cc:     frankja@linux.ibm.com
References: <20220721105641.131710-1-imbrenda@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220721105641.131710-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/07/2022 12.56, Claudio Imbrenda wrote:
> Qemu commit f8333de2793 ("target/s390x/tcg: SPX: check validity of new prefix")
> fixes a TCG bug discovered with a new testcase in the intercept test.
> 
> The gitlab pipeline for the KVM unit tests uses TCG and it will keep
> failing every time as long as the pipeline uses a version of Qemu
> without the aforementioned patch.
> 
> Fence the specific testcase for now. Once the pipeline is fixed, this
> patch can safely be reverted.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   s390x/intercept.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/intercept.c b/s390x/intercept.c
> index 54bed5a4..c48818c2 100644
> --- a/s390x/intercept.c
> +++ b/s390x/intercept.c
> @@ -14,6 +14,7 @@
>   #include <asm/page.h>
>   #include <asm/facility.h>
>   #include <asm/time.h>
> +#include <hardware.h>
>   
>   static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
>   
> @@ -76,7 +77,7 @@ static void test_spx(void)
>   	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
>   
>   	new_prefix = get_ram_size() & 0x7fffe000;
> -	if (get_ram_size() - new_prefix < 2 * PAGE_SIZE) {
> +	if (!host_is_tcg() && (get_ram_size() - new_prefix < 2 * PAGE_SIZE)) {

Could you please add a comment à la

  /* TODO: Remove host_is_tcg() once CIs are using QEMU >= 7.1 */

?

  Thomas


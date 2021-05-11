Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD56C433B4
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3972B61155
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEKLqQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 May 2021 07:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230400AbhEKLqO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 May 2021 07:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620733508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0otTSj3OsAISXi/QZvZvvC7OfoKZIM9PUw7jqrFrVd8=;
        b=FMcOup1ah/qj8qSmCET0A1Nb5KFS16NoOSgFIxK2RZ1ummMxVwIn155GFmn+EL60XLzjpi
        8LBePzjzD6oN2GA2dDk2qebyN6vciwdVao2VXh/GFkN9ECm+hnLbvwCqUz8kmHnGrSSBUU
        oylMXZCSbH3DQZVte/efKrhK5SvLCwY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-BUtNKAITPhG8kPaTXEIxjg-1; Tue, 11 May 2021 07:45:06 -0400
X-MC-Unique: BUtNKAITPhG8kPaTXEIxjg-1
Received: by mail-wm1-f71.google.com with SMTP id y193-20020a1c32ca0000b029014cbf30c3f2so954466wmy.1
        for <linux-s390@vger.kernel.org>; Tue, 11 May 2021 04:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0otTSj3OsAISXi/QZvZvvC7OfoKZIM9PUw7jqrFrVd8=;
        b=ENkCYXY+YMmNMGj9oi/3CYZQYHb6g7pnIGRH4DdyVhrG5qfBjrXg2hf7Wf9C/k5mw8
         gA2dIdaFC7TZWn82+cfXfaHZg4EAe5n3aYd1kjYjAAvUX7OIndj9q5h8ivVlptWfYzWe
         IqQKrtIKVachTGu7afSgEvjW8rPrcS86zATw4Q2jmgYBF7tbZydIUWp0XXggVoKSzygF
         MDEZJmunP05YWZ5NgraFGX/0rYqWZgtBfDj1NZ2CObRSyagC7hUC//+ZJj6qnEHXD94s
         P1R9pTiJCYaW6NLKfv/wVzNBMuo133QTQkW5s1/QtoTb7HxxtKX+9MowkqxxdIWTwb+q
         Ewkg==
X-Gm-Message-State: AOAM531w1qwyimpEhHNTdsbEbr3ldg5op9lk98HZD9UAypErEJ7q4KoP
        U0u2XG/Tz6YfeQs4AB0ML+2/S5QC0H7ddtlpjT/liLdcBYdqPvMQkgg1bImXgWlxhxrxdBXo1SY
        Jzf9kwkytekSuRVYVZ8Vrfg==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr31843670wmk.22.1620733505081;
        Tue, 11 May 2021 04:45:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeoG0qMkWvIW/Vmsi2YQP64+0h62W/3xn4fsB9Rj2MA+kkAHHPP/2nY55iSlh5Wwgi0nCLYw==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr31843653wmk.22.1620733504892;
        Tue, 11 May 2021 04:45:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6329.dip0.t-ipconnect.de. [91.12.99.41])
        by smtp.gmail.com with ESMTPSA id f11sm3243694wmq.41.2021.05.11.04.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 04:45:04 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 3/4] s390x: cpumodel: FMT4 SCLP test
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210510150015.11119-1-frankja@linux.ibm.com>
 <20210510150015.11119-4-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <10c758a5-9347-37ad-dc37-f4cde5af066c@redhat.com>
Date:   Tue, 11 May 2021 13:45:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510150015.11119-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.05.21 17:00, Janosch Frank wrote:
> SCLP is also part of the cpumodel, so we need to make sure that the
> features indicated via read info / read cpu info are correct.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/cpumodel.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/cpumodel.c b/s390x/cpumodel.c
> index 4dd8b96f..619c3dc7 100644
> --- a/s390x/cpumodel.c
> +++ b/s390x/cpumodel.c
> @@ -2,14 +2,69 @@
>   /*
>    * Test the known dependencies for facilities
>    *
> - * Copyright 2019 IBM Corp.
> + * Copyright 2019, 2021 IBM Corp.
>    *
>    * Authors:
>    *    Christian Borntraeger <borntraeger@de.ibm.com>
> + *    Janosch Frank <frankja@linux.ibm.com>
>    */
>   
>   #include <asm/facility.h>
>   #include <vm.h>
> +#include <sclp.h>
> +#include <uv.h>
> +#include <asm/uv.h>
> +
> +static void test_sclp_missing_sief2_implications(void)
> +{
> +	/* Virtualization related facilities */
> +	report(!sclp_facilities.has_64bscao, "!64bscao");
> +	report(!sclp_facilities.has_pfmfi, "!pfmfi");
> +	report(!sclp_facilities.has_gsls, "!gsls");
> +	report(!sclp_facilities.has_cmma, "!cmma");
> +	report(!sclp_facilities.has_esca, "!esca");
> +	report(!sclp_facilities.has_kss, "!kss");
> +	report(!sclp_facilities.has_ibs, "!ibs");
> +
> +	/* Virtualization related facilities reported via CPU entries */
> +	report(!sclp_facilities.has_sigpif, "!sigpif");
> +	report(!sclp_facilities.has_sief2, "!sief2");
> +	report(!sclp_facilities.has_skeyi, "!skeyi");
> +	report(!sclp_facilities.has_siif, "!siif");
> +	report(!sclp_facilities.has_cei, "!cei");
> +	report(!sclp_facilities.has_ib, "!ib");
> +}
> +
> +static void test_sclp_features_fmt4(void)
> +{
> +	/*
> +	 * STFLE facilities are handled by the Ultravisor but SCLP
> +	 * facilities are advertised by the hypervisor.
> +	 */
> +	report_prefix_push("PV guest implies");
> +
> +	/* General facilities */
> +	report(!sclp_facilities.has_diag318, "!diag318");
> +
> +	/*
> +	 * Virtualization related facilities, all of which are
> +	 * unavailable because there's no virtualization support in a
> +	 * protected guest.
> +	 */
> +	test_sclp_missing_sief2_implications();
> +
> +	report_prefix_pop();
> +}
> +
> +static void test_sclp_features(void)
> +{
> +	report_prefix_push("sclp");
> +
> +	if (uv_os_is_guest())
> +		test_sclp_features_fmt4();
> +
> +	report_prefix_pop();
> +}
>   
>   static struct {
>   	int facility;
> @@ -60,6 +115,8 @@ int main(void)
>   	}
>   	report_prefix_pop();
>   
> +	test_sclp_features();
> +
>   	report_prefix_pop();
>   	return report_summary();
>   }
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


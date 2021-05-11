Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C78C43460
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E85961155
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhEKLrR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 May 2021 07:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231349AbhEKLrP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 May 2021 07:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620733569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KnehP62jTgxCuPr6k9MZbaNlRjHOqW8Ae/zjW9smOX8=;
        b=RNojMiuz8y8OYboeb/ETPKTecLsa5t03bYQZp3V45bq+Pj1jIpdbJq5PNfE0V0dNmPMMnZ
        z1a2cUuL/XP9f0kyfbuBhcmKk79M1hPdTyepSfFq7bfdi4CTWsBuvRr7YntxjTq1m6dIx7
        Lj42kAm6gXUa6G1zGlNxVKhoKjNVA6k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-wcEJNC-EPk-K7Bdc5I7qLg-1; Tue, 11 May 2021 07:46:07 -0400
X-MC-Unique: wcEJNC-EPk-K7Bdc5I7qLg-1
Received: by mail-wr1-f70.google.com with SMTP id j33-20020adf91240000b029010e4009d2ffso6177995wrj.0
        for <linux-s390@vger.kernel.org>; Tue, 11 May 2021 04:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KnehP62jTgxCuPr6k9MZbaNlRjHOqW8Ae/zjW9smOX8=;
        b=TkFdNXwf67UF76ULq/4T7/VKC2LnK2/CBw9sZJ4owUuDwJ6UctUJPzvwysX9eveDlJ
         amaXfafVV/qfWj2jvfsZ5TLE3t7F4rm1n7JHcWcZbgQWrppnmv6HoDBoPCIQLF+i7l0A
         gLeQQC0k2w10IpXcSeerqK1zkcpxmrDAuh8nnajnXEeOfUlF2f6XJTKkSJ/fnph8BMvT
         suh4ccMwcbxZMci7taJ1ZA2qBrl2T1+v7yWs/JK7LzzlBaSgCwmcGOM7q1fSygK7AoPb
         NQIl8+oLcihMabhsW61se7PNVWL625PVB1y/vj9/E0iGcbFEzVuwv6bF503QgWATL+Qo
         +0ww==
X-Gm-Message-State: AOAM530QAm73wyBn18gvWWAM4mdf74FoiPFG8eo9rabb7z+xSxZhe31L
        WKrAyGPBT3TACoCC53NS9nvcskg3HCj3tqvDsVU0Q0iJCAT78ssQC7nm8+ClArTNN5u/2OoLCsw
        gxaU1dRxJMsP2raKHzbhz8A==
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr31747802wmi.128.1620733566440;
        Tue, 11 May 2021 04:46:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrNXEPgoZMyPICExn2J3OJsOKC9meT3BX3Y92xuG75W+OWnljWUaSEdzp9ps1I/zuqPH+AcQ==
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr31747781wmi.128.1620733566224;
        Tue, 11 May 2021 04:46:06 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6329.dip0.t-ipconnect.de. [91.12.99.41])
        by smtp.gmail.com with ESMTPSA id 3sm23617944wms.30.2021.05.11.04.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 04:46:05 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 4/4] s390x: cpumodel: FMT2 SCLP implies
 test
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210510150015.11119-1-frankja@linux.ibm.com>
 <20210510150015.11119-5-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5f9d81aa-1546-91af-0e06-5e879b854b13@redhat.com>
Date:   Tue, 11 May 2021 13:46:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510150015.11119-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.05.21 17:00, Janosch Frank wrote:
> The sie facilities require sief2 to also be enabled, so lets check if
> that's the case.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/cpumodel.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/s390x/cpumodel.c b/s390x/cpumodel.c
> index 619c3dc7..67bb6543 100644
> --- a/s390x/cpumodel.c
> +++ b/s390x/cpumodel.c
> @@ -56,12 +56,24 @@ static void test_sclp_features_fmt4(void)
>   	report_prefix_pop();
>   }
>   
> +static void test_sclp_features_fmt2(void)
> +{
> +	if (sclp_facilities.has_sief2)
> +		return;
> +
> +	report_prefix_push("!sief2 implies");
> +	test_sclp_missing_sief2_implications();
> +	report_prefix_pop();
> +}
> +
>   static void test_sclp_features(void)
>   {
>   	report_prefix_push("sclp");
>   
>   	if (uv_os_is_guest())
>   		test_sclp_features_fmt4();
> +	else
> +		test_sclp_features_fmt2();
>   
>   	report_prefix_pop();
>   }
> 

I'd fold that into the previous patch

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


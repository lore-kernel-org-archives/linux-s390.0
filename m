Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700CC001DF
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 08:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGXIaX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGXIaQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 04:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869731A1
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690187367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DNzHbGom77n0zpxl+676gi9KyXFJ85R3IBrxW//ask=;
        b=K8kmA+7dSOblqZadST5t/3eJ4VGRbLlp2oUN00eDKQIGR1spm5Nq6A62il1JjEuSuAsXqS
        Ayrgda/ypu7909N1w+mpX/4k8cAz65W8GdjoY+PzWfw8++1t+K8fY9y7XvzynL/Nga5U8u
        zKKZLBt4bcAzaB8KQCQr7xheqKWBmZs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-0tzk2MisMSSQ-lclexDd6Q-1; Mon, 24 Jul 2023 04:29:26 -0400
X-MC-Unique: 0tzk2MisMSSQ-lclexDd6Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fc00d7d62cso25524735e9.2
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187365; x=1690792165;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DNzHbGom77n0zpxl+676gi9KyXFJ85R3IBrxW//ask=;
        b=NOyvgnpE6gvCi83rh5tLHiCulHkYRYQKvUvSBjhHIdAIIoyv02ezMH/74fHuEfIi/K
         PKXa034WydKr7Vc9RoBk1VQyEFi2VSa53PDXTQzTua15Esqs20PtmDQIFmrl7gJ7SQe5
         Taqt7oyy0MhWqKgHOTRyle2sbKQfKKe8V6wh+UTUmFa3YtDKWJCbaVQ+2rpnGV9bC/x7
         kVubuyoYgfNaLq05OPuTCWfbPSXnbEYoJdwx+fqRNZSRd8G6bMXjnQN9L0Bq5wOKTE9e
         luOBQAZYSUneU26Dr9X6r8YcSYTzJSQbJWbo3qj4ORQpLan+U/qRt6o9gwmZvGojMuiF
         Vpfw==
X-Gm-Message-State: ABy/qLaaJIjZFm1xaoaWvANvS678csL0l6J8iyPY0JDzPLRVc2EqtCuL
        7i7ywZwKRyJhSfRm+ZUQq69T4GC5deMx1cxzSEeTS48IgxC3y7Uevb7AJkKCsAa8u5b/j3BhMOo
        7Otb4l1U2Obmyyrp5Ro6fkS27bCbhJQ==
X-Received: by 2002:a05:600c:2308:b0:3f7:3991:e12e with SMTP id 8-20020a05600c230800b003f73991e12emr7402832wmo.1.1690187364802;
        Mon, 24 Jul 2023 01:29:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJflnC/NPtGCRbFCR9C92TkIUPD7R5nWkt94QfcSqyyptU/48AkbkWHtvlGEwx8uIuiIpKVQ==
X-Received: by 2002:a05:600c:2308:b0:3f7:3991:e12e with SMTP id 8-20020a05600c230800b003f73991e12emr7402823wmo.1.1690187364547;
        Mon, 24 Jul 2023 01:29:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003fba92fad35sm12223151wmi.26.2023.07.24.01.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:29:24 -0700 (PDT)
Message-ID: <dbf871ad-1768-18d0-318f-86df33df7446@redhat.com>
Date:   Mon, 24 Jul 2023 10:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/6] KVM: s390: interrupt: Fix single-stepping ISKE
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
References: <20230721120046.2262291-1-iii@linux.ibm.com>
 <20230721120046.2262291-6-iii@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230721120046.2262291-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21.07.23 13:57, Ilya Leoshkevich wrote:
> kvm_s390_skey_check_enable() does not emulate any instructions, rather,
> it clears CPUSTAT_KSS and arranges for ISKE to run again. Therefore,
> skip the PER check and let ISKE run happen. Otherwise a debugger will
> see two single-step events on the same ISKE.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   arch/s390/kvm/intercept.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index d2f7940c5d03..8793cec066a6 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -630,8 +630,7 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>   		rc = handle_partial_execution(vcpu);
>   		break;
>   	case ICPT_KSS:
> -		rc = kvm_s390_skey_check_enable(vcpu);
> -		break;
> +		return kvm_s390_skey_check_enable(vcpu);
>   	case ICPT_MCHKREQ:
>   	case ICPT_INT_ENABLE:
>   		/*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F9C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  4 Oct 2022 08:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJDISa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJDISJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Oct 2022 04:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2035B7F8
        for <linux-s390@vger.kernel.org>; Tue,  4 Oct 2022 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664871487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLtFZq4bDaN6BM38qfHtC/XiTFqjPED0T8bmDBUI3bM=;
        b=aKPINECU2mZkGGYzCCh/i63jRNEzx9cXdFTUtWJ3ucxQFXPi22jT52Hwq0kHSP5YbAJu7g
        hvnhu/tu3zdN0Jur9Nl6lCx5Hyx4NbvQ1SneEUOct3cLwzapqjC9PlOwAMtEGezq8Dqp3f
        8/j7fRdmAF/c+N6hnM6RJUQeBCm2hQU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-j97fn2ZXMrOPDXIqcL4dRg-1; Tue, 04 Oct 2022 04:18:05 -0400
X-MC-Unique: j97fn2ZXMrOPDXIqcL4dRg-1
Received: by mail-wm1-f71.google.com with SMTP id c2-20020a1c3502000000b003b535aacc0bso10520933wma.2
        for <linux-s390@vger.kernel.org>; Tue, 04 Oct 2022 01:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NLtFZq4bDaN6BM38qfHtC/XiTFqjPED0T8bmDBUI3bM=;
        b=P+I+C5L8SnothRGEJevYvHai3TrQPgiEUfsx/SrPrV0bu6nSybjj4i5hQZC9DbONNy
         KKHxp4GdPJLqJRBZEHex9oUlG0uXNsQr281BXl9IeZlL9iT9CkZ8bcm4vvJ36AnAT35W
         AvuV0+RxYG6mdwLghFuZsBcvOcK2JrAzd4sHWs77tlpqp2z1kPDH34EpkGdukTLOOAWG
         9cyFdXgNNYa0FXfX7teKcbwG5QyEIIXN1TUfwAxpsl73czFkEoAMn8tJm3WYNZCgBlqp
         2UkGFe9JWwzr2sJ5pr1TSuZQGu22JfPfEcDDCgiG37kWhZ5WcIM2AA9YiTFqTxUn0IZr
         RTWw==
X-Gm-Message-State: ACrzQf2JaoIhOPXrC8hyohN8znlh1X7S5kAbhCDjRB4slms6m8Zn4GJn
        1d9/OHjTcJTumfooAZ52mYRkPkkLEonfxdh8Buu91x5BJfk/AWIumJj0U8h/fmExorEimcqGDlh
        9fZrFxiCxQMc/p465p4uUvA==
X-Received: by 2002:adf:d1e3:0:b0:22a:b9e2:8841 with SMTP id g3-20020adfd1e3000000b0022ab9e28841mr14873497wrd.184.1664871484640;
        Tue, 04 Oct 2022 01:18:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6pGiVfRgi+gr5FmqmXrxztDFohEkGW+UwhA75mOZyu+1mXYa4G6dLTHbSwxPWZraEEuJmhXw==
X-Received: by 2002:adf:d1e3:0:b0:22a:b9e2:8841 with SMTP id g3-20020adfd1e3000000b0022ab9e28841mr14873486wrd.184.1664871484473;
        Tue, 04 Oct 2022 01:18:04 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-246.web.vodafone.de. [109.43.178.246])
        by smtp.gmail.com with ESMTPSA id y9-20020a5d4ac9000000b0021badf3cb26sm14655866wrs.63.2022.10.04.01.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:18:03 -0700 (PDT)
Message-ID: <65ec72fd-5893-659d-cc79-340eacb3a897@redhat.com>
Date:   Tue, 4 Oct 2022 10:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 4/9] KVM: s390: selftest: memop: Pass mop_desc via
 pointer
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
 <20220930210751.225873-5-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220930210751.225873-5-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> The struct is quite large, so this seems nicer.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 44 +++++++++++------------
>   1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


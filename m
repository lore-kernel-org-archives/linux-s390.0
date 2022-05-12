Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6796CC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 12 May 2022 10:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiELKCA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 May 2022 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352480AbiELKB6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 May 2022 06:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F016E5F4A
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652349717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3arBzyEj0Y+10rY33HKP6mUUeQUbMaPvYDzVucF481c=;
        b=ASCrFMxnhN/zp0y8jQ2PXeNrqNr6j5WYIdV4ZjsKnibGhI7Qc0Imt9loWa9VqciFQaBPHK
        uvDgltXOlq6RxShqJ6uVR9ruSmg/KvllHsVASURcPtgrp3Qcm2QBDF6XBZMgDBvRUB5vZT
        2oMfPJCoZsqWvxCEFWpxLxTsNnP/Qqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-v6eVskFkPxupKA0R2MJO9w-1; Thu, 12 May 2022 06:01:56 -0400
X-MC-Unique: v6eVskFkPxupKA0R2MJO9w-1
Received: by mail-wr1-f71.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so1882832wrn.6
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 03:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3arBzyEj0Y+10rY33HKP6mUUeQUbMaPvYDzVucF481c=;
        b=sM47lHm742KEg1zXzCz3Ddyp+FUwoxsqa2DQT6uOfBQVoPQqZaM5ppKCCd3BrgO2nT
         7Y49sd3Dys7hLB5eDeynZ8JPYfeXKbwjYR0p8qPWoR4ZwkENLNc+sF0vwFyw7UAbwudZ
         JXhCuefCvEHLehFLPyOQ6z1Ylz/0GTEMPyatfwXT+RLBfT1gKQEsvR6dR6iFe7aF4TPN
         7XBRe+QpFYbcvpFjp5yIYpqxBdK1Y5r5QjiF1bpvGUEyXD1gt3gMEuMGE5GcChad8sU4
         ZzHWmDqMpwt2We99b8kSfsavnXyIfQjCIZD1KQ3uTGc1lzS4m2do0vDSnWT6/euuu/gz
         bfmA==
X-Gm-Message-State: AOAM530c/TbzVmiRtKlwbay7bz+c6moH8bVIb4FN/J+sRZt8IQC/tcew
        sYuPqlsmFHy7T0m3UcYJxITyImL5eGbgRU02D5k9Lk9cVdypgUT+D9vLox5Tuxc6ZVUcL67UGDd
        DIcIU55OAHH76KN2pQFe2/A==
X-Received: by 2002:a5d:4a0a:0:b0:20a:c899:cb7b with SMTP id m10-20020a5d4a0a000000b0020ac899cb7bmr27316348wrq.618.1652349714381;
        Thu, 12 May 2022 03:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRhDGBs9YTvxkam9DUV8EFQnoG6RsdfM4bAsBLkkDwQvHU5eaODpobFR9pjyP7q6gQhfIqPA==
X-Received: by 2002:a5d:4a0a:0:b0:20a:c899:cb7b with SMTP id m10-20020a5d4a0a000000b0020ac899cb7bmr27316320wrq.618.1652349714148;
        Thu, 12 May 2022 03:01:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600018d100b0020c5253d90asm3878293wrq.86.2022.05.12.03.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:01:52 -0700 (PDT)
Message-ID: <70a7d93c-c1b1-fa72-0eb4-02e3e2235f94@redhat.com>
Date:   Thu, 12 May 2022 12:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 3/3] s390x: KVM: resetting the Topology-Change-Report
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com,
        wintera@linux.ibm.com, seiden@linux.ibm.com, nrb@linux.ibm.com
References: <20220506092403.47406-1-pmorel@linux.ibm.com>
 <20220506092403.47406-4-pmorel@linux.ibm.com>
 <76fd0c11-5b9b-0032-183b-54db650f13b1@redhat.com>
 <20220512115250.2e20bfdf@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220512115250.2e20bfdf@p-imbrenda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>>
>> I think we prefer something like u16 when copying to user space.
> 
> but then userspace also has to expect a u16, right?

Yep.

-- 
Thanks,

David / dhildenb


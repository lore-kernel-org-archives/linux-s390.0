Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0EC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 29 Apr 2022 06:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiD2GYm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Apr 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiD2GYd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Apr 2022 02:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 557AC6213D
        for <linux-s390@vger.kernel.org>; Thu, 28 Apr 2022 23:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651213269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sc42abCE1lLkpR2z5/9d9ajEOgsNqnuHzbg51Wp3bw8=;
        b=BwhFHIxvyB/C37CXCzAtjQGnnW77jJqxX0yWHYVCUsy6mTWopjGcPinbvY71SkDsxBQtxD
        Ya9Ng6PyZRE8LHNuuAyJ1X/zaCBd9kK7K0dCOTzxJxF5yGfZQ5C0mNVw7FtpHxYlPlKpb8
        jg7w1aAbf3tHnNPQ7YzE7smH6nkcD6w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-uJ8cPRUcPVyE-13X7f4Elg-1; Fri, 29 Apr 2022 02:21:08 -0400
X-MC-Unique: uJ8cPRUcPVyE-13X7f4Elg-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso2094606wmq.3
        for <linux-s390@vger.kernel.org>; Thu, 28 Apr 2022 23:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sc42abCE1lLkpR2z5/9d9ajEOgsNqnuHzbg51Wp3bw8=;
        b=rzCqyQqrQgSCLUF5oftsz3xHG1draIwcRJHp1FlS15UZaEOjshnyrJdq+v5GGmGGTI
         nVwTGwTNXclbI92CAtvQL97flLbXDGQY1fvL1CLz+pYr8qICGYPvy8bf84djdV9n1jqG
         dFWR4UuJ+viqyTUeZiSA4yqFDZqnlvPqg2WhFfAcgK8Lhc29iA2dXadLmXDwHoY2HV8f
         6JsIfhgdEuStFZvPMF39qdFdL68eO2BPdLQdrhGT6bPOJXzHF4qXiw+qbWxz0wfxDhc2
         7U2uCX9peN6/wkrN644EQKETlJ62qF5thRpLYEX4jmlPB3q3g8yiqKPoemmpwyGuc5KL
         9MrA==
X-Gm-Message-State: AOAM530QabIV/t8sbPUNmAyzmGWQZAIXLT85u2kJAE1QZ+0PmxhDzedT
        uo3/o1fdMFIFh3ski40AwC4fvfL0dlsKA7sgT7e9daVi/uWGbyl6sTkMTn7jEXMjS8l75EZBe8c
        dFCGKeS/mnBoBzmUsPdgpaw==
X-Received: by 2002:a05:6000:1789:b0:20a:9f94:1620 with SMTP id e9-20020a056000178900b0020a9f941620mr30319021wrg.640.1651213267353;
        Thu, 28 Apr 2022 23:21:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHmnF6dRdNFoY1hNrODSzQG1BlQrGbBRtnEPalxmlm2IQZ73XMdQ+B/D2QLzh+Ka9dXWrjQQ==
X-Received: by 2002:a05:6000:1789:b0:20a:9f94:1620 with SMTP id e9-20020a056000178900b0020a9f941620mr30319000wrg.640.1651213267073;
        Thu, 28 Apr 2022 23:21:07 -0700 (PDT)
Received: from [192.168.8.104] (tmo-082-126.customers.d1-online.com. [80.187.82.126])
        by smtp.gmail.com with ESMTPSA id v3-20020adf8b43000000b0020aeb170557sm1805400wra.36.2022.04.28.23.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 23:21:06 -0700 (PDT)
Message-ID: <88b40226-b163-5bec-a9bc-cc9c3b323615@redhat.com>
Date:   Fri, 29 Apr 2022 08:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 4/4] KVM: s390: selftests: Use TAP interface in the
 reset test
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20220419185857.128351-1-thuth@redhat.com>
 <20220419185857.128351-5-thuth@redhat.com>
 <fb468756-2f80-3e0b-91d9-8e6a0679f36c@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <fb468756-2f80-3e0b-91d9-8e6a0679f36c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20/04/2022 12.34, Janosch Frank wrote:
> On 4/19/22 20:58, Thomas Huth wrote:
>> Let's standardize the s390x KVM selftest output to the TAP output
>> generated via the kselftests.h interface.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
> [...]
>> -    return 0;
>> +
>> +    ksft_finished();
> 
> main() is still int so it looks really weird, that we remove the return 
> here. After reading the ksft_finished() code I know that we never return 
> because we do an exit() but I'd like to have a comment, change to void or 
> noreturn tag to make this clearer.

Changing the return type of main() to void causes a compiler warning here, 
so I'll go with the comment.

  Thomas




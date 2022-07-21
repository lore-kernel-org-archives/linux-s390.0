Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE42C43334
	for <linux-s390@archiver.kernel.org>; Thu, 21 Jul 2022 13:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGUNlg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGUNlf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Jul 2022 09:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0999E5F98D
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658410894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOTAglfildlQpzBhPUUzw4cfO8q4AwGdpV6kvHB58lU=;
        b=iQ+MDTXZQ3dsnsQlq+Nd3wNKYcPKnbLe71P5lacYpE7fqjsd3+zIiBzRAHqsP/hSC9R5i/
        8sghtO6FuFe76ZVHlGulZ5KR8re+GWzysM6ZqjLNnZaDUZ5LA0LoXP1ldTrVNmOt9aWbfG
        HnY52gbWp5gcPDchEU/z98PGjDUbnoo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-dYICFmkjP2uYBUDj1foMEg-1; Thu, 21 Jul 2022 09:41:33 -0400
X-MC-Unique: dYICFmkjP2uYBUDj1foMEg-1
Received: by mail-wm1-f70.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so650030wmb.1
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 06:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XOTAglfildlQpzBhPUUzw4cfO8q4AwGdpV6kvHB58lU=;
        b=ZqZ+gmnSRkKw1EK9FRsTa1MZ1KjR66Ezsm2w+FfvTGpXIEHKiRg/3Dm35y12x/oWDO
         yeiyZkA/g3+WtGcQ5jJx4ILxYjZ6Scp8m/ltUgv+auWhROs4rZPHHCdNHFdLc2wqjJ9M
         JUb+jn/mMonnodgdwMoIeU6KL+0SwWcpeZR9uq6VD9gJe2OyLFJpsAgop9yUzGXHIfPK
         oV1n6fgWFSkPLq5LGsKN1EzQEy6S8+T6Yd/7XJrh0dku1gtnQKoAoD51DSmDBHFRw2Im
         u7M9JlVRrfHMlIWynEfeF6wULXC11rUls04NHnFdUKSln0ncphI+9CCY+VdddZ19SW8a
         ARww==
X-Gm-Message-State: AJIora+j6q8WZ4tL4fPfIdCCTyPMARW63fjMMZ7WsdloH1dYMdu5rrJ1
        8WrW9gy/iE204jUsrUYwbLcYhCOAZNuzaXbM4nDYkazUWne7CLJWL2WWgBEd9HBy1LD9btVJu5H
        WeMoeN3/duO8jMr4mxVRySw==
X-Received: by 2002:a7b:c4cc:0:b0:3a3:2123:8c1b with SMTP id g12-20020a7bc4cc000000b003a321238c1bmr8337881wmk.180.1658410891947;
        Thu, 21 Jul 2022 06:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sAE6GYEAZ08pTY0+ZSDPtaz9NdC7tvx8/YU/pJlX6qweJIHvVfQalZypFJT7Elr/oVUJ/aSg==
X-Received: by 2002:a7b:c4cc:0:b0:3a3:2123:8c1b with SMTP id g12-20020a7bc4cc000000b003a321238c1bmr8337855wmk.180.1658410891638;
        Thu, 21 Jul 2022 06:41:31 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-217.web.vodafone.de. [109.43.179.217])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bcb8f000000b003a2e27fc275sm1852956wmi.12.2022.07.21.06.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:41:31 -0700 (PDT)
Message-ID: <b250461b-ee09-d499-e5a4-4a9a303bed66@redhat.com>
Date:   Thu, 21 Jul 2022 15:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] s390x: intercept: fence one test when using TCG
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, qemu-s390x@nongnu.org
Cc:     frankja@linux.ibm.com
References: <20220721133002.142897-1-imbrenda@linux.ibm.com>
 <20220721133002.142897-2-imbrenda@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220721133002.142897-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/07/2022 15.30, Claudio Imbrenda wrote:
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
> This patch is meant to go on top this already queued patch from Janis:
> "s390x/intercept: Test invalid prefix argument to SET PREFIX"
> https://lore.kernel.org/all/20220627152412.2243255-1-scgl@linux.ibm.com/

If we keep this as a separate patch, that paragraph should be removed from 
the commit description.

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>


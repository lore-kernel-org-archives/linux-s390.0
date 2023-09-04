Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296ACC71153
	for <linux-s390@archiver.kernel.org>; Mon,  4 Sep 2023 09:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjIDJzU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Sep 2023 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbjIDJzT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Sep 2023 05:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B92CCD
        for <linux-s390@vger.kernel.org>; Mon,  4 Sep 2023 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693821257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTvB95KyzDb1YHMdthNLhzgghnoayFFEqz5D/WvthFE=;
        b=AlZV4P7Jr8azjspM1DAn3/0D/qB/FpUOXm6MYVTAt9bfFc0myRZYpxq2RZiDrOn+Gu8r/L
        Wzohp7+WBbXqgMB9F3xqOuLl3BPCSC29M+XAz9kON4OTYgxAFt3BsZ+91mvxpcQ+9NB9aC
        DSABLJFa5/1tKqKiP6oIpbfa8pNXOdk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-dAN52iE4OzOejNwTuRRQRQ-1; Mon, 04 Sep 2023 05:54:16 -0400
X-MC-Unique: dAN52iE4OzOejNwTuRRQRQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401be705672so8597495e9.2
        for <linux-s390@vger.kernel.org>; Mon, 04 Sep 2023 02:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693821255; x=1694426055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTvB95KyzDb1YHMdthNLhzgghnoayFFEqz5D/WvthFE=;
        b=JDJJFnAOUyeFdnD5xDWcWoXR2zc0ZE4DDsRDCYMfsOc1eaTpqTIl5+sATrh6BsTKJs
         x0/moeXvXy5DWmmM06bY6ln8vHBxEhAPVO94I9AbITfLpAdT1Mln3QSBXrq08wrBymnw
         cRXns/OU8PVHQQ+20mFhW17IUflonSUFULuRM3oQIJeT6JXLSw8I3+0uUox42hheAHUj
         pSxtztWy7Neik6xRUXsn/3DdVNBRG5SBuuJvKzpj6wo8KPWAk1KFAOYA/em2xgOLJ3zU
         aoNR4CBWc4RG8NeLluHzmF9d5Fbooxr7FEao5ogDVRahAKB59pnB5AzvL2pxB8YVt76c
         i21w==
X-Gm-Message-State: AOJu0YzSdKy/6ui2ZvnWUGU/UuBcH3AZYLzxgWkvjQO0tHrcd5IH8NwG
        hc/XGL7es/T1MArHFdGGByslM0llEq/H/ychPJvByqTHAyp/+1Peqp4bgdwciDU8vhhiepTkgiM
        bQB137CsEpmTrFZlK8lLvvQ==
X-Received: by 2002:a05:600c:446:b0:401:c52c:5ed9 with SMTP id s6-20020a05600c044600b00401c52c5ed9mr7189478wmb.32.1693821255443;
        Mon, 04 Sep 2023 02:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI10YPPteFQXl1Pb89NCBFyOvAvoSR+teTCFaysuJFUUiOp7xeh0z9/8Eei9B2E8yp9v3jyQ==
X-Received: by 2002:a05:600c:446:b0:401:c52c:5ed9 with SMTP id s6-20020a05600c044600b00401c52c5ed9mr7189466wmb.32.1693821255096;
        Mon, 04 Sep 2023 02:54:15 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bce12000000b00401dc20a070sm16566936wmc.43.2023.09.04.02.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:54:14 -0700 (PDT)
Message-ID: <74a7684b-0c11-37b3-4313-9241a3f975cc@redhat.com>
Date:   Mon, 4 Sep 2023 11:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [kvm-unit-tests PATCH v6 2/8] s390x: add function to set DAT mode
 for all interrupts
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904082318.1465055-1-nrb@linux.ibm.com>
 <20230904082318.1465055-3-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230904082318.1465055-3-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/09/2023 10.22, Nico Boehr wrote:
> When toggling DAT or switch address space modes, it is likely that
> interrupts should be handled in the same DAT or address space mode.
> 
> Add a function which toggles DAT and address space mode for all
> interruptions, except restart interrupts.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h  | 10 ++++++----
>   lib/s390x/asm/interrupt.h |  2 ++
>   lib/s390x/interrupt.c     | 35 +++++++++++++++++++++++++++++++++++
>   lib/s390x/mmu.c           |  5 +++--
>   4 files changed, 46 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01153C0015E
	for <linux-s390@archiver.kernel.org>; Thu, 13 Jul 2023 08:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjGMIcS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjGMIb6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Jul 2023 04:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2485D5FC0
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689236476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKDC12Vuv9wLWICjMpw42qHMl5EhA99+6gECr+MAJew=;
        b=GMhtvF3kdW7csP/v5Xs8uLKzW9Zn6hh8yuoOrQq4L5+bvZuFOUDbg72sWsoUmhFvonlgDA
        em4zXsfzvEvYC5Xdtc0NH+zlmBIotrX6eFYh72KqNeb3ZJ16EEZUd/PqWOP7rqDLUCPpvd
        Oly3UJ5RMcmVQm35W6t6Efw6BibuF7g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-djCUeYCSORm27hMcdWiMtA-1; Thu, 13 Jul 2023 04:21:14 -0400
X-MC-Unique: djCUeYCSORm27hMcdWiMtA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f9e556c7d8so12543641cf.0
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 01:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236474; x=1691828474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKDC12Vuv9wLWICjMpw42qHMl5EhA99+6gECr+MAJew=;
        b=cc0EwbOkkjtk2WXRMuC3lzRsUVYOYlvNzGA3U8kHe7CITaFaEhe/ZHzFIH+UFH8Rsf
         7GJGqaAz5VajXeo7k8aNsNsiCfvnX8TwigvTx5Hdv1C402SCzf+Ue3CCicLNkLQvjOhx
         roT1UEvVTfb0TSOw8NNA1aFg7sqV4jukn8hTFPIkhhVs2MIrQr4SzuICcehEpcDfLDSX
         +eqTKTYxOmu191QczE7TBrYMlO3kmp1WeVNLsJspZ57nuIXL8nKQxLDlNiDwiJ1qivv9
         YMVH1+esDwRAmOLF7F4W5NRzoy8pkzH3hPhtSLpHiU0HH/p5Ml6CQ+XLD5b3Da8W0OIk
         uazw==
X-Gm-Message-State: ABy/qLaFCoDKuNT0yXns1SPYoqAWII728SeAOer3zjuObhV71wmAS5Rp
        ariIHz+5JIuz4XaJaj2yEzT3AAFhEjgbHBDvkL+nY4+af+JLqDP72oYS6Q6W/Dh0iUBA/7vc8lP
        HTU58RTkgUxn3ALnhQf9Tew==
X-Received: by 2002:ac8:7f95:0:b0:403:a9e1:2ae4 with SMTP id z21-20020ac87f95000000b00403a9e12ae4mr4838747qtj.22.1689236474537;
        Thu, 13 Jul 2023 01:21:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHrCN28U1pVIFfdhJ5pC209ToaxshKrVEyEsbK9Bu4N3LbyT6oB6EEZVaH8LNZPKja4jn5Lww==
X-Received: by 2002:ac8:7f95:0:b0:403:a9e1:2ae4 with SMTP id z21-20020ac87f95000000b00403a9e12ae4mr4838741qtj.22.1689236474336;
        Thu, 13 Jul 2023 01:21:14 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id f13-20020ac87f0d000000b00401217aa51dsm2908044qtk.76.2023.07.13.01.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:21:14 -0700 (PDT)
Message-ID: <cedb8a69-c801-daee-52ed-b38b84deabd1@redhat.com>
Date:   Thu, 13 Jul 2023 10:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [kvm-unit-tests PATCH v5 3/6] s390x: sie: switch to home space
 mode before entering SIE
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-4-nrb@linux.ibm.com>
 <3dbe3094-b796-6b78-a97f-130a82780421@redhat.com>
 <20230713101707.1d1da214@p-imbrenda>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230713101707.1d1da214@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/07/2023 10.17, Claudio Imbrenda wrote:
> On Thu, 13 Jul 2023 09:28:19 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> [...]
> 
>>> +	irq_set_dat_mode(IRQ_DAT_ON, AS_PRIM);
>>> +	psw_mask_clear_bits(PSW_MASK_HOME);
>>> +
>>> +	/* restore the old CR 13 */
>>> +	lctlg(13, old_cr13);
>>
>> Wouldn't it be better to always switch to HOME address mode directly in our
>> startup code already (where we enable DAT)? Switching back and forth every
>> time we enter SIE looks confusing to me ... or is there a reason why we
>> should continue to run in primary address mode by default and only switch to
>> home mode here?
> 
> the existing tests are written with the assumption that they are
> running in primary mode.
> 
> switching back and forth might be confusing, but avoids having to
> fix all the tests

Which tests are breaking? And why? And how much effort would it be to fix them?

  Thomas


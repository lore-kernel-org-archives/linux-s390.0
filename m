Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630BDEB64DC
	for <linux-s390@archiver.kernel.org>; Tue, 11 Jul 2023 08:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGKIoV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 Jul 2023 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGKIoU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Jul 2023 04:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE3E6F
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689065009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUu4PL9YIqWcJDoz1iYa6iEBpdujMvrErvf1ceFhKC8=;
        b=Xfq+ZxpUQ42CrNliZay0PfsmYR2IoN9SdhmAdRit4xJrCRBh6FPppydXnIbf72SrzdqSow
        nH9zt4yAvvaHxn6Sq9F57dJ9AAAI+KkeA/wJscS715OwJYgYa6KjW4T+NajTgAZza5ivNR
        1/vxOWSL2pk8oQHPw8sduUWsIvM7NUg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-MBJTav9UMWyZgJO85Zp41A-1; Tue, 11 Jul 2023 04:43:28 -0400
X-MC-Unique: MBJTav9UMWyZgJO85Zp41A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635325b87c9so59566166d6.1
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 01:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689065007; x=1691657007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUu4PL9YIqWcJDoz1iYa6iEBpdujMvrErvf1ceFhKC8=;
        b=X46u2wsz6QVVe/XzDD61KDPW0rrxYmsIjKnprYrkREXelu9OKBTgKlOYX+P7CNVTrH
         I+FDU86hHYgyayibXBy67b9PFDxTTvGxZZuLqauJQ6FtyyZMokleE5LF4KkHtDkCsigJ
         otXhCrEvpjx8GP6alZu/xmFKa6nMgwwCKCfPTk4gfufL1X3dcBsyAWT6Ex2DU722bGot
         kBdQyaNDCKynwccGqvMfxx1LmH6IC2gMmfEXFBz3dQSpwEgQaA7lyiRcN83flsBG0MJ4
         Ocxf949yazmO5i0DnPpfImQ+pKGICbRFPfxhd7vcHC89F8T5s/jRh4rQ76m31cHFGY61
         it/w==
X-Gm-Message-State: ABy/qLZwEW8Ejdx1ov1HQh+jHvz9kmTjPawgqf5B7zi0vKhUSH66tHz4
        YOnMhvf/gMOme8kW0K2nN8W+o8GRtNH3Q4FAabttkBt12HCOCQgcWUzGI/Jddd8i7S+Ahwmu4JP
        mq/5TIc7wim/yN+5YSu2dqQ==
X-Received: by 2002:a0c:e404:0:b0:631:f9ad:1d46 with SMTP id o4-20020a0ce404000000b00631f9ad1d46mr14182374qvl.47.1689065007683;
        Tue, 11 Jul 2023 01:43:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGj7Vd/vQTScrAG5ij63JKspRZF0xJa4kLp0VBmiMtFSOODfIYmuhY6YAYY2/wK7Wqh2pD3+g==
X-Received: by 2002:a0c:e404:0:b0:631:f9ad:1d46 with SMTP id o4-20020a0ce404000000b00631f9ad1d46mr14182363qvl.47.1689065007480;
        Tue, 11 Jul 2023 01:43:27 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id h7-20020a37c447000000b0076745f352adsm757917qkm.59.2023.07.11.01.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 01:43:27 -0700 (PDT)
Message-ID: <6c690eb9-06b1-a5e8-4875-e0d83f8d1ce7@redhat.com>
Date:   Tue, 11 Jul 2023 10:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [kvm-unit-tests PATCH v10 2/2] s390x: topology: Checking
 Configuration Topology Information
To:     Nico Boehr <nrb@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, kvm@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nsg@linux.ibm.com
References: <20230627082155.6375-1-pmorel@linux.ibm.com>
 <20230627082155.6375-3-pmorel@linux.ibm.com>
 <ffc48a06-52b2-fc65-e12d-58603d13b3e6@redhat.com>
 <168897816265.42553.541677592228445286@t14-nrb>
 <d52e4c34-55f0-56a5-1543-52fefb39e2a6@redhat.com>
 <168906286416.9488.17612605115280167157@t14-nrb>
Content-Language: en-US
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <168906286416.9488.17612605115280167157@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/07/2023 10.07, Nico Boehr wrote:
> Quoting Thomas Huth (2023-07-10 16:38:22)
>> On 10/07/2023 10.36, Nico Boehr wrote:
>>> Quoting Thomas Huth (2023-07-06 12:48:50)
>>> [...]
>>>> Does this patch series depend on some other patches that are not upstream
>>>> yet? I just tried to run the test, but I'm only getting:
>>>>
>>>>     lib/s390x/sclp.c:122: assert failed: read_info
>>>>
>>>> Any ideas what could be wrong?
>>>
>>> Yep, as you guessed this depends on:
>>> Fixing infinite loop on SCLP READ SCP INFO error
>>> https://lore.kernel.org/all/20230601164537.31769-1-pmorel@linux.ibm.com/
>>
>> Ok, that fixes the assertion, but now I get a test failure:
>>
>> ABORT: READ_SCP_INFO failed
>>
>> What else could I be missing?
> 
> Argh, I forgot that you need this fixup to the patch:
> https://lore.kernel.org/all/269afffb-2d56-3b2f-9d83-485d0d29fab5@linux.ibm.com/
> 
> If that doesn't work, let me know, so I can try and reproduce it here.

Thank you very much, removing that line fixed the problem, indeed. Both 
topology tests are passing now on my z15 LPAR.

Tested-by: Thomas Huth <thuth@redhat.com>



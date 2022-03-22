Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A7C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 22 Mar 2022 13:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiCVNqK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiCVNqJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Mar 2022 09:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 789F62655A
        for <linux-s390@vger.kernel.org>; Tue, 22 Mar 2022 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647956681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANKRQzRELaWdzD2QZS9qzovKRV7eroomvX7D4M7GefI=;
        b=g7+V3JbVs1NjAcpGgaxm0/Cgbl4uHRS89TIIyZS3Cp0FZ91N1661wzHpDz6JJmD31Ei6e8
        /cPQiPCqqlGXqOBfTuXue6M1SAVpY+Cd+5uhIL+S1JfjttYivA2cujSNtsqofdB2whZ8Kh
        rDHrp/vvBuu/AJJS8VvFrLCEhhLWAhs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-QYySKJDMOai5laBqlRYtNA-1; Tue, 22 Mar 2022 09:44:40 -0400
X-MC-Unique: QYySKJDMOai5laBqlRYtNA-1
Received: by mail-wm1-f70.google.com with SMTP id v184-20020a1cacc1000000b0038a12dbc23bso1306881wme.5
        for <linux-s390@vger.kernel.org>; Tue, 22 Mar 2022 06:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ANKRQzRELaWdzD2QZS9qzovKRV7eroomvX7D4M7GefI=;
        b=KUYcdkMGXLyZnaVjgGK4xcTWBHsICBj3vGwpdq18J7DVsc75eg1RoMWv6LNGztWFuI
         NxB4eMoMbTS4kfPp1bGAln3oKZJlqdgcJEpTb+Ab8Hqoy53t43iJ1G9fFcnWwgM6LiQS
         gZQf0ZBKhLxQXvkDLNrkoAcZVpcZCO4HbVHyrZDmWbgWi1xqskrNL4FTJLG2ZCNoe2rb
         pykcoq+IBHQ46Zc9cVNE/y9kqIRDMyZBtF1ZE1/urr7sg5HqibI9ZZQdzsqRa9fhY3er
         agU/z08R20Ig1zbs1YnaeBZtIps1WWVKsgxsKgVjl7I0Th5yttZYtGKY21Iop64SlgzX
         fZwQ==
X-Gm-Message-State: AOAM530pz4Hm4V/HAA52ZIaRAJXS94fv26nTuNO8gizG0Rvff3XxuGA+
        n2sP2I4mzt9ZvN6vxTfToCvSfdzS0m4h0OazzRS5cssI7xo28sSVVEvvARqMd0uGmw9YirZxwf0
        bM+AZahFOzO2gpkwd0mUDLw==
X-Received: by 2002:a05:600c:190e:b0:38c:b1ea:f4ac with SMTP id j14-20020a05600c190e00b0038cb1eaf4acmr3938601wmq.70.1647956678926;
        Tue, 22 Mar 2022 06:44:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKzYLnUW0xmdSIOPKaXoGHiETfm21cVrTbD3uRC5iXSe1fa2PPvEzTtyV8TFh7MPCRVt9NLQ==
X-Received: by 2002:a05:600c:190e:b0:38c:b1ea:f4ac with SMTP id j14-20020a05600c190e00b0038cb1eaf4acmr3938572wmq.70.1647956678543;
        Tue, 22 Mar 2022 06:44:38 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id e8-20020a056000178800b00203da3bb4d2sm16782777wrg.41.2022.03.22.06.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 06:44:37 -0700 (PDT)
Message-ID: <da339883-fc3a-da42-a071-d6e6c9f88b3e@redhat.com>
Date:   Tue, 22 Mar 2022 14:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH] libfdt: use logical "or" instead of
 bitwise "or" with boolean operands
Content-Language: en-US
To:     Andrew Jones <drjones@redhat.com>, Bill Wendling <morbo@google.com>
Cc:     kvm@vger.kernel.org, Nikos Nikoleris <nikos.nikoleris@arm.com>,
        lvivier@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@redhat.com, pbonzini@redhat.com,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, mark.rutland@arm.com
References: <20220316060214.2200695-1-morbo@google.com>
 <20220318093601.zqhuzrp2ujgswsiw@gator>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220318093601.zqhuzrp2ujgswsiw@gator>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/03/2022 10.36, Andrew Jones wrote:
> On Tue, Mar 15, 2022 at 11:02:14PM -0700, Bill Wendling wrote:
>> Clang warns about using a bitwise '|' with boolean operands. This seems
>> to be due to a small typo.
>>
>>    lib/libfdt/fdt_rw.c:438:6: warning: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>>            if (can_assume(LIBFDT_ORDER) |
>>
>> Using '||' removes this warnings.
>>
>> Signed-off-by: Bill Wendling <morbo@google.com>
>> ---
>>   lib/libfdt/fdt_rw.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/libfdt/fdt_rw.c b/lib/libfdt/fdt_rw.c
>> index 13854253ff86..3320e5559cac 100644
>> --- a/lib/libfdt/fdt_rw.c
>> +++ b/lib/libfdt/fdt_rw.c
>> @@ -435,7 +435,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
>>   			return struct_size;
>>   	}
>>   
>> -	if (can_assume(LIBFDT_ORDER) |
>> +	if (can_assume(LIBFDT_ORDER) ||
>>   	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
>>   		/* no further work necessary */
>>   		err = fdt_move(fdt, buf, bufsize);
>> -- 
>> 2.35.1.723.g4982287a31-goog
>>
> 
> We're not getting as much interest in the submodule discussion as I hoped.
> I see one vote against on this thread and one vote for on a different
> thread[1]. For now I'll just commit a big rebase patch for libfdt. We can
> revisit it again after we decide what to do for QCBOR.

I recently learnt that there are indeed people who ship kvm-unit-tests with 
their distro - at least buildroot has a package:
https://git.busybox.net/buildroot/tree/package/kvm-unit-tests

So one more argument for copying the files over instead of using submodules: 
The tarballs for tags will be self-contained, e.g.:

https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/archive/v2022-03-08/kvm-unit-tests-v2022-03-08.tar.gz

If we use submodules, I guess the content of the submodule content will be 
missing in there?

  Thomas


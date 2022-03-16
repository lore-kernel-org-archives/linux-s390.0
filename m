Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C798FC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 07:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiCPHzE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 03:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354127AbiCPHzE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 03:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40E0460CE8
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647417229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbrJE+kT+A4TgNq8to760TzvdzqcyJdX7Cp/jTz5ddk=;
        b=XugeXJ7Eus/5iy1hfbiMcEoIEXCkmqdo1nM5R6fxUkNJOgO/tqeh6nU58s21yLm0sLqu33
        wBmuu870yMRwQN4fX1IQ3boA70wcc39B+n8bIJU60vjIzwCFLUtzaXMnUATRJt5CScL82a
        Czrv1Zd0QS14HxXDaaIx8oFLU5RmRdU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-6CNr69MOM7mB8lSQ-3Z5uQ-1; Wed, 16 Mar 2022 03:53:47 -0400
X-MC-Unique: 6CNr69MOM7mB8lSQ-3Z5uQ-1
Received: by mail-wm1-f71.google.com with SMTP id m34-20020a05600c3b2200b0038115c73361so502133wms.5
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 00:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xbrJE+kT+A4TgNq8to760TzvdzqcyJdX7Cp/jTz5ddk=;
        b=8OUk5tkwMWwJqSh6dqRw/HlmvZGZ0GiAdnfwDkkdR62QYUV18nS0Yv+3QDI2scdO3Y
         if8lR/W8KQ8pyxoIamcIsr5N7cu7zVUmqfnopcW8ODxhuITIvtXLO+f8qs36RkYVHHGm
         rArmrXi+12jALdWNJUDCDvroZdhEt299rKtZcB9U5C7YkHOYB9TT2YuHBy8aCb9eA2sq
         4ZNEesIhoVvcBl+d1e1aQgR2WlMrq6xKMH3BfXUZhEEFqrthUQY0xrNRtTXeBiYvfnCA
         fliREgvbqNPpWnaqoUMzlzItsksX/s6OjbBDO4rh0LcibYWdMtMMxOudOwDn9iJO6Mec
         B1Eg==
X-Gm-Message-State: AOAM532zCcBM3BaeOYWIUAxTFKxoB+/FBOrikzKlwP6o7pEURS1Yv9hf
        JwOpUtSpXEvd67VEg+KRL6yLyPbUskzsbEOqXBvNkk0RfUmIwTSRobIyrWUuf22QzL2PVYSOJhy
        DmjTFBHmqLJPOBKjl34Prjg==
X-Received: by 2002:a1c:4c13:0:b0:389:a4ab:df7c with SMTP id z19-20020a1c4c13000000b00389a4abdf7cmr6206711wmf.14.1647417226810;
        Wed, 16 Mar 2022 00:53:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+ih92S8u3acUVacRNC38Qj2+u/ewT64E9VVLdgOqn7mbnYPyPFAiPxKeeFBjt2DWcwzIGBA==
X-Received: by 2002:a1c:4c13:0:b0:389:a4ab:df7c with SMTP id z19-20020a1c4c13000000b00389a4abdf7cmr6206704wmf.14.1647417226551;
        Wed, 16 Mar 2022 00:53:46 -0700 (PDT)
Received: from [10.33.192.232] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6d52000000b00203da94cf01sm982259wri.14.2022.03.16.00.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 00:53:46 -0700 (PDT)
Message-ID: <334cc93e-9843-daa9-5846-394c199e294f@redhat.com>
Date:   Wed, 16 Mar 2022 08:53:45 +0100
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
        linux-s390@vger.kernel.org
References: <20220316060214.2200695-1-morbo@google.com>
 <20220316074356.n7e5lzrmnal2dcgu@gator>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220316074356.n7e5lzrmnal2dcgu@gator>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/03/2022 08.43, Andrew Jones wrote:
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
> This is fixed in libfdt upstream with commit 7be250b4 ("libfdt:
> Correct condition for reordering blocks"), which is in v1.6.1.
> We can either take this patch as a backport of 7be250b4 or we
> can rebase all of our libfdt to v1.6.1. Based on the number of
> fixes in v1.6.1, which appear to be mostly for compiling with
> later compilers, I'm in favor of rebasing.

+1 for updating to v1.6.1 completely.

> Actually, we can also use this opportunity to [re]visit the
> idea of changing libfdt to a git submodule. I'd like to hear
> opinions on that.

I'm always a little bit torn when it comes to this question. Sure, git 
submodules maybe make the update easier ... but they are a real pita when 
you're working with remote machines that might not have direct connection to 
the internet. For example, I'm used to rsync my sources to the non-x86 
machines, and if you forget to update the submodule to the right state 
before the sync, you've just lost. So from my side, it's a preference for 
continuing without submodules (but I won't insist if everybody else wants to 
have them instead).

  Thomas


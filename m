Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A391C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 19 May 2022 09:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiESJqR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 May 2022 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiESJqM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 May 2022 05:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 629D61E3EA
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652953570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hI6W8P9fA9nR+fpH4a9T05sDfeZ0jypbZAGOWKRF+9U=;
        b=Xrz74zX4uqU322rGMDM2hS4zVhCLXrjxA71mqNZ+G9uTbVJ+XDxU5hzudJbBGIzPj8xDdM
        gvzbG7NLSwBrm8t/5BxBOUr4ki+ed5yAneSYw4TqzM3ebxKx+Ntld3NBPgxrJjO9spN9hQ
        blr1D2cW1ZSzSsn4IG3twPfC3rq/Je4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-vpf1apy4OF2VfRmFI95VjQ-1; Thu, 19 May 2022 05:46:09 -0400
X-MC-Unique: vpf1apy4OF2VfRmFI95VjQ-1
Received: by mail-wm1-f69.google.com with SMTP id r83-20020a1c4456000000b003972daa86deso404497wma.4
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 02:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hI6W8P9fA9nR+fpH4a9T05sDfeZ0jypbZAGOWKRF+9U=;
        b=i564vzJ94Wv6ACLGFvbRc9N7Myn3L2HpODOOQbV58ZuX1IbOlxhfOfQIoXNBplWPsD
         hWXGv0HkqQkMtTaEQg5aamNmCV7VH34ly8JfxbsaJZUZ9v4MLYzP4eNKiKviVz9MDnOs
         Car0w6MIteB3Qd75Ex9mYdxh+a5UcY7iMgigRPuscXzvjlnaaxR1+wLNqlw8+fL1M8LJ
         CFAIQUXcVm0Ti9Vru+qd/QebYRxjKedq6/EeBXPH9n01tI8j6TfI0VgJz09GCH5ziuFK
         ZZugZwa7q/5UkwkJcBla+X4a3eWtHP5TLTQLGTfkSpZJpnTBAn9XLe6sc1QWOAiVjaht
         qC9w==
X-Gm-Message-State: AOAM531S/uQGh15xT+wEG0+OG1AsFzEbdQAkn2CO3Lo68jbBPBV9SCja
        zk+JypwUCM7IqCXCr93Oo2lmDDMpAlBCjlUTcodmfIbqWW9g5mtclfPDeapH+DgCL7oP7zQAmVr
        0UsQ4cHSpDwPW71te2/1aHg==
X-Received: by 2002:a05:600c:5022:b0:394:5caf:2b46 with SMTP id n34-20020a05600c502200b003945caf2b46mr3524566wmr.156.1652953568068;
        Thu, 19 May 2022 02:46:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYUOEqyPkfiXdwd3qRcUwYjVAJCYVd80xcXpeUyq2ofDkX+MI1awx166V7xgBxLa8yAS7dKg==
X-Received: by 2002:a05:600c:5022:b0:394:5caf:2b46 with SMTP id n34-20020a05600c502200b003945caf2b46mr3524548wmr.156.1652953567863;
        Thu, 19 May 2022 02:46:07 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-176-97.web.vodafone.de. [109.43.176.97])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b00397335c8ad4sm637941wmb.1.2022.05.19.02.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:46:07 -0700 (PDT)
Message-ID: <52befa6f-409c-8ace-7aa7-7aa7837d6584@redhat.com>
Date:   Thu, 19 May 2022 11:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [kvm-unit-tests PATCH] s390x: Ignore gcc 12 warnings for low
 addresses
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
References: <20220516144332.3785876-1-scgl@linux.ibm.com>
 <20220517140206.6a58760f@p-imbrenda>
 <15aee36c-de22-5f2a-d32b-b74cddebfc1c@redhat.com>
 <79585ac9-61cc-52a6-6df4-ca1530dbbc9f@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <79585ac9-61cc-52a6-6df4-ca1530dbbc9f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/05/2022 13.07, Janis Schoetterl-Glausch wrote:
> On 5/17/22 18:09, Thomas Huth wrote:
>> On 17/05/2022 14.02, Claudio Imbrenda wrote:
>>> On Mon, 16 May 2022 16:43:32 +0200
>>> Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
>>>
>>>> gcc 12 warns if a memory operand to inline asm points to memory in the
>>>> first 4k bytes. However, in our case, these operands are fine, either
>>>> because we actually want to use that memory, or expect and handle the
>>>> resulting exception.
>>>> Therefore, silence the warning.
>>>
>>> I really dislike this
>>
>> I agree the pragmas are ugly. But maybe we should mimic what the kernel
>> is doing here?
>>
>> $ git show 8b202ee218395
>> commit 8b202ee218395319aec1ef44f72043e1fbaccdd6
>> Author: Sven Schnelle <svens@linux.ibm.com>
>> Date:   Mon Apr 25 14:17:42 2022 +0200
>>
>>      s390: disable -Warray-bounds
>>          gcc-12 shows a lot of array bound warnings on s390. This is caused
>>      by the S390_lowcore macro which uses a hardcoded address of 0.
>>          Wrapping that with absolute_pointer() works, but gcc no longer knows
>>      that a 12 bit displacement is sufficient to access lowcore. So it
>>      emits instructions like 'lghi %r1,0; l %rx,xxx(%r1)' instead of a
>>      single load/store instruction. As s390 stores variables often
>>      read/written in lowcore, this is considered problematic. Therefore
>>      disable -Warray-bounds on s390 for gcc-12 for the time being, until
>>      there is a better solution.
>>
>> ... so we should maybe disable it in the Makefile, too, until the
>> kernel folks found a nicer solution?
>>
>>   Thomas
>>
> 
> Neat, wasn't aware of that commit.
> 
> I don't think we need to concern ourselves with performance in this case and can define
> 
> +#define HIDE_PTR(ptr)                          \
> +({                                             \
> +       uint64_t __ptr;                         \
> +       asm ("" : "=d" (__ptr) : "0" (ptr));    \
> +       (typeof(ptr))__ptr;                     \
> +})
> +
> 
> in some header (which?).
> 
> Another alternative would be to define some extern symbols for the addresses we want to use.
> It might be nice to have a symbol for the lowcore anyway, then we can get rid of
> 
> static struct lowcore *lc;
> struct lowcore *lc = (struct lowcore *)0x0;
> ...
> 
> in a bunch of tests.

I like that idea.

> And use that symbol to derive the addresses we want to use.
> emulator.c uses -1 to generate an addressing exception, we either need another symbol for
> that or use another invalid address. (Can't get to -1 from lowcore/0 because the max array
> size is signed int64 max)

Maybe use INT64_MAX or something similar? Would that work?

  Thomas


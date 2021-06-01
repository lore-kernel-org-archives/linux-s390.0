Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51DC47080
	for <linux-s390@archiver.kernel.org>; Tue,  1 Jun 2021 18:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341F060FF3
	for <linux-s390@archiver.kernel.org>; Tue,  1 Jun 2021 18:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhFASEy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Jun 2021 14:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhFASEx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Jun 2021 14:04:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F2EC061574
        for <linux-s390@vger.kernel.org>; Tue,  1 Jun 2021 11:03:11 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id a13so216668oid.9
        for <linux-s390@vger.kernel.org>; Tue, 01 Jun 2021 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fBK7i8eOCWD7bhsE5M2Uc/50Bg2gXfvHWSF0m3uzUmM=;
        b=LnrSeewa+v24qnBzJliqTIX8159l+VdnoAsvT4KHaU5f8k8D6lD428BufJUiXBBw5j
         wH4z6NKEncrcfV82RLY3MbBz8g3P3kPOlQyGNRNDph4hYhKZikfx3XuukA6Ei/NuMVqS
         WbcA9mp6ey51P5OCGeE1KXU0Kt5rMYexrs59F1dnnCbTJSP8Soh+f3/fyCPsQk60oyfQ
         Lgrn1vcJdM9dLnz2Am/ndB+s+XtoYf0UmViHFXRZswELtuLIwrfIaGU2vsOSBIH3uudz
         KmUo8iBJy65UbiJN8Uao08H9Crm8jRm5CujkLR3NEAp/99RRcN9x/1r4kvs+5mMg0d/g
         QEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBK7i8eOCWD7bhsE5M2Uc/50Bg2gXfvHWSF0m3uzUmM=;
        b=tUy7SWsxRwqYb8Gxd9//wcy50vNLOt/5UwGgXMQQSjNSi4VqSImdATTL/CP2XAG52P
         50x7i4LFBKLimq5rMprX/JRBponenQnavvNTjTxq8XhkX4Wom5XEZJXmde4guO6WuPqI
         ZWyb1sGBUERX7wRlUd4q3ZCN1Y2Mmo1h17z4T9LQE8vaPDGFwwWX0fSndm0yprZlxYzj
         j5Da7Jj6Qtt8YXUhnJK12ejp64l8hvPf3mioWcpbhbQtShk9oYAS0vmbnHokmNHmTwS2
         aFKLumxJhmDhdE9A2zS0xrbMPzu6zIC9GsR5/z5pEwuejrI4zDqMhlkWR9CXEq7SWMK8
         oUVQ==
X-Gm-Message-State: AOAM531j03D8r7m2RjHzbZBIjoDnsKqMuoy78fRQOUZJAgqg9fJCwdgp
        sWvVNYxfokkTNaUjwzxklkLJjEfdui4iL8gM
X-Google-Smtp-Source: ABdhPJyVPnUkCmmFwHeHSJkQyiP8pFVashqQQa5tEsHea86rjeVsxiTYqAFDUT1H33rToJ3vgvGJjg==
X-Received: by 2002:a05:6808:a97:: with SMTP id q23mr3076754oij.39.1622570590479;
        Tue, 01 Jun 2021 11:03:10 -0700 (PDT)
Received: from [192.168.86.140] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id w10sm3727739ott.75.2021.06.01.11.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 11:03:09 -0700 (PDT)
Subject: Re: [PATCH] Replace use of perl with sed and tr in s390x build.
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a48c51f8-5fe4-87e7-284e-c96e2381801a@landley.net>
 <your-ad-here.call-01622498121-ext-5758@work.hours>
From:   Rob Landley <rob@landley.net>
Message-ID: <91e7a6bd-847b-3cbc-9ebf-b73921d456f0@landley.net>
Date:   Tue, 1 Jun 2021 13:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <your-ad-here.call-01622498121-ext-5758@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/31/21 4:55 PM, Vasily Gorbik wrote:
> On Mon, May 17, 2021 at 11:46:44PM -0500, Rob Landley wrote:
>> From: Rob Landley <rob@landley.net>
>>
>> Commit 246218962e21 in November added a perl dependency to the s390x vmlinux
>> build, complicating the "countering trusting trust" build approach ala
>> http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html
>>
>> Signed-off-by: Rob Landley <rob@landley.net>
>> ---
>>
>>  arch/s390/boot/compressed/Makefile |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
>> index de18dab518bb..e941b165bd4f 100644
>> --- a/arch/s390/boot/compressed/Makefile
>> +++ b/arch/s390/boot/compressed/Makefile
>> @@ -33,7 +33,7 @@ $(obj)/vmlinux.syms: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OB
>>  
>>  quiet_cmd_dumpsyms = DUMPSYMS $<
>>  define cmd_dumpsyms
>> -	$(NM) -n -S --format=bsd "$<" | $(PERL) -ne '/(\w+)\s+(\w+)\s+[tT]\s+(\w+)/ and printf "%x %x %s\0",hex $$1,hex $$2,$$3' > "$@"
>> +	$(NM) -n -S --format=bsd "$<" | sed -nE 's/^0*([0-9a-fA-F]+) 0*([0-9a-fA-F]+) [tT] ([^ ]*)$$/\1 \2 \3/p' | tr '\n' '\0' > "$@"
>>  endef
> 
> The change itself is fine. Yields the same result as before with
> binutils/llvm/elfutils versions of nm.

...

> So, would you mind if I pick your patch changing the commit message
> like the following?
> """
> s390/decompressor: replace use of perl with simple sed/tr
> 
> Use simple sed/tr instead of perl to generate decompressor symbols
> file with the same result.

Works for me.

> Signed-off-by: Rob Landley <rob@landley.net>
> """

Thanks,

Rob

Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09179C4167D
	for <linux-s390@archiver.kernel.org>; Tue,  7 Nov 2023 08:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjKGIin (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Nov 2023 03:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjKGIim (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Nov 2023 03:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55303184
        for <linux-s390@vger.kernel.org>; Tue,  7 Nov 2023 00:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699346270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=rrf9M0yg1iFKGMAdaP8YMM5yDFIo4Qz87x7Angm1feY=;
        b=GEWQYkxRU/AsbKlqY4N3xwaF6btKAolZ8Do3G/fu1ZbugvZfUZ1j/W8fEw7CWoQ/2FQhb/
        wrL/IVFVqPQkagExr3n0zVhrBtc1DbyYPsNC4L4cZhdgcQ/XOAZ2VxOJj3wpRgGvMZfIY+
        7Ovtw2W0CQ4mV99+ojaP0fbi9nJK/Ss=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436--u62qo7vOQ6UajXXeP_jcA-1; Tue, 07 Nov 2023 03:37:49 -0500
X-MC-Unique: -u62qo7vOQ6UajXXeP_jcA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41cb4d6744bso58626941cf.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Nov 2023 00:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699346268; x=1699951068;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrf9M0yg1iFKGMAdaP8YMM5yDFIo4Qz87x7Angm1feY=;
        b=j6gsdnb0pVIfXqs5tWxDlxReagmRJ5v4fXuWHAnV6NDrhcLnRFWFLLoVKBYJB7juGd
         zdiyP1fuEJ5hwo0gB4DABBDVSebti8LTFRXdsXWWoJNsYHxEIiD8znPxVYhynigEEnsF
         bzS44gLgo25GKlUtT3cXH+xAS1odu8boUlSpiyAUVkLxaZmXxh2IJHutLb9fRivU1N+P
         nbResMY2M0o6TXXGMmH++DK4HBgPEjs6qJ9ZGd8CI1R5slROAQ2rXCUAhhjmqrAqn5Ge
         oadQwQzdlXpknKGeWpFVJ0b7Ap9jvIuFvxKJxT/M7w9AouB9LKjsvD+xvWyJHw7uG0px
         664A==
X-Gm-Message-State: AOJu0Yz5cLxj4yAMQzlM5Iy1tGrWBw4+pix18RLHp1iqcSGWgqJaIptF
        0UsDmJiukznnkjeX8AXTuRZ6l+ffhUFK/FHKTJyP+fdW1Fwj8sqvnT/Uto/xCr1PZoYOO181GDi
        M0OuA5KDriw8OrSLT/MC9vw==
X-Received: by 2002:a05:622a:24b:b0:418:1365:9b4e with SMTP id c11-20020a05622a024b00b0041813659b4emr38594942qtx.20.1699346268725;
        Tue, 07 Nov 2023 00:37:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj96uBnFkczY3xtB+XXEgGhNWzX6io7rIzu4SzpkseDfWVLha9iYywQdIUBiwc7nYLV7BhAw==
X-Received: by 2002:a05:622a:24b:b0:418:1365:9b4e with SMTP id c11-20020a05622a024b00b0041813659b4emr38594927qtx.20.1699346268388;
        Tue, 07 Nov 2023 00:37:48 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-179-224.web.vodafone.de. [109.43.179.224])
        by smtp.gmail.com with ESMTPSA id ew3-20020a05622a514300b0041520676966sm4148868qtb.47.2023.11.07.00.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 00:37:48 -0800 (PST)
Message-ID: <2fd73726-5696-4398-9c81-95b5c9fa6713@redhat.com>
Date:   Tue, 7 Nov 2023 09:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v1 02/10] powerpc: properly format
 non-kernel-doc comments
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     frankja@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        andrew.jones@linux.dev, lvivier@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20231106125352.859992-1-nrb@linux.ibm.com>
 <20231106125352.859992-3-nrb@linux.ibm.com>
 <20231106175316.1f05d090@p-imbrenda>
 <169929081714.70850.5803437896270751208@t14-nrb>
From:   Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <169929081714.70850.5803437896270751208@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/11/2023 18.13, Nico Boehr wrote:
> Quoting Claudio Imbrenda (2023-11-06 17:53:16)
>> On Mon,  6 Nov 2023 13:50:58 +0100
>> Nico Boehr <nrb@linux.ibm.com> wrote:
>>
>>> These comments do not follow the kernel-doc style, hence they should not
>>> start with /**.
>>>
>>> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
>>> ---
>>>   powerpc/emulator.c    | 2 +-
>>>   powerpc/spapr_hcall.c | 6 +++---
>>>   powerpc/spapr_vpa.c   | 4 ++--
>>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/powerpc/emulator.c b/powerpc/emulator.c
>>> index 65ae4b65e655..39dd59645368 100644
>>> --- a/powerpc/emulator.c
>>> +++ b/powerpc/emulator.c
>>> @@ -71,7 +71,7 @@ static void test_64bit(void)
>>>        report_prefix_pop();
>>>   }
>>>   
>>> -/**
>>> +/*
>>>    * Test 'Load String Word Immediate' instruction
>>>    */
>>
>> this should have the name of the function first:
>>   * test_lswi() - Test 'Load String ...
>>
>> (same for all the other functions here)
> 
> Since none of these comments really follow kerneldoc style and are mostly
> static anyways, the idea was to convert them to non-kerneldoc style, by
> changing the comment from:
> /**
> 
> to:
> /*
> 
> But I am just as fine to make the comments proper kerneldoc style, if we
> see value in that.

I think it makes sense to do that for the files in the lib/ folder ... for 
the other ones, I think it is not really necessary (but it wouldn't hurt 
either).

  Thomas


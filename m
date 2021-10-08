Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB0C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC28261039
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 07:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhJHHWO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhJHHWN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Oct 2021 03:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633677618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqC/5VAETazVyO6TNWaj66dbCj9XhYnOIWIpjNlIq7I=;
        b=GxWCD+RWiZnBPVeKjtm0f4UvvSyJcjo8vmARLZDC/cCT6JD08WamNEr468rZksbRlcE0BT
        ScmVbUniY2GYO51s/Pxid57J1vBZoONUBHSjda/slmMG4FU3rQyqxu5MLOkpCy7Z8N3feZ
        NI8Ew6R5JSIzrWC5F7xxGvFsqIGBQT8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-0eAk0LOyOz6eov3ubawzAg-1; Fri, 08 Oct 2021 03:20:07 -0400
X-MC-Unique: 0eAk0LOyOz6eov3ubawzAg-1
Received: by mail-wr1-f70.google.com with SMTP id r25-20020adfab59000000b001609ddd5579so6557458wrc.21
        for <linux-s390@vger.kernel.org>; Fri, 08 Oct 2021 00:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rqC/5VAETazVyO6TNWaj66dbCj9XhYnOIWIpjNlIq7I=;
        b=FOkwCF19z8UyKSWW/d9YxiMZdofcn9ILGeLymxi79BQO2DhNqaAWyS6P927jPn1nTz
         tKG+FV9df6h1x8eBxkhZlQNDjyaFnGnaWky31FfOywMKlKgY7Neqj/zcAe8/ww9oOo5m
         lIsILFW3IEXQvKZgDCRzg5wDr+QMAjJ/upQaTK3nVnvXJM6wVIvTOKZ34vK+Lnms4rJr
         QCpXpLnPl3ZZNx7nR2J6cAkR9yoZ+TKR9qMPATKARy9nrJV//cSollBPzzN1LZUqS+zn
         PbOwU7s7oNwEolGpdhjDF8Eb3RKj1ScD6UrJTDsH/h0gjmj1FPzZC4jKpP3BPpNpdEK0
         V6BA==
X-Gm-Message-State: AOAM532pNFMYyAGDc5HYTG9oZVUnuUmABCS31psNLy/eBIXlto9c2EdQ
        5rsPS/3DjZ9qR3IfNQN80Mhzfn99ToqbWXKN1noFEWDg80LLG7GDlKq1NeCztKrcwyrhcAPlQoC
        iSdtdWRJDHfhAbNiihMgLZg==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr1986259wrp.172.1633677606419;
        Fri, 08 Oct 2021 00:20:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4jKSzfJVv6uoe0EHSmIxunSNd3S9zw3RdZ2AEWUZlmf9vr6835IAXGnldZEevqkJ0p6mUjA==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr1986237wrp.172.1633677606223;
        Fri, 08 Oct 2021 00:20:06 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id b19sm9105609wmb.1.2021.10.08.00.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 00:20:05 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v3 9/9] s390x: snippets: Define all things
 that are needed to link the lib
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com, scgl@linux.ibm.com
References: <20211007085027.13050-1-frankja@linux.ibm.com>
 <20211007085027.13050-10-frankja@linux.ibm.com>
 <c3bed287-5c4c-a54b-4276-391c6cdb37f4@redhat.com>
 <8c1cac56-3f4b-5f00-4e62-d14aebbb537d@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <bf94d76c-ee23-465e-1c2a-8c4ee1b006f7@redhat.com>
Date:   Fri, 8 Oct 2021 09:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8c1cac56-3f4b-5f00-4e62-d14aebbb537d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/10/2021 12.44, Janosch Frank wrote:
> On 10/7/21 11:44, Thomas Huth wrote:
>> On 07/10/2021 10.50, Janosch Frank wrote:
>>> Let's just define all of the needed things so we can link libcflat.
>>>
>>> A significant portion of the lib won't work, like printing and
>>> allocation but we can still use things like memset() which already
>>> improves our lives significantly.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    s390x/snippets/c/cstart.S | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/s390x/snippets/c/cstart.S b/s390x/snippets/c/cstart.S
>>> index 031a6b83..2d397669 100644
>>> --- a/s390x/snippets/c/cstart.S
>>> +++ b/s390x/snippets/c/cstart.S
>>> @@ -20,6 +20,20 @@ start:
>>>        lghi    %r15, stackptr
>>>        sam64
>>>        brasl    %r14, main
>>> +/*
>>> + * Defining things that the linker needs to link in libcflat and make
>>> + * them result in sigp stop if called.
>>> + */
>>> +.globl sie_exit
>>> +.globl sie_entry
>>> +.globl smp_cpu_setup_state
>>> +.globl ipl_args
>>> +.globl auxinfo
>>> +sie_exit:
>>> +sie_entry:
>>> +smp_cpu_setup_state:
>>> +ipl_args:
>>> +auxinfo:
>>
>> I think this likely could be done in a somewhat nicer way, e.g. by moving
> 
> Definitely, as I said, it's a simple fix

Alternatively, something like this might work, too:

diff --git a/s390x/Makefile b/s390x/Makefile
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -80,7 +80,7 @@ asmlib = $(TEST_DIR)/cstart64.o $(TEST_DIR)/cpu.o
  FLATLIBS = $(libcflat)
  
  SNIPPET_DIR = $(TEST_DIR)/snippets
-snippet_asmlib = $(SNIPPET_DIR)/c/cstart.o
+snippet_asmlib = $(SNIPPET_DIR)/c/cstart.o lib/auxinfo.o
  
  # perquisites (=guests) for the snippet hosts.
  # $(TEST_DIR)/<snippet-host>.elf: snippets = $(SNIPPET_DIR)/<c/asm>/<snippet>.gbin
diff --git a/s390x/snippets/c/cstart.S b/s390x/snippets/c/cstart.S
--- a/s390x/snippets/c/cstart.S
+++ b/s390x/snippets/c/cstart.S
@@ -21,5 +21,9 @@ start:
         sam64
         brasl   %r14, main
         /* For now let's only use cpu 0 in snippets so this will always work. */
+.global puts
+.global exit
+puts:
+exit:
         xgr     %r0, %r0
         sigp    %r2, %r0, SIGP_STOP

I think that's more clear this way, since we're fencing the
functions that caused the dependencies to the other functions
from your patch. What do you think?

  Thomas


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870BFC4743C
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C95610C7
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFUPBd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhFUPBd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 11:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624287558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZLJmw8eGYXnhmh6V4iZaqFXsIhAiyXib6kymsQkEv0=;
        b=WJXFIb9BMktiBUXyHPMwwujtBVXFRVzfZ4xtDo17qtr9gOAM8v0Nfs6F+NcHvLPYFBDl5C
        hhU08ji4EPbtj1NkS7g7jwv2PZmuA1S8etA5emYxScUKVHFTLkmLqiYGE87aHQoXz4T1Mj
        GhyC3eOBmg/S1TdkFkL4WWKNBkGTqCQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-DI1DweoeOoyIj6-2S_oAsA-1; Mon, 21 Jun 2021 10:59:17 -0400
X-MC-Unique: DI1DweoeOoyIj6-2S_oAsA-1
Received: by mail-wr1-f72.google.com with SMTP id j2-20020a5d61820000b029011a6a8149b5so8100481wru.14
        for <linux-s390@vger.kernel.org>; Mon, 21 Jun 2021 07:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZLJmw8eGYXnhmh6V4iZaqFXsIhAiyXib6kymsQkEv0=;
        b=CklVzjmmvRYtN/h4I/EIcAdzi9V0+CCmnuHdZpdxOVsIWmnDlJ2gSLkI5rJi2zR4rr
         lEij/HWcghhTa3lARnX4U30BlWQF3R5aPU+QqxgX0YTDs0Vje8q0bfM/4va8Jvn7pMow
         70jhiitsGKSiMkvCAhrwGfSonos2v7l2QNr3BNj/Q9YgBkHvIBCwYutL0JhjzZDmAcAU
         ce3IlNIM4pGa0pwxBffRf1gLCrYsFaOxri346wcLUi4qlt5wqe6J4ERf150Yt72UiS7S
         x/9U6rdF/ZYJlss/mP41XTI1HdQoX03d2bFmejN19JUbj+SLIzKhb7jbdDP6BfUXQmbW
         r1Vg==
X-Gm-Message-State: AOAM531wqTmHu08hRN23kajsO6/yUbRf6Q+56OwuHP3Us8+EE1e1TmuF
        N+0EyAoMQGMmoqeIPYo5BwJ4YycrPWUmtE3ZxTukzI2TlbddKVVqAjX5k4W7FJMo4mclQajOZvn
        4hAaeHBI2sVtV1y6jbPLjFw==
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr29625099wrs.164.1624287556345;
        Mon, 21 Jun 2021 07:59:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcgbP8FMKFc7DiOUAFxof8dUnFlRKyB47BWAjypMdnBBgdHStbh8MWCMzMXsXum6DKRmMUlg==
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr29625075wrs.164.1624287556134;
        Mon, 21 Jun 2021 07:59:16 -0700 (PDT)
Received: from thuth.remote.csb (pd9575fcd.dip0.t-ipconnect.de. [217.87.95.205])
        by smtp.gmail.com with ESMTPSA id p16sm18337758wrs.52.2021.06.21.07.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 07:59:15 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC 1/2] s390x: Add guest snippet support
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210520094730.55759-1-frankja@linux.ibm.com>
 <20210520094730.55759-2-frankja@linux.ibm.com>
 <b5171773-afb6-e148-a82f-ea78877206ce@redhat.com>
 <d20e7f88-dcca-67ca-17e0-7c45982aa5ff@linux.ibm.com>
 <304a297a-c366-9d61-9d13-fc1f86dd4f50@redhat.com>
 <19e99dfe-6730-194b-a0c5-87455f446625@linux.ibm.com>
 <5149db0e-8372-6054-da0d-fc8f85ac4038@redhat.com>
 <68698aa3-d207-9260-197e-9d906cc6704f@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <a74f86e1-6fc9-e2fd-12f9-4670c1290355@redhat.com>
Date:   Mon, 21 Jun 2021 16:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <68698aa3-d207-9260-197e-9d906cc6704f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/06/2021 16.42, Janosch Frank wrote:
> On 6/21/21 3:28 PM, Thomas Huth wrote:
>> On 21/06/2021 14.39, Janosch Frank wrote:
>>> On 6/21/21 2:32 PM, Thomas Huth wrote:
>>>> On 21/06/2021 14.19, Janosch Frank wrote:
>>>>> On 6/21/21 12:10 PM, Thomas Huth wrote:
>>>>>> On 20/05/2021 11.47, Janosch Frank wrote:
>>>>>>> Snippets can be used to easily write and run guest (SIE) tests.
>>>>>>> The snippet is linked into the test binaries and can therefore be
>>>>>>> accessed via a ptr.
>>>>>>>
>>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>>> ---
>>>>>>>      .gitignore                |  2 ++
>>>>>>>      s390x/Makefile            | 28 ++++++++++++++++++---
>>>>>>>      s390x/snippets/c/cstart.S | 13 ++++++++++
>>>>>>>      s390x/snippets/c/flat.lds | 51 +++++++++++++++++++++++++++++++++++++++
>>>>>>>      4 files changed, 91 insertions(+), 3 deletions(-)
>>>>>>>      create mode 100644 s390x/snippets/c/cstart.S
>>>>>>>      create mode 100644 s390x/snippets/c/flat.lds
>>>>>>>
>>>>>>> diff --git a/.gitignore b/.gitignore
>>>>>>> index 784cb2dd..29d3635b 100644
>>>>>>> --- a/.gitignore
>>>>>>> +++ b/.gitignore
>>>>>>> @@ -22,3 +22,5 @@ cscope.*
>>>>>>>      /api/dirty-log
>>>>>>>      /api/dirty-log-perf
>>>>>>>      /s390x/*.bin
>>>>>>> +/s390x/snippets/*/*.bin
>>>>>>> +/s390x/snippets/*/*.gbin
>>>>>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>>>>>> index 8de926ab..fe267011 100644
>>>>>>> --- a/s390x/Makefile
>>>>>>> +++ b/s390x/Makefile
>>>>>>> @@ -75,11 +75,33 @@ OBJDIRS += lib/s390x
>>>>>>>      asmlib = $(TEST_DIR)/cstart64.o $(TEST_DIR)/cpu.o
>>>>>>>      
>>>>>>>      FLATLIBS = $(libcflat)
>>>>>>> -%.elf: %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>>>>>>> +
>>>>>>> +SNIPPET_DIR = $(TEST_DIR)/snippets
>>>>>>> +
>>>>>>> +# C snippets that need to be linked
>>>>>>> +snippets-c =
>>>>>>> +
>>>>>>> +# ASM snippets that are directly compiled and converted to a *.gbin
>>>>>>> +snippets-a =
>>>>>>
>>>>>> Could you please call this snippets-s instead of ...-a ? The -a suffix looks
>>>>>> like an archive to me otherwise.
>>>>>
>>>>> Sure
>>>>>
>>>>>>
>>>>>>> +snippets = $(snippets-a)$(snippets-c)
>>>>>>
>>>>>> Shouldn't there be a space between the two?
>>>>>
>>>>> Yes, already fixed that a long while ago
>>>>> I thought I had sent out a new version already, maybe that was an
>>>>> illusion as I can't seem to find it right now.
>>>>>
>>>>>>
>>>>>>> +snippets-o += $(patsubst %.gbin,%.o,$(snippets))
>>>>>>> +
>>>>>>> +$(snippets-a): $(snippets-o) $(FLATLIBS)
>>>>>>> +	$(OBJCOPY) -O binary $(patsubst %.gbin,%.o,$@) $@
>>>>>>> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
>>>>>>> +
>>>>>>> +$(snippets-c): $(snippets-o) $(SNIPPET_DIR)/c/cstart.o  $(FLATLIBS)
>>>>>>> +	$(CC) $(LDFLAGS) -o $@ -T $(SNIPPET_DIR)/c/flat.lds \
>>>>>>> +		$(filter %.o, $^) $(FLATLIBS)
>>>>>>> +	$(OBJCOPY) -O binary $@ $@
>>>>>>> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
>>>>>>> +
>>>>>>> +%.elf: $(snippets) %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>>>>>>>      	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) \
>>>>>>>      		$(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$@\"
>>>>>>>      	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/flat.lds \
>>>>>>> -		$(filter %.o, $^) $(FLATLIBS) $(@:.elf=.aux.o)
>>>>>>> +		$(filter %.o, $^) $(FLATLIBS) $(snippets) $(@:.elf=.aux.o)
>>>>>>
>>>>>> Does this link the snippets into all elf files? ... wouldn't it be better to
>>>>>> restrict it somehow to the files that really need them?
>>>>>
>>>>> Yes it does.
>>>>> I'd like to avoid having to specify a makefile rule for every test that
>>>>> uses snippets as we already have more than the mvpg one in the queue.
>>>>>
>>>>> So I'm having Steffen looking into a solution for this problem. My first
>>>>> idea was to bring the used snippets into the unittests.cfg but I
>>>>> disliked that we then would have compile instructions in another file.
>>>>> Maybe there's a way to include that into the makefile in a clever way?
>>>>
>>>> I haven't tried, but maybe you could replace the $(snippets) in the last
>>>> line with
>>>>
>>>>     $(wildcard snippets/$@.gbin)
>>>>
>>>> or something similar?
>>>
>>> That starts falling apart when multiple tests use the same snippet, no?
>>
>> That's true ... Maybe something like:
>>
>>    $(filter %.gbin,$^)
> 
> That filters all files that are not gbins from the prereqs, right?
> In what way is that different to linking all the snippets? After all
> they are currently a prereq for %.elf or am I missing something here?

Sorry, I meant we could then add the prereqs manually for each tests that 
require it, e.g. add a single line like:

mvpg-sie.elf: snippets/mvpg.gbin

(without specifying a rule, just the dependency)

... not sure whether that works, though...

  Thomas


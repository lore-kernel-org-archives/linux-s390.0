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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04BAC4743C
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 12:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50E860FE7
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 12:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUMe5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 08:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhFUMe4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 08:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624278762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGMUbfnGyMMTYCkdzbsRQAbBw7iAtTsxA7NUShiOjV8=;
        b=hjF7CS5y3UNZ0RetqCAXAtvwh70CcKElZlGQtTQZ+RddgJcjhTMAIkEfFzx1mlWPnTEwdR
        6XYzdSs7k2530yytRjYLitHsRUbH6YuGRbG++UVSRu9f3YYqhhAnSQDOmOEn+gKiFiLRpQ
        0YXwmgXooXf3F46QtiHrfc0OW2gubw8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-SvyH4FjKMlyWH3enUlum1Q-1; Mon, 21 Jun 2021 08:32:39 -0400
X-MC-Unique: SvyH4FjKMlyWH3enUlum1Q-1
Received: by mail-wr1-f71.google.com with SMTP id l6-20020a0560000226b029011a80413b4fso5070466wrz.23
        for <linux-s390@vger.kernel.org>; Mon, 21 Jun 2021 05:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGMUbfnGyMMTYCkdzbsRQAbBw7iAtTsxA7NUShiOjV8=;
        b=l+jqxTAu1p6quzhq87hprd6EzcFPdJGhH4WOzB/jO+YSHgJwzj6NabK3ASBZFTs+Oe
         obvtKI2cqcs85Boyi8Cfx8XlvkpR6lYgIZRULRdcyeXB6JBLnXXsdTB/fW/h93ALYBeM
         lK0Abyz9Gs4unhlbZRFpLL9BKw8YhcowEMn8P5BMIsUNNafmGazTv03d+8lA2T6v5XaA
         l3pokdBBC4FQBr9d553rbj8G0W7E60UOJqVk2Ao6FLuiClGFUcF4NqB67Z4aXVXiypAY
         HCNUS+mMRubpQ36rWdUlv0o1WvdZ4aCw3wCKGG6m46xVTrd0akwH0q5w0XifUSBvX1e8
         GQiA==
X-Gm-Message-State: AOAM533czumR8JyxaOAUSv0s5L93gifvCCCPLnC1HGfBs8Kkoy71S3J5
        y6hulE7E6Z31YmHxA6C6UnFL2I1sCrTYjL1YWr32ohcw5A6Que22Yg4W3rplgoZf7pV9mWDmmPH
        yZnXoz2gjKpWXc6bAHrFSBA==
X-Received: by 2002:adf:c790:: with SMTP id l16mr28684546wrg.121.1624278758646;
        Mon, 21 Jun 2021 05:32:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Pu4Md5BGN+GMcXUudxysZZePKneAHE0UWjhUhVHFjY8rZs/njwyRama1WyTFbF6RFmX5vQ==
X-Received: by 2002:adf:c790:: with SMTP id l16mr28684531wrg.121.1624278758453;
        Mon, 21 Jun 2021 05:32:38 -0700 (PDT)
Received: from thuth.remote.csb (pd9575fcd.dip0.t-ipconnect.de. [217.87.95.205])
        by smtp.gmail.com with ESMTPSA id y189sm3959076wmg.6.2021.06.21.05.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:32:37 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC 1/2] s390x: Add guest snippet support
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210520094730.55759-1-frankja@linux.ibm.com>
 <20210520094730.55759-2-frankja@linux.ibm.com>
 <b5171773-afb6-e148-a82f-ea78877206ce@redhat.com>
 <d20e7f88-dcca-67ca-17e0-7c45982aa5ff@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <304a297a-c366-9d61-9d13-fc1f86dd4f50@redhat.com>
Date:   Mon, 21 Jun 2021 14:32:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d20e7f88-dcca-67ca-17e0-7c45982aa5ff@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/06/2021 14.19, Janosch Frank wrote:
> On 6/21/21 12:10 PM, Thomas Huth wrote:
>> On 20/05/2021 11.47, Janosch Frank wrote:
>>> Snippets can be used to easily write and run guest (SIE) tests.
>>> The snippet is linked into the test binaries and can therefore be
>>> accessed via a ptr.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    .gitignore                |  2 ++
>>>    s390x/Makefile            | 28 ++++++++++++++++++---
>>>    s390x/snippets/c/cstart.S | 13 ++++++++++
>>>    s390x/snippets/c/flat.lds | 51 +++++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 91 insertions(+), 3 deletions(-)
>>>    create mode 100644 s390x/snippets/c/cstart.S
>>>    create mode 100644 s390x/snippets/c/flat.lds
>>>
>>> diff --git a/.gitignore b/.gitignore
>>> index 784cb2dd..29d3635b 100644
>>> --- a/.gitignore
>>> +++ b/.gitignore
>>> @@ -22,3 +22,5 @@ cscope.*
>>>    /api/dirty-log
>>>    /api/dirty-log-perf
>>>    /s390x/*.bin
>>> +/s390x/snippets/*/*.bin
>>> +/s390x/snippets/*/*.gbin
>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>> index 8de926ab..fe267011 100644
>>> --- a/s390x/Makefile
>>> +++ b/s390x/Makefile
>>> @@ -75,11 +75,33 @@ OBJDIRS += lib/s390x
>>>    asmlib = $(TEST_DIR)/cstart64.o $(TEST_DIR)/cpu.o
>>>    
>>>    FLATLIBS = $(libcflat)
>>> -%.elf: %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>>> +
>>> +SNIPPET_DIR = $(TEST_DIR)/snippets
>>> +
>>> +# C snippets that need to be linked
>>> +snippets-c =
>>> +
>>> +# ASM snippets that are directly compiled and converted to a *.gbin
>>> +snippets-a =
>>
>> Could you please call this snippets-s instead of ...-a ? The -a suffix looks
>> like an archive to me otherwise.
> 
> Sure
> 
>>
>>> +snippets = $(snippets-a)$(snippets-c)
>>
>> Shouldn't there be a space between the two?
> 
> Yes, already fixed that a long while ago
> I thought I had sent out a new version already, maybe that was an
> illusion as I can't seem to find it right now.
> 
>>
>>> +snippets-o += $(patsubst %.gbin,%.o,$(snippets))
>>> +
>>> +$(snippets-a): $(snippets-o) $(FLATLIBS)
>>> +	$(OBJCOPY) -O binary $(patsubst %.gbin,%.o,$@) $@
>>> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
>>> +
>>> +$(snippets-c): $(snippets-o) $(SNIPPET_DIR)/c/cstart.o  $(FLATLIBS)
>>> +	$(CC) $(LDFLAGS) -o $@ -T $(SNIPPET_DIR)/c/flat.lds \
>>> +		$(filter %.o, $^) $(FLATLIBS)
>>> +	$(OBJCOPY) -O binary $@ $@
>>> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
>>> +
>>> +%.elf: $(snippets) %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>>>    	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) \
>>>    		$(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$@\"
>>>    	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/flat.lds \
>>> -		$(filter %.o, $^) $(FLATLIBS) $(@:.elf=.aux.o)
>>> +		$(filter %.o, $^) $(FLATLIBS) $(snippets) $(@:.elf=.aux.o)
>>
>> Does this link the snippets into all elf files? ... wouldn't it be better to
>> restrict it somehow to the files that really need them?
> 
> Yes it does.
> I'd like to avoid having to specify a makefile rule for every test that
> uses snippets as we already have more than the mvpg one in the queue.
> 
> So I'm having Steffen looking into a solution for this problem. My first
> idea was to bring the used snippets into the unittests.cfg but I
> disliked that we then would have compile instructions in another file.
> Maybe there's a way to include that into the makefile in a clever way?

I haven't tried, but maybe you could replace the $(snippets) in the last 
line with

  $(wildcard snippets/$@.gbin)

or something similar?

  Thomas


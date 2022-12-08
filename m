Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D05C3A5A7
	for <linux-s390@archiver.kernel.org>; Thu,  8 Dec 2022 16:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiLHQQW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLHQQV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Dec 2022 11:16:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49FE9E468
        for <linux-s390@vger.kernel.org>; Thu,  8 Dec 2022 08:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670516123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5JSj6tpBiw9sXeHTofqWR8FzlPYJBbVdgJf9+K81HA=;
        b=G4gzn7lq4CKBWLkhzXYmtMkkzG3lRLCQVKBnFi/V5zHj/8HbNrgFm4yXUnv76aPilvQKfy
        ze84NHUiYV4qDqGkCq8VOYJtqfc136139T9lFi2Ljz383B3Zyu11pZTXiq7QhDcK2HBkBr
        /M9YPcYmAHKAiER8e7KGTSsucwEgQEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-112-FpdJ9fn0P8GbQa5trA_OXQ-1; Thu, 08 Dec 2022 11:15:22 -0500
X-MC-Unique: FpdJ9fn0P8GbQa5trA_OXQ-1
Received: by mail-wm1-f70.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so822977wmb.2
        for <linux-s390@vger.kernel.org>; Thu, 08 Dec 2022 08:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5JSj6tpBiw9sXeHTofqWR8FzlPYJBbVdgJf9+K81HA=;
        b=s7eXM2R9pGjz4Jx4bXGu5b6Rz7WvXcdG3TApCSVnrHTic8gA5III6Uk7RerW5ilfTk
         oLtmyGNc4F9FL269FK0VF6NACdj8svaN3z8H3R6ShK5DWYq4mZlxhu/4TURYF1sSAw46
         NWggpKZ+Y0TQmi5ln5K6tfcCz2W95gZkvuGkorCHkajISihFUd25KJnw55+V8a8TGL8F
         rGrnzpQ+W05ZxkxbAUATZZdvrGAMZlshmD+35VYV3zhiSHi0k/XY0/KaFoGAW18GAnoN
         izx1Ftji/H0ROdp6VPceTv3WQZu+Sa8tJjQM94qHINVVTlvRIHHILTSHBADWpQBPV/lw
         76BA==
X-Gm-Message-State: ANoB5pnF9tMPkycfg445CU7jKfXRiLBGSTjF+zV4ogdMs9WJ7AxxyWtn
        ymJCRZpuVBEqLPj0PBbVDuO51xSm+uKm/ZjIF1p96fA6JeNTRg2bYsCsgUzsriqh2+IMQvWzClk
        bYBeYDKekBXz1/Hy+m4L9yg==
X-Received: by 2002:a1c:4c06:0:b0:3cf:88c3:d008 with SMTP id z6-20020a1c4c06000000b003cf88c3d008mr2326489wmf.28.1670516121053;
        Thu, 08 Dec 2022 08:15:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5yYLMTTDSRrDK1DcXudstkrPr9nLHKLQBvdzMIjk/U3hsH27sRZgwoVy+ZKGHTYS5p01Q2Kw==
X-Received: by 2002:a1c:4c06:0:b0:3cf:88c3:d008 with SMTP id z6-20020a1c4c06000000b003cf88c3d008mr2326480wmf.28.1670516120857;
        Thu, 08 Dec 2022 08:15:20 -0800 (PST)
Received: from [192.168.8.102] (tmo-113-115.customers.d1-online.com. [80.187.113.115])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003c6cd82596esm5390208wmi.43.2022.12.08.08.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:15:20 -0800 (PST)
Message-ID: <a798542a-ef24-9f18-6ee3-c85ad6151bc2@redhat.com>
Date:   Thu, 8 Dec 2022 17:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [kvm-unit-tests PATCH] s390x: sie: Test whether the epoch
 extension field is working as expected
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20221207133118.70746-1-thuth@redhat.com>
 <20221207155909.6a3271f7@p-imbrenda>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20221207155909.6a3271f7@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/12/2022 15.59, Claudio Imbrenda wrote:
> On Wed,  7 Dec 2022 14:31:18 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> We recently discovered a bug with the time management in nested scenarios
>> which got fixed by kernel commit "KVM: s390: vsie: Fix the initialization
>> of the epoch extension (epdx) field". This adds a simple test for this
>> bug so that it is easier to decide whether the host kernel of a machine
> 
> s/decide/determine/
> 
>> has already been fixed or not.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   s390x/sie.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/s390x/sie.c b/s390x/sie.c
>> index 87575b29..7ec4b030 100644
>> --- a/s390x/sie.c
>> +++ b/s390x/sie.c
>> @@ -58,6 +58,33 @@ static void test_diags(void)
>>   	}
>>   }
>>   
>> +static void test_epoch_ext(void)
>> +{
>> +	u32 instr[] = {
>> +		0xb2780000,	/* STCKE 0 */
>> +		0x83020044	/* DIAG 0x44 to intercept */
> 
> I'm conflicted about this. one one hand, it should be 0x83000044, but
> on the other hand it does not matter at all, and the other testcase
> also has the spurious 2 in the middle (to check things we are not
> checking here)

D'oh, I simply copy-n-pasted that value from the other test ... well, it 
shouldn't really matter as long as the instruction just gets intercepted. 
OTOH, it's nicer if we make it at least clean here in this new code. I'll 
send a v2 without this "2" in between.

  Thomas


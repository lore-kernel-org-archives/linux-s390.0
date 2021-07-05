Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E4C07E9A
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A68C613BD
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 09:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhGEJol (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 05:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhGEJok (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Jul 2021 05:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625478123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNV9OaYdnxR15a4jV7psRkuzfog3J+Wb9pPXNeHN/OU=;
        b=JHoe9EZn6NW1K6aw9BCFFRgypUmfEOSsOHw1dHvh9/cXXHcVtU8XRSCCv+cz4/ZZdKoWoD
        A0ynqyfbjEUjaeiyXcBapGes9iVRBNdUE4maU5i3c7NIrf7SI+SdYdsnbqDeVLvYpuhrwU
        akNNarqUg/O2G/yqO6dvSA8R576qhaQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-DPEk3KViMFipGMXgry9zsg-1; Mon, 05 Jul 2021 05:42:00 -0400
X-MC-Unique: DPEk3KViMFipGMXgry9zsg-1
Received: by mail-wm1-f69.google.com with SMTP id j38-20020a05600c1c26b02901dbf7d18ff8so9646337wms.8
        for <linux-s390@vger.kernel.org>; Mon, 05 Jul 2021 02:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HNV9OaYdnxR15a4jV7psRkuzfog3J+Wb9pPXNeHN/OU=;
        b=S6G/AEO5J3Tccd2OkuXr0p738vHjE2I6gKubNHCbj35OFAtdnBRHSCUTRr94xmeaJh
         OhNi4nonLyg6s0cBkv++VIphp3dEJZ/5uQxAWWGm9KybjHvh6QGNl2n+/qiociF4lxgo
         SjoIgGPcpuGh/CFod1qZ42UpGmFn7Y4WncmfUqKANk63L/8K+23S6cjnfaZ/ruiAiLym
         aFQVYy7B7JtAh++ClqNFRbPQltvUGX3Ow5nhbBqY73+/3NG1A1yE5zEKNTnG3PZz599Z
         gheoyZdL+un7PaN2xubNI9snTVdeN1QyXHpa2HLjCHEvX/4Fes+sDWle4hbv2qKEi4gt
         eqHQ==
X-Gm-Message-State: AOAM530OMEL5HUJZ//L+tEjjOMw1GLIF22NywPWhWVe2zRHt8xAhUM5A
        E1Fydof9UoXE6gTZ5pH9gHfXOvP9LVOKlGeyt0tqQRd/lMr+GuX2iG6+IPlUkRKlN7YHohYl9qZ
        DDY7td2jiBDYGFOE1TteI9A==
X-Received: by 2002:a5d:59ac:: with SMTP id p12mr14401731wrr.372.1625478119419;
        Mon, 05 Jul 2021 02:41:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwROn59GNG7B7qUvOnlsTSj0bjCriNcmIjYmQhXrt9GtxEi3rru9PFkq9tYjW1KOwe9du/eQg==
X-Received: by 2002:a5d:59ac:: with SMTP id p12mr14401716wrr.372.1625478119214;
        Mon, 05 Jul 2021 02:41:59 -0700 (PDT)
Received: from thuth.remote.csb (pd9575e1e.dip0.t-ipconnect.de. [217.87.94.30])
        by smtp.gmail.com with ESMTPSA id b20sm12203150wmj.7.2021.07.05.02.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 02:41:58 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 3/5] lib: s390x: uv: Int type cleanup
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210629133322.19193-1-frankja@linux.ibm.com>
 <20210629133322.19193-4-frankja@linux.ibm.com>
 <d2798bf7-3018-e311-1dfb-120144fb343d@redhat.com>
 <3876955c-24bd-2052-e634-8436f7558df4@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <b06633be-3832-7a07-37c3-1beaecd2202a@redhat.com>
Date:   Mon, 5 Jul 2021 11:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3876955c-24bd-2052-e634-8436f7558df4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/07/2021 11.33, Janosch Frank wrote:
> On 7/4/21 9:51 AM, Thomas Huth wrote:
>> On 29/06/2021 15.33, Janosch Frank wrote:
>>> These structs have largely been copied from the kernel so they still
>>> have the old uint short types which we want to avoid in favor of the
>>> uint*_t ones.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    lib/s390x/asm/uv.h | 142 +++++++++++++++++++++++----------------------
>>>    1 file changed, 72 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
>>> index dc3e02d..96a2a7e 100644
>>> --- a/lib/s390x/asm/uv.h
>>> +++ b/lib/s390x/asm/uv.h
>>> @@ -12,6 +12,8 @@
>>>    #ifndef _ASMS390X_UV_H_
>>>    #define _ASMS390X_UV_H_
>>>    
>>> +#include <stdint.h>
>>> +
>>>    #define UVC_RC_EXECUTED		0x0001
>>>    #define UVC_RC_INV_CMD		0x0002
>>>    #define UVC_RC_INV_STATE	0x0003
>>> @@ -68,73 +70,73 @@ enum uv_cmds_inst {
>>>    };
>>>    
>>>    struct uv_cb_header {
>>> -	u16 len;
>>> -	u16 cmd;	/* Command Code */
>>> -	u16 rc;		/* Response Code */
>>> -	u16 rrc;	/* Return Reason Code */
>>> +	uint16_t len;
>>> +	uint16_t cmd;	/* Command Code */
>>> +	uint16_t rc;	/* Response Code */
>>> +	uint16_t rrc;	/* Return Reason Code */
>>>    } __attribute__((packed))  __attribute__((aligned(8)));
>>
>> Hmm, for files that are more or less a copy from the corresponding kernel
>> header, I'm not sure whether it makes sense to convert them to the stdint.h
>> types? It might be better to keep the kernel types so that updates to this
>> header can be ported more easily to the kvm-unit-tests later?
> 
> sie.h contents are 90% sblk which came directly from KVM...
> Do you really want to have exceptions for one file? Because if that's
> the case then I see no sense in changing other things over since I
> prefer using short types.

Completely inaccurate checks with the lib directory of the kvm-unit-tests:

$ grep -r u64 lib/ | wc -l
234
$ grep -r uint64 lib/ | wc -l
245

$ grep -r u8 lib/ | wc -l
137
$ grep -r uint8 lib/ | wc -l
193

... I guess that's an indication that we do not really have a prevailing 
style here?
I personally prefer the stdint.h types, I'm just not sure whether it makes 
sense to keep some headers close to the kernel or not...?

  Thomas


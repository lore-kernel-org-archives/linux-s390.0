Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A69EB64DD
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 16:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjFWQEU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjFWQES (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 12:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA362718
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687536212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGvZEb4xaeTCLlMZCHf/6JLvoihCjh5MngBavGT5bMs=;
        b=hebThoFVssVWal5BmTqgX2CadqGwV5AYWB94KAYQfy6yeRKZNk3oXOgKQUXxRJRIBero0I
        vPj60snqmHpkRWhlndrAunUD9QzaPj3kpznAESLU6l4aCzfdaMj4wul+y/0JXKif4GUMal
        polxFw6Bf08hipuy0fCtqsIBST60LDk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-V6gpTPlvPEClq6-Oq7VtNg-1; Fri, 23 Jun 2023 12:03:28 -0400
X-MC-Unique: V6gpTPlvPEClq6-Oq7VtNg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f864ca6243so618689e87.0
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 09:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536207; x=1690128207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGvZEb4xaeTCLlMZCHf/6JLvoihCjh5MngBavGT5bMs=;
        b=UTGIzG/fk3Xt+XdU/dhNUtaLwHn4DhIhmhKQI8PWNITZj6xpaB+mnbmV+WSwmP7lUv
         qz9iDY7NlPaQ/95AO8H4JemJZIzsA04AR9W2aTxky36TCuftINjP/ZzJLcwfbV4x+aV+
         XnXHNHgXXDgupA+ZyY7JR2h6L6Dk6rnW/L50EaEoLQXCFrS6CPCO6cTffO6tK9KNAd/Q
         3Mx6t4ZZ3KU7p1+DmbvDVsGkjmpAZXFzR1JLkOdrL2FAA1tjhLNmJStcD0Umou31YVhd
         /S3US1RB6u+6CS3BkbGuSwYLUmp5NaFosIKaJpvAE64zGqHODig2HB3IU+YSMjtQ3Fwa
         QYnA==
X-Gm-Message-State: AC+VfDx650866q21w/myvisLdPaCg1oLdTc8T6CTI7FN0j0USVDKot+k
        5XHKhOJh4b0zDOeNLZRsDI995bsS2cvn3QDaFBy9z1xa97r3snB0rBKERC1HLr4uycYDqla2XYa
        B5gvHW7xF0M8c96XyMK/eLQ==
X-Received: by 2002:a19:6601:0:b0:4f6:6037:128e with SMTP id a1-20020a196601000000b004f66037128emr13950323lfc.57.1687536207038;
        Fri, 23 Jun 2023 09:03:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FhNowTVfmy0Vku7MNzLc5bMuiBYL6uHFIN/glgac8uc/9qkhgwWZMHcPVOfP2JGnHjumDqA==
X-Received: by 2002:a19:6601:0:b0:4f6:6037:128e with SMTP id a1-20020a196601000000b004f66037128emr13950297lfc.57.1687536206687;
        Fri, 23 Jun 2023 09:03:26 -0700 (PDT)
Received: from [192.168.8.100] (tmo-099-170.customers.d1-online.com. [80.187.99.170])
        by smtp.gmail.com with ESMTPSA id f2-20020a056402004200b0051bde3e1e48sm3461571edu.96.2023.06.23.09.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:03:25 -0700 (PDT)
Message-ID: <fc70263c-b7af-d8e0-14f4-4ffcde67aa3e@redhat.com>
Date:   Fri, 23 Jun 2023 18:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [kvm-unit-tests PATCH 2/2] Link with "-z noexecstack" to avoid
 warning from newer versions of ld
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Nico_B=c3=b6hr?= <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Andrew Jones <andrew.jones@linux.dev>, kvmarm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
References: <20230623125416.481755-1-thuth@redhat.com>
 <20230623125416.481755-3-thuth@redhat.com> <ZJWrKtnflTrskPkX@google.com>
Content-Language: en-US
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZJWrKtnflTrskPkX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23/06/2023 16.24, Sean Christopherson wrote:
> On Fri, Jun 23, 2023, Thomas Huth wrote:
>> Newer versions of ld (from binutils 2.40) complain on s390x and x86:
>>
>>   ld: warning: s390x/cpu.o: missing .note.GNU-stack section implies
>>                executable stack
>>   ld: NOTE: This behaviour is deprecated and will be removed in a
>>             future version of the linker
>>
>> We can silence these warnings by using "-z noexecstack" for linking
>> (which should not have any real influence on the kvm-unit-tests since
>> the information from the ELF header is not used here anyway, so it's
>> just cosmetics).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 0e5d85a1..20f7137c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -96,7 +96,7 @@ CFLAGS += -Woverride-init -Wmissing-prototypes -Wstrict-prototypes
>>   
>>   autodepend-flags = -MMD -MF $(dir $*).$(notdir $*).d
>>   
>> -LDFLAGS += -nostdlib
>> +LDFLAGS += -nostdlib -z noexecstack
> 
> Drat, the pull request[1] I sent to Paolo yesterday only fixes x86[2].

Oops, sorry, I did not notice that patch in my overcrowded mailboxes (or 
forgot about it during KVM forum...) :-/

> Paolo, want me to redo the pull request to drop the x86-specific patch?

I can also respin my patch on top of your series later ... the problem 
currently also only seems to happen on x86 and s390x, on ppc64 and aarch64, 
the linker does not complain ... so maybe it's even better to do it 
per-architecture only anyway? Opinions?

  Thomas


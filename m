Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DDEC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC77160E0B
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 15:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhJLPZs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237199AbhJLPZs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 11:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634052226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUNWsEMCH8AQRm4enH3NW07bbyVW1h00f08YvKhGAyg=;
        b=SnKM26b5/AOndYeKdh09NO8qIOWt29ilY5gQyCwY5FIpUTBGCd5qX9mjKdhF3CmrtcRdFa
        v6WmFZly8kEgjFmEpjFmMgNA/bFy/Cgk7UkSrj5heTEmQcKytk61AweJQ3H89Ls7KUr2HR
        SGOKhNs+1DgzJPl1fZfdofclBCrQO4A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-8rKelA4_Mlulw5GunmJjMg-1; Tue, 12 Oct 2021 11:23:45 -0400
X-MC-Unique: 8rKelA4_Mlulw5GunmJjMg-1
Received: by mail-ed1-f69.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so224799edi.12
        for <linux-s390@vger.kernel.org>; Tue, 12 Oct 2021 08:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUNWsEMCH8AQRm4enH3NW07bbyVW1h00f08YvKhGAyg=;
        b=E8TIpeequViNzQEWpwuuCH8q9ULqSLgMJul2ArOGfBYqFUS/sGLpypVI7VSxpdFjer
         IIGtkasmwOIvAYgTZZb5xucKN1uoaZEIhU38soy0//+0aIreir3wyaAYqIjFJdzKtGFN
         bXaGB5BBCVB1Jf4oQTAXuvVIgYTSJTtK4d8oF4trtPqXz6oazxirmcTlNzO51cQjnrK4
         r9Mwf6hmbAMW4octJ68HHRwmxCWWWwEwnaqc6WuNxEhhUEI3s5LlkbID25VmYon/pqiN
         zW1PZw13c84Q99F4ZgW2GYGgod1cZQ819l6WKyRSHS6uJpmXVPI4xaWc3sca6RrAoRm1
         +lOQ==
X-Gm-Message-State: AOAM532gXZf1ks+9eDOL3Nqrs/ayjbkyrjpwUbX4FasAB5x8QFX36Rqs
        cxFd5QQ4e/DP+ljVi15ANOO5kh3ABmBBKmoazYGMB85gaW91p0+hLaU7EysmnW73Sly6WP0Ln/8
        UNIguDx0Z7bhlTFTZqK+j6jtxtPkeg8+sYRCjgUdrwpKhXhbabmgf3o1XeI4W7xX7iPBeSA==
X-Received: by 2002:a17:906:3715:: with SMTP id d21mr34461715ejc.74.1634052223320;
        Tue, 12 Oct 2021 08:23:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2IP3i0/aLOUBHHi766a0SooVDmZqczi9FDL+1qQrvgNcNOHniwukHlu2O6vUWWqh6v+8Vjg==
X-Received: by 2002:a17:906:3715:: with SMTP id d21mr34461685ejc.74.1634052223079;
        Tue, 12 Oct 2021 08:23:43 -0700 (PDT)
Received: from thuth.remote.csb (p54886540.dip0.t-ipconnect.de. [84.136.101.64])
        by smtp.gmail.com with ESMTPSA id a9sm5926809edr.96.2021.10.12.08.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 08:23:42 -0700 (PDT)
Subject: Re: [RFC PATCH v1 3/6] KVM: s390: Simplify SIGP Restart
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20211008203112.1979843-1-farman@linux.ibm.com>
 <20211008203112.1979843-4-farman@linux.ibm.com>
 <e3b874c1-e220-5e23-bd67-ed08c261e425@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <518fea79-1579-ee4a-c09b-ae4e70e32d96@redhat.com>
Date:   Tue, 12 Oct 2021 17:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e3b874c1-e220-5e23-bd67-ed08c261e425@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/10/2021 09.45, Christian Borntraeger wrote:
> 
> 
> Am 08.10.21 um 22:31 schrieb Eric Farman:
>> Now that we check for the STOP IRQ injection at the top of the SIGP
>> handler (before the userspace/kernelspace check), we don't need to do
>> it down here for the Restart order.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   arch/s390/kvm/sigp.c | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
>> index 6ca01bbc72cf..0c08927ca7c9 100644
>> --- a/arch/s390/kvm/sigp.c
>> +++ b/arch/s390/kvm/sigp.c
>> @@ -240,17 +240,8 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu,
>>   static int __prepare_sigp_re_start(struct kvm_vcpu *vcpu,
>>                      struct kvm_vcpu *dst_vcpu, u8 order_code)
>>   {
>> -    struct kvm_s390_local_interrupt *li = &dst_vcpu->arch.local_int;
>>       /* handle (RE)START in user space */
>> -    int rc = -EOPNOTSUPP;
>> -
>> -    /* make sure we don't race with STOP irq injection */
>> -    spin_lock(&li->lock);
>> -    if (kvm_s390_is_stop_irq_pending(dst_vcpu))
>> -        rc = SIGP_CC_BUSY;
>> -    spin_unlock(&li->lock);
>> -
>> -    return rc;
>> +    return -EOPNOTSUPP;
>>   }
>>   static int __prepare_sigp_cpu_reset(struct kvm_vcpu *vcpu,
>>
> 
> @thuth?
> Question is, does it make sense to merge patch 2 and 3 to make things more 
> obvious?

Maybe.

Anyway: Would it make sense to remove __prepare_sigp_re_start() completely 
now and let __prepare_sigp_unknown() set the return code in the "default:" case?

  Thomas


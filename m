Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86FDC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 07:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CD360EE5
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 07:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhJKHy2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234570AbhJKHyW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Oct 2021 03:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633938742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDSPdEvNFrtvXVynwwZmj5xA3ZQVo02k+z/8ezjUWqU=;
        b=BsfxfYAFbK7lpdgRdzXlxjw2DvjbnDr+kcoAXPzM3l1Qjy3jj6DxeeXEcNN9ywcjWMrSls
        DtH4cUs1qpY9ExvvKkB4xo06iv6SE6q257wDV2/zReeyWVhS8JGMXR8jG3wqJcRDG/CY/P
        P1LgJE6KoEBHWoDCl/6Xg2ubA/ulD/4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-2GaXwj_UPMa0at0pOmg1AQ-1; Mon, 11 Oct 2021 03:52:21 -0400
X-MC-Unique: 2GaXwj_UPMa0at0pOmg1AQ-1
Received: by mail-wr1-f71.google.com with SMTP id 10-20020a5d47aa000000b001610cbda93dso1371600wrb.23
        for <linux-s390@vger.kernel.org>; Mon, 11 Oct 2021 00:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qDSPdEvNFrtvXVynwwZmj5xA3ZQVo02k+z/8ezjUWqU=;
        b=KPFpxgzJ06PldW1xxiaFCWn2IulXAR8TP74QuCVb7kySJKpq1gSCipDsRUXRfl3Pa0
         7EnyB26GuzzBYOGwMT5cBg4gwBQQ9GU6jXeOyb6Km5nLr9GzSMOeQubGKIJnMV+sozRY
         w8gow4CUWLJS+8k5c0VCXeLWoAyiMNd4onHEEAF2FqktuOMa9SutgGQBvWgRkosE8zWn
         83Q74D5bgEYtVMD0WwJoWUOalXbD9rBsjpjhQifoHI9I/0hoN2gCtyMrs2qUKJTdqFsI
         aV4nI1+cyHG0RJcog2ncxiVHN1RqqUvrX33V2sY+ichV06vMUw2Ur1PDNFgOggNzfliv
         7ASA==
X-Gm-Message-State: AOAM531xPs/01MMC/wuUgR45a30MRPsxqbMBwA+E9BzEErOsuBIEmUTW
        duwUBJa/9uvQlKKpu1JslO3YntG4na880Qg8IbKRcPmstArQlR10o2u5xAwc2xHSfaT1dCRYkl/
        Q5ntjJP2QmT7/0u3dk8kKISb9Fi8Pt+FENqGLvzuWelEB2zIVGwZuA1x0O1B5q5Cl71Ruag==
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr22794270wru.250.1633938740221;
        Mon, 11 Oct 2021 00:52:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGRX0Q2kcOA5l8aMvnHGWsEXHQj14Vc+t/nVjIu/sKbYFxVASb4QOTUSSJLgsKMrbXZbRUBg==
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr22794232wru.250.1633938739862;
        Mon, 11 Oct 2021 00:52:19 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k8sm7251059wmr.32.2021.10.11.00.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 00:52:19 -0700 (PDT)
Subject: Re: [RFC PATCH v1 2/6] KVM: s390: Reject SIGP when destination CPU is
 busy
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
 <20211008203112.1979843-3-farman@linux.ibm.com>
 <4c6c0b14-e148-9000-c581-db14d2ea555e@redhat.com>
 <8d8012a8-6ea5-6e0e-19c4-d9c64e785222@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <bddd3a05-b364-7b52-f329-11a07146394e@redhat.com>
Date:   Mon, 11 Oct 2021 09:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8d8012a8-6ea5-6e0e-19c4-d9c64e785222@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/10/2021 09.43, Christian Borntraeger wrote:
> Am 11.10.21 um 09:27 schrieb Thomas Huth:
>> On 08/10/2021 22.31, Eric Farman wrote:
>>> With KVM_CAP_USER_SIGP enabled, most orders are handled by userspace.
>>> However, some orders (such as STOP or STOP AND STORE STATUS) end up
>>> injecting work back into the kernel. Userspace itself should (and QEMU
>>> does) look for this conflict, and reject additional (non-reset) orders
>>> until this work completes.
>>>
>>> But there's no need to delay that. If the kernel knows about the STOP
>>> IRQ that is in process, the newly-requested SIGP order can be rejected
>>> with a BUSY condition right up front.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>   arch/s390/kvm/sigp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 43 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
>>> index cf4de80bd541..6ca01bbc72cf 100644
>>> --- a/arch/s390/kvm/sigp.c
>>> +++ b/arch/s390/kvm/sigp.c
>>> @@ -394,6 +394,45 @@ static int handle_sigp_order_in_user_space(struct 
>>> kvm_vcpu *vcpu, u8 order_code,
>>>       return 1;
>>>   }
>>> +static int handle_sigp_order_is_blocked(struct kvm_vcpu *vcpu, u8 
>>> order_code,
>>> +                    u16 cpu_addr)
>>> +{
>>> +    struct kvm_vcpu *dst_vcpu = kvm_get_vcpu_by_id(vcpu->kvm, cpu_addr);
>>> +    int rc = 0;
>>> +
>>> +    /*
>>> +     * SIGP orders directed at invalid vcpus are not blocking,
>>> +     * and should not return busy here. The code that handles
>>> +     * the actual SIGP order will generate the "not operational"
>>> +     * response for such a vcpu.
>>> +     */
>>> +    if (!dst_vcpu)
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * SIGP orders that process a flavor of reset would not be
>>> +     * blocked through another SIGP on the destination CPU.
>>> +     */
>>> +    if (order_code == SIGP_CPU_RESET ||
>>> +        order_code == SIGP_INITIAL_CPU_RESET)
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * Any other SIGP order could race with an existing SIGP order
>>> +     * on the destination CPU, and thus encounter a busy condition
>>> +     * on the CPU processing the SIGP order. Reject the order at
>>> +     * this point, rather than racing with the STOP IRQ injection.
>>> +     */
>>> +    spin_lock(&dst_vcpu->arch.local_int.lock);
>>> +    if (kvm_s390_is_stop_irq_pending(dst_vcpu)) {
>>> +        kvm_s390_set_psw_cc(vcpu, SIGP_CC_BUSY);
>>> +        rc = 1;
>>> +    }
>>> +    spin_unlock(&dst_vcpu->arch.local_int.lock);
>>> +
>>> +    return rc;
>>> +}
>>> +
>>>   int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
>>>   {
>>>       int r1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
>>> @@ -408,6 +447,10 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
>>>           return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>>>       order_code = kvm_s390_get_base_disp_rs(vcpu, NULL);
>>> +
>>> +    if (handle_sigp_order_is_blocked(vcpu, order_code, cpu_addr))
>>> +        return 0;
>>> +
>>>       if (handle_sigp_order_in_user_space(vcpu, order_code, cpu_addr))
>>>           return -EOPNOTSUPP;
>>
>> We've been bitten quite a bit of times in the past already by doing too 
>> much control logic in the kernel instead of doing it in QEMU, where we 
>> should have a more complete view of the state ... so I'm feeling quite a 
>> bit uneasy of adding this in front of the "return -EOPNOTSUPP" here ... 
>> Did you see any performance issues that would justify this change?
> 
> It does at least handle this case for simple userspaces without 
> KVM_CAP_S390_USER_SIGP .

For that case, I'd prefer to swap the order here by doing the "if 
handle_sigp_order_in_user_space return -EOPNOTSUPP" first, and doing the "if 
handle_sigp_order_is_blocked return 0" afterwards.

... unless we feel really, really sure that it always ok to do it like in 
this patch ... but as I said, we've been bitten by such things a couple of 
times already, so I'd suggest to better play safe...

  Thomas


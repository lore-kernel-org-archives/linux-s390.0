Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1611AC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DF360EFE
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 07:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhJKHd7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234484AbhJKHd5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Oct 2021 03:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633937517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a210ckzQm4JqYYBLhKsiHngtpgbwX0XEROzyJlo7jpM=;
        b=Y3Pxqc5eo07JWd33KGsv0SUmHna/wzlfkgzGU5HTI2VJl3yDfVN77oZpj9TzDDJc7udff5
        VH8lBzAWxh7oBQRQV4eOBuEusNC5e1H/9ysBmBq02iguxSygsJqaZX3yIRWx6rdj2iYze+
        9Hndae3WhKIHQHdOe8tQgxr6kUC8guk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-o1Cu-XIkMHaZFnwA-OYqwg-1; Mon, 11 Oct 2021 03:31:55 -0400
X-MC-Unique: o1Cu-XIkMHaZFnwA-OYqwg-1
Received: by mail-wr1-f69.google.com with SMTP id r16-20020adfb1d0000000b00160bf8972ceso12532316wra.13
        for <linux-s390@vger.kernel.org>; Mon, 11 Oct 2021 00:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a210ckzQm4JqYYBLhKsiHngtpgbwX0XEROzyJlo7jpM=;
        b=zEvNWal6SRAn8ayEkunlSvKmMlRuqWJ/9YiGHMHJ53qa8oRld3GkqeB4gi8PYLj9qF
         /rxAKuFNr9Ww7Ray+mxhLE+PpC/jgV21nRHetUiSB/P53q/TR7+V+gMhMQkHkdRJE7WR
         m8xpmrf/h44I6CX6PEzwCqHbTvLMNdeB/d7fh078acnyOvlitsXPnR2ZY/Z+9+Xr3Jmp
         E4fhjdLcbZYWy4FNRtD633QoDQioKg9WzP8WjL7+NiqFKfWphraiGvmB/gID+qjGjVzE
         PqpsEo9aZJAAlv9A6es9Gw5SNJG309HgHhrP+9ecSFtUCT5aqgu3gybtBkOyAkaSWqBt
         N5AA==
X-Gm-Message-State: AOAM531f/ci1bYclZVJbvcPd5UIxAegvGzxbPnGjjOkBVQu87aeiX1jn
        z06nrC1vxXYn7W8prOB30jNfC8VHLnbTTq2nlrJ4BxhOpr7clPJQSQtAWRAbELJkYqLZiCqnQ52
        Pm3rSEEzQloieNnNgvbJ0/iF+3xaXKQ85+DRhbP2KuW9oQIRetyWmLQFAsh243w+dyrDx/w==
X-Received: by 2002:a1c:f201:: with SMTP id s1mr19273226wmc.101.1633937514777;
        Mon, 11 Oct 2021 00:31:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0c1SsMWT1kdbkWnjImvHpEkjZjpFpHfh+uoDJO5Bt7abuD+iUkEvXNytiunZjBlS2SLg8TA==
X-Received: by 2002:a1c:f201:: with SMTP id s1mr19273206wmc.101.1633937514543;
        Mon, 11 Oct 2021 00:31:54 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k8sm7201014wmr.32.2021.10.11.00.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 00:31:54 -0700 (PDT)
Subject: Re: [RFC PATCH v1 6/6] KVM: s390: Add a routine for setting userspace
 CPU state
To:     Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20211008203112.1979843-1-farman@linux.ibm.com>
 <20211008203112.1979843-7-farman@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <ed462de1-47c7-695e-b958-6b5de6119a1d@redhat.com>
Date:   Mon, 11 Oct 2021 09:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008203112.1979843-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08/10/2021 22.31, Eric Farman wrote:
> This capability exists, but we don't record anything when userspace
> enables it. Let's refactor that code so that a note can be made in
> the debug logs that it was enabled.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 6 +++---
>   arch/s390/kvm/kvm-s390.h | 9 +++++++++
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 33d71fa42d68..48ac0bd05bee 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2487,8 +2487,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
>   	case KVM_S390_PV_COMMAND: {
>   		struct kvm_pv_cmd args;
>   
> -		/* protvirt means user sigp */
> -		kvm->arch.user_cpu_state_ctrl = 1;
> +		/* protvirt means user cpu state */
> +		kvm_s390_set_user_cpu_state_ctrl(kvm);
>   		r = 0;
>   		if (!is_prot_virt_host()) {
>   			r = -EINVAL;
> @@ -3801,7 +3801,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>   	vcpu_load(vcpu);
>   
>   	/* user space knows about this interface - let it control the state */
> -	vcpu->kvm->arch.user_cpu_state_ctrl = 1;
> +	kvm_s390_set_user_cpu_state_ctrl(vcpu->kvm);
>   
>   	switch (mp_state->mp_state) {
>   	case KVM_MP_STATE_STOPPED:
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 57c5e9369d65..36f4d585513c 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -208,6 +208,15 @@ static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
>   	return kvm->arch.user_cpu_state_ctrl != 0;
>   }
>   
> +static inline void kvm_s390_set_user_cpu_state_ctrl(struct kvm *kvm)
> +{
> +	if (kvm->arch.user_cpu_state_ctrl)
> +		return;
> +
> +	VM_EVENT(kvm, 3, "%s", "ENABLE: Userspace CPU state control");
> +	kvm->arch.user_cpu_state_ctrl = 1;
> +}
> +
>   /* implemented in pv.c */
>   int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc);
>   int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


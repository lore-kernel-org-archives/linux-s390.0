Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE67C47E48
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 08:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4F261358
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 08:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhGOIyC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240579AbhGOIyB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 04:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626339068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e2SYtP9pCzJ8Qy+YABmhjYddUS5OjmPwYSSqvCJPec=;
        b=ERsjy6rQ+JRgKTNncjgMpYpyzVhYY279WILoE1PSqxe8EuQoynxqNByFsoYj8wQlXBdFOL
        huYFyDFdjUwSKvvPeNhs6npYe8MRE29SDIBMscrvAzhn3XgKZ9xsaKNtcsEX9PGkxmK//a
        og/OQrlz7nETIHApiwfP5rF0kW7wD0I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-vyr9MGT0PKyyUpEZfrLDUQ-1; Thu, 15 Jul 2021 04:51:07 -0400
X-MC-Unique: vyr9MGT0PKyyUpEZfrLDUQ-1
Received: by mail-wr1-f71.google.com with SMTP id h11-20020adffa8b0000b029013a357d7bdcso2980210wrr.18
        for <linux-s390@vger.kernel.org>; Thu, 15 Jul 2021 01:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5e2SYtP9pCzJ8Qy+YABmhjYddUS5OjmPwYSSqvCJPec=;
        b=lebonPrf/xyqeZHJbfAGXB9znT/TV+ZENiPaSqqdN+MqxB5WPikK9m7A854XjPTBs7
         Sgi8vmqgBMdY+zs4fozQFu/NnR17X+xmNUJDNNJigdx6rkoK5qPPiejEhHRpNumOYjhe
         ASlv1BWA/MhFyGuKws3syuQshV9MSXmzlkkqLt7RakfSz1cpTjw92LFLtjI9pZ3xxP+S
         uPDEt0nBiLk7ztWe4mGc52BDYoy2jYGOfCcpUMfHO4mewnrsUG7r6F+5LhO48r203t7U
         SLgd5BE/G8QyuQU/8KScyrplcNaKf01pGPfaaQroueYXuQiyHqDnyBk3bP+mvj17PJj1
         UJlQ==
X-Gm-Message-State: AOAM532TeQ+pr4q4VEBM0bZl/blW6Kuv3plsf4p3Jff2TO3yjfm0+FEK
        ryfsRkeFamWWdt8MKpT6ijvTaPbO7EXeXLfkWGKE63ybVRIfLTFz7Lj6sFCR5ENP9A5q+v3PUNH
        B5mhcaBoQWlGRhZIaa6iuKQ==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr3309655wma.35.1626339065614;
        Thu, 15 Jul 2021 01:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAULp1ZdUpcwNXdKv+9+BK62W58TpdaA3VxBgJb3SfB4IKVgFfmUXt1itxFS+IB/Mb7fDGAQ==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr3309617wma.35.1626339065284;
        Thu, 15 Jul 2021 01:51:05 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
        by smtp.gmail.com with ESMTPSA id e15sm5515474wrp.29.2021.07.15.01.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:51:04 -0700 (PDT)
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
References: <1626276343-22805-1-git-send-email-pmorel@linux.ibm.com>
 <1626276343-22805-2-git-send-email-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/2] s390x: KVM: accept STSI for CPU topology
 information
Message-ID: <db788a8c-99a9-6d99-07ab-b49e953d91a2@redhat.com>
Date:   Thu, 15 Jul 2021 10:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626276343-22805-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14.07.21 17:25, Pierre Morel wrote:
> STSI(15.1.x) gives information on the CPU configuration topology.
> Let's accept the interception of STSI with the function code 15 and
> let the userland part of the hypervisor handle it.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/kvm/priv.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c677..4ab5f8b7780e 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -856,7 +856,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>   	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>   		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>   
> -	if (fc > 3) {
> +	if (fc > 3 && fc != 15) {
>   		kvm_s390_set_psw_cc(vcpu, 3);
>   		return 0;
>   	}
> @@ -893,6 +893,15 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>   			goto out_no_data;
>   		handle_stsi_3_2_2(vcpu, (void *) mem);
>   		break;
> +	case 15:
> +		if (sel1 != 1 || sel2 < 2 || sel2 > 6)
> +			goto out_no_data;
> +		if (vcpu->kvm->arch.user_stsi) {
> +			insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
> +			return -EREMOTE;
> +		}
> +		kvm_s390_set_psw_cc(vcpu, 3);
> +		return 0;
>   	}
>   	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
>   		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
> 

1. Setting GPRS to 0

I was wondering why we have the "vcpu->run->s.regs.gprs[0] = 0;"
for existing fc 1,2,3 in case we set cc=0.

Looking at the doc, all I find is:

"CC 0: Requested configuration-level number placed in
general register 0 or requested SYSIB informa-
tion stored"

But I don't find where it states that we are supposed to set
general register 0 to 0. Wouldn't we also have to do it for
fc=15 or for none?

If fc 1,2,3 and 15 are to be handled equally, I suggest the following:

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9928f785c677..6eb86fa58b0b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -893,17 +893,23 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
                         goto out_no_data;
                 handle_stsi_3_2_2(vcpu, (void *) mem);
                 break;
+       case 15:
+               if (sel1 != 1 || sel2 < 2 || sel2 > 6)
+                       goto out_no_data;
+               break;
         }
-       if (kvm_s390_pv_cpu_is_protected(vcpu)) {
-               memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
-                      PAGE_SIZE);
-               rc = 0;
-       } else {
-               rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
-       }
-       if (rc) {
-               rc = kvm_s390_inject_prog_cond(vcpu, rc);
-               goto out;
+       if (mem) {
+               if (kvm_s390_pv_cpu_is_protected(vcpu)) {
+                       memcpy((void *)sida_origin(vcpu->arch.sie_block),
+                              (void *)mem, PAGE_SIZE);
+               } else {
+                       rc = write_guest(vcpu, operand2, ar, (void *)mem,
+                                        PAGE_SIZE);
+                       if (rc) {
+                               rc = kvm_s390_inject_prog_cond(vcpu, rc);
+                               goto out;
+                       }
+               }
         }
         if (vcpu->kvm->arch.user_stsi) {
                 insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);


2. maximum-MNest facility

"
1. If the maximum-MNest facility is installed and
selector 2 exceeds the nonzero model-depen-
dent maximum-selector-2 value."

2. If the maximum-MNest facility is not installed and
selector 2 is not specified as two.
"

We will we be handling the presence/absence of the maximum-MNest facility
(for our guest?) in QEMU, corect?

I do wonder if we should just let any fc=15 go to user space let the whole
sel1 / sel2 checking be handled there. I don't think it's a fast path after all.
But no strong opinion.

How do we identify availability of maximum-MNest facility?


3. User space awareness

How can user space identify that we actually forward these intercepts?
How can it enable them? The old KVM_CAP_S390_USER_STSI capability
is not sufficient.

I do wonder if we want KVM_CAP_S390_USER_STSI_15 or sth like that to change
the behavior once enabled by user space.


4. Without vcpu->kvm->arch.user_stsi, we indicate cc=0 to our guest,
also for fc 1,2,3. Is that actually what we want? (or do we simply not care
because the guest is not supposed to use stsi?)

-- 
Thanks,

David / dhildenb


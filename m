Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95588C001DE
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 08:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjGXI2a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGXI2X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 04:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357C9133
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690187252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95yU/Tppmz3W6Wgx0aprDygFp+YkQiriuNqIdtc06vU=;
        b=Zak7PIYysqo4CaAQ7yW4R2bzNbHNS8dySIakA54msKMcwjk+yxN4CuSaTIbTWJkSE1h5YP
        RV5R5WwR3N2NnQAzYj7j0DTm9ryADz6pvNrFMP+JT5uMmEyn2wSZ8KJRcySXHMnFd9nerC
        N5Uf6bwQb68LJHTZcC66dezJz3Xt1wU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-J_5CRBTBM1SKgu0-mLZ2tQ-1; Mon, 24 Jul 2023 04:27:30 -0400
X-MC-Unique: J_5CRBTBM1SKgu0-mLZ2tQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fdde27470aso3250839e87.2
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187249; x=1690792049;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95yU/Tppmz3W6Wgx0aprDygFp+YkQiriuNqIdtc06vU=;
        b=Xh0GiHzaHQPvtvoNwmfu6YF7eZLWfRBlC9uNUhZX/LUOGW1gUReZFx0+npShV2eHPw
         MMH6aqFgCV9z0i7QAZaN20YhpPmhCUQqenN5Lwz1GbIOboX9gGzqXl3HPEBTSq7+x8Ir
         GNsQnoEf/xB1lbuzALTeqqX09JcORJLXZGUIki7hBxOMQ302BLK6ONJFhaSrxhVi+G+N
         A4gMLnRAROe83Le83EPmwcOcjYu5rvxES3mQxMzZNpfsF1cCgfIWboT6UsxPQrhJaCzV
         Z/ulvEN3OLlSqwpd7294GmB4cHn9kacVa5KTym7CslgVAreD705igM3mbULTglMsDPoO
         mALg==
X-Gm-Message-State: ABy/qLY4owSYf6r/qGmihhLzg/JkOqpLtWmMrR3Km9nM7TlRPQKQqQ2t
        rWszjdJiVe593e5phXWnuFRsGJbVZ5gub1q3JoOoa2Ymb9IStpApIzFyK8pgIs1vSFz7Vfq7iq+
        6c1PhPAiAe9Vg/HSRfcjXHw==
X-Received: by 2002:ac2:505c:0:b0:4f8:5604:4b50 with SMTP id a28-20020ac2505c000000b004f856044b50mr4339174lfm.64.1690187249271;
        Mon, 24 Jul 2023 01:27:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCEMOq1o4lei/ac0I0Ri//BOpQqln7ql1w8BcwesPNHuyuLe8cISemFtN93mHRCisihMVloA==
X-Received: by 2002:ac2:505c:0:b0:4f8:5604:4b50 with SMTP id a28-20020ac2505c000000b004f856044b50mr4339142lfm.64.1690187248874;
        Mon, 24 Jul 2023 01:27:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id s14-20020adfea8e000000b003143be36d99sm12106076wrm.58.2023.07.24.01.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:27:28 -0700 (PDT)
Message-ID: <c5944b74-db61-8383-cf15-13a9915ff7e5@redhat.com>
Date:   Mon, 24 Jul 2023 10:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/6] KVM: s390: interrupt: Fix single-stepping
 kernel-emulated instructions
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
References: <20230721120046.2262291-1-iii@linux.ibm.com>
 <20230721120046.2262291-4-iii@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230721120046.2262291-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21.07.23 13:57, Ilya Leoshkevich wrote:
> Single-stepping a kernel-emulated instruction that generates an
> interrupt causes GDB to land on the instruction following it instead of
> the respective interrupt handler.
> 
> The reason is that kvm_handle_sie_intercept(), after injecting the
> interrupt, also processes the PER event and arranges a KVM_SINGLESTEP
> exit. The interrupt is not yet delivered, however, so the userspace
> sees the next instruction.
> 
> Fix by avoiding the KVM_SINGLESTEP exit when there is a pending
> interrupt. The next __vcpu_run() loop iteration will arrange a
> KVM_SINGLESTEP exit after delivering the interrupt.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   arch/s390/kvm/intercept.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 7cdd927541b0..d2f7940c5d03 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -583,6 +583,19 @@ static int handle_pv_notification(struct kvm_vcpu *vcpu)
>   	return handle_instruction(vcpu);
>   }
>   
> +static bool should_handle_per_ifetch(const struct kvm_vcpu *vcpu, int rc)
> +{
> +	/* Process PER, also if the instruction is processed in user space. */
> +	if (!(vcpu->arch.sie_block->icptstatus & 0x02))
> +		return false;
> +	if (rc != 0 && rc != -EOPNOTSUPP)
> +		return false;
> +	if (guestdbg_sstep_enabled(vcpu) && vcpu->arch.local_int.pending_irqs)
> +		/* __vcpu_run() will exit after delivering the interrupt. */
> +		return false;
> +	return true;
> +}
> +
>   int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>   {
>   	int rc, per_rc = 0;
> @@ -645,9 +658,7 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* process PER, also if the instruction is processed in user space */
> -	if (vcpu->arch.sie_block->icptstatus & 0x02 &&
> -	    (!rc || rc == -EOPNOTSUPP))
> +	if (should_handle_per_ifetch(vcpu, rc))
>   		per_rc = kvm_s390_handle_per_ifetch_icpt(vcpu);
>   	return per_rc ? per_rc : rc;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


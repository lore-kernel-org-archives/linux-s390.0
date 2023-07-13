Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36612EB64DD
	for <linux-s390@archiver.kernel.org>; Thu, 13 Jul 2023 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGMH3O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjGMH3L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Jul 2023 03:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EF6C2
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689233305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30ZNaaFR/fjAYb5/oeSFvevjx8Dhisn2cnhujT75U2g=;
        b=QWnqhMkV/a7XVVsOguykQyw+ya1fk1bX/tv7yboWle5hzDNhuzbrQ3ajbSO5bD9f5e7Wg6
        52/1+jZGuaPNZZJ0K1nv+f8eqkeuKQjMGI0e9KE9sN9nmr2wVm6x92nL2XQmMAbVF/+xuu
        lyFR6zpYH/L4ZE4KTrbT0Y0Hlfl6dzQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-i53xvIxfPPWtyXePMpPiLg-1; Thu, 13 Jul 2023 03:28:23 -0400
X-MC-Unique: i53xvIxfPPWtyXePMpPiLg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7675581a4afso60194385a.1
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 00:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689233302; x=1691825302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30ZNaaFR/fjAYb5/oeSFvevjx8Dhisn2cnhujT75U2g=;
        b=L+1TQe5dxsk4R2BDWnk8ngII3EE+tLnpXL9VioE3MSIiReCfHx7ineInNpfnHi0bGP
         XxB+z+AjKxnJq0TLWWqao8RZTlpWB4sPTFpeEowoxSew4B2jmykH/ED6gowVD8S4D/zP
         4rGBaw5Q6UebMo6z3gghUvLKgXriA3AgKLlpYsFZKct/FBh8n6z1+3BUoGVr9sqpGrVg
         DbOuKlqd7LA9d8v9x40Yr7A5chnJiI2ceal/yLORK59Wn1PtFtUQq0htKz5k8pUn6Exw
         I50KZsG4pNUhZOhKr4k3nW5Ct8G9ufnchA8eT6YnCLxLQqkoR7BybVE4dhISe6xV48HU
         3ZCg==
X-Gm-Message-State: ABy/qLa2zz5djTcbE2wOAmRJreWn6cX+XHWp1iirFbDBCOZmOfLk3xZg
        grP42jNfO1PVytP85Yg6THfJkR3nm7ZeUYDCQ8HYTz/0ObEfVfF2H4PHFqt9cCqwwH3l3FA4PHM
        +C5bujxyf12tQjzdAGdAu8A==
X-Received: by 2002:a05:620a:2686:b0:767:797b:4115 with SMTP id c6-20020a05620a268600b00767797b4115mr745222qkp.60.1689233302655;
        Thu, 13 Jul 2023 00:28:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2gFzkOuSf4lYd58Pk8j/nNj/eJAjGLR+Rj/GXsfdUz61A/I2+7/B41jkUWsJ5AucgeoUorA==
X-Received: by 2002:a05:620a:2686:b0:767:797b:4115 with SMTP id c6-20020a05620a268600b00767797b4115mr745217qkp.60.1689233302412;
        Thu, 13 Jul 2023 00:28:22 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a140300b0075b13a89c30sm2712892qkj.3.2023.07.13.00.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:28:21 -0700 (PDT)
Message-ID: <3dbe3094-b796-6b78-a97f-130a82780421@redhat.com>
Date:   Thu, 13 Jul 2023 09:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [kvm-unit-tests PATCH v5 3/6] s390x: sie: switch to home space
 mode before entering SIE
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-4-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230712114149.1291580-4-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/07/2023 13.41, Nico Boehr wrote:
> This is to prepare for running guests without MSO/MSL, which is
> currently not possible.
> 
> We already have code in sie64a to setup a guest primary ASCE before
> entering SIE, so we can in theory switch to the page tables which
> translate gpa to hpa.
> 
> But the host is running in primary space mode already, so changing the
> primary ASCE before entering SIE will also affect the host's code and
> data.
> 
> To make this switch useful, the host should run in a different address
> space mode. Hence, set up and change to home address space mode before
> installing the guest ASCE.
> 
> The home space ASCE is just copied over from the primary space ASCE, so
> no functional change is intended, also for tests that want to use
> MSO/MSL. If a test intends to use a different primary space ASCE, it can
> now just set the guest.asce in the save_area.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h |  1 +
>   lib/s390x/sie.c          | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 53279572a9ee..65e1cf58c7e7 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -91,6 +91,7 @@ struct cpu {
>   #define AS_HOME				3
>   
>   #define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_HOME			0x0000C00000000000UL
>   #define PSW_MASK_IO			0x0200000000000000UL
>   #define PSW_MASK_EXT			0x0100000000000000UL
>   #define PSW_MASK_KEY			0x00F0000000000000UL
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> index 9241b4b4a512..ffa8ec91a423 100644
> --- a/lib/s390x/sie.c
> +++ b/lib/s390x/sie.c
> @@ -46,6 +46,8 @@ void sie_handle_validity(struct vm *vm)
>   
>   void sie(struct vm *vm)
>   {
> +	uint64_t old_cr13;
> +
>   	if (vm->sblk->sdf == 2)
>   		memcpy(vm->sblk->pv_grregs, vm->save_area.guest.grs,
>   		       sizeof(vm->save_area.guest.grs));
> @@ -53,6 +55,16 @@ void sie(struct vm *vm)
>   	/* Reset icptcode so we don't trip over it below */
>   	vm->sblk->icptcode = 0;
>   
> +	/* set up home address space to match primary space */
> +	old_cr13 = stctg(13);
> +	lctlg(13, stctg(1));
> +
> +	/* switch to home space so guest tables can be different from host */
> +	psw_mask_set_bits(PSW_MASK_HOME);
> +
> +	/* also handle all interruptions in home space while in SIE */
> +	irq_set_dat_mode(IRQ_DAT_ON, AS_HOME);
> +
>   	while (vm->sblk->icptcode == 0) {
>   		sie64a(vm->sblk, &vm->save_area);
>   		sie_handle_validity(vm);
> @@ -60,6 +72,12 @@ void sie(struct vm *vm)
>   	vm->save_area.guest.grs[14] = vm->sblk->gg14;
>   	vm->save_area.guest.grs[15] = vm->sblk->gg15;
>   
> +	irq_set_dat_mode(IRQ_DAT_ON, AS_PRIM);
> +	psw_mask_clear_bits(PSW_MASK_HOME);
> +
> +	/* restore the old CR 13 */
> +	lctlg(13, old_cr13);

Wouldn't it be better to always switch to HOME address mode directly in our 
startup code already (where we enable DAT)? Switching back and forth every 
time we enter SIE looks confusing to me ... or is there a reason why we 
should continue to run in primary address mode by default and only switch to 
home mode here?

  Thomas



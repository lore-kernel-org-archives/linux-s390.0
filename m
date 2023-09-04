Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E73C71153
	for <linux-s390@archiver.kernel.org>; Mon,  4 Sep 2023 10:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjIDKAn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Sep 2023 06:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjIDKAm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Sep 2023 06:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C231B5
        for <linux-s390@vger.kernel.org>; Mon,  4 Sep 2023 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693821574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gLQONe3A7A3zhpq2R2f2t/QPz1+qDDXvx06VKYHFco=;
        b=GTxicPdNtOoCNWUBEHaD+9dZVoAjtyQfJMWrJhL+DtLoO3DZCyfNCbhKM32t61rEmiYSWo
        ZzzT8eZhpxp0jNyPBp8wyz4D2ZbgkPDMKoEzqIt3zgQTktLnP34oSPqT6VOK/BbxwKttNq
        btBgx8Mgk2r1ZCZ2S3c+B4ROtdxOiDY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-1ATOShZfObyKQtL9KT5ZbQ-1; Mon, 04 Sep 2023 05:59:33 -0400
X-MC-Unique: 1ATOShZfObyKQtL9KT5ZbQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31c5cc3b512so648680f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 04 Sep 2023 02:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693821572; x=1694426372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gLQONe3A7A3zhpq2R2f2t/QPz1+qDDXvx06VKYHFco=;
        b=HJDVbfJ/f+Goi9z2l8yztvMuD51y/cI6mnCrGcPRBrTWxtWmoHXmyZp+JffSO91i9Z
         A8qZRy2Wd0AcupCRYsnsqk+MjX3kfzxdGKhmBTrhvprsBbqKNQC1Mvf49/Ifyl1/F+GO
         FK3MK4/FSDDviaInyStkOYz83P9Y9nHNK6O5JkQwExc2nfs+F9ub2I8m7iAknpbSHdsN
         w7SeEAaZrZhrR27cWoU9V7sj36SJP90hx33b0KA4TQpPHhM3ZspoQilep68dNVDcizyE
         P8C++UAe3eEJgY8KlHa2L15lfBEmilLApKms2fzggijMlOBVn7uAuR0LG2sOBzxreZfV
         zXJQ==
X-Gm-Message-State: AOJu0Yw76gNZErVBOQ5U8zhwwgnJ86orIPK3qSXfWPAyGvn4KNZd4n99
        p43DXnb2sgK5c68/elsKODsalrg60kWwYAu3o6jtx90Ch/ia+C03RFehG0jkifkGtEKvDh2bfKA
        qnSCaVhA3rOhcEPLv5+P1hw==
X-Received: by 2002:a5d:4803:0:b0:313:f5f8:a331 with SMTP id l3-20020a5d4803000000b00313f5f8a331mr5923391wrq.34.1693821572321;
        Mon, 04 Sep 2023 02:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaOZWp3NC9aQ89fp1eDlPRv2ilOOeQD7G7e3dFArroHsCUJ+caLPVVnJf4hSIVe9Nl9ly3vw==
X-Received: by 2002:a5d:4803:0:b0:313:f5f8:a331 with SMTP id l3-20020a5d4803000000b00313f5f8a331mr5923382wrq.34.1693821572032;
        Mon, 04 Sep 2023 02:59:32 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4012000000b0031c79de4d8bsm14060748wrp.106.2023.09.04.02.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:59:31 -0700 (PDT)
Message-ID: <e6b8a718-4c99-cd37-c73f-fcb604a67af4@redhat.com>
Date:   Mon, 4 Sep 2023 11:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [kvm-unit-tests PATCH v6 3/8] s390x: sie: switch to home space
 mode before entering SIE
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904082318.1465055-1-nrb@linux.ibm.com>
 <20230904082318.1465055-4-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230904082318.1465055-4-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/09/2023 10.22, Nico Boehr wrote:
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
>   lib/s390x/sie.c          | 26 ++++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 5638fd01fd85..90a178ca0351 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -93,6 +93,7 @@ enum address_space {
>   };
>   
>   #define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_HOME			0x0000C00000000000UL
>   #define PSW_MASK_IO			0x0200000000000000UL
>   #define PSW_MASK_EXT			0x0100000000000000UL
>   #define PSW_MASK_KEY			0x00F0000000000000UL
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> index b44febdeaaac..7f4474555ff7 100644
> --- a/lib/s390x/sie.c
> +++ b/lib/s390x/sie.c
> @@ -52,6 +52,8 @@ void sie_handle_validity(struct vm *vm)
>   
>   void sie(struct vm *vm)
>   {
> +	uint64_t old_cr13;
> +
>   	if (vm->sblk->sdf == 2)
>   		memcpy(vm->sblk->pv_grregs, vm->save_area.guest.grs,
>   		       sizeof(vm->save_area.guest.grs));
> @@ -59,6 +61,24 @@ void sie(struct vm *vm)
>   	/* Reset icptcode so we don't trip over it below */
>   	vm->sblk->icptcode = 0;
>   
> +	/*
> +	 * Set up home address space to match primary space. Instead of running
> +	 * in home space all the time, we switch every time in sie() because:
> +	 * - tests that depend on running in primary space mode don't need to be
> +	 *   touched
> +	 * - it avoids regressions in tests
> +	 * - switching every time makes it easier to extend this in the future,
> +	 *   for example to allow tests to run in whatever space they want

If we want tests to be able in other modes in the future...

> +	 */
> +	old_cr13 = stctg(13);
> +	lctlg(13, stctg(1));
> +
> +	/* switch to home space so guest tables can be different from host */
> +	psw_mask_set_bits(PSW_MASK_HOME);
> +
> +	/* also handle all interruptions in home space while in SIE */
> +	irq_set_dat_mode(true, AS_HOME);
> +
>   	while (vm->sblk->icptcode == 0) {
>   		sie64a(vm->sblk, &vm->save_area);
>   		sie_handle_validity(vm);
> @@ -66,6 +86,12 @@ void sie(struct vm *vm)
>   	vm->save_area.guest.grs[14] = vm->sblk->gg14;
>   	vm->save_area.guest.grs[15] = vm->sblk->gg15;
>   
> +	irq_set_dat_mode(true, AS_PRIM);
> +	psw_mask_clear_bits(PSW_MASK_HOME);

... we should maybe restore the previous mode here instead of switching 
always to primary mode?

Anyway, could be done later, but you might want to update your comment.

Reviewed-by: Thomas Huth <thuth@redhat.com>


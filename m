Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C576C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FBE6137A
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 22:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbhI1WJW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbhI1WJV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Sep 2021 18:09:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BEEC06161C
        for <linux-s390@vger.kernel.org>; Tue, 28 Sep 2021 15:07:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q81so347585qke.5
        for <linux-s390@vger.kernel.org>; Tue, 28 Sep 2021 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hqLpx7Wm6Aikf3yaBVZ1DfYqAohja9hoxxDTJ4xjS7o=;
        b=I79TXBeeKhqw/PkSZBawchrYJxCClh648BkPzWLbNa1UkVvlTTkBiT5/9JZ+EP89Ho
         guh8PRCNJ/vUJtFdxBjphdv3bgHIkUSsNWXSjlUDvsWO3HOrWnzDZvk/lFdojijY2jBm
         97fJyoUUndoubaQUCmKy2tXrCNSbPLATypEeOetRkXaSK7lLYOl8+AdZseYJPanJiAoB
         KfXAL15/M4xU3OTAtvuix3kZ1MqdcjRGfyiy9wFV2n8BOIJUv9Q4ppd4p+p0P7dD6qbE
         GLziTGb2w4zMAPXS6NDZ4GbcEi892+RAgDw4uV9gr7Gi4UuGL6DvBJ3bjf+mUAn+Yeim
         ooKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hqLpx7Wm6Aikf3yaBVZ1DfYqAohja9hoxxDTJ4xjS7o=;
        b=T/KQbIDvzfHU/6bjADFr3DfJQe/u86ZFP9v4r/wO1tCkqeNMqSwHxzJ10jg3o09YIu
         mJI3bCw1ITF0g8qLqFM2hxXMh1lZbsuPs7zxF4MRdAg3i7b+a5ZHNizhlrxiPv+YLFQo
         iWQg7uTxOPBYBwLA+1/fSZvrwjzAHQvDtEwlgzHr2jYWgJ/QKM4FkIHcvrfugik2jaSa
         neFWFgq/uaKrx9kb+B0+Xv50x6F/+CYpJEalCibX839Bb4wPV13+nGi/3tdyeJG0dUii
         zJV8YecZprwxC3ZdcD34+KLQEfj8patUOG4qbZvgy0roNeDoN/Pq53PJ5ivGrqTKCb0l
         E4yA==
X-Gm-Message-State: AOAM530kwXBbnjLEBzZ0qe6jICzbRmf8vhTVoFxGuijHo3hB6Fv/g+Jn
        nEMGPTy+eqh2HqJnkqpawp85qg==
X-Google-Smtp-Source: ABdhPJwYa3sPb+5NPeY3D11qHxW63pqGnDrFPVG/BTx8yJXFd0HA44jnISUSxDVomkPI7Dkdn063kA==
X-Received: by 2002:ae9:de86:: with SMTP id s128mr2452630qkf.146.1632866860009;
        Tue, 28 Sep 2021 15:07:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e16sm332752qtq.18.2021.09.28.15.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 15:07:39 -0700 (PDT)
Date:   Tue, 28 Sep 2021 15:07:39 -0700 (PDT)
X-Google-Original-Date: Tue, 28 Sep 2021 15:07:35 PDT (-0700)
Subject:     Re: [RFC PATCH 7/8] riscv: rely on core code to keep thread_info::cpu updated
In-Reply-To: <20210914121036.3975026-8-ardb@kernel.org>
CC:     linux-kernel@vger.kernel.org, ardb@kernel.org, keithpac@amazon.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org,
        christophe.leroy@csgroup.eu, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, peterz@infradead.org, keescook@chromium.org,
        luto@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-7d24dba9-38a7-4267-b01c-388471412237@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 14 Sep 2021 05:10:35 PDT (-0700), ardb@kernel.org wrote:
> Now that the core code switched back to using thread_info::cpu to keep
> a task's CPU number, we no longer need to keep it in sync explicitly. So
> just drop the code that does this.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/riscv/kernel/asm-offsets.c | 1 -
>  arch/riscv/kernel/entry.S       | 5 -----
>  arch/riscv/kernel/head.S        | 1 -
>  3 files changed, 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 90f8ce64fa6f..478d9f02dab5 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -33,7 +33,6 @@ void asm_offsets(void)
>  	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
> -	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
>
>  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 98f502654edd..459eb1714353 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -544,11 +544,6 @@ ENTRY(__switch_to)
>  	REG_L s9,  TASK_THREAD_S9_RA(a4)
>  	REG_L s10, TASK_THREAD_S10_RA(a4)
>  	REG_L s11, TASK_THREAD_S11_RA(a4)
> -	/* Swap the CPU entry around. */
> -	lw a3, TASK_TI_CPU(a0)
> -	lw a4, TASK_TI_CPU(a1)
> -	sw a3, TASK_TI_CPU(a1)
> -	sw a4, TASK_TI_CPU(a0)
>  	/* The offset of thread_info in task_struct is zero. */
>  	move tp, a1
>  	ret
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index fce5184b22c3..d5ec30ef6f5d 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -317,7 +317,6 @@ clear_bss_done:
>  	call setup_trap_vector
>  	/* Restore C environment */
>  	la tp, init_task
> -	sw zero, TASK_TI_CPU(tp)
>  	la sp, init_thread_union + THREAD_SIZE
>
>  #ifdef CONFIG_KASAN

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68755C2BA4C
	for <linux-s390@archiver.kernel.org>; Wed, 26 Jan 2022 08:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiAZIqc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbiAZIqb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jan 2022 03:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643186790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhxoRmdTAF+6nln7Wk69B4aXqbBBj2NXD9P+Xp5SDyQ=;
        b=PCiLm5v49peO5y0YuhrAtkLXo/0PkmrnpWQJr80H5TUgacXPtEdhCRWUmgGhcexLpJUKe6
        432gV3WoGflBxvvZ5wvSNvZP0bPSTOunjrqJyuXipVc42hdEhn2C9+97TdlUUUzwbWqMZf
        DAFuDsMcuYnpfPu6RdTZ3O5CljuCZrI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-Mxnw_uc-O_aa1m_y33TsKA-1; Wed, 26 Jan 2022 03:46:29 -0500
X-MC-Unique: Mxnw_uc-O_aa1m_y33TsKA-1
Received: by mail-wr1-f72.google.com with SMTP id k12-20020adfe3cc000000b001d6806dfde1so3980717wrm.16
        for <linux-s390@vger.kernel.org>; Wed, 26 Jan 2022 00:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OhxoRmdTAF+6nln7Wk69B4aXqbBBj2NXD9P+Xp5SDyQ=;
        b=FrNvdwV71F9odgzjq5uNID0RYFvXnvOYldjNLlyx5l3IdYS8OKiWrkvi7gzpfV1lNu
         cZcwFt3wbqSqF/2A2hc0HCL4vnGmM1cGGjYLFiOdly1MrG+in7mKmJAZEkhS2fr4zbbK
         x+/BHGGApAGxGJhPzJxl+KmASHBLzZQI8+ymWg7XVG0axuy3wF0jhdFIwY4Czc8qx69D
         1mXBm6pYfQI7b1jTYPYsV2xJ+IerhyJhXwrbNKDUyeuM+v7yXpNGfrVjPL6F6BzPZXfS
         d9FuerByB3Zq+JAHnNUNV6H6r0vERvfSRAUEn8RNrNu5l/ZJn7abLaO9Z+RDqba/8CDH
         sHzg==
X-Gm-Message-State: AOAM5301TYBvIHyrSekKLbfGA7MseomJ36/QDGG2y9XfqaI3AkNpMKHA
        QBVQV4dlwN2PjRFZeIbGQA/wpnAZ/WPM54r4Lazd8RcKvtgnjLxC77FhF5V6slabFKyeJDxxWqz
        YofhXlYU2bEBsDW3LYItKJA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr14261799wrs.493.1643186788171;
        Wed, 26 Jan 2022 00:46:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmwc/MfLLWlotMpx76NYdhsLJzU8dXvFwmwPFZbVd8OjIH5avUaMlUgXDytKnopBZWGbmUpA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr14261783wrs.493.1643186787902;
        Wed, 26 Jan 2022 00:46:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id x13sm19098962wru.28.2022.01.26.00.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 00:46:27 -0800 (PST)
Message-ID: <44307fea-dd94-96a0-e0b5-59d8c641cf45@redhat.com>
Date:   Wed, 26 Jan 2022 09:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH qemu v2] s390x: sck: load into a temporary not into in1
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, qemu-devel@nongnu.org
Cc:     richard.henderson@linaro.org, thuth@redhat.com,
        linux-s390@vger.kernel.org
References: <20220126084201.774457-1-nrb@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220126084201.774457-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 26.01.22 09:42, Nico Boehr wrote:
> We previously loaded into in1, but in1 is not filled during
> disassembly and hence always zero. This leads to an assertion failure:
> 
>   qemu-system-s390x: /home/nrb/qemu/include/tcg/tcg.h:654: temp_idx:
>   Assertion `n >= 0 && n < tcg_ctx->nb_temps' failed.`
> 
> Instead, use in2_la2_m64a to load from storage into in2 and pass that to
> the helper, which matches what we already do for SCKC.
> 
> This fixes the SCK test I sent here under TCG:
> <https://www.spinics.net/lists/kvm/msg265169.html>
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>  target/s390x/tcg/insn-data.def | 2 +-
>  target/s390x/tcg/translate.c   | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/insn-data.def b/target/s390x/tcg/insn-data.def
> index 3e5594210c88..848a9c9e622f 100644
> --- a/target/s390x/tcg/insn-data.def
> +++ b/target/s390x/tcg/insn-data.def
> @@ -1317,7 +1317,7 @@
>  /* SET ADDRESS SPACE CONTROL FAST */
>      F(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0, IF_PRIV)
>  /* SET CLOCK */
> -    F(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0, IF_PRIV | IF_IO)
> +    F(0xb204, SCK,     S,     Z,   0, m2_64a, 0, 0, sck, 0, IF_PRIV | IF_IO)
>  /* SET CLOCK COMPARATOR */
>      F(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0, IF_PRIV | IF_IO)
>  /* SET CLOCK PROGRAMMABLE FIELD */
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index dcc249a197ce..7fb87cd9f3b7 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -4295,8 +4295,7 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
>  #ifndef CONFIG_USER_ONLY
>  static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
>  {
> -    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
> -    gen_helper_sck(cc_op, cpu_env, o->in1);
> +    gen_helper_sck(cc_op, cpu_env, o->in2);
>      set_cc_static(s);
>      return DISAS_NEXT;
>  }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


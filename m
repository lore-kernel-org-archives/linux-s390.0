Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D932DC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jan 2022 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576014AbiAYNPs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1575910AbiAYNN6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Jan 2022 08:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643116436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJ2RoCCHw0iEYJKh5Pl0+R5jmzTmOENS7idwYfPTh+w=;
        b=dcek2mKUbHHTZSUx4Rb7skrmFDudgmnppjdeF2T+HpSoLC01CajLckHCbAoXG9sHSKR6iB
        8/Il3G3aiLhrXfJMzNfVy7iJ+J0mORjyT0c8rds5VrX4Vr2VqFTruIpWPN7JSq2eTpzppy
        WGAOtBwYizaipSQNgAk//1lIP/PewRM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-mGihD3uLPkiEmN9MuTanAA-1; Tue, 25 Jan 2022 08:13:55 -0500
X-MC-Unique: mGihD3uLPkiEmN9MuTanAA-1
Received: by mail-ed1-f70.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso2198943edk.13
        for <linux-s390@vger.kernel.org>; Tue, 25 Jan 2022 05:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EJ2RoCCHw0iEYJKh5Pl0+R5jmzTmOENS7idwYfPTh+w=;
        b=XhwFecG/7V72g1YGf9no29ay0ypZ9PwKBQNpRKjsYHAJStJHeyd6MkvK80EF0HLPrC
         vISvihaklW3+tptyvC1SAQy/tIv1kNjLpQZYArHx8JVkub5ET+9YbFHT7s9mM4vowyox
         AAlmaqHtePnrhiB/CKrwkgPogMzWDob2iA/moPtr4+XmbMogrh0hVaXjwjBPmEPWymHr
         HkMfWpbn1nYh8kyHjdlbtHpwQsQqJwyfvxJUS3HvIlccHV/7DKLkIZ7HO88ooI7QO5VW
         WVrWgctV6bLpkgaUcbo7R9m0AQhGnkXxUPvWTYPuMKR4WdxkzfhX6gXkoiyI3AOzoFj/
         csXA==
X-Gm-Message-State: AOAM5327Uy7ZWSajGG9RvJMbefVSAEONBmKK6CP4JoC9B16o/kWxRG51
        dcFJAKCw0EvAPH7g8CGpIUfqpzrg63dQg4ArwEqUIdcM5NTe/fHuENDnVeHpySZDEC+WSuN+8Od
        sTaO8uoQ7Vz/owdeBHIwHxw==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr20021013edr.205.1643116433809;
        Tue, 25 Jan 2022 05:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzceNfHm5lPSxQ3MW0l4VoMp2F+3V9e9ADWPrkIZ5wSE0xUiaxRKV7PcWyLIMFLykYJK0XLMA==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr20020995edr.205.1643116433519;
        Tue, 25 Jan 2022 05:13:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8000:9797:8f:1ed9:7596? (p200300cbc70f80009797008f1ed97596.dip0.t-ipconnect.de. [2003:cb:c70f:8000:9797:8f:1ed9:7596])
        by smtp.gmail.com with ESMTPSA id k4sm7821815edo.55.2022.01.25.05.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:13:52 -0800 (PST)
Message-ID: <9a888391-1020-89b0-65ed-5c93f2cc8642@redhat.com>
Date:   Tue, 25 Jan 2022 14:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH qemu] s390x: sck: load into a temporary not into in1
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, qemu-devel@nongnu.org
Cc:     richard.henderson@linaro.org, thuth@redhat.com,
        linux-s390@vger.kernel.org
References: <20220125122914.567599-1-nrb@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220125122914.567599-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25.01.22 13:29, Nico Boehr wrote:
> We previously loaded into in1, but in1 is not filled during
> disassembly and hence always zero. This leads to an assertion failure:
> 
>   qemu-system-s390x: /home/nrb/qemu/include/tcg/tcg.h:654: temp_idx:
>   Assertion `n >= 0 && n < tcg_ctx->nb_temps' failed.`
> 
> Instead, load into a temporary and pass that to the helper.
> 
> This fixes the SCK test I sent here under TCG:
> <https://www.spinics.net/lists/kvm/msg265169.html>
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>  target/s390x/tcg/translate.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 46dea733571e..dc0baec5a5f4 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -4290,9 +4290,16 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
>  #ifndef CONFIG_USER_ONLY
>  static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
>  {
> -    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEUQ | MO_ALIGN);
> -    gen_helper_sck(cc_op, cpu_env, o->in1);
> +    TCGv_i64 t1;
> +
> +    t1 = tcg_temp_new_i64();
> +
> +    tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_TEUQ | MO_ALIGN);
> +    gen_helper_sck(cc_op, cpu_env, t1);
>      set_cc_static(s);
> +
> +    tcg_temp_free_i64(t1);
> +
>      return DISAS_NEXT;
>  }
>  

I think you can actually just reuse in2_m2_64a, similar as we handle SCKC


diff --git a/target/s390x/tcg/insn-data.def b/target/s390x/tcg/insn-data.def
index f0af458aee..3a78606866 100644
--- a/target/s390x/tcg/insn-data.def
+++ b/target/s390x/tcg/insn-data.def
@@ -1317,7 +1317,7 @@
 /* SET ADDRESS SPACE CONTROL FAST */
     F(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0, IF_PRIV)
 /* SET CLOCK */
-    F(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0, IF_PRIV | IF_IO)
+    F(0xb204, SCK,     S,     Z,   0, m2_64a, 0, 0, sck, 0, IF_PRIV | IF_IO)
 /* SET CLOCK COMPARATOR */
     F(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0, IF_PRIV | IF_IO)
 /* SET CLOCK PROGRAMMABLE FIELD */
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index f180853e7a..c18011920e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4295,8 +4295,7 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEUQ | MO_ALIGN);
-    gen_helper_sck(cc_op, cpu_env, o->in1);
+    gen_helper_sck(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
 }


-- 
Thanks,

David / dhildenb


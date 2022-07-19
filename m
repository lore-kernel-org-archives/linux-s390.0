Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07875CCA47F
	for <linux-s390@archiver.kernel.org>; Tue, 19 Jul 2022 09:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiGSJyM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiGSJyM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Jul 2022 05:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB0D2286DD
        for <linux-s390@vger.kernel.org>; Tue, 19 Jul 2022 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658224449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZryJeKrcFWgmh1PiRNCBDjqzwCAgOZ1tTa2broykCc=;
        b=DQ4xyg/CegEzfJikI3CuD+fd2cye5jE/yX253UlBR80nMxMNMv+5Eth9vrFScxb0TIHwp+
        kptpQpxQ7rNRiwRsnqmwQf9LanEVdLUqqFpOV2lPTl3nyLaU2zjwPSLeJQrQAWeNzC3ci3
        nWlOJoIk6ZndgoBMjGwVwPfN9nwBayQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-b4P2OaygMfu4j4x-SJWJdA-1; Tue, 19 Jul 2022 05:54:07 -0400
X-MC-Unique: b4P2OaygMfu4j4x-SJWJdA-1
Received: by mail-wm1-f71.google.com with SMTP id n30-20020a05600c501e00b003a3264465ebso119557wmr.1
        for <linux-s390@vger.kernel.org>; Tue, 19 Jul 2022 02:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=NZryJeKrcFWgmh1PiRNCBDjqzwCAgOZ1tTa2broykCc=;
        b=PS1J6AYwEiw5JbuquT+raTNahkUrdYCtAhFDuoug2qyl+A2l/NP+UzRhBND3lpjjRc
         nOeI4KafJg9wK2b7fVDC4oimXwi5CyGDayQUCrX2BV0fMRRCT03ETYfJq6rw3QosYyri
         0NqttPCslUexGtbcVNi0eiFBe7ykWnSHMTFpVknUX6Zf9451aqL+ldMpWotl0bbZgN7K
         mZ29KBrwDOmzxUBW3SWmSCy4FQlJZz0eW2CpomZjGiBVfwQ3KKp0jgRlpsjVOOC4SsKM
         IIXNyc/dGFSGw+gj+ZhQPOqEHTlTVtnyxTxdPxx+hbojYlYlGhHfXICbdALaSasKlVh3
         6JXg==
X-Gm-Message-State: AJIora8AGxPHrNVRq/NotaQXJlg9+GZDxxlxzg0BKoptwPXga+BCywrH
        L/O2Xc68BTeisAPPOAhxGmmHyFqsu9FXv1OrfvXqpGxSt3TDJrmUc5e/5Lqn+0ZIHtzZdsRUdcr
        lvrw4VGB2+BXguAcRkUB5nA==
X-Received: by 2002:adf:e6c9:0:b0:21d:7f65:f1e7 with SMTP id y9-20020adfe6c9000000b0021d7f65f1e7mr25344851wrm.151.1658224446292;
        Tue, 19 Jul 2022 02:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6JYA7HzuINHFc2f2kTJDolhVu3asFX9NnBno1jNqS/YbUkCcpJ7xAViWJOGhqgHTNhxVBIA==
X-Received: by 2002:adf:e6c9:0:b0:21d:7f65:f1e7 with SMTP id y9-20020adfe6c9000000b0021d7f65f1e7mr25344841wrm.151.1658224446016;
        Tue, 19 Jul 2022 02:54:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:600:7807:c947:bc5a:1aea? (p200300cbc70906007807c947bc5a1aea.dip0.t-ipconnect.de. [2003:cb:c709:600:7807:c947:bc5a:1aea])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d49c8000000b0021e37fd6f32sm1322990wrs.112.2022.07.19.02.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 02:54:05 -0700 (PDT)
Message-ID: <8326327a-e55e-3aba-049f-b925282f95a8@redhat.com>
Date:   Tue, 19 Jul 2022 11:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-s390@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Thomas Huth <thuth@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>
References: <20220712164627.581570-1-Jason@zx2c4.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH qemu] target/s390x: support PRNO_TRNG instruction
In-Reply-To: <20220712164627.581570-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12.07.22 18:46, Jason A. Donenfeld wrote:
> In order for hosts running inside of TCG to initialize the kernel's
> random number generator, we should support the PRNO_TRNG instruction,
> backed in the usual way with the qemu_guest_getrandom helper. This is
> confirmed working on Linux 5.19-rc6.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Holger Dengler <dengler@linux.ibm.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Please cc maintainers+lists as described MAINTAINERS next time.
Otherwise I won't stumble over that ever unless pinged by other people ;)

> ---
>  target/s390x/gen-features.c      |  2 ++
>  target/s390x/tcg/crypto_helper.c | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index ad140184b9..3d333e2789 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -749,6 +749,8 @@ static uint16_t qemu_V7_0[] = {
>   */
>  static uint16_t qemu_MAX[] = {
>      S390_FEAT_VECTOR_ENH2,
> +    S390_FEAT_MSA_EXT_5,
> +    S390_FEAT_PRNO_TRNG,
>  };

Please see

commit 4756b106b372e525365c62b41df38052571c0a71
Author: David Hildenbrand <david@redhat.com>
Date:   Thu Apr 28 11:46:57 2022 +0200

    s390x/cpu_models: drop "msa5" from the TCG "max" model
    
    We don't include the "msa5" feature in the "qemu" model because it
    generates a warning. The PoP states:
    
    "The message-security-assist extension 5 requires
    the secure-hash-algorithm (SHA-512) capabilities of
    the message-security-assist extension 2 as a prereq-
    uisite. (March, 2015)"
    
    As SHA-512 won't be supported in the near future, let's just drop the
    feature from the "max" model. This avoids the warning and allows us for
    making the "max" model match the "qemu" model (except for compat
    machines). We don't lose much, as we only implement the function stubs
    for MSA, excluding any real subfunctions.
    

How is that warning avoided now? We have to sort that out first -- either by
removing that dependency (easy) or implementing SHA-512 (hard).

>  
>  /****** END FEATURE DEFS ******/
> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index 138d9e7ad9..cefdfd114e 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -12,12 +12,28 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/guest-random.h"
>  #include "s390x-internal.h"
>  #include "tcg_s390x.h"
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  
> +static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
> +                            uint64_t buf, uint64_t len)
> +{
> +        uint64_t addr = wrap_address(env, buf);
> +        uint8_t tmp[256];
> +
> +        while (len) {
> +                size_t block = MIN(len, sizeof(tmp));
> +                qemu_guest_getrandom_nofail(tmp, block);
> +                for (size_t i = 0; i < block; ++i)
> +                        cpu_stb_data_ra(env, addr++, tmp[i], ra);


There seems to be something missing regarding exception + register handling.

The doc states:

In the 31-
bit addressing mode, bits 33-63 of the even-num-
bered register are incremented by the number of
bytes processed for the respective operand, bits 0-31
of the register remain unchanged, and regardless of
the operand’s length, bit 32 of the register may be set
to zero or may remain unchanged. In the 64-bit
addressing mode, bits 0-63 of the even-numbered
register are incremented by the number of bytes pro-
cessed for the respective operand. In either the 24-
or 31-bit addressing mode, bits 32-63 of the odd-
numbered register are decremented by the number
of bytes processed for the respective operand, and
bits 0-31 of the register remain unchanged. In the 64-
bit addressing mode, bits 0-63 of the odd-numbered
register are decremented by the number of bytes pro-
cessed for the respective operand.

And:

Regardless of whether the operation ends due to
normal or partial completion, general registers R1
and R1 + 1 are incremented and decremented,
respectively, by the number of bytes stored into the
first operand, and general registers R2 and R2 + 1 are
incremented and decremented, respectively, by the
number of bytes stored into the second operand.



So I suspect we are not updating the registers accordingly,
especially before an exception could strike, or am I missing
something important?


Further, to be 100% correct you might have to wrap the address whenever
you increment it.

> +                len -= block;
> +        }
> +}
> +
>  uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
>                       uint32_t type)
>  {
> @@ -52,6 +68,13 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
>              cpu_stb_data_ra(env, param_addr, subfunc[i], ra);
>          }
>          break;
> +    case 114: {
> +        const uint64_t ucbuf = env->regs[r1], ucbuf_len = env->regs[r1 + 1];
> +        const uint64_t cbuf = env->regs[r2], cbuf_len = env->regs[r2 + 1];

empty line please.

> +        fill_buf_random(env, ra, ucbuf, ucbuf_len);
> +        fill_buf_random(env, ra, cbuf, cbuf_len);
> +        break;
> +    }
>      default:
>          /* we don't implement any other subfunction yet */
>          g_assert_not_reached();

Thanks!

-- 
Thanks,

David / dhildenb


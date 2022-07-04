Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7C1C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Jul 2022 13:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiGDN1H (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Jul 2022 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiGDN0H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jul 2022 09:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 172A312A82
        for <linux-s390@vger.kernel.org>; Mon,  4 Jul 2022 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656941021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++fJgtu1Gsy4nJVDDaNos/TBbdlOhBzdbNWHZ5EkqwY=;
        b=BOkXi0UN+JdRgN032nBhIKmB2oaUzOytPqptCFcaSVM649wSYLMp53uXLiGi83SpCjAWfK
        pRN0/NnaE/UPgFeEccDELgY/mibl135+pl124kr4mBIINyUe+2anKc4D+YeonC7deijtU4
        Ssz4JVrky461j6zxEnQ6P7gCU0zqUrg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-7EXKE91uMVqbdnwRNiUfSQ-1; Mon, 04 Jul 2022 09:23:40 -0400
X-MC-Unique: 7EXKE91uMVqbdnwRNiUfSQ-1
Received: by mail-ed1-f70.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso7279541eda.23
        for <linux-s390@vger.kernel.org>; Mon, 04 Jul 2022 06:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++fJgtu1Gsy4nJVDDaNos/TBbdlOhBzdbNWHZ5EkqwY=;
        b=n/aDaI5KIdD/gEH0bxxRCwlSHF0XIAs3fjge1JxOqgRXYQklxnv7VlGRa/EfyyMTvF
         M1hnwCu2dLYmd/UvlnY0dMu6SigIVM8aRadgHvWhPHKZr5b9kXeeEvqeHk3i+V3RryaY
         EoR+1dC9a3jYu2tTwTCnKS7/k8IQoG7Sab0Y7imZroKz4pH5PnRtsfRRP4GdaL/OrdnT
         O8zi/Ews5NlqHSaS1715h/XJckR1JNOZ8WVvadZUNh9LcUxq89T5Qqw3FbBx4UStvULc
         FBwxLjd/nn7ks+aYIJX6oEGlHy8PvN65brRzThrXPwXAInJFnIuj0PrUf7XYaJMQzTcn
         YIXw==
X-Gm-Message-State: AJIora/H3un5cDQiqrfmyEr3fez4Q7cjQBcMhkIll0UPpw2GZLej9nK6
        Zc8BsM+ropByC+c3WPy4trMR0jpTu+Ugu33GYJZuQhOfJw+/Aw3H41UOSXXWJnV2Nwth0/atnuo
        guM5ueczCLksEh6DijHRYaTsHLuNtEKu+0Q40Sg==
X-Received: by 2002:a17:907:1dea:b0:72a:6012:7bbc with SMTP id og42-20020a1709071dea00b0072a60127bbcmr22739734ejc.258.1656941019233;
        Mon, 04 Jul 2022 06:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1us+BJZNsaBxoVlhuOHsDmDB0TuEnxFOGCQHinJXmpvFVRGrl2Z3hyJhPYMWd9HALphgmfV9qcRQ2n0jxT4UXk=
X-Received: by 2002:a17:907:1dea:b0:72a:6012:7bbc with SMTP id
 og42-20020a1709071dea00b0072a60127bbcmr22739720ejc.258.1656941019093; Mon, 04
 Jul 2022 06:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142515.14800-1-code@siddh.me>
In-Reply-To: <20220701142515.14800-1-code@siddh.me>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 4 Jul 2022 15:23:28 +0200
Message-ID: <CAMusb+QLOyOmk-MQ=FJV7N19g17TUb0gyBi522Rna1uTR9S2+A@mail.gmail.com>
Subject: Re: [RESEND PATCH] MAINTAINERS: Add tools/testing/crypto/chacha20-s390/
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 4:31 PM Siddh Raman Pant <code@siddh.me> wrote:
>
> This adds the maintainers' information for the
> s390 ChaCha20 self-test module.
>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
> CC'd the maintainers in this enail which I had not
> done last time.
>
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe5daf141501..0fcacd715b1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17438,6 +17438,14 @@ F:     Documentation/s390/
>  F:     arch/s390/
>  F:     drivers/s390/
>
> +S390 CHACHA20 SELFTEST
> +M:     Vladis Dronov <vdronov@redhat.com>
> +M:     Herbert Xu <herbert@gondor.apana.org.au>
> +R:     Harald Freudenberger <freude@linux.ibm.com>
> +L:     linux-s390@vger.kernel.org
> +S:     Supported
> +F:     tools/testing/crypto/chacha20-s390/
> +
>  S390 COMMON I/O LAYER
>  M:     Vineeth Vijayan <vneethv@linux.ibm.com>
>  M:     Peter Oberparleiter <oberpar@linux.ibm.com>

Honestly, I'm not quite sure this is really needed. test-cipher.c is a
"one-shot"
thing quite exactly and it is not supposed to be changed / developed anyhow
in the future.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer


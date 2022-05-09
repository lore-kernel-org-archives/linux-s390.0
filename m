Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D958AC433F5
	for <linux-s390@archiver.kernel.org>; Mon,  9 May 2022 10:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiEIKVb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 May 2022 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiEIKVO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 May 2022 06:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67F3516F919
        for <linux-s390@vger.kernel.org>; Mon,  9 May 2022 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652091438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rAG+hhLyyADjfWKc/qIMa3fRClDqyFw6+rAc7ZUweE=;
        b=TBY0qSgrMGaSblfpeABrbY52GYWqUpAD6/5ERWkmHINoqzkTfYmNY854ethXRQjzU3uNIm
        IA2egAh9lQVLHeyi/z7ejkUHwzpJ6ZNLSDkA/79Ch6/3vBUlWaOcz0kltJGz2iTN4KPcwE
        EIwojyGUMPiaVFIJ/Zkk/b2ad2FqFpg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-gn6QXwNoMHq9-gU_8ugOjw-1; Mon, 09 May 2022 06:17:17 -0400
X-MC-Unique: gn6QXwNoMHq9-gU_8ugOjw-1
Received: by mail-ed1-f70.google.com with SMTP id cz24-20020a0564021cb800b00425dfdd7768so8073877edb.2
        for <linux-s390@vger.kernel.org>; Mon, 09 May 2022 03:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rAG+hhLyyADjfWKc/qIMa3fRClDqyFw6+rAc7ZUweE=;
        b=ZCoH9ixyvN31vHFNZLsRh14NMKQSZ5CrSbqWTyOInt8NawJGEwAfOBeRCRNtxvXHpx
         jTFmEwY0/flmHWXDl83QUyT8d4MuV8a+0MMBs00BIRaD4k+Y1VKDyKqPG8LIeSTkk6D0
         ZRlbKGkwAfnycl8suxMLFOorBttgI4SxD5MFCcQP1lr9PDJo+DcQODuKRbvqmfcg4HyH
         if9yKmV32Uyln8vOKnqyA0XsFskR/BhHAO3rrmUFWjvocV75EWKvXvDB/BEg6vatg/Nm
         L3PeSBgiQWbkBGGzPs4Se9AMxm3xcDfCAqx/AQfNwdsjp6dMGdPir1elMelRuvzZ2VmR
         0BAw==
X-Gm-Message-State: AOAM533ryP9J2Y7ZhI24fHUQ886kPet7TlRdZDP9BhjGiARSNanvt4ZN
        fIs7fYJ5mWOd591Qn+6XGNQuIfS1tuG/vrtfsH5JjnXbE9A8T9GDuaetQGM+jF47KdqVAeFnQk+
        GPE6oCKPioyNB6u7pJ1kQeNBXOkIKusCp+xtgLw==
X-Received: by 2002:a50:d08b:0:b0:425:eb86:f36d with SMTP id v11-20020a50d08b000000b00425eb86f36dmr16301827edd.235.1652091436039;
        Mon, 09 May 2022 03:17:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWF5i0r1wWzRnyta1jc1Xzs8fjC2bR2GTrVWYAaiAIuMqphiWE9pkwqenZGV0+CFmZVoPSFTydmMUJBGOVC04=
X-Received: by 2002:a50:d08b:0:b0:425:eb86:f36d with SMTP id
 v11-20020a50d08b000000b00425eb86f36dmr16301818edd.235.1652091435909; Mon, 09
 May 2022 03:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220508130944.17860-1-vdronoff@gmail.com> <3f16033ef08063ef9fcb707010e78bd0@linux.ibm.com>
In-Reply-To: <3f16033ef08063ef9fcb707010e78bd0@linux.ibm.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 9 May 2022 12:17:04 +0200
Message-ID: <CAMusb+Q11JMyOXV0iy4VLJ8yST7L0QrmDUJWOpnvsBxfBzjrdA@mail.gmail.com>
Subject: Re: [PATCH] s390/crypto: add crypto library interface for ChaCha20
To:     freude@linux.ibm.com
Cc:     Patrick Steuer <patrick.steuer@de.ibm.com>,
        Harald Freudenberger <freude@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi, Harald,

Thank you for your response, review and an ACK. Let me ask Herbert if
he would agree
to add your Reviewed-by and submit (so I do not send v2 just for this).

Best regards,
Vladis


On Mon, May 9, 2022 at 12:10 PM Harald Freudenberger
<freude@linux.ibm.com> wrote:
>
> On 2022-05-08 15:09, Vladis Dronov wrote:
> > From: Vladis Dronov <vdronov@redhat.com>
> >
> > Implement a crypto library interface for the s390-native ChaCha20
> > cipher
> > algorithm. This allows us to stop to select CRYPTO_CHACHA20 and instead
> > select CRYPTO_ARCH_HAVE_LIB_CHACHA. This allows BIG_KEYS=y not to build
> > a whole ChaCha20 crypto infrastructure as a built-in, but build a
> > smaller
> > CRYPTO_LIB_CHACHA instead.
> >
> > Make CRYPTO_CHACHA_S390 config entry to look like similar ones on other
> > architectures. Remove CRYPTO_ALGAPI select as anyway it is selected by
> > CRYPTO_SKCIPHER.
> >
> > Add a new test module and a test script for ChaCha20 cipher and its
> > interfaces. Here are test results on an idle z15 machine:
> >
> > ...skip...
>
> Hello Vladis
> Thanks for your work. Please add my
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
>
> however, always the question who will pick and forward this patch ?
> To me this looks like most parts are common so I would suggest that
> Herbert Xu  will pick this patch.
>


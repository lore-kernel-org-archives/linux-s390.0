Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2DFC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 30 Jun 2022 17:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiF3R0D (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiF3R0D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jun 2022 13:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 770593E5FD
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656609961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3T5aBD9PUbE+5Fu1Vz+qh55CgD24J2SDZXI2Y4tmhUQ=;
        b=OI+E57//AnVDrHIuchkVaVN+XtC/S7E5KjX5Avxy3ZioXqNXmc8llLZx/i8ggXBg+7e6H8
        WCubORF+DA7syPMpV2xxrXUBfWFBHGZNvLS26tBVZHuwoJoAjbh8lPxsDMJZiRELFiJgbq
        nRrMya/7BCzUfwSW+ozBGdBbeFPNdYQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-q1gkOIxlPx2t2R1l_Hb9yQ-1; Thu, 30 Jun 2022 13:26:00 -0400
X-MC-Unique: q1gkOIxlPx2t2R1l_Hb9yQ-1
Received: by mail-wm1-f69.google.com with SMTP id p22-20020a05600c359600b0039c7b23a1c7so1705903wmq.2
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 10:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3T5aBD9PUbE+5Fu1Vz+qh55CgD24J2SDZXI2Y4tmhUQ=;
        b=1CPbR2xo9Zl6ah2cPi2RBMl2qQekHfDrG972RT0L4zo2R0X+U5oUvczfEdEoDwZXdS
         UG2imoz8ohiQejsj4R7YHWxVuShQfA4waw3zvltWC7zhkI0rCpF7t/TopgL8UKubww4P
         hST763GizTzLPwIxKT/mQ81sTz2IECqe8A8v1lrgn23LXJvNidVPunQQulP8QtYaW4d7
         mVUiVQfIZFYCamK5KeC8Sia4N+fyab5h2JOVR6GNHmNiOSJkEXSS+MlvvxKC2ZoP4wGi
         gPydTCG+QvOT/+vex2n04n4MZmc2qiqi52KpzBA/Xx9aPiLBJxyT6dWd07rgQaHPWwO/
         DjDA==
X-Gm-Message-State: AJIora+habMt0WmReXbgj7UOkU2PEQ8MzNc7A21eWdj1+vFOVThEjo2a
        0xhxFxtiyHHYmiR/ICpkwq/6hItUe1qT5jR47I5AJXCmD69tuPxdQVwo33viJwGCiykc7IzOL4c
        At2K62lVpTd/qkToI0ucKeA==
X-Received: by 2002:adf:f6c5:0:b0:21b:a6b1:ac6f with SMTP id y5-20020adff6c5000000b0021ba6b1ac6fmr9970089wrp.595.1656609958880;
        Thu, 30 Jun 2022 10:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uvPVyKkwk9O81CQQqdU0A8ODbmBKkCB7g1UXHn87z4YkhWA6TO8MZBj2BSVIwRNhDuqgUw9g==
X-Received: by 2002:adf:f6c5:0:b0:21b:a6b1:ac6f with SMTP id y5-20020adff6c5000000b0021ba6b1ac6fmr9970061wrp.595.1656609958626;
        Thu, 30 Jun 2022 10:25:58 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-66.web.vodafone.de. [109.43.179.66])
        by smtp.gmail.com with ESMTPSA id f190-20020a1c38c7000000b0039c5328ad92sm3239958wma.41.2022.06.30.10.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:25:58 -0700 (PDT)
Message-ID: <069be6f0-2f3a-3fea-3eca-d42f99e98220@redhat.com>
Date:   Thu, 30 Jun 2022 19:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220630113059.229221-1-nrb@linux.ibm.com>
 <20220630113059.229221-4-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v1 3/3] s390x: add pgm spec interrupt loop
 test
In-Reply-To: <20220630113059.229221-4-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/06/2022 13.30, Nico Boehr wrote:
> An invalid PSW causes a program interrupt. When an invalid PSW is
> introduced in the pgm_new_psw, an interrupt loop occurs as soon as a
> program interrupt is caused.
> 
> QEMU should detect that and panick the guest, hence add a test for it.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
....
> +int main(void)
> +{
> +	report_prefix_push("pgmint-loop");
> +
> +	lowcore.pgm_new_psw.addr = (uint64_t) pgm_int_handler;
> +	/* bit 12 set is invalid */
> +	lowcore.pgm_new_psw.mask = extract_psw_mask() | BIT(63 - 12);

Basically patch looks fine to me ... just an idea for an extension (but that 
could also be done later):

Looking at the is_valid_psw() function in the Linux kernel sources, there 
are a couple of additional condition that could cause a PGM interrupt loop 
... you could maybe check them here, too, e.g. by adding a "extra_params = 
-append '...'" in the unittests.cfg file to select the indiviual tests via 
argv[] ?

  Thomas


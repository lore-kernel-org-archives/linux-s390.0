Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C1C83F2C
	for <linux-s390@archiver.kernel.org>; Mon,  4 Sep 2023 10:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjIDKkK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Sep 2023 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjIDKkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Sep 2023 06:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D618F
        for <linux-s390@vger.kernel.org>; Mon,  4 Sep 2023 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693823965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrrAxmOl7Fc5ehdBn/+i35ndvgk9dyz/k3neFMBGrkA=;
        b=JI71jmpRD2qsNpMUQzu2dGoXzXSk72A0gdSQhcaC8obz7TODCrtG1P7hY4wTtFwpcJoTeq
        jBKelOqrxX8ktv5wUkgwjiW7xFB7zIdaBecZv1lUILtyed2F5h5QD6irMPKKW283xksW6Z
        OkJFcj/gJxxGccXfBgDV1favNCPPUlM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-VRU8bZekMouz18pWZFBs5w-1; Mon, 04 Sep 2023 06:39:23 -0400
X-MC-Unique: VRU8bZekMouz18pWZFBs5w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c7bfba03dso732259f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 04 Sep 2023 03:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693823962; x=1694428762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrrAxmOl7Fc5ehdBn/+i35ndvgk9dyz/k3neFMBGrkA=;
        b=KxkEUTGO8xEXNtSmWH6F+igosURgo2WIX/Pg+9g4ufCYOoFYBfz+pBsNWz6vnGB6X8
         B5+kAZlI5bmGlxNMuFq2NZQ7MWDhSKuAEr4Xv+8eajBQBQgWcYVis5NMXAJcgwTpV6vD
         94rS3WMvW1yHfimDSjtU4TIBgZAspXHrMWL3Yz7+lpLeVckHxdC9v9tHfencXEHIKFFe
         +UUrbCpC5M86iYp9I7i+LlQjjz7m2ajuu9TBTvsapFGe7primdCLvCNPEKXBTziHxG8b
         xFGZO/9e+kRp5X8Iu/p6kDn84N8GkpzKlyQPAs9miQWFlLJJMyNITnnIaB8aGBKk6g0u
         iXbA==
X-Gm-Message-State: AOJu0YyuSk2Un3n9Q24DJ5JsSa5s39yIMoKtm0FZOfzOBfyCviWdGSr+
        ks3Ck3OaTdeneZQAyK6IvVOnjAX5FpR1XYvUF4l6b2OKMCc3m8D0sJUZn2aqwM82BMmWwlqmZ5G
        CaOcHWHf9gHi93vBlhXZeMg==
X-Received: by 2002:adf:ed08:0:b0:313:f957:bf29 with SMTP id a8-20020adfed08000000b00313f957bf29mr7363510wro.65.1693823962422;
        Mon, 04 Sep 2023 03:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbgplqKkw6Vu6xARK0QJsuOMRprGgSL6s3l9wtqZ/cakGNrxcvoJVirpVMtfzIKF1H1hlANQ==
X-Received: by 2002:adf:ed08:0:b0:313:f957:bf29 with SMTP id a8-20020adfed08000000b00313f957bf29mr7363503wro.65.1693823962157;
        Mon, 04 Sep 2023 03:39:22 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003177074f830sm14146238wrq.59.2023.09.04.03.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 03:39:21 -0700 (PDT)
Message-ID: <c81706fb-5e90-d431-2f6d-07c1f328e7ed@redhat.com>
Date:   Mon, 4 Sep 2023 12:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [kvm-unit-tests PATCH v6 8/8] lib: s390x: interrupt: remove
 TEID_ASCE defines
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904082318.1465055-1-nrb@linux.ibm.com>
 <20230904082318.1465055-9-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230904082318.1465055-9-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/09/2023 10.22, Nico Boehr wrote:
> These defines were - I can only guess - ment for the asce_id field.

s/ment/meant/

> Since print_decode_teid() used AS_PRIM and friends instead, I see little
> benefit in keeping these around.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   lib/s390x/asm/interrupt.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
> index 7f73d473b346..48bd78fa1515 100644
> --- a/lib/s390x/asm/interrupt.h
> +++ b/lib/s390x/asm/interrupt.h
> @@ -13,11 +13,6 @@
>   #define EXT_IRQ_EXTERNAL_CALL	0x1202
>   #define EXT_IRQ_SERVICE_SIG	0x2401
>   
> -#define TEID_ASCE_PRIMARY	0
> -#define TEID_ASCE_AR		1
> -#define TEID_ASCE_SECONDARY	2
> -#define TEID_ASCE_HOME		3
> -
>   union teid {
>   	unsigned long val;
>   	union {

With the nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


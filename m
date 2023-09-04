Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34CCC71153
	for <linux-s390@archiver.kernel.org>; Mon,  4 Sep 2023 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjIDKix (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Sep 2023 06:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjIDKix (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Sep 2023 06:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573B18F
        for <linux-s390@vger.kernel.org>; Mon,  4 Sep 2023 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693823881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kB/mKl04D1nauBtQD42CnfhXSKfamjz9K6ZUolRckUw=;
        b=V1PvnFiqpS4veVfLWoLiKlQ4RqdJcaDy8tFY37HcTJ4eG9wrsG0MEwZGRozI8p8ZCX5PZc
        H0DhW6Yhooriaz0Hr3tdzTjsAyNC9LsWcFcUR5l4qzLgX64QsD8HondXqFhwf49YqiG+82
        lkOd+Ji1EPcH6HIMZnq5KSrhOJl3DGI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-aeEimJCVPpiuSku3IT6xZw-1; Mon, 04 Sep 2023 06:37:59 -0400
X-MC-Unique: aeEimJCVPpiuSku3IT6xZw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-500b0aa547eso1403040e87.2
        for <linux-s390@vger.kernel.org>; Mon, 04 Sep 2023 03:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693823878; x=1694428678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kB/mKl04D1nauBtQD42CnfhXSKfamjz9K6ZUolRckUw=;
        b=KBks4/uUcT+qKjsifuMX918c2DX7eebrfXgfpoC9fQi5jxrMEi5OfyKpK65fNLpUjD
         f/u/YsPKuKlJB5Id0fB/WIOGcM8ybExNj1Jd4mjz80Rlhb0Xa2R0DoFu0Uf/OnqZjSvw
         q4lftQESJLmiY56riREU5DVhiq95Qm4vmn2fE6ZW0qagubClouU1sqq7qsxxpCh6XIgZ
         eJI1WsU5RhPViFds6M2qaIpGa6mXF7HurF4y7jifSsYhdb71oM9K5fnmp2htj24rVpat
         CNOZSaXTROdu3xStS9gDhB1rVzY3HpqRKJoGLW7iMbHl2vxPmrdipGlNTz1hEO6G4egs
         qOLg==
X-Gm-Message-State: AOJu0Yx0tMXVfeKpnwzG591Kof+p3/6CzCOIPlSM0k7TkGF7iAQx+Bcc
        TIZdCybI3X0Ax7T8OTE1cnmJkPHsMRFR26/AgeFddLum3EGPOUTmaxURrwyMFGmBIOFOM60wQJ3
        tfvti7iKhsekS9dkJP9MB8RWlte6IgyP7
X-Received: by 2002:a05:6512:401e:b0:500:b7dc:6c90 with SMTP id br30-20020a056512401e00b00500b7dc6c90mr8035074lfb.36.1693823878406;
        Mon, 04 Sep 2023 03:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZy+TKH5uraUkUcIKJ3GTBj7PqNOLTlrizw3fYS9+pkb9g/V6szA42tCREnPG0KkrnJtrHfQ==
X-Received: by 2002:a05:6512:401e:b0:500:b7dc:6c90 with SMTP id br30-20020a056512401e00b00500b7dc6c90mr8035061lfb.36.1693823878121;
        Mon, 04 Sep 2023 03:37:58 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm13500437wms.39.2023.09.04.03.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 03:37:57 -0700 (PDT)
Message-ID: <e1fa6315-5de1-e843-3022-7f3023b1e189@redhat.com>
Date:   Mon, 4 Sep 2023 12:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [kvm-unit-tests PATCH v6 6/8] s390x: add test source dir to
 include paths
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904082318.1465055-1-nrb@linux.ibm.com>
 <20230904082318.1465055-7-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230904082318.1465055-7-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/09/2023 10.22, Nico Boehr wrote:
> Sometimes, it is useful to share some defines between a snippet and a
> test. By adding the source directory to include paths, header files can
> be placed in the snippet directory and included from the test (or vice
> versa).
> 
> This is a prerequisite for "s390x: add a test for SIE without MSO/MSL".
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 706be7920406..9d5c08339d16 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -67,7 +67,7 @@ test_cases: $(tests)
>   test_cases_binary: $(tests_binary)
>   test_cases_pv: $(tests_pv_binary)
>   
> -INCLUDE_PATHS = $(SRCDIR)/lib $(SRCDIR)/lib/s390x
> +INCLUDE_PATHS = $(SRCDIR)/lib $(SRCDIR)/lib/s390x $(SRCDIR)/s390x
>   # Include generated header files (e.g. in case of out-of-source builds)
>   INCLUDE_PATHS += lib
>   CPPFLAGS = $(addprefix -I,$(INCLUDE_PATHS))

Reviewed-by: Thomas Huth <thuth@redhat.com>


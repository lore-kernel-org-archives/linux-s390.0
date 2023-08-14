Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C5C04A94
	for <linux-s390@archiver.kernel.org>; Mon, 14 Aug 2023 10:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjHNKYT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Aug 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjHNKYI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Aug 2023 06:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1CC10C8
        for <linux-s390@vger.kernel.org>; Mon, 14 Aug 2023 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692008600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TeLUVrGt92hyTJJZe96M/I16QCmsjhVESaM/SouixQg=;
        b=HWbUD6gpCc9LF9dkGTfoW1vQIMUqW/GHM0rXxFGJocfG6ayfbMyjFz4R7P18SYIu5/HsXf
        RIwUJFjK2jqN/yW89m0hi3+t171YC3nM+eRr4erbcA1zP64rjwjCihih4iZiJRaxW/EIQA
        /XRYPDuSrmuYRC2+1iREWEXsAxFgl0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-IpAZ0kHANryjCSAy7rU03g-1; Mon, 14 Aug 2023 06:23:19 -0400
X-MC-Unique: IpAZ0kHANryjCSAy7rU03g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-319652e9920so1262382f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 14 Aug 2023 03:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008598; x=1692613398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeLUVrGt92hyTJJZe96M/I16QCmsjhVESaM/SouixQg=;
        b=MGXehYx+oYNO3KXGxBzu+Fc5SW3h73mMgrs6mjg+xKsj6xKzy2SMmaFadkssKbjJDL
         Q7+EWZUqW5a5IO28XBf3sGzK2CTnv6FSrttBlvYnH0jqtXac9gB3sUCNCnpszcs0hhlX
         Q2HgwYqXMS+eYowhy8TitiakwAsk1n6fLxAXCmDz6RELC78JlJuwCn+gDIsqWXhrUZrH
         aE+b/h3aDCLpF+b/9g+ebnbrrlIKUB0z0osp8EkMnZ0LsSjwY2T13y4usM8IHhE9e/iW
         VY4h04gBv4vXJH7u/TsXwWiZc9Wd3pQNKMwcpg9iquSUJ1b7U2NHor/lnO5MGZmuK6wQ
         SIfg==
X-Gm-Message-State: AOJu0YzszLY2Nrw2JchKp2z5fQaHuFIKxCGWrzZAWhXIG+lPZkz22Dyk
        FvWGv+WuwcGEaj5nQr1ZszukFrTrzcRcDljYrImmsHZ6m13AkqMIOH+bk3SyfWe4O71kCXEPFfP
        yezx+nOJwP3QFXG5VktULiQ==
X-Received: by 2002:adf:f041:0:b0:313:fe1b:f444 with SMTP id t1-20020adff041000000b00313fe1bf444mr6025599wro.68.1692008598492;
        Mon, 14 Aug 2023 03:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk431CcIU0nC/ZlJfr94Ibz0UhYGVcUu0oIkiQ3p0YVUUYgb6a+HDazlSMtQNjlj7nkmH1Xg==
X-Received: by 2002:adf:f041:0:b0:313:fe1b:f444 with SMTP id t1-20020adff041000000b00313fe1bf444mr6025590wro.68.1692008598171;
        Mon, 14 Aug 2023 03:23:18 -0700 (PDT)
Received: from [192.168.8.105] (dynamic-046-114-244-033.46.114.pool.telefonica.de. [46.114.244.33])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600001c700b0031423a8f4f7sm14163529wrx.56.2023.08.14.03.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 03:23:17 -0700 (PDT)
Message-ID: <b25d92c6-7d2a-337f-10d6-ee7e6b9d7288@redhat.com>
Date:   Mon, 14 Aug 2023 12:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [kvm-unit-tests PATCH v1] s390x: spec_ex: load full register
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, nsg@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230811112949.888903-1-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230811112949.888903-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/08/2023 13.29, Nico Boehr wrote:
> There may be contents left in the upper 32 bits of executed_addr; hence
> we should use a 64-bit load to make sure they are overwritten.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/spec_ex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/spec_ex.c b/s390x/spec_ex.c
> index e3dd85dcb153..72b942576369 100644
> --- a/s390x/spec_ex.c
> +++ b/s390x/spec_ex.c
> @@ -142,7 +142,7 @@ static int psw_odd_address(void)
>   		"	larl	%%r1,0f\n"
>   		"	stg	%%r1,%[fixup_addr]\n"
>   		"	lpswe	%[odd_psw]\n"
> -		"0:	lr	%[executed_addr],%%r0\n"
> +		"0:	lgr	%[executed_addr],%%r0\n"
>   	: [fixup_addr] "=&T" (fixup_psw.addr),
>   	  [executed_addr] "=d" (executed_addr)
>   	: [odd_psw] "Q" (odd)

Reviewed-by: Thomas Huth <thuth@redhat.com>


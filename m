Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED253C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  2 Dec 2021 10:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbhLBKdf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Dec 2021 05:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356786AbhLBKde (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Dec 2021 05:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638441012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYsLP2MP00b1oH3DtRnSUpLrjUtCpztF+PeHvMRQbAg=;
        b=RBSicacWJ11I2/bbfz2s8Rz34gVLHEh9bRK+NxnTHSQG/NBkdpVg6Sd50O1oDkRnt4mnzh
        FmRRZTcaGI18KSmia0fK4QAt4Zupd5X0CttUnkJuLml+xN2FBMMqYV3oOlHVtmbRWeA/aG
        tgnksBaOqQSI3hz+EsNl/KDcT07QXjg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-Kj47D3JAOc6NCYLafixS8A-1; Thu, 02 Dec 2021 05:30:11 -0500
X-MC-Unique: Kj47D3JAOc6NCYLafixS8A-1
Received: by mail-wr1-f72.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so4895774wro.18
        for <linux-s390@vger.kernel.org>; Thu, 02 Dec 2021 02:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BYsLP2MP00b1oH3DtRnSUpLrjUtCpztF+PeHvMRQbAg=;
        b=U08zh94yRXP6ju7SRU96zHP2+1zFa+XAvjKkShFIcBheqMqxu5NShP67hnRbg+9HSb
         ej5GooprXJZb/gAnS1+lYup+LQ6SmjMUc3v23ch3P3HmsChqpQP1G5pTuPyfRru/Chdn
         y9yBv1ajT7GYWFb/zVaFgfYhiXgXDu0SY1rIPCAMqOq90xcMlWWx+8TjZWy459+OMDL8
         0cUhBvvEPKxT2JztMR2CM+xfF0pC7RXrOfXc7ntYCdMj57LKOEU6qZF9yisI5OsKb/xz
         uxI3L0h6i8UK8eYcmmDN71ZrvHpB1cfNOaVhVDGQele5tKTQBFtDLBZoh9bCIikLjl7u
         dk0w==
X-Gm-Message-State: AOAM530BnLnUa2QvX7mcrYQSRADaHLBiOxnVmF+ETHW/d7dMpaZqGh36
        cUmeVs1AQb5y41+leT/cevdnkzPF5V/IxTUEonBkoK0DP5TXeTymArADiHJM8HdCFqUbCpLA1gc
        ROdkXbkr8D68RCOpF9c70eg==
X-Received: by 2002:a1c:447:: with SMTP id 68mr5335595wme.69.1638441009880;
        Thu, 02 Dec 2021 02:30:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4e0l4QmJap0Ltd3O3NXcmX4oslOmpQ87IkX1xwbcf4AZjE1poLYtPmREDNqOy75l9ACRqCA==
X-Received: by 2002:a1c:447:: with SMTP id 68mr5335573wme.69.1638441009708;
        Thu, 02 Dec 2021 02:30:09 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id o4sm1955473wmq.31.2021.12.02.02.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 02:30:08 -0800 (PST)
Message-ID: <94d78a53-cb59-d712-65c5-d31e909f13d4@redhat.com>
Date:   Thu, 2 Dec 2021 11:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [kvm-unit-tests PATCH v1 1/2] s390x: make smp_cpu_setup() return
 0 on success
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sebastian Mitterle <smitterl@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20211202095843.41162-1-david@redhat.com>
 <20211202095843.41162-2-david@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20211202095843.41162-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 02/12/2021 10.58, David Hildenbrand wrote:
> Properly return "0" on success so callers can check if the setup was
> successful.
> 
> The return value is yet unused, which is why this wasn't noticed so far.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   lib/s390x/smp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index da6d32f..b753eab 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -212,6 +212,7 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>   	/* Wait until the cpu has finished setup and started the provided psw */
>   	while (lc->restart_new_psw.addr != psw.addr)
>   		mb();
> +	rc = 0;
>   out:
>   	spin_unlock(&lock);
>   	return rc;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


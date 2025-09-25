Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA912D7DD1
	for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793248; cv=none; b=t+5dv9hC5sGjUlu8rZ5IjCnbD1NVXE0cgs95J1YX3K/Di+eHdO/dCyrkBG6gCBYys3OvJxYzg/FhsoyKobuLJulMa5No5DwrGWGcY/q+BtPkK7KW7316YExpo+UbYy1K5AjHbrvpSqLoHUtu+JJ0Hi5VB9DVpFCOWc4xyo7jD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793248; c=relaxed/simple;
	bh=Ismx6yKHMCrWAtzO1V+zHu5cuIvgP8WRaG1URDkbiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g3iWmtQqwD/8DSAymE8lJSD3FO7txQEt9Y25U+mXH4NEkac7BbHMf5pi2yu292DVnQZMRHoK69xhQiUdQKI3i7Xr5jvYfyEBydyPqdqYuZ4a1lK5tCBW1l5/ayOwoWZq96u6N/1v8AQOZYaHSvxI3DG0wlXCfFnizx6GzrVSTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VM7nNPhU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM7nNPhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758793246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OC7o0y5NqDwPgeMke0PyEOvsv7ZIPwi/d2lkMqYclw=;
	b=VM7nNPhUVAk4Qs0rVVAmraMhV5ziteRXcRsjBOLHaOMjjc4E87QalvmqJGk16mNJNiamkI
	G0nfyRFDqsYqlKa7KOo9/qpKA6HpgANVOxoXFUzqXx9DPlTy1Ly+Zj4v/b+iTGEGTtGxKA
	T8tqfyY1zfmDcaab4okpd6icCpps9dk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-mxP626RRO1KP4wrGpm9S5A-1; Thu, 25 Sep 2025 05:40:44 -0400
X-MC-Unique: mxP626RRO1KP4wrGpm9S5A-1
X-Mimecast-MFC-AGG-ID: mxP626RRO1KP4wrGpm9S5A_1758793244
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso573333f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 25 Sep 2025 02:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793243; x=1759398043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OC7o0y5NqDwPgeMke0PyEOvsv7ZIPwi/d2lkMqYclw=;
        b=jgsSX19Xc9z2FG7plnqEUGMJyTtLaPpAY0lu6X0FQ8EfPo9lFhPcwNzX2nIS/mLu2E
         pe3MiTEee4O2keOKtZSaoUqkQEji5Ur/XWwSLyTtdn/j4g0Vzy+L32WZWTkwI+V3gTkO
         WwxFAml2vudVFcfbm9wUCgNHGaz4ZRnE3OiCG9tHcXjUrM7u4UA8ZpAYzE3lqK40+3fr
         ybNSTWbq3yxPIJOUIR9NnaLoSjGLQP4hnoApzaeYa2ocwYTT/gj9DZ2vw2UDCUkx+t8I
         /oORi7qb1Yw1kAVRPfiboeAd5SKsAJ8pvWKPLcHQ8fZhefpsC0DKk6K5Mkc7/3zxqUG8
         NArQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYY1vgtFFXD//OwjPqGseSOxQp8hiIDbuu690xsijzyIm5ecxb0o7GQs/KM1x1V5ZilPVA/eegaDhQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxzH8TF7tuWJnBj25ZCr73jZb2Uza/V6DHEu+CSh/LWWl5Ya40l
	yKTBGqVncLgKIlDZMz7vq+k4/zPyU69ZAW5rX88zljkVppf+YJmPqRvU166RWRn/DUkvtO+cyDy
	FIVcrAkod/6aC09izTWqd7Ig9OuFVhm7phnZ+clgsvZ3BEngKTdMGpk3PGu4JiFU=
X-Gm-Gg: ASbGncsIpcV+9V9uRRPsr5IN20EpPp+fmwA7uMsTXe/8z0G1ScJuMFNsWvfHs52jY8C
	JsCDa/Ef/sfsgYzHrdh1NjDBuABxx6mwRxCrYgHFhDHYIjsSdXlyfiQJYutCEhr1sxb7z+ttciv
	ZVS22Mo1G1jqyh2wkrIFTFTpCpQuqrRkF/SlZA5CMgFl6W0qhFODWBKVsPtCJJ0qRNr/l/mnaC/
	37DNMMg8ncfhzIGPT2ag5fcz9Kc2RK4J7G0+1KPOP3Uf0k23hMgdBB7dTF2LrDaGiv7OB/RR3vu
	OUQLGeoT5kL5ul2GCY1HWyb8b676PshgRgWn1/wDIQDHDoKsIzISpClIXip8yYv/+aDYlPaqRbz
	4ZvU+RcIviCks
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr2786405f8f.32.1758793243368;
        Thu, 25 Sep 2025 02:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrxeBRnYoMGSl0W8MRr9kJ35noutUmBpUjFhjol2reKWsJgQ/uDYSHftZAJXtiFbd/sSnPig==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr2786379f8f.32.1758793242960;
        Thu, 25 Sep 2025 02:40:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e902sm25724495e9.5.2025.09.25.02.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:40:42 -0700 (PDT)
Message-ID: <cd1c6040-0a8f-45fb-91aa-2df2c5ae085a@redhat.com>
Date: Thu, 25 Sep 2025 11:40:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 11:44 PM, Halil Pasic wrote:
> @@ -836,27 +838,39 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	rc = smc_llc_link_init(lnk);
>  	if (rc)
>  		goto out;
> -	rc = smc_wr_alloc_link_mem(lnk);
> -	if (rc)
> -		goto clear_llc_lnk;
>  	rc = smc_ib_create_protection_domain(lnk);
>  	if (rc)
> -		goto free_link_mem;
> -	rc = smc_ib_create_queue_pair(lnk);
> -	if (rc)
> -		goto dealloc_pd;
> +		goto clear_llc_lnk;
> +	do {
> +		rc = smc_ib_create_queue_pair(lnk);
> +		if (rc)
> +			goto dealloc_pd;
> +		rc = smc_wr_alloc_link_mem(lnk);
> +		if (!rc)
> +			break;
> +		else if (rc != -ENOMEM) /* give up */
> +			goto destroy_qp;
> +		/* retry with smaller ... */
> +		lnk->max_send_wr /= 2;
> +		lnk->max_recv_wr /= 2;
> +		/* ... unless droping below old SMC_WR_BUF_SIZE */
> +		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
> +			goto destroy_qp;

If i.e. smc.sysctl_smcr_max_recv_wr == 2048, and
smc.sysctl_smcr_max_send_wr == 16, the above loop can give-up a little
too early - after the first failure. What about changing the termination
condition to:

	lnk->max_send_wr < 16 && lnk->max_recv_wr < 48

and use 2 as a lower bound for both lnk->max_send_wr and lnk->max_recv_wr?

Thanks,

Paolo


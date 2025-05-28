Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0027978C
	for <linux-s390@vger.kernel.org>; Wed, 28 May 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426144; cv=none; b=VQDgh4zC4GDAUUrQvJVUq++ik+73EQmM87f1vnLpeCNq3u8iHtog+fWFzspyh/LjmL09qvkALBU1UGMfZ+pFxIAgASplEO1DGA26+PS+w0fkW1Fk8xBA90CexwbyD4O1uaFHDmmdVaLceSn0D/QswjC3sugy3O4J/J0b2/KPmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426144; c=relaxed/simple;
	bh=Bq9NnJQCLieTHo46SHCR/l5w8PJhavGssYMF/tD3KAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXjHIyHOiv9sjCSHIV7vyMJwBx/LOngqepJak8nhw+7kdR7M8y6dRaCiid5g/qS/EXRqTUMuUOXcswiqZDiabZboDjte3rGvzSl5LvBJjKFJtdcFUsiGN+pBOChMX9hEE9eSrXeHeHLA+azgAqqktQGlb7+HgnvgCyrvjNhU4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5NzDS+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5NzDS+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748426142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/cht4wxLcFIV4a9YvAsqXFOunCOP/XdOXqc3a31CrSY=;
	b=Q5NzDS+VRgfJxrHVi/jzyinvrYwiALS5NDjRHi6hECxIF3YBIvLSBPxtAi66bu0LhaiuMx
	OPSqI9JRWIHOc5tyIqvITHdozhYQwHmgWIzYtmqwrsv/4t3KLjq2OVomXVpmsdkXet0sPO
	Aw8SIbgzrUYfYAxftlfo7x6J3aIE48Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-FZTIM_5UMvC2CUzhKw5oCg-1; Wed, 28 May 2025 05:55:40 -0400
X-MC-Unique: FZTIM_5UMvC2CUzhKw5oCg-1
X-Mimecast-MFC-AGG-ID: FZTIM_5UMvC2CUzhKw5oCg_1748426140
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso25313435e9.0
        for <linux-s390@vger.kernel.org>; Wed, 28 May 2025 02:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748426139; x=1749030939;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cht4wxLcFIV4a9YvAsqXFOunCOP/XdOXqc3a31CrSY=;
        b=dcD4xmZngMSYwtRlm+pN8WApSIBhIo2kDO+bSbaAJ9DiSpccMsQGLn0bzItyWR1ACZ
         jve3OORocErgdGz0W66rDavvZtnnFo1NvbfIeDIjMnqma9Hy5BvhWuqS3TBATkbej1Vl
         6AKxO7XlWY05l2rdaKgN/pmoo1ddgfg/uD4FrSeAmAwgKU+i2kgYgsvbsCpexxO+NRDZ
         +QpDEm853Nlnr/kDoIKISgh/Gg/tB4+cUn48wyvIMbZOS4UFw79Tp/IRzfMfF9jIC9hi
         VlAH/401F+pJJnh0fx+VqfaCJyEqiPFpE7uP6jNT9QRsKF9s+K4PIV/y2nEetCj4QEWM
         iIpw==
X-Gm-Message-State: AOJu0YyUQ4k/RE+JtPsoJixukzaGTWul+yDRMqf/JlOkWLm8vNG74sn8
	+qDIoWJPk+RsVgmGIXxn3L3+1j/avWOcJGPTAYEGl6tmhDOV6Qg0UQm+b94A39Qi6BDoCISvgHd
	Y5lKE6QDIKJ8M3Cx4zSc1Kjc+3NhUNvxYVDNGLtM3TYGMvL0P7bnGSCUmbZLBpqc=
X-Gm-Gg: ASbGnctEaMHhjna+axefAf9KCVPK5033j9t0bpCGnX8U3ajiPrbmmZ0DXo8FgAn2Cgr
	1xvkLHXrEjnONGPPenWobi1e/iZhkQDRhzyHDzU0P0hnxSS4FnDaz0c7GFnNKHFqyC4gFS+aehw
	xw07vcvxgj5CdodSEiomPBLVvryNj/J71BbemB9vh2tMy+o3zBFDwZNoxV/FM00Z76OfDORoGpl
	QaCg3W4NjNvJRMCiZ28RRdRR1A1p4ZVAtJ2c9gOKsdMWqLglQ6pVz2jeAS/3n+bZp1dUztqiZkX
	dvBDCG6j26reJ/fwaqR74YaaeTEOikdkTut50X7sQ6l3y7BDoFMx
X-Received: by 2002:a05:600c:810e:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-45072545a3emr12228195e9.5.1748426139584;
        Wed, 28 May 2025 02:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/QDqORs/FPU6I7L8M2SGEUxj+I4km9Pmeldlp+XFogLbVFnrfaEvD1plPhMd3uKqoFlhGrw==
X-Received: by 2002:a05:600c:810e:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-45072545a3emr12227925e9.5.1748426139154;
        Wed, 28 May 2025 02:55:39 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net. [47.64.112.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac6e6cbsm1024110f8f.15.2025.05.28.02.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:55:38 -0700 (PDT)
Message-ID: <411a5e54-e9c4-4b97-8467-38f371bfd9d5@redhat.com>
Date: Wed, 28 May 2025 11:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: diag10: Fence tcg and pv
 environments
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, david@redhat.com,
 nrb@linux.ibm.com
References: <20250528091412.19483-1-frankja@linux.ibm.com>
 <20250528091412.19483-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250528091412.19483-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2025 11.13, Janosch Frank wrote:
> Diag10 isn't supported under either of these environments so let's
> make sure that the test bails out accordingly.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/diag10.c      | 15 +++++++++++++++
>   s390x/unittests.cfg |  1 +
>   2 files changed, 16 insertions(+)
> 
> diff --git a/s390x/diag10.c b/s390x/diag10.c
> index 579a7a5d..00725f58 100644
> --- a/s390x/diag10.c
> +++ b/s390x/diag10.c
> @@ -9,6 +9,8 @@
>    */
>   
>   #include <libcflat.h>
> +#include <uv.h>
> +#include <hardware.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/interrupt.h>
>   #include <asm/page.h>
> @@ -95,8 +97,21 @@ static void test_priv(void)
>   int main(void)
>   {
>   	report_prefix_push("diag10");
> +
> +	if (host_is_tcg()) {
> +		report_skip("Test unsupported under TCG");
> +		goto out;
> +	}
> +	if (uv_os_is_guest()) {
> +		report_skip("Test unsupported under PV");
> +		goto out;
> +	}
> +
>   	test_prefix();
>   	test_params();
>   	test_priv();

Would it make sense to run test_priv() at least for TCG/PV, too?

  Thomas


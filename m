Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83E19925D
	for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368871; cv=none; b=P2aS7W+QIrcgjEfp+RI9EcOhjP84XCTQc8OZIFHdlk1nuSncVI7AlE3gsMNV02FReO5qeZWTnQ3upHuCtqemmvKPPW026+k90vUqb31z/ZJZwCUcIojMlP1E90e942Fryjy7Po4lieRr++58qZge/6y6Un/RsgK7+WiQfMlwn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368871; c=relaxed/simple;
	bh=mxBwCZ+75CvqTLN1XhZznWwc3o4QKtGNftdDgMJUoUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUXwq1yLtj/Sskz9IT8T8QGY7EVz/gVBKBUhWlP8OFhCOGAGx9b5Hy1dXy5F0zf3Z0yVEbMp9I917PCA7ylUWj+fp2OxSHtIZWn7auwMtKCykdeTC7TORwo+Bn1UB0Dicg+mHOLpFwDp2sZVls6I0Ob5crykU2atub6FoCObmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+1V2ghQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+1V2ghQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730368868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNwUIz30QtNdiMVxCPTr3YIfDnzUPKkej1rAw1oJyCA=;
	b=A+1V2ghQJp/NlScKtlfrpY5ok3ToP3sFE5tfnuAT9Rf5RzdLU047r3SuwWd7KsFW7VFoQy
	Fyls0kGGE3vIqxo4XRAaK5ZVxdqJ6LP5VkYQKefy/q7yThZR23Umvs5gQZmz5tQhQxaxcQ
	gfC3BTKkY1I/IiE+bbgzpO44bxD5jXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-94ZU716XNA6GI0uVkpLOHQ-1; Thu, 31 Oct 2024 06:01:06 -0400
X-MC-Unique: 94ZU716XNA6GI0uVkpLOHQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so5372045e9.1
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2024 03:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368866; x=1730973666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNwUIz30QtNdiMVxCPTr3YIfDnzUPKkej1rAw1oJyCA=;
        b=cFIUN963WDSawVgoYQcGIx2OG53q6EzH/LHOadjSuwkucyut0a7BqSwE4FdLV4XZig
         p/wDJhzItUPj3MUEctqj8g1WQiXjvvTs9jq6C6JPUbi6RF8pwrKnmgKj5yrbscCY8NaH
         3OM1izvqyU20Mgv8CzlWnryf1V1Ob5o+DoqboFyCIQSmxVzpRVixqVX9A/NG5lqzzeRf
         C61Epgk1mbSfwUkx1xRta9MX+HGNLxaKsddOMyWd4F+kkA4A6pJyhG7iDLBEl7Yb6t1W
         adLe7YZ74JJUz36MvKyObiryM7cMnCGK/T5zlYIm2INdHRLIjtJuR3zUXtdMTpK0MIRP
         4Dkg==
X-Forwarded-Encrypted: i=1; AJvYcCU9A4Rogl0T64hfL6wxbUSYmRngt11NyIE09wvQgEP0gaNk3UqWCw+PiyicD/lrYVENTRBU4BgUIjT/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzprq611fTpcHp3eoPtvcQnjecJvYGq8nbp81VQxLQaC/UB1TuD
	4sKHD9XRHXFfLb9YaAIwmnn5Jg+/ngp9aDJlNxiSMIiqRl6h0gnX7eOFOnVRBlnXdE0Ab7Domqp
	bz4YGFcIyfIPcWpFmcT/TaBOLaO/70G/DiMv+zX4aFNwDBZyx5urMhkc9s8o=
X-Received: by 2002:a05:600c:1d84:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-4319ad36a7amr137673665e9.35.1730368865706;
        Thu, 31 Oct 2024 03:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXcf+eLrrEBWd42M24owEstd+6Sm/m+ybY5oz8+0inJZDKxl4Erh9jI+EL0/KuP+rh0hO9Fg==
X-Received: by 2002:a05:600c:1d84:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-4319ad36a7amr137673285e9.35.1730368865280;
        Thu, 31 Oct 2024 03:01:05 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4b0sm19630105e9.14.2024.10.31.03.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:01:04 -0700 (PDT)
Message-ID: <79f0b90d-9420-4e35-9bad-5775c2104c02@redhat.com>
Date: Thu, 31 Oct 2024 11:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Nils Hoppmann <niho@linux.ibm.com>, Niklas Schnell <schnelle@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>,
 Aswin K <aswin@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 09:23, Wenjia Zhang wrote:
> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> alternative to get_netdev") introduced an API ib_device_get_netdev.
> The SMC-R variant of the SMC protocol continued to use the old API
> ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> device driver. Thus, using ib_device_set_netdev() now became mandatory.
> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Please adjust the commit message as per Leon suggestion. You can retain
all the ack collected so far.

Thanks,

Paolo


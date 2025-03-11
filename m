Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FF22CBED
	for <linux-s390@vger.kernel.org>; Tue, 11 Mar 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683598; cv=none; b=qfGI1HIjWL/FqIrmT4eXRmsVUSgqDf7eHcOsoS/Bcg0BeGrCWVkr7qNpo5FK17vKG+dpg9bF+VxSd8bIqLXOD8ObPW/djQ2PSSsGOf1Q2EKhUC68Vexx9O/FYBYzVJrwnyuZ4NAn+m8I65+20V7n3uaUCZv7WBzZVwHOqF2hRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683598; c=relaxed/simple;
	bh=iA6mnCj7Qy5YCe/bg0WzxBq0xFn9tOEWd8Sg/pfOH78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyQBYpiu/tKezlrmwewslf5ei7P9ZbcTlCYWY3UeZZKhCkbyHZ/ANQCPiVQoN9YorbkCk67v+wQhd3YeO7KuGOl+nDobBQkI5ftHi+upAVVKMXWMM06AHrD3lsXkzlxxKWK34cXgu0/hJL/W4xqTN4Clj5xp6cYL8rSSnhiRMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPYLoAxQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPYLoAxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741683595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqnlKZZInNbUMVaxemGpweqmwSoqd9viWeAicyRcRjo=;
	b=UPYLoAxQzW1B1fjTrZ9cNstv7tRA+devNR6g6ycjdH2bsX5OkNHVMdY6kfc3Ejd2VGfIFX
	mQEOllaSLQAvaPAovt/bG3bMx3d48OgR5duwe5dnJ97XEFJQw9fpBIcEN2B5eu/bewMnKn
	4EftR+9kJSRQOcGlVORUYy4tpXM6pT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-n2cQwi0kNoS9OB11866_HQ-1; Tue, 11 Mar 2025 04:59:54 -0400
X-MC-Unique: n2cQwi0kNoS9OB11866_HQ-1
X-Mimecast-MFC-AGG-ID: n2cQwi0kNoS9OB11866_HQ_1741683593
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so12018065e9.3
        for <linux-s390@vger.kernel.org>; Tue, 11 Mar 2025 01:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683593; x=1742288393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqnlKZZInNbUMVaxemGpweqmwSoqd9viWeAicyRcRjo=;
        b=N1A3ziLGYNAZU+6tdy7U+Cp3rlZwzYRbCDSEhQv3QMcdm9TtACfoKfxqP4soHURT/8
         gwRMSt5dQcswkYd66GDiy2SOIPOYg0JQyCmmNqFMC8K1wj6pZX05bHiZs3EMbRVMC0Sy
         lc8+ByZN4j0YAGWMEvSmgmzc24T0uLJ6rcOrdkogG7ERQvmmdPczRhj6unf13/1K8uAz
         CRHQ9D6BLgZ6eTkKhCaF1Ek1iPUQhLkXyGEgm5P94ZXm/RXUhTBpoHagbQ8717bi/V5p
         iEqhIQ974pC/pRb4efB9UNJKoSP75Z01Gmugn4zZ0E8NvNzj0rpbQyR6YKMYkeUPFbQv
         Ln+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFiWelnFN3oZ2GgD8OuZXoIfIZLev9EXho5T1B+xkg1ooIoyYUgtn1N4AJESb1se7kGxM8UV6w8Eu1@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIIi7USSBYe/5lS7ODSLYkpT65VdTqN8mwkQ+mZUnLtU7FhQI
	U5xYMANSMbPwU8J0u6WAcaXW4ME3CAgvhj9Y8icJETq0PnHEVKtayuOexkfdtYq34CAL0qoJ5hT
	rdZcKkl47sV/DYZ8R4gcphbHCjxB8yrD0ln0RzSPwiu8oEJtaAsjCA6KY0/c=
X-Gm-Gg: ASbGncvdqnc368KHLPF23EGzfYOIXy4p8vu8ySUDWW/3egAE81MD+C8ucBWsf1pUh92
	622xL8hHPaczDzbTr0u90nfzmDIiSki0wkcC6Fec+J7+70VqupCgn3OqMWm1gJItSwQ6BirShgC
	yU5ovqwKltjr2SYqYaevUWBxxfw/RToEsVl7+WCOCUOkZGJVvAep3SbHJeEPCSqn2ld2ZgoC5zc
	NhiMGtd8cZ3dOFz1Wfjkm8qTwynirzscv5XpHgtaIZCrD95AwZfpaETXEOEz76CXk8cIJ6GdW+0
	2oaZquEQLO62xQdBqlOBLOLZL6xpo6qU84ZccoRC2DinUg==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d01bdbc01mr40750315e9.10.1741683593083;
        Tue, 11 Mar 2025 01:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ5AVycEeQIEPH/bGBFOO7jW/oC4hoyt2MafohO5QdfjBwnRvqtWeJdoi9Lli+bBR0MxeIMA==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d01bdbc01mr40750015e9.10.1741683592688;
        Tue, 11 Mar 2025 01:59:52 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79cfsm17510326f8f.10.2025.03.11.01.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 01:59:52 -0700 (PDT)
Message-ID: <2c9accbd-fd6f-421c-9d00-1f36a6152b8d@redhat.com>
Date: Tue, 11 Mar 2025 09:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find pnetid
 by pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 pasic@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 1:43 PM, Guangguan Wang wrote:
> When using smc_pnet in SMC, it will only search the pnetid in the
> base_ndev of the netdev hierarchy(both HW PNETID and User-defined
> sw pnetid). This may not work for some scenarios when using SMC in
> container on cloud environment.
> In container, there have choices of different container network,
> such as directly using host network, virtual network IPVLAN, veth,
> etc. Different choices of container network have different netdev
> hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
> in host below is the netdev directly related to the physical device).
>             _______________________________
>            |   _________________           |
>            |  |POD              |          |
>            |  |                 |          |
>            |  | eth0_________   |          |
>            |  |____|         |__|          |
>            |       |         |             |
>            |       |         |             |
>            |   eth1|base_ndev| eth0_______ |
>            |       |         |    | RDMA  ||
>            | host  |_________|    |_______||
>            ---------------------------------
>      netdev hierarchy if directly using host network
>            ________________________________
>            |   _________________           |
>            |  |POD  __________  |          |
>            |  |    |upper_ndev| |          |
>            |  |eth0|__________| |          |
>            |  |_______|_________|          |
>            |          |lower netdev        |
>            |        __|______              |
>            |   eth1|         | eth0_______ |
>            |       |base_ndev|    | RDMA  ||
>            | host  |_________|    |_______||
>            ---------------------------------
>             netdev hierarchy if using IPVLAN
>             _______________________________
>            |   _____________________       |
>            |  |POD        _________ |      |
>            |  |          |base_ndev||      |
>            |  |eth0(veth)|_________||      |
>            |  |____________|________|      |
>            |               |pairs          |
>            |        _______|_              |
>            |       |         | eth0_______ |
>            |   veth|base_ndev|    | RDMA  ||
>            |       |_________|    |_______||
>            |        _________              |
>            |   eth1|base_ndev|             |
>            | host  |_________|             |
>            ---------------------------------
>              netdev hierarchy if using veth
> Due to some reasons, the eth1 in host is not RDMA attached netdevice,
> pnetid is needed to map the eth1(in host) with RDMA device so that POD
> can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
> as Terway, network management plugin in container environment), and in
> cloud environment the eth(in host) can dynamically be inserted by CNI
> when POD create and dynamically be removed by CNI when POD destroy and
> no POD related to the eth(in host) anymore. It is hard to config the
> pnetid to the eth1(in host). But it is easy to config the pnetid to the
> netdevice which can be seen in POD. When do SMC-R, both the container
> directly using host network and the container using veth network can
> successfully match the RDMA device, because the configured pnetid netdev
> is a base_ndev. But the container using IPVLAN can not successfully
> match the RDMA device and 0x03030000 fallback happens, because the
> configured pnetid netdev is not a base_ndev. Additionally, if config
> pnetid to the eth1(in host) also can not work for matching RDMA device
> when using veth network and doing SMC-R in POD.
> 
> To resolve the problems list above, this patch extends to search user
> -defined sw pnetid in the clc handshake ndev when no pnetid can be found
> in the base_ndev, and the base_ndev take precedence over ndev for backward
> compatibility. This patch also can unify the pnetid setup of different
> network choices list above in container(Config user-defined sw pnetid in
> the netdevice can be seen in POD).
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>  net/smc/smc_pnet.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 716808f374a8..b391c2ef463f 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1079,14 +1079,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
>  					 struct smc_init_info *ini)
>  {
>  	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
> +	struct net_device *base_ndev;
>  	struct net *net;
>  
> -	ndev = pnet_find_base_ndev(ndev);
> +	base_ndev = pnet_find_base_ndev(ndev);
>  	net = dev_net(ndev);
> -	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
> +	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
>  				   ndev_pnetid) &&
> +	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
>  	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
> -		smc_pnet_find_rdma_dev(ndev, ini);
> +		smc_pnet_find_rdma_dev(base_ndev, ini);
>  		return; /* pnetid could not be determined */
>  	}
>  	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);

I understand Wenjia opposed to this solution as it may create invalid
topologies ?!?

https://lore.kernel.org/netdev/08cd6e15-3f8c-47a0-8490-103d59abf910@linux.ibm.com/#t

Wenjia, could you please confirm?

Thanks,

Paolo


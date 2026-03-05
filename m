Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64133A9CB
	for <linux-s390@vger.kernel.org>; Thu,  5 Mar 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697422; cv=none; b=OE4+bNC+Zx7nCo1OZSy+I/fbkaabbojilDkoL/PRbUA/8inIIRMNVPe6tPMOHC60ZWv79grVPWtjriORe9obzJlglFwbu+/e5OgFNlIKcYQYoN0pjsyrOGPdSmu5xocFwrGS1H3idlKsYRNZY+NlIGz5G/psF1cPF4cT1OApAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697422; c=relaxed/simple;
	bh=4wIxeVTtUPRh42TWlTdhNgCgomVeyReKlBgjR5dJ2js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJgimIH7n0yeZqzjXD2jojwoLEsWim7KHqYx/t7aZbIPfafho25xfCzXHE5sfpCk5c4svVHTy4K+44sbLXmfvGoxy6ULuII7F+ZJ+HlzhBCoWGPA7cedu3YE8x9VE2ZrsW1+DUIlgaVGCVtwKYaBAJ2/EmqHo5T7VGNFJbzIMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEHco10t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEHco10t"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483487335c2so63652005e9.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Mar 2026 23:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772697419; x=1773302219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLoLFtQnBLuT+MV5dFOmu6NN10b/asgsiLccSm2U4ts=;
        b=bEHco10taJSnYvPwnxuD+kIz+NYB6VxwovQeBraNNHDnrOVfgA9wI7t8wvQkHHZHua
         W6jYrIvNdN4B1n3pNfcPVz9GtvzYvvTzfSl0Dgyh0rpzyizBAMe2ZjP5oN328a8I6aei
         4iU97xIoe4rC/m63EL3WTFyDWEWPd6+jM/6O9GQvdE4DxA45rOtVcjYRHBEC2Ikx0Qel
         2Zi1ZlVbh/kzKX6//yZHY1w0pTFB4isOPEPwg6v5ocaoKfPabKHMqeeVY/6xSUVSmHyy
         3aZBtUD6mAbauP3kPhEcugYBEcma4Nl29Eb0m4Hro0TixXExEkWkMN9jH3C+43/I0RcR
         3Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772697419; x=1773302219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLoLFtQnBLuT+MV5dFOmu6NN10b/asgsiLccSm2U4ts=;
        b=wXOHlYGohcTmC0pdPF9+JhEhpbGeAeFHsblDtmFUwmTtqOS3PamI+DhBI9m9ycklsC
         OHC2ErR0L9l514FGrPpw8k00C855oS23JoqAPodcIWJ+IpMDMsA+pbjIYjY9KYsma3Uf
         SvWnq1MBuWjDCiURdIcI2Q163j/fXRB+5m+oelm0jRFFL3JYUGp8mtFZR0dPrw6RyEro
         wWgprKyinAp0AyCqnR/RN98ropvvQcp/HuLOaZHOZjTQGCkMYj5Jnuu5GSe9NNHXJEYs
         7G/5wnLxJs1bRz6JuLA373Fk+hggJQrlHtRGKuuR1OpyS6qJyAb76mDyykUaysoGWkFB
         PdRA==
X-Forwarded-Encrypted: i=1; AJvYcCVg9ZkIZTvZLq/pG72Ewh8BKc2Rx6Vg25oXWIIGlr2RAqIuxBkcLn371zmwCgI0vwXNlBym4E4BgmhF@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXiDD+vuvpz7s4PT1TGTTfzyNgfUKGZj7V/zznG0P01q6ISWQ
	Zhi8hw5JUQ9AhxMq6woejfpqn/cmZyu/Vh8Ki/UpiIOOKElhYN69IPQ4
X-Gm-Gg: ATEYQzzJedGp3WOttkN15mpIxfzJ3CUVmx5k8BBYi4A+WDOkHJnyidtC8b5MbJH1SNz
	AxevlimXHCLESw4/DOb/bo4IRBbg18XgcWaW1THddaR3GcJ1tdUNRUgEDdKHH5Lq1JI/93SM8dh
	afUMM2u8H+7a8v8f9mUYeO6NZ3uu4EYsbxXmeDSWjz5714OIArDwX5X90KiUF4Q5vFQk61DJtAG
	WW/rlPZm7SjujfHw296mQux/CmKrKwT2kmBLP+K8mb99xWaht979C+24VLFegIZTUigcnKVogK6
	y/70WqOhAZZVLaccn5gZ4G6+Y1qBUDbEgvOGwUJaBewYNJoyhU6/IeLMfP+sbp6WBBUI3PWbjPS
	evq9b4pYFOqjrBTnCNcpV0vDcTWTzh41wh79ADwkV3WYXA/BekFDk5NRyYZ3I8vHWYfnk9qREk9
	GhtiD/t4yeOHhODXlnW0HEBxfDZxSwmH/q8zB7NFD2gDcFRPkVHQ==
X-Received: by 2002:a05:600c:1d09:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-4851988366bmr83224505e9.23.1772697418510;
        Wed, 04 Mar 2026 23:56:58 -0800 (PST)
Received: from [10.221.137.160] ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fadf67bsm36856295e9.6.2026.03.04.23.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:56:58 -0800 (PST)
Message-ID: <d6fcf417-87b1-4bbe-9ec1-cabb2b2ed1a6@gmail.com>
Date: Thu, 5 Mar 2026 09:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Allow asynchronous probe
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260303-parprobe_mlx5-v1-1-18194f2a1a3a@linux.ibm.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260303-parprobe_mlx5-v1-1-18194f2a1a3a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/2026 12:33, Gerd Bayer wrote:
> Announce that mlx5_core supports asynchronous probing.
> 

Hi Gerd,
Interesting patch.

> Tests on s390 - where VFs can show up isolated from their PF in OS
> instances - showed symptoms of "mlx5_core: probe of 00e7:00:00.0 failed
> with error -12" when booting a system with a large number (> 250) of
> Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
> (15b3:101e) PCI functions.
> 
> Turns out that this is due to systemd-udev's time-out supervision of
> "modprobe" killing the sequential initialization of additional functions
> if probing exceeds a default of 180 seconds.
> 
> According to [1] device drivers could (slow ones should!) opt-in to have
> their probe step being executed asynchronously - and interleaved. With
> the mlx5_core device driver announcing PROBE_PREFER_ASYNCHRONOUS as
> proposed by this patch, we've measured 275 VFs being probed successfully
> in about 60 seconds.
> 

Nice.

> [1] https://www.kernel.org/doc/html/latest/driver-api/infrastructure.html
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Hi all,
> 
> this patch helps to speed up boot times when there are a large numbers
> of Mellanox/NVidia VFs in a configuration. Although we've seens real
> issues, I'm hesitating to declare this a fix of commit 9603b61de1ee
> ("mlx5: Move pci device handling from mlx5_ib to mlx5_core") primarily
> because the concept of asynchronous probing with commit 765230b5f084
> ("driver-core: add asynchronous probing support for drivers") was
> introduced only later.
> 
> Thanks,
> Gerd Bayer
> ---

This is an interesting problem, and the proposed solution looks 
reasonable. That said, this is a very sensitive area and there may still 
be hidden assumptions or corner cases we haven't considered. This needs 
thorough testing across a wide range of real-world scenarios and 
different system topologies before we can be confident in it.

We'll take this for testing and report back once we have results.

BTW, as you probably know, a possible workaround is to increase the 
systemd-udev timeout.
What timeout is required for it to succeed without this change?

>   drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index fdc3ba20912e4fbc53c65825c62e868996eff56d..b53fc3f2566acf5a07cb8df649124c4a87f3e043 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -2306,6 +2306,9 @@ static struct pci_driver mlx5_core_driver = {
>   	.sriov_configure   = mlx5_core_sriov_configure,
>   	.sriov_get_vf_total_msix = mlx5_sriov_get_vf_total_msix,
>   	.sriov_set_msix_vec_count = mlx5_core_sriov_set_msix_vec_count,
> +	.driver		= {
> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> +	}
>   };
>   
>   /**
> 
> ---
> base-commit: c69855ada28656fdd7e197b6e24cd40a04fe14d3
> change-id: 20260303-parprobe_mlx5-d10d2a746d3a
> 
> Best regards,


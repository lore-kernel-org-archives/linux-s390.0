Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED83314A1
	for <linux-s390@vger.kernel.org>; Thu,  4 Dec 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836849; cv=none; b=SXxG8eCSunFrF43W5e4VSvVavx7NivcaeW54AKhlOsfo8tK/ft84EWouimQAVmOLJVKIlNbELOkTOxREr2zJnps0jD0k/fSa/9Qf3n3Jqcm07XGszqMzjXbcooCSDUaaDrTdDWPHcDz5019Yw0p8coGBOrR1l81MIlpHsLGcBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836849; c=relaxed/simple;
	bh=+mJapQUcgIG/gMfIXcsKANm2CElCwdjZuVxCtHLEwxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvOFQGBNDLfuRO3gqvHcSXDkEz2uYodpoAsxCZYJzPzXzP1zi/p8+ASGWrw8edvvAnG9ClN/Hcy7G7LdqaVtC5fER/aqDFV9+3rzDnySRodsHv84bd71ciywOoULzMA5gy56nbRkK/XvrMXg1yXPBj3/Wk0GXTE23ldVl6r/HnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDwPM5S0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDwPM5S0"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2e40582eso383060f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 04 Dec 2025 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764836846; x=1765441646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk4Me8kGllHr/VDwvtsYkc5klFKItoxmBTnZhaBfwbM=;
        b=CDwPM5S08fh9JhPXyvVPbvm2Pw9U39wGIKSNwVHgCsQAXg9PMLSSZuqMYQvvNSC3I8
         UBgFCo12qkaz9VnC4HsBIcqfXy7KpXGvFMg+AyLWTXS3pmr5LTF7oJ1t+2AfaybgjiGK
         n7HBboT9VvquQlMaSxJyN04HtIi3LaG8wf/ubSYSzrS3mqJjzKa0rtrRNKxVtgePjKnf
         Ub3cECCfVs7KvxyNhf+MXV8rFFUpOGzLyd6SDAxy8HMR2hOk3fMN+9mUqlWtOkFipTIk
         QtkPp9+NRsy34tSog+hGmJupf/fUSr97qPtNoYPSzcQEz9uvkXiHdvjUeqrgLK8gnL+X
         i77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764836846; x=1765441646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk4Me8kGllHr/VDwvtsYkc5klFKItoxmBTnZhaBfwbM=;
        b=I709fYpTywrQ4avqBEivC8H2ijPrlXvCmToUESZ19XFmKIepf3NgWHjVd5LaZSfvKz
         fQYtPg2zlTH6OYdPCDcXRpFo/Aq14YCwMNhDprWrks1HlfN0h0OdiIJhVbDUv+JNFHEV
         +NdYbKAA4oA7Z1ytuqD3xMMK3ciLT1wFIgVxVQd/QRko4sQ/6UmvuJRt0orpYpPtbdGZ
         Cg9+h0GcDT+FYE6S7PcgEqOq8FIkJ/UkP7TeisIm/wy9tldLRodqqnuGOy6N5Ix5spZx
         4+uJrDdvzTyHxA7k2tBTNxvWU0ACFK5nVuW0KhrodqR5/n86mNyfqx6YW0exhLEL/pwm
         T8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXtIGrWRCyq4fJV1M1jVApZ6s3vFiO721rGtDvsVHod/APiRGYDpQVU86KsM/EmqPVDkH6xMuzUJzqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzfClt5AEt9e87gHYBavglaGiGRQbEKrjP1aes7mN9lcFbLvKXe
	paN2+osfB7yBVWwQKw9PnVwetwK277mwRbB/IxU5pE7EIa+oJgF9H90d
X-Gm-Gg: ASbGnctNFcE/GxKxS+xEkhimfi3f+TBAdNcnttN/v0qL2cZsFpDxKndCpWla9nb2Qhq
	UHBBAZ3TW/Xy1Eo8kaW0oNgex7IwtLTaQ3UvyfOh1SAbcBwpovRkTefqvN6qgdINLtu1YYec4Yq
	BDs+2gUPi2C5NuD/yGaDAurIztM+6FysTmcYov0XpECNSNAdVq9axUzg1dSSGPgN3C1po7mBEoq
	hIYwRZ2PxNr+k6ok3bx0UFJ2/b6dj52FI6U+vzaUHm1cQAK+tjK7wBBJha++MV21ZUxTixHo/mj
	8EVSMLZchRRC6O+lZVer+T+5/rCTEVuM/WjaO+m/OCcLvo9T8GAKn/IhbnNxNhGNACr3s5+fKXI
	aeWHXHwK4rfn90ExDZg+FbbAUDHwvLKR5qBpTvf01LjV8aLaFcY+aRFzsuDNXHGwD9xzoVQUrVz
	qdVA8BKrmDHCQQ5RXiIjeDhOR7iRTV9HJyzTM=
X-Google-Smtp-Source: AGHT+IH0YMI90ZQb6ct+nat8DtXdZsUN3AYv/eA+GemdRzLIQywet3ITexoNTtRP65Z6ow9GuR0Ipw==
X-Received: by 2002:a05:6000:24c6:b0:42b:394a:9b1 with SMTP id ffacd0b85a97d-42f79841510mr1872635f8f.37.1764836845435;
        Thu, 04 Dec 2025 00:27:25 -0800 (PST)
Received: from [10.221.198.188] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe90f0sm1864164f8f.9.2025.12.04.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 00:27:24 -0800 (PST)
Message-ID: <825efa1d-363a-4e82-8dc1-d7520c413414@gmail.com>
Date: Thu, 4 Dec 2025 10:27:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
To: Farhan Ali <alifm@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shay Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
 <99db437a-be91-4e85-a201-ec3a890900c8@linux.ibm.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <99db437a-be91-4e85-a201-ec3a890900c8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/12/2025 23:10, Farhan Ali wrote:
> 
> On 12/2/2025 3:12 AM, Gerd Bayer wrote:
>> Clear hca_devcom_comp in device's private data after unregistering it in
>> LAG teardown. Otherwise a slightly lagging second pass through
>> mlx5_unload_one() might try to unregister it again and trip over
>> use-after-free.
>>
>> On s390 almost all PCI level recovery events trigger two passes through
>> mxl5_unload_one() - one through the poll_health() method and one through
>> mlx5_pci_err_detected() as callback from generic PCI error recovery.
>> While testing PCI error recovery paths with more kernel debug features
>> enabled, this issue reproducibly led to kernel panics with the following
>> call chain:
>>
>>   Unable to handle kernel pointer dereference in virtual kernel 
>> address space
>>   Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803 ESOP-2 FSI
>>   Fault in home space mode while using kernel ASCE.
>>   AS:00000000705c4007 R3:0000000000000024
>>   Oops: 0038 ilc:3 [#1]SMP
>>
>>   CPU: 14 UID: 0 PID: 156 Comm: kmcheck Kdump: loaded Not tainted
>>        6.18.0-20251130.rc7.git0.16131a59cab1.300.fc43.s390x+debug #1 
>> PREEMPT
>>
>>   Krnl PSW : 0404e00180000000 0000020fc86aa1dc 
>> (__lock_acquire+0x5c/0x15f0)
>>              R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>>   Krnl GPRS: 0000000000000000 0000020f00000001 6b6b6b6b6b6b6c33 
>> 0000000000000000
>>              0000000000000000 0000000000000000 0000000000000001 
>> 0000000000000000
>>              0000000000000000 0000020fca28b820 0000000000000000 
>> 0000010a1ced8100
>>              0000010a1ced8100 0000020fc9775068 0000018fce14f8b8 
>> 0000018fce14f7f8
>>   Krnl Code: 0000020fc86aa1cc: e3b003400004        lg      %r11,832
>>              0000020fc86aa1d2: a7840211           brc     
>> 8,0000020fc86aa5f4
>>             *0000020fc86aa1d6: c09000df0b25       larl    
>> %r9,0000020fca28b820
>>             >0000020fc86aa1dc: d50790002000       clc     0(8,%r9),0(%r2)
>>              0000020fc86aa1e2: a7840209           brc     
>> 8,0000020fc86aa5f4
>>              0000020fc86aa1e6: c0e001100401       larl    
>> %r14,0000020fca8aa9e8
>>              0000020fc86aa1ec: c01000e25a00       larl    
>> %r1,0000020fca2f55ec
>>              0000020fc86aa1f2: a7eb00e8           aghi    %r14,232
>>
>>   Call Trace:
>>    __lock_acquire+0x5c/0x15f0
>>    lock_acquire.part.0+0xf8/0x270
>>    lock_acquire+0xb0/0x1b0
>>    down_write+0x5a/0x250
>>    mlx5_detach_device+0x42/0x110 [mlx5_core]
>>    mlx5_unload_one_devl_locked+0x50/0xc0 [mlx5_core]
>>    mlx5_unload_one+0x42/0x60 [mlx5_core]
>>    mlx5_pci_err_detected+0x94/0x150 [mlx5_core]
>>    zpci_event_attempt_error_recovery+0xcc/0x388
>>
>> Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG 
>> layer")
>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>> ---
>> Hi Shay et al,
>>
>> while checking for potential regressions by Lukas Wunner's recent work
>> on pci_save/restore_state() for the recoverability of mlx5 functions I
>> consistently hit this bug. (Bjorn has queued this up for 6.19, according
>> to [0] and [1])
>>
>> Apparently, the issue is unrelated to Lukas' work but can be reproduced
>> with master. It appears to be timing-sensitive, since it shows up only
>> when I use s390's debug_defconfig, but I think needs fixing anyhow, as
>> timing can change for other reasons, too.
>>
>> I've spotted two additional places where the devcom reference is not
>> cleared after calling mlx5_devcom_unregister_component() in
>> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
>> addressed with a patch, since I'm unclear about how to test these
>> paths.
>>
>> Thanks,
>> Gerd
>>
>> [0] https://lore.kernel.org/all/cover.1760274044.git.lukas@wunner.de/
>> [1] https://lore.kernel.org/linux-pci/ 
>> cover.1763483367.git.lukas@wunner.de/
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> index 
>> 3db0387bf6dcb727a65df9d0253f242554af06db..8ec04a5f434dd4f717d6d556649fcc2a584db847 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> @@ -1413,6 +1413,7 @@ static int __mlx5_lag_dev_add_mdev(struct 
>> mlx5_core_dev *dev)
>>   static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev 
>> *dev)
>>   {
>>       mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
>> +    dev->priv.hca_devcom_comp = NULL;
>>   }
> 
> Though this fix looks correct to me in freeing hca_devcom_comp (not too 
> familiar with mlx5 internals), I wonder if it would be better to just 
> set devcom = NULL in devcom_free_comp_dev() after the kfree? This would 
> also take care of other places where devcom is not set to NULL?
> 

Setting NULL after the kfree will have no impact, it won't nullify the 
original field, but the function parameter copy (by-value).

devcom_free_comp_dev() and mlx5_devcom_unregister_component() get struct 
mlx5_devcom_comp_dev *devcom to work with, they can't nullify it for the 
caller context.



> Thanks
> 
> Farhan
> 


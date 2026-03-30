Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A027393DF7
	for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903279; cv=none; b=GpB0YjZyvMhKKxUTis3i9XPXOrHolnkogkhVNEKFHsVxrce8NMnb8oIPjLNo3mPZJM2fddthzsJyJ3lwyMgZKxNXB4pJChLx6pjni2f6KyLt9djjGAtFR0H7CFObQUX+nGbevX5bBUwPE3PEYUwOBZza4buSpL96puXZtd0YZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903279; c=relaxed/simple;
	bh=9uIbPXwWsurj9l5HFm8RLxB2sjiX4yhEJkqSj3hWVK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmFMBL8Wlj7TG1IrgzoRO5xj515+T5GHWz5JxLNf8yMfDwevTDxMUIPgGLon/yChb3CYbX3vA4SiRp0XaVBZZ45qQ/sqD9wYe/jlaufB/igGoD//HA4Mdgx9aLgyBsKEy++IAjDYfdKcNwrrESzhYvkFyY9osjg9GSxPP67hcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=gfrBUX57; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="gfrBUX57"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd7ecedf2cso512604685a.3
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1774903276; x=1775508076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wXDBgKhrFka/ZVFt0EHIQCYNPYyORHFuU+s65Tm4Q4=;
        b=gfrBUX57Gn/I6wQtu9zduwQaIMPGqw78YhjmjHKEmrxBGcKnpTKGfy0thRMur/FxaK
         LOpp/lQvNGFP3e8L5UnetEf8P/mvZpJIHfZgnAWvy70Q6jjy/QPump+34bwq1U0THNTV
         i5MdrYDwyfOVZA4K+vcpy3t73oDyLcYNZF/DUxPkqrFAf/CxpKTXPboA0D+OuKD1HqTY
         SyqCLMp7ofeLxJVeYkFsunG6JQPWNoMRDcZuH+x6jihRZyQ5NXzHQAB++Xi3up/6Qf+0
         +KBw/odtSW6f3TbNyigW2cN0B8wVNz0+pEDtdD7g5/AEXGaMIRT+EXinCtAbbfeYEgYi
         W3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903276; x=1775508076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wXDBgKhrFka/ZVFt0EHIQCYNPYyORHFuU+s65Tm4Q4=;
        b=s2EdarXXOXXZavHteHcWPrBFV2+ywXzkyeQNFSveWt7PhYt5/cF0W2weZg1mk0j1jr
         H2G4jqfsyC6uMTd1NYgPoVvYnUoSNJ7kirpEhhBkEvBJ+G53XMRjNpS4/mb+WjKWZdFc
         wE0CeMMtwXA2ZbXjChhqMheGD1KxbfAXaOZiiHtAgnQdLJCXkINvyBSR1ifueqdLu9dK
         taJRvspced9YiHkdl95yGYiQIFLV+lcv1uY5OefzpTOPH1wChS36W7mS99Sn54yViVmd
         u2AqkwnQGH3ndthdWkIcYIIamLzWDhaF+gpmn0EDHNsS6yRg22+jdJI+xEMF10cLG8l1
         mPVw==
X-Forwarded-Encrypted: i=1; AJvYcCU8RybrvTJo1LMuyighvkaF9P6Z5MYlSMPWuyofWieoV/rcq5j/3nWUHbX5DPP3od+tmcG4DzxRFyNc@vger.kernel.org
X-Gm-Message-State: AOJu0YymJ4AEBC2iXgAzv8vxaunIJm/Mym6eZBRRjJ5Mzw4RifvqHTZr
	ZGBDRqafCCFx22lJwUEL7YLo9OOGMf7IBl6OH6oCyx0ugjnC9YxzI8No+dqkbei6RA0=
X-Gm-Gg: ATEYQzzxWs6vwMu6aS47+0QZzn4Q0oo1wzp+J3l49E7HDVwpaeluYaHqzpVjXmebFGQ
	f1hZj0IqcX99sfWVvUgYXpl9hIEUdGTCcl9p8Tj3T0+8zEUKX3uOvLSerz0zYWQKHqEfEV/kgMo
	fYH3eDW8o+50/uwRY+HlbvryzvW+PsmCL2hx3NN6D2q3VAogErQHQUTSasE9gLNQCb0Mwk5uBpM
	BbLox20OX/6cI5tyQikBx87Iu30JOHW19S62qr6B9agtNhSn33MRnMKwfCQAY2Kv/ndxG7J0pg/
	81mK9F921F4BJEC1+xm/iX+m8kIVtDExCcj5wnlUaP6YMPuYZtzE7M1qXzlz6TTJJfx82oRZ2QZ
	zz5rlk1j2r+fe5IePxvmLDlfZbERfYFXAbHEVweKRuZEVTaFxCl43xji1JMh0fllr03NTCFVcdx
	7KxaP+MKKvwEvu/bXJ4hhnbihJNpRUWufs
X-Received: by 2002:a05:620a:46a7:b0:8cd:b7bc:5184 with SMTP id af79cd13be357-8d01c617642mr1827202885a.8.1774903275859;
        Mon, 30 Mar 2026 13:41:15 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edc650sm677771885a.6.2026.03.30.13.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:41:15 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:41:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] mm: switch deferred split shrinker to list_lru -
 [s390] panic in __memcg_list_lru_alloc
Message-ID: <acrf5_rS7hO5Ec0Q@cmpxchg.org>
References: <20260318200352.1039011-1-hannes@cmpxchg.org>
 <20260318200352.1039011-8-hannes@cmpxchg.org>
 <4d3f8d79-3593-47df-9de8-f94f7f09a403@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3f8d79-3593-47df-9de8-f94f7f09a403@linux.ibm.com>

Hello Mikhail,

On Mon, Mar 30, 2026 at 06:37:01PM +0200, Mikhail Zaslonko wrote:
> with this series in linux-next (since next-20260324) I see a reproducible panic on s390 in the
> dump kernel when running NVMe standalone dump (ngdump).
> This only happens in the 'capture kernel', normal boot of the same kernel works fine.
> 
> [   14.350676] Unable to handle kernel pointer dereference in virtual kernel address space
> [   14.350682] Failing address: 4000000000000000 TEID: 4000000000000803 ESOP-2 FSI
> [   14.350686] Fault in home space mode while using kernel ASCE.
> [   14.350689] AS:0000000002798007 R3:000000002d2c4007 S:000000002d2c3001 P:000000000000013d 
> [   14.350730] Oops: 0038 ilc:3 [#1]SMP 
> [   14.350735] Modules linked in: dm_service_time zfcp scsi_transport_fc uvdevice diag288_wdt nvme prng aes_s390 nvme_core des_s390 libdes zcrypt_cex4 dm_mirror dm_region_hash dm_log scsi_dh_rdac scsi_dh_emc scsi_dh_alua paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey dm_multipath autofs4
> [   14.350760] CPU: 0 UID: 0 PID: 32 Comm: khugepaged Not tainted 7.0.0-rc5-next-20260324 
> [   14.350762] Hardware name: IBM 3931 A01 704 (LPAR)
> [   14.350764] Krnl PSW : 0704d00180000000 000003ffe0443a82 (__memcg_list_lru_alloc+0x52/0x1d0)
> [   14.350774]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> [   14.350776] Krnl GPRS: 0000000000000402 00000000000bece0 0000000000000000 000003ffe1c17928
> [   14.350778]            00000000001c24ca 0000000000000000 0000000000000000 000003ffe1c17948
> [   14.350780]            0000000000000000 00000000000824c0 0000037200098000 4000000000000000
> [   14.350782]            0000000000782400 0000000000000001 0000037fe00f39b8 0000037fe00f3918
> [   14.350788] Krnl Code: 000003ffe0443a72: a7690000            lghi    %r6,0
> [   14.350788]            000003ffe0443a76: e380f0a00004        lg      %r8,160(%r15)
> [   14.350788]           *000003ffe0443a7c: e3b080b80004        lg      %r11,184(%r8)
> [   14.350788]           >000003ffe0443a82: e330b9400012        lt      %r3,2368(%r11)
> [   14.350788]            000003ffe0443a88: a7a40065            brc     10,000003ffe0443b52
> [   14.350788]            000003ffe0443a8c: e3b0f0a00004        lg      %r11,160(%r15)
> [   14.350788]            000003ffe0443a92: ec68006f007c        cgij    %r6,0,8,000003ffe0443b70
> [   14.350788]            000003ffe0443a98: e300b9400014        lgf     %r0,2368(%r11)
> [   14.350825] Call Trace:
> [   14.350826]  [<000003ffe0443a82>] __memcg_list_lru_alloc+0x52/0x1d0 
> [   14.350831]  [<000003ffe044529a>] folio_memcg_list_lru_alloc+0xba/0x150 
> [   14.350834]  [<000003ffe04f279a>] alloc_charge_folio+0x18a/0x250 
> [   14.350839]  [<000003ffe04f34dc>] collapse_huge_page+0x8c/0x890 
> [   14.350841]  [<000003ffe04f4222>] collapse_scan_pmd+0x542/0x690 
> [   14.350844]  [<000003ffe04f65b4>] collapse_single_pmd+0x144/0x240 
> [   14.350847]  [<000003ffe04f69ce>] collapse_scan_mm_slot.constprop.0+0x31e/0x480 
> [   14.350849]  [<000003ffe04f6d3c>] khugepaged+0x20c/0x210 
> [   14.350852]  [<000003ffe019b0a8>] kthread+0x148/0x170 
> [   14.350856]  [<000003ffe0119fec>] __ret_from_fork+0x3c/0x240 
> [   14.350860]  [<000003ffe0ffa4b2>] ret_from_fork+0xa/0x30 
> [   14.350865] Last Breaking-Event-Address:
> [   14.350865]  [<000003ffe0445294>] folio_memcg_list_lru_alloc+0xb4/0x150
> [   14.350870] Kernel panic - not syncing: Fatal exception: panic_on_oops

Thanks for the report. Would you be able to correlate the function
offset in __memcg_list_lru_alloc() to C code? It would be very useful
to understand *which* pointer or data structure it's tripping over.

thp_shrinker_init() is called before start_stop_khugepaged(), so I am
not sure how we could have invalid/uninitialized list_lru structures.

Could you extract the instruction stream sequence surrounding the
crash? I don't see a Code: line, but maybe you can correlate it with
objdump? And then correlate it with C code (make mm/list_lru.lst e.g.)

That would be super helpful. Sorry about the breakage.

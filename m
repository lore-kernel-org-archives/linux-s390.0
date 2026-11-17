Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904309;
	b=cQI9ZQFq6EWB+wm4lIunkp7w/d+MJ0xHFewHzzVc5Nv+GWnJUsbOXUy2LMpgedReHxgF
	 qbNjLX/qRaxuz7K2ZpQ0sD+QY1EQQjPMAk/Ee3QZsWcmHvRraW2FuUuZnpPSpmNw42qgz
	 b9YiQPBYLXwFuGIhpiGl4II2RjQZiEe+a+TgX4UY3iBBOPUEJlaLYIy9yw/z0xX5sem8z
	 /dGAaRD+YQi0BtcgVdJSp3xDVHRseZ4RVGpCKJM7g2CSme005qtHAw+01wN9H7eSxemcy
	 ++jEvbws/7Y+jrZmsh4s8YNHZmz/UF6rSmhOThQkFyqJVTpmNapQ7HSKNXDUQ90UWDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=TmH6s81HME+/ARGnJwgL9bVR9VW6JoGP/0HNw1M8o+8=;
	b=iT83PISMKArcFbCNDLLasCufiV8grYi9GWVO3RoKqiMFF+THnughenIi7zHg0KGgeExh
	 d/0zt4ntK3LSzAE/lxzBniNhrVXEV9T7wcXBktSh9cIVXVcwh7Fg4IrZMC9I3IzTkmJqJ
	 9gekhPutHo7aCdmqJ2wvk0sG/JJpoTbWNRlRToi4yF+9NTLLzcVTEpZAggMMCURpvcGBb
	 EGjKH6ULwZSxClhs8J/OxaGVlaLFDu3K1LW8bLKcTlmfTN8JtwOAabkVHP90MP4ay6pQm
	 A6d8GQR+M4kJaJ7HJLgK5SSC02VjIBYIijXnf89botTSzDc6Dukf2d9IKejkbr2FYDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ourL8s16;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E8606A323
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D51E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ourL8s16
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55c38cdd5b7so40042781cf.2
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794904305; x=1795509105; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TmH6s81HME+/ARGnJwgL9bVR9VW6JoGP/0HNw1M8o+8=;
        b=ourL8s16qvV/ByzrXiQnYSg2kF1A4uqN/AnfqBVQNPBbatZm3DUHQ8Aj5mDYNeanQ5
         MJwxDSueO/GwOBcCYIaM2431ceTkAtIwsRppYKovBOwmv3uilo2gi3HtSlXrxM41UOrR
         nIwd/WnpWNv0lDvrSo4gxjlev3eVFrvzyvPT32/reHLN8c1iROWdTpDcqLiwSDVszKTk
         tI9wm2+3jBJNt+T7vJIMKCVa+vkQ2GH6b803gnwQfkS8l1Bx4WBOwUeysmA7sm5XbKP6
         WiMR5/pZsgjQZYxksMerIC0S6h9yq2gpH5rpRHE1RZmPl0Btw+pchgk0cibqsJOcA4N+
         ka0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904305; x=1795509105;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmH6s81HME+/ARGnJwgL9bVR9VW6JoGP/0HNw1M8o+8=;
        b=OCdn/WFn5KGLPAGBzJYsNtCN8ObrSO4t4Z3EdfY3wl+Jgcggm9LYNts7DmpAX4CBR6
         YliISG0KoePt35NV4NrKXmbEAF/gkmnQi3tdLhb7Kkt9whFF2SqklNi4pm4MUR44NLwH
         fb29KQsDm2bbf5ztFq4XTsF+o3YAP8zT4iBzCag+9Kvtp9zQBpQx1Gj97gTuiGCDdgHV
         3jnUIbPDu3RvtWmOrC+IUApq6oAfcQoqZVJFmfHVvRG2JBMTBEFolV4WZb6RDRKQRiI5
         O6kE24aH0SyrIc82tw8Wz0pLGW4mpjdE6F0OSKcXrrBc20WImMQbvHi2yB7SferZKCGl
         HK1A==
X-Forwarded-Encrypted: i=1; AL+hErH97n9Vx/jEU8DU1RMnJqbuxeP8dYtYBsFC/DefYXo8H1AQMg7WCk6rYUarZMRHIzpjs72V/JN4V4ec@vger.kernel.org
X-Gm-Message-State: APuU4Z+YxN2lTCCSQBz9U3u65ylBqX4GuqWusoRJAAzmvLwuAaVNHzni
	X4QArQB+lKPKGKVR5XojQ5zcyVFXTUut55oDabAFaNTpGGw92UHsXocDIMS9pj1bsCg=
X-Gm-Gg: AYBFou3GMz+0x9m1YwRFPOVk8x4MFXLfqPause2+St/xAvY8crVD1a4fLiaSDDT1GyS
	xVYbVcTFUEfgbO+iaY++QTmWMMPsXrDpqtDOxnm/4LFkvar5oZ8WioMcM5sGrvPcQT4GXjXOdAI
	GbfiHhjrICtqz1ltVXfRfACto2Y6ZvTsezlR81gZj6bpa4ZQ/NlsgmIm1mj8F4EgX2+BHjFOXLI
	TskH3f45mCUtOM4Mx/DzHITzIRAzQnTWaYRUyCOfYSdn5MRnUUmQp/N+mhT0sCs1N2LnvU3qdrb
	MfNMObXt3rAHl6gaRgRkRZTJfZqwIzw8EcrBGdE5UvZRquTkQA65GUUMsC49ml4iZVY/EltMBYd
	6aBbN+o+SOCspghB0vR2TUS9VvMJ2zhHrafpRnPY1JUKbfRUdOMYr8q9igQ4QJkN3FtbzGCfUav
	TJEM5bOkd7y/rA39Ye767MHcUND2ml7X2h8buhsvRKSfe2W6glx5fvoPJTaO8DHQWt7tI0/xk+9
	F48VWIHrveDh69d7KI4KknAaTiqXNy5dkIHfDbV0czjfuGhhC1kQ8zwT+i4rm4HqsujdXIMSPUN
	GDMTZc2Y7s6heaA8EILyv4zAWKxiW6U1p9Gl8PIH/u8I93IijTM5qXG8ZDXpfAXfLaWcuf9KLyq
	TkdlcC5PELbrl2dmCDuFPwbBkQ+QlzQ==
X-Received: by 2002:a05:622a:258a:b0:55d:30e6:8d8f with SMTP id d75a77b69052e-55d30e6a736mr108004181cf.59.1794904304803;
        Tue, 17 Nov 2026 00:31:44 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2006csm99694361cf.10.2026.11.17.00.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:31:44 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 07/15] hugetlbfs: fix unmapping folios from private
 VMAs
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, stable@kernel.org, 
 Daehyeon Ko <4ncienth@gmail.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-7-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-7-4dd9e94ea9ac@kernel.org>
Date: Tue, 17 Nov 2026 03:31:43 -0500
Message-Id: <179490430300.482102.17633361840450824485.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-16 19:29 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> hugetlb_unmap_file_folio() assumes vm_private_data points to a struct
> hugetlb_vma_lock when hugetlb_vma_trylock_write() fails. Since hugetlb VMA
> locking was extended to private VMAs, this can also happen when
> vm_private_data contains a resv_map pointer; treating it as a
> hugetlb_vma_lock corrupts memory and can cause crashes or hangs.
> 
> Only take the VMA lock when a shareable lock exists, as additional locking
> is only needed for PMD table sharing. The fault mutex and i_mmap_rwsem
> already provide the required protection for private VMAs.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
> Cc: stable@kernel.org
> Tested-by: Daehyeon Ko <4ncienth@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify description and comment ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Was able to reproduce a hang / RCU lockup pretty handily and verified
this resolves it.  Have not seen the relevant crash.

Regardless:

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory


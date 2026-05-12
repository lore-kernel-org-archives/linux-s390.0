Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40E36F8FE
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571978; cv=none; b=X7Gk4qC7ZGGQKxbd0P2vsCOn8Dua0LPMsdMEzo28Sm3H5WWoPlQg9iFG1W5YByNVjMUnA2I9vvjYQT7TmG+PZUvFik0VwmZGYuwXgKilbG5texCC11Ua18t9xsoylGnQ70K+3CSupaJ2LKnKAqHdVltlsCDl1DCddV9iDV+W9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571978; c=relaxed/simple;
	bh=/Z0eDts7hPR158brE6qkne1NNt8xM3IFZWLEr3Ouv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLXX5bwVJp1lMH1pjJxVEVrmAbDFS4b17hJTQuuagV/yCXGb72TqgHcSW3SNt/rvKImABRhWU8mz4z8PMYxMkCnzM8JsJqHQMZU96RiQJ0QbIXE5qTxT/Hmi+va9vBOnB4aA8HGV2jzuzNW29uib08hHaVcynsYmz5KiHEqbWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TmN8fyUc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TmN8fyUc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso36213595e9.1
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571971; x=1779176771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MV3zAoldwoclbqs7qOGs2hdICyTLCe/Y0G+BfFOFXqo=;
        b=TmN8fyUcGD3UV4/9o2jXioobwkzO8Rgv78EP0grsZh1d/mSD62zYDLRKmqiGWVBRMl
         9w/zsz0u/MmuQG+m1kE2I4P1UkYAyt6SPYzUqpn9rBuqK0xQ10BffgP+spoDChgcObHf
         dWA9y8gymnJ3QZSkcq7F1tvx1gPOA5U2PanxKoGsy9vRgElDwQLFGAR0D4XGG929L4zs
         3fmNSeBghzd9F3eikTLgnPOLqgwP3JQv6PL0dAj/VU6hooOY/CHsRMMobHlytap4jH0R
         ZwB9ejY3Vhh/yK9AXslQZ9vFVlqyaVsQJ1dZWVkG/jO6KHrHhYNAQX3aHxz3hli8IiDV
         N2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571971; x=1779176771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MV3zAoldwoclbqs7qOGs2hdICyTLCe/Y0G+BfFOFXqo=;
        b=RGIUxPzr9ti+RL7HEvrn9QEFm3XDmnUdkpmLkegaVO/bJioTLvYjfoJO2qC9002H+f
         zgQWYb1KouVO3UfwfJptGE+hH/WEMWBFjPHKa2n6+MkP8kuFmbGyhht8zmMtHT3qKPjs
         rkt6gl+z46D1GOFpuV6wmvRGXM7exlD0MtHoejNv5kgGqtq4Wu2K1k1Pf2aqrocFgvS2
         0B6TfJnvYTgj5ZXPu0f5XttzZm6eGsEV4k1HKRqei9Kv4Ez/AVzpsaNElqH02iR8usc2
         jJJzaYX7F4TLHZLzvAJDDQKVPuV86uyOE3P0YLuMLtHEwrAYKjIKxoRoH7ROXoEaSc2V
         AkFA==
X-Forwarded-Encrypted: i=1; AFNElJ8rUpbiiG8PpCspNzuIL40H6TaLqErmlKYMTYGLqTRxHMNZAz1pXS5xTGvRqiBPDr4kUZxZcSHTxdqY@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbIWOmhScFFoQPdTahwFDyFrEMQT1m5UbX8tRxo/lnkEB/2xb
	1CMBIfLVKe3soo1JWc/3LqNboLwmdRadi+D8/FtoCNRQSQY+NVdDfXngDKXJRMqSJpA=
X-Gm-Gg: Acq92OFKEUeCRTTxQ0Ps6m3LQr0ETAeq+26SN6fo993ELvoK94AFzCpxK8eJxCMUxAv
	bgzZvA2sc09bRZQFrXcuaywn6AcMZptJSBTwKN1j28Rcmkqx91QJVCkY5DB14Np7Zfm7cCDb+If
	g/E3ciG4NTKaliP4a4LXLjdEHRXaNVlQGY23Warcmzxt0PWAy6jXd47I5p7OWtVSXBCbmm9vpnf
	0P+EIBjzMd1hFb2xFfSu5vBtUOFjRUs8OuFhy9QfIIVQ8uIrzRz+7015jhx1DPTpk5sC5QC0dqX
	1aDVhusGdHQ/Nz3gdR2R8uiVZpLzyuyiGvp5gx17atXElKWK72iJCisbw+zDrAHlAwnf4IywxWl
	CXRIERChTHjh8cRqrVCuWg+1sGyt3fNLNd2iYZQVPi1TRqLqZwAMNDRXD89XM7B1leHKt/CdUAe
	FiX9v2vjBQHRHgtKmKoJ7FmTNi7gHR31RmI/dh
X-Received: by 2002:a05:600c:a02:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48e67244c53mr274594475e9.0.1778571970739;
        Tue, 12 May 2026 00:46:10 -0700 (PDT)
Received: from localhost (109-81-80-123.rct.o2.cz. [109.81.80.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908cb62dsm42830055e9.10.2026.05.12.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:46:10 -0700 (PDT)
Date: Tue, 12 May 2026 09:46:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 1)
Message-ID: <agLawTyWlnuC9Rz1@tiehlicka>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>

On Mon 11-05-26 16:05:28, David Hildenbrand wrote:
> We want to remove CONFIG_HAVE_BOOTMEM_INFO_NODE. As a first step,
> let's limit the remaining harm to x86 and core code, removing
> sparc, ppc and s390 leftovers, starting the stepwise removal by removing
> and simplifying some code.
> 
> Once a related x86 vmemmap fix [1] is in, we can merge part 2 that will
> remove CONFIG_HAVE_BOOTMEM_INFO_NODE entirely.
> 
> Tested on x86-64 with hugetlb vmemmap optimization in combination with
> KMEMLEAK, making sure that the problem reported in dd0ff4d12dd2 ("bootmem:
> remove the vmemmap pages from kmemleak in put_page_bootmem") does not
> reappear -- hoping I managed to trigger the original problem.
> 
> Heavily cross-compiled, but let's let build bots run on it for a bit.
> 
> [1] https://lore.kernel.org/r/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org 
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> David Hildenbrand (Arm) (8):
>       sparc/mm: remove register_page_bootmem_info()
>       mm/bootmem_info: drop initialization of page->lru
>       mm/bootmem_info: stop using PG_private
>       mm/bootmem_info: remove call to kmemleak_free_part_phys()
>       mm/bootmem_info: stop marking the pgdat as NODE_INFO
>       mm/bootmem_info: stop marking mem_section_usage as MIX_SECTION_INFO
>       s390/mm: use free_reserved_page() in vmem_free_pages()
>       powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
> 
>  arch/powerpc/mm/init_64.c    |  8 --------
>  arch/s390/mm/vmem.c          |  3 +--
>  arch/sparc/mm/init_64.c      | 20 --------------------
>  include/linux/bootmem_info.h |  1 -
>  mm/Kconfig                   |  2 +-
>  mm/bootmem_info.c            | 25 ++-----------------------
>  6 files changed, 4 insertions(+), 55 deletions(-)

Good clean up. Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
to all patches but kmemleak one which I do not feel qualified to judge.

Thanks!

-- 
Michal Hocko
SUSE Labs

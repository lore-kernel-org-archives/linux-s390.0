Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE932A3F2
	for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607984; cv=none; b=dqsGBm2zLQIBWFO8rB10bi2kc8vcAhksAWOdlAkBDqwdtUsRU1Iqgpaa+ViahP5mGQSeFCZvyusqSUBk/bydJPoSjaYTmwFQ9Jn45rQkRPzTYJQLshk6hNJpuahhLDDDVMT5tTLYTUhRZ5Rl5Gs7pOJw0O5amae7Qs6ysZGISqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607984; c=relaxed/simple;
	bh=ya34dnXBkVMZ4acUVB749ZaVXuLYyX25Ei5hDiCldOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8U5RxEX2hNy+nhxccupXOPEjfphmu5Ea+i9qV+cZCKk/o6THrSIoCYMNRrbcpB1dO1uMC5/ZFaUX1DnkcMVxUETofXLtsBAvPW8y52JaTfezVueLe2HuoxJxPa+kLZe4qChjSGvR9wh3M/4BJ+hjawk2kYdh1mHjfaFK6kxopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XPfEVKpA; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XPfEVKpA"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87d8fa51993so61848756d6.1
        for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761607981; x=1762212781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeBkBGZ09M3QB76OpujQtXgjWBBtrpYzqcpEmFvCTi4=;
        b=XPfEVKpAkz0EqqJlblUgrQ2PbfAJJwC+FFil/Vd5htXfHTtIAt0AcJCsl4NmBxKXRJ
         eIW5UeA7107giYfaQifJ5a/gcKAR8VZ9z0golFJy5Hb23kycJSDDiGo9zpEv9kL7Qk7s
         w7zRqTxUMrIW23T1nvKpH2c36Y7Gmc+zKGLLJpUtGCt5fPfRM1WTsbfA/tTdW9nn2aUs
         ftNj7HpeKguvAOHG0jEjFwpWYouZrm59oAzF2CNPOw8w7oeCkLSrBScDF73Fz4cxKAC8
         hjTanLd8/LkCYdg+DpDtdHCnEdUb1gxr4DzFdHDnJdW+eZ6Z/hxItchsfPdz1TLQ2R8w
         4aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607981; x=1762212781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeBkBGZ09M3QB76OpujQtXgjWBBtrpYzqcpEmFvCTi4=;
        b=OKl/jnNJ7MNh+EdCGPaB3x9a82albyKCtFhTcfJG+8i6Ku9wu0R0qHY1e9YZ14pnEj
         oGKZDGCv/5sUaeJ2WCEIr6o+GGiLFh60N2lpVm/xAdboHxsoRKeqSrcITtIE44t8QNGX
         u3yWhISOBdGTa+G0U5ggB/SHk8sDwKU5iqDYQubXtmomhiEn32laxkXGDof6MI+4u3iD
         nrGasDIbFD6khoG80PLf9ANA55gkk1otMPe3+Pc5jhOmKbFEgbjcvCl/754x/hZFzMQm
         pKTWifg3wg+U1rYoWwDqRAt3efCitfQsznmCKiRZw8Zi7YZ5mcwoIzfQDEoauZj8h9YK
         OEIw==
X-Forwarded-Encrypted: i=1; AJvYcCWyshBhvj16xsS3rp2ImWZdJmFgB4HfVlDn4T9DHF8VCcm9D7GjZoLs4d+lSrHUeujuB4zQ/MaSwvVi@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4pWFAbsFKJ2ywZRgd+77ZEBMKiUOX4zB36yZl+6SRpxUl0mV
	JgBj40/yPVCQOSWqrRwbBbJ68Og/rIQT6CtgHdjPziD5PoqIcrgPuC3odFfJB58hsU8=
X-Gm-Gg: ASbGncskZBFwAzXYDMJ7JDDevkZpmAPLJkuSKdho05A9qzOEScYrOnOH7pNI1b0uctl
	7URK/D30W+jnFgbeCu4lDthOzMOMO+XI83Ews7RV8fhjiterZ43KX+FGpwdHoIZEIdg4oi/7B+0
	86bmeHuZVjUXYKT9nNYy1rZGjmc+aCcgQeu9Idejn+euzLG4AZ7Qlj8tNZvCJUSIvRP5XkQ8CWm
	zkVWJLUSlp43nZM6wPl5rHa/DB1GWdgkgzzl5roe20DENZ5dVoQ3Ar2laR1g4FK+AG9OncE+yI6
	ETaSgJpkyGQPCUX1h98iaFeGumBbhmttf2V2Kc+2vk32aRyPz9s78KY0g/H+5Za+t5giQZGoUi6
	Kc0LTe121qgWwG2aJwk6v7RmuUawDkT2p4htorrkvqKvJbGNaqn+4Aj/G5KyEXdG6TnyV9+7aAK
	BlQQ1VcOW3g/FjWI+9aU5R8N6nZo2UKo+D2HI1fE3oDd9zuFwYQtp/J98SJyY=
X-Google-Smtp-Source: AGHT+IGY0mnN3CFDP7vaLRad7aeAt7RbVIUmDhfxoFPsiCMHR/zS0q6YLuuynQuqtuF/1igQEZd8Tg==
X-Received: by 2002:ad4:5cad:0:b0:87c:2b03:c776 with SMTP id 6a1803df08f44-87ffb0f3094mr20891046d6.47.1761607981318;
        Mon, 27 Oct 2025 16:33:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48ea92fsm64277606d6.24.2025.10.27.16.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:33:00 -0700 (PDT)
Date: Mon, 27 Oct 2025 19:32:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <aQABKgQYfVkO7n9m@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027160923.GF760669@ziepe.ca>

On Mon, Oct 27, 2025 at 01:09:23PM -0300, Jason Gunthorpe wrote:
> 
> I'm not keen on is_non_present_entry(), it seems confusing again.
> 

The confusion stems from `present` referring to the state of the hardware
PTE bits, instead of referring to the state of the entry.

But even if we're stuck with "non-present entry", it's still infinitely
more understandable (and teachable) than "non_swap_swap_entry".

So even if we never get to the point of replacing swp_entry_t, this is a
clear and obvious improvement.
~Gregory

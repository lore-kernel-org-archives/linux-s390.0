Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99001330B32
	for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656949; cv=none; b=TdiwBjBmNDys4l9fSPFwRKaaRZny3ZJGDNwBWWN2/fHcrKhPo90nmm0oUoz97VW1Ym3OAWPYEl4avVYFilNhUs1zkSZIQLi6nYfM21GvkcNNIDv1xeSwfEaWt8xrdDYIAsvJ8m+HPtzhblufQ2vL3y88cnH9jkvqpycqDpESGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656949; c=relaxed/simple;
	bh=GYhA9Iy3/9/Ee+jnl+wXccAoqjQ72aXNdQ/Z7T9pA1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTBLBFYkLjx0dkJrkAMZ6/OcFhNckQT3irmTG4K+aMUulm0h11c/4STn1j4iEU9h6vuKkS1Za60O9Qw8EuZQIoEkHEq4ZeYWyBJLVxmOBHjELq/utq5x8yav7Eo/UxEJvimdKhEwy9uxVMm1FXJjz+0lIqkj2T8AUrKfnGlDYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iti0ydl9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iti0ydl9"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109c6b9fcso53734851cf.3
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761656946; x=1762261746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCGJuNdSiDHSbgE1dTHIFDy3cujeZVBX/ZxNKRqqViA=;
        b=iti0ydl9RPgT1+rOMGa7fKebSxzZ81u7N14kwlJzu5uRUDmZbPW+tGbASCk+XXvRwU
         3DkxfpY9BRxdfJ67wcRt1kiNB9jxq9QtSFb272lGIQ7kWPWRvUs9PMmImYnfy4r3+yTN
         KsXR8cfl7FqQKXXEA+O1e0FjU/FZ73eJiEZBIvrerCSuFTu2IutUaosQeQ9TTgivg+ay
         n8Q8jKL8KKjOGEJHfPcAPfe/uiYjyGlNfmzGu/agS/soO6Q6ZUU+TgmPDQZxicUU9F76
         HZAcaugdfQ1xnGONKzQmuOZtXRIULbBI7QzSFBY/1/Ke7dpJF2F3DYwINFlLU2aGy7D/
         aVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761656946; x=1762261746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCGJuNdSiDHSbgE1dTHIFDy3cujeZVBX/ZxNKRqqViA=;
        b=BP3SggJd9JQPdnArDRJyij8K4L7j3rWSoGJIG/9r2AWsoofMlaQyV3yL9LvsJYcCQH
         /vHD25pnhkxWtEactthZEJFJ/aGUZCy00jMx5U9/uJpVTzdIIZsgDHr2e++1FihV3kqS
         kqyEQ2Ghe+vv+6qWoRfkOSCadmwlaHNYQNbLGt7UBiqggDtPYnI2V1FrNR0m2k8fGrhU
         w4iOyIItaocwWMU/RkLTD8iwlqCPcIv9ZRizF/NyPtltaWAHt2no2lPemztb4EKYjqmv
         380qR4L7W5H09aYd2oQQLWpFcWp9iEMUkTvQb+qF/Irewa8JkhgXHc3iTZjbx4h8Kwxj
         stiw==
X-Forwarded-Encrypted: i=1; AJvYcCUTPp88/upCiXJMXBcTcGv1UYtWE4lWuOSlN2LGFSe9sB6UGF5OqbU15K/T4q+iZtztfd9CDD7bxsnp@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBonFm8R6d6nnHBMEUs0tIjj7TQftn2o31A/nmRw2kkIQjHzd
	U+q779g2xgnLddgSz81agMMHtEDgiHUN9KK+k6x0p9W6e6Fx90l250eETawB4sh95X0=
X-Gm-Gg: ASbGncv3/xI589eQbe3cN+EH3ECdii0MqdYWBfJeTceUU0Kx45sCyt6gmEEWBLkJCuH
	nWpPNlrD3UxSh+q5YIziAEYBnZ7F0ACpI4pL5Gts7MI3qYoaXD/EX5Qr0Kp44RHEBWGIDzH9IfB
	0mUr6CS3GYguRO/weDRbkfAkc56wymw3vcK78r8JGZ70vPAiQ1PjgWCYS/RCb0AtzR9lbiLB+yK
	pCFlds8aDp1EA1NlGrpMzg+q3GgmN2pMh2E5t+bpJ62V/jIHzrGR3bX6uZw1onfzSa5k8XUU10O
	074tIvpIf6kxtVZv7UGg/N4fN1r0/m0VfDgpHd7QZjpVKlv2d6oEGXOFzTJ61XUbidrLR04iQ7J
	Au4FQlwIlR082Et3gjCaWgSZ+MLCrvaoy1dJaoh8efLQpNN2x3etRvphH2HdJqS5/0TmU8fcDx8
	SArunkBcuTz295COH51r7xjkmw29Q/gF1uN4jSA+2A9yOBM8ND63T0qmzj0qo=
X-Google-Smtp-Source: AGHT+IH98kqIm4OLBZ9BxTzNh4SoN+f3UCMEHEUjHueEIBmZ3ZFACR4imRWFssU1iLJ7HaKse0MxjQ==
X-Received: by 2002:a05:622a:261b:b0:4db:db96:15d3 with SMTP id d75a77b69052e-4ed074df11dmr43296561cf.31.1761656944848;
        Tue, 28 Oct 2025 06:09:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba386b6b9sm71298341cf.33.2025.10.28.06.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:09:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:09:01 -0400
From: Gregory Price <gourry@gourry.net>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
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
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <aQDAbcpO8_SeDh_c@gourry-fedora-PF4VCD3F>
References: <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
 <20251027161146.GG760669@ziepe.ca>
 <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
 <dac763e0-3912-439d-a9c3-6e54bf3329c6@redhat.com>
 <a813aa51-cc5c-4375-9146-31699b4be4ca@lucifer.local>
 <20251028125244.GI760669@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028125244.GI760669@ziepe.ca>

On Tue, Oct 28, 2025 at 09:52:44AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 27, 2025 at 04:38:05PM +0000, Lorenzo Stoakes wrote:
> 
> The union helps encode in the type system what code is operating on
> what type of the leaf entry.
> 
> It seems pretty simple.
>

My recommendation of a union was a joke and is anything but simple.

Switching to a union now means every current toucher of a swp_entry_t
needs functions to do conversions to/from that thing as it gets passed
around to various subsystems. It increases overall complexity for no
value, i.e. "for negative value".

Please do not do this, I regret making the joke.

Regards,
Gregory

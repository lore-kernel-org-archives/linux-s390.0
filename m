Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB83557F4
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332866; cv=none; b=nIeGM28KC9TVIRveSv6GdW1A4rfE0QXG/1zjHOtUT0Y9tnmlHtey2xfQ4AkuZFizlVLr8kKQppCRAKKUB8d8e3jp2kOdAtcVsUSHb7xlhEtdFXTrkcmGXAC0bbywnmKD5Jh1Jnn23zG7hfh/eJHL3gGlXoEvLscGL4v1vloPrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332866; c=relaxed/simple;
	bh=BLEG6QVxINnxGSV9PP3rHj14LkkUoRrxiY/LRA160IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3v8e6GmbD2CA83unHqzoir08upyN9Ixrx6qJsA6TR1JfxPwYey5svz+xyafj1H47W1ES08wb4wK8+suKA7ymiDgXGlnjVvt+8hClsJ30ziyXA3uZsukivaIQi1tW7xY2H7ZBRV6V6J7X2h2b7zXxMY2RDbWwyLmDA62IHTfpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r4EKg749; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r4EKg749"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e89183fe47so22824091cf.2
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761332864; x=1761937664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5Dh5pou/PyGHQeCBr0c/6aApj2l3K41F6GbY+zS02k=;
        b=r4EKg749YYSw/kYQOx6FLdlqv/KCYEmMkRbKABtyYYMzpnnKTBzACCD3qguUm0bn/a
         gubeqPMkAo9DJuDdXd0tUyt/A7h55itwwf7TuTBFFc98FMmjE/gR03WHZ8i9LaV5VGFu
         6X2azELy+Y/wwlZCq9OrZPV3ruYPh+nHZv6VzZVE1wrGR8kdae2ngo2s0SnTUSk0WfhN
         QkbvJx4cls7kMjSZbKBhawEZTngmEdpy0yPX3PjNvQ1B4iUtXeTTEg9WRBiXF0LR6yD8
         ubxo+T3y1k2KUnUzfkVBiZbf71rGL1rF+gBNetTDC6FofBKqXwv1C8fuwpR7Umnm2yXr
         Twqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761332864; x=1761937664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5Dh5pou/PyGHQeCBr0c/6aApj2l3K41F6GbY+zS02k=;
        b=PN8MyFpA6CB3/KAI1LO1FQWj8kHKaoo3nyj4GY9VhS9rcdIHh+MfYcO74XMIhP03WI
         yf8JDZ4hFgDukSNYY2JWf2LR7oJd1rGCcaPazF05rgk5qTlvNB5waxA0PaozdNt0wpS7
         Ss/otkpwRl011zniUK7dG65gWOztQm98yf+MQL5NUADZFt1AWjhv9QSJ5q8nEcxm9/kS
         JJv99PTpiYJ6HHGMAkLQ4pOWoBPCa+R6F58sGMRMXbKeiV6QwdWtHRyx3mUeUt8Cu47A
         Jbub9FNARGk/8Sze21xZivQc756XSmIT5yzWLdCSHAyuW1j66YoX9xaL5Xmwx5YbqAHx
         Rr5w==
X-Forwarded-Encrypted: i=1; AJvYcCUslUy8Sf/hzLKbCXFYoQ5XxkuINzCqo9OW5vWtKm8TD/0caN0RkXe7d4Ia9GS8s6yVRRQXME+EAqMw@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8Apk4QRuP/yLwPX9+3D+4F0u8UD8CjnPHIa0GxT+M8TQhphz
	dWOVJv1Jkhi/OFjkSt+CftwvYCXQZ8HqzrXweX1LTX39ASlFD8ihz7Adlr8Nu6KW6HQ=
X-Gm-Gg: ASbGncvn1Lf+eGNlT06eohTzHoYv6HEg78Qw5QLQQ/BHnF6vzNpidJEJ/tM7rafnx2j
	PCOSgvQ6vV/FuBuQu6prbB8n34Ez3OuTvGfRq/4Xq7/h0nTgwIW7oKabdeCmhXFIrvhyrXAXRN8
	7502qY0hpgS1ykumDE4qSCBiYbA61VOEYzKgdWnjijNyh8TQBEdIatZU0A1Ag6JF2AJFZWxwkpo
	ulB8u6GIn0M7z/JQZQBQuCzWKS2YNqySRyAqrHnKu/JkojIk20FEyDPc0+mt0l7ri9jVWamA4w5
	tJSHcL+dEyhR4q6/zk1LPxKt+ZiOJsEpJWIDtSYmhyoPf9rVyk3EaOxSP1EVAmb0g4bHvuvF10P
	dnPLwZu2QW81+YGjYVLrtyuRIspng9GEN58vnildLnYGBrGfSS4inAISkq9KzTmCcF4jFdR8n7c
	6lGvBSA/95CSVsSyT+WAd8+0huuw7L270912pN/AUXWCFKAf84WuaMCplY+6eg0q8EkdL+IgoPr
	CVS5GDB
X-Google-Smtp-Source: AGHT+IGJ10HVaocsCEydg4aVTizi/vMPamVub9HiazMH0e97AeDKtQcVhgmZnH66d5WlxZIy8Zx0/A==
X-Received: by 2002:a05:622a:1453:b0:4e8:a967:953e with SMTP id d75a77b69052e-4eb940ecd89mr41100001cf.24.1761332863649;
        Fri, 24 Oct 2025 12:07:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eb85e917c5sm35169951cf.24.2025.10.24.12.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:07:43 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:07:40 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [RFC PATCH 11/12] mm: rename non_swap_entry() to
 is_non_present_entry()
Message-ID: <aPvOfIfcRM0X_RaK@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <a4d5b41bd96d7a066962693fd2e29eb7db6e5c8d.1761288179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d5b41bd96d7a066962693fd2e29eb7db6e5c8d.1761288179.git.lorenzo.stoakes@oracle.com>

On Fri, Oct 24, 2025 at 08:41:27AM +0100, Lorenzo Stoakes wrote:
> Referring to non-swap swap entries is simply confusing. While we store
> non-present entries unrelated to swap itself, in swp_entry_t fields, we can
> avoid referring to them as 'non-swap' entries.
> 
--- >8
>  static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
>  {
> -	if (!non_swap_entry(entry))
> +	if (!is_non_present_entry(entry))
>  		dec_mm_counter(mm, MM_SWAPENTS);

I guess the question I have here is whether it's feasible to invert the
logic to avoid the double-negative not-logic.

Anyway, naming is hard. In general I appreciate the additional clarity,
even if we still have some `!is_non_*` logic sprinkled about.

--- addt'l aside semi-unrelated to your patches

I can see where this is going in the long run, but the name of this
function (ptep_zap_swap_entry) is as frustrating as the check for
non_swap_entry(entry).

may as well call it `ptep_zap_leaf_thingy` if it's handling multiple
special entry types.

but renaming even more functions in strange places outside scope here.

---

~Gregory

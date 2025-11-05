Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D533074BD
	for <linux-s390@vger.kernel.org>; Wed,  5 Nov 2025 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372872; cv=none; b=MLRAs6qsvl4i6/mwcCRa+E85YeG/D5AW2YC5gJJ30S3xDwqE02SzfRlJKGeRnP33Masg5I61OJNZZ1tayMZmHgg4CHJQoOUn6pVkL7yL2Zlpbobyfa6dyOTkNrCCJ2BRsnR+uMzZA6RR91SLnYOZdVhsrXpnDBUdgkt12xcpbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372872; c=relaxed/simple;
	bh=GsjEeX/yoeLxBaD+dnbSv8Mk07ocMdYdXojXWIK+l4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeC0xhPdXly/gy86FKWbCbfK35qOMZEbUA6r9vspQ2LJG4ZveWlLYJRznN8+Rb+9mgZrBLWo/ljM86GcybiAvb37mhThl2qNawKSudEEOTHcIAkoDHwD1+d3WILgPbdWnv/we2AxOLk44RH0P8FnR1XCWQPNnCeRjdYO+opYTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZSxGdxX9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZSxGdxX9"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so2550426d6.2
        for <linux-s390@vger.kernel.org>; Wed, 05 Nov 2025 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762372865; x=1762977665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=ZSxGdxX9xCk1HKNpVIcM3JeGL4ppDGq/ppX1tKu4zzry89rvCfCuRLNhxVQTwFsO/1
         xzBHvTqNEf1f//pxFOyyjiKoLv3JQ6jMFuZ1U0gtSFs0gUY5788vd0Bw+sW7CJcHcas5
         /cwugQ+wGeG5ifFdnhLsHYmm7TAMulD3ytgLT9U21uBeTuEwU3xQhOJyUj57qplDnfTR
         6OGd4k3TKUOwqaDx7S/HHNZKW9KXKtxkZML1HmUe3fcX1+KMtLTI5WtXaoSnN5l1vuRl
         ThKKki1xOPnWTPWwyCqM3j+KNciRfeFxGonXxktJUKdXwJHAPgOsc3ryftcHX8Y9jd+0
         lCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372865; x=1762977665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=nmuTSj8KaSApb1PZPKE6RVC5OddNhmjmkA3CyQB0XvWALbU0/znBJWsg4cfiIfZ5O8
         R5ufl6F8dhg1fpyyk8/E1YZfsAmph4yOkH/h5k2uRRjYVgM0dRnfVvPEcqyfaF891VL3
         LzM3RSUHMvg/7yFQ07j9ma360CX3YXXs015F2j/PftHLkJUnpNY8Cu8cCkzsswsnHVYI
         aDAQh5ZtRSoZt+YxmdhtVD0wF23hGtJMUgnt6B1+CDm1dPlgGU3ozSwux4oOWcuwetpF
         8W42Vvnq6Oo2eAf2W8mgC7213vNJHUltm44+NcuRQiffjyskpCXAiUgov72XxsEOuPWp
         jrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2ARJsAnEURvXKOblDasuxfcZ2atwxNPpl0hkTgDTzZDsxeQM0cNw9eR2L2ojxF0JlTy9aWi5ft2XI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1ZghyM3UArcm7Gev2zPu0R0In0f0Kqur1+MqzWBQPei+4DPa
	Q5PbiHIdNR+pvZxdZLd3qOXqDhEe0RuNoEobiPi9+FWDI5Leb98xoRPxuBFrzB0v8xs=
X-Gm-Gg: ASbGncvgnDNHb1KH2mKuSGYzgxTqudkH+ypLhQ+dwqtJrhcADRKL7MtxNdUeQRi38BW
	X+tGDcFcFPVy9kIs4gMqzrEIaOky37bf0SLhIcKmSdzyq+Fb0sPyQAdyXTAvdU577sk1UwD8uik
	7/BJYfYgW6AR1ChorcVch9a8U7QCYUFxkWE79Kfit6p9X7oHbZlQak1tkSWR6xByhGkNgnLF2GG
	SXe+bVKAembcix5ygYAMv36ZsiiehC2GJhAqmQDNiDiCxeMgNFCT6gaaRpk8xUnZyDU72ccgKW4
	iZ30FsUgXK1sbMnfZN4KYzGNc6YYcC3urelcBL6hTEAtoWKunnhYjdGi4TrL36t4IvoXui7uHez
	Gi63LJNRsz//IALC2ec6SL41pqLE5CYt1AP2EexNrA4plkPaz30s+XCOYmvoKTm2jabcHr7ZZl9
	/upbyTUbflBBjpZB7T6HeGZO67rYisD3wgRwEuuX8UR3qZb4ZXNBdFhqxLdwU=
X-Google-Smtp-Source: AGHT+IFrPbLMeE9CYwB+D7eMKoLl9vB1NdinT/slFi02CGhPHxsO1o1rCTabfaRmYf3n9WMkLz+GWg==
X-Received: by 2002:a05:6214:20ad:b0:880:4896:5d81 with SMTP id 6a1803df08f44-88071135a41mr51873106d6.3.1762372864533;
        Wed, 05 Nov 2025 12:01:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c4570sm4100556d6.10.2025.11.05.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:01:03 -0800 (PST)
Date: Wed, 5 Nov 2025 15:01:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>

On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> I thought about doing this but it doesn't really work as the type is
> _abstracted_ from the architecture-specific value, _and_ we use what is
> currently the swp_type field to identify what this is.
> 
> So we would lose the architecture-specific information that any 'hardware leaf'
> entry would require and not be able to reliably identify it without losing bits.
> 
> Trying to preserve the value _and_ correctly identify it as a present entry
> would be difficult.
> 
> And I _really_ didn't want to go on a deep dive through all the architectures to
> see if we could encode it differently to allow for this.
> 
> Rather I think it's better to differentiate between s/w + h/w leaf entries.
>

Reasonable - names are hard, but just about anything will be better than swp_entry.

SWE / sw_entry seems perfectly reasonable.

~Gregory

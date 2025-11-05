Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEB26E6FA
	for <linux-s390@vger.kernel.org>; Wed,  5 Nov 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366613; cv=none; b=WYDNWJJ/JXu9ScD/aw/36mLYHCkfCJqTbXY1Y2LavvpIZL/kS5Mg8qzEhMUQc7E0UlnSqOduHfSHcdkL3ZeGCQNnRCTJJmo4q332s4rJm/ydtALtqrQwLmLs34NE2EnhsVCMIqrc3yRwfZ2vx1kHi2oFg/Ft36enk5Y4Fk+iVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366613; c=relaxed/simple;
	bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pobWy9fyZKGAHCO03EzPtLimeG5oJXM6bJj1zDPvk4rbas8o0AOvOyrn2pHq0bjRw/6AdESLv56AJpuOnOC1JOaj3Myz0ybdVjy5m/6+hc6oxdZg2ivi5i1I8ix8mYD/VRqx3xfH0Yqhz0+EPExPqShAMl2l8iKsUuX3K0cVWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CDITUnbF; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CDITUnbF"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-880503ab181so2200996d6.2
        for <linux-s390@vger.kernel.org>; Wed, 05 Nov 2025 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762366611; x=1762971411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=CDITUnbF0zeKPEDxkTffAxzBC0jmHf5Y876UCRRtQ2rLcs8qb+Z88PVwnenEzbG9aw
         TMKKMq/cUOFjI2hTB2p69LTktVVOtIqKWN9gVdyAGB0YIcRo8qLYrHgvJ/lgpNMTOqYn
         5iGkwqREVHwe96A34n/Rc0FVPbB27ODK14DCh2OFhV9uFagGPKjsP9GYkvCjfza6Dr88
         6GMOm+6souMEhZX9dAd2h4LFh83WkPTW5+p0XwToVKFFytPbcqK/U523HxPJggggsXFT
         VGSfZzgVaOv85EidWvOuLQN8+8UnO2EVDpdPhjqOu8sJRpthaiOS7KXU+YZ62FxzOB5z
         H2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762366611; x=1762971411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=I/6jbnrrmbo38XnphU86jBsEmFEjJkQrQe7jaqLJpBMEJyeGRSF/a17XMzXhxqhu8z
         xFByh6WVKjJW82d4MnRv+HgYAohpsCM3kdU1FDylxGTqzi/iOrhVsQPZic/kDdVRI7xH
         /T8AdhykQXlDiNagCqQRobiSV9ClBusZBoqq78fh+m6k7OgHvCiM5OnyeFcHpZTxQL3c
         OU+F6BBFQt0GE8B6hCNJ55samOkHrcnwSjBWiQJxS18RVzj/N4LLxl87k0eG7mJz8kdC
         cE1ciNR40Lb6QsV74XVlhe2V17ffiTpoGZBtJgllJKDQGaYTyh6v3Eq8DgNAvsXb3ZTx
         Iu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv3o8dwbJfu3U/eoqgxbZgGYLgB+ckByavNRYzJXZ2Q7VyOOShtiURUvC1zvGeZBEYUxoNlQiLgtrz@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGZLj0vG6/oKU2g0rEtbWyAI+d7rsrn8NEJOml+MjTJbBzCXk
	ELNHByeLrJCi+3kFKo8RtpEafVKpeiWPH4RokuImBg/kabjHuvY2NK9430ouDgKd1g0=
X-Gm-Gg: ASbGnctbZAvtNB+XJ+b8vpAkzNUILGbl5FSYnap71CnsWBmP9cAFE7myHoyFt7ho9tg
	7YVEVOxiH91W7+ynoJJY+pCwa2Lxq4SBXxYg0Vy7mJWgSbZDwsxm5dxPUaGn2esNff3JGQVlaym
	UVEhp8bNodoemhPc+dly+7nhfAZOtyDYjGOsMv/GsOpAS+IhTuUCAOlT7RPgstdZq6ibBVT/H4a
	lgKZF/sZZ0HnuJFGYfsnokuQhicDgrOlWNoDMQsbsmbUhabJSiFrEP+oHX9v8h/2HeRrzZBqSJN
	QObHAiff/JYyPtO+BkiSuYOqOUb1Ku+5JeGUsT4j2ito3GrSbW5sDFZmGDldZfIcXhrOTQVTf0J
	Q7a+nDYPth4gozAB17VFLAM+ClVONByYaxiMSXh6f6SoyWOW3+Q+7EM43kXAzb4KwSzvax7iYEH
	kFoj3nIondcZnbAgJkvfKU1xMvflVM/OdiGvpi5lUU/z6hlA==
X-Google-Smtp-Source: AGHT+IFaewYCh7lZ/e3jrLC+zJ6aPttGSWBIKbLkQBuHB0fmqLtXdWY7nE/Y+kB9ksn8kefKsppo3A==
X-Received: by 2002:ad4:5aa7:0:b0:880:5cc1:6923 with SMTP id 6a1803df08f44-880711d8255mr64437896d6.36.1762366610614;
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c457bsm1883826d6.5.2025.11.05.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGi3s-00000007CLf-2PE0;
	Wed, 05 Nov 2025 14:16:48 -0400
Date: Wed, 5 Nov 2025 14:16:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Gregory Price <gourry@gourry.net>,
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
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20251105181648.GR1204670@ziepe.ca>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
 <20251105172115.GQ1204670@ziepe.ca>
 <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>

On Wed, Nov 05, 2025 at 05:32:29PM +0000, Lorenzo Stoakes wrote:

> Obviously heavily influenced by your great feedback, but I really did try to
> build it in a way that tried to simplify as much as possible.

My main remark, and it is not something you should necessarily do
anything about, but pte_none() can be given a consistent name too:

leafent_is_none_pte(pte)

Which is definted to be identical to:

leafent_is_none(leafent_from_pte(pte))

But presumably faster.

Jason

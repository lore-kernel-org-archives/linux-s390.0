Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A82E1C78
	for <linux-s390@vger.kernel.org>; Thu, 28 Aug 2025 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407182; cv=none; b=fTsOsSgUf2wxO3UBj4KNHw99s0oNx7XCpizgtbR0gC7Nx0FeXYI8TZVRv0RcOGxdWgvzfnozI+2FtH2L7p3qlaioxhK3uvdsKRVJNvPGIXby9AMNsUvBphS3NM0qtNBMBhzaMLkEKB2z1A25qWmzOpM3sZlB4q2eTHU+T05l3Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407182; c=relaxed/simple;
	bh=CgULwvBoKBpoCxSt14lLKe61Fel/Z9Jurl+x1vHCKzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwRfk+O6KLWoAMxuAbZjPn5I3suMxXUMXx89Cr0xt8dAMVarc8cO+F42GQqVOKd2edOZbW/zGRTg+PH22orn6dpUafGaMlbMeGxZiFwO8+TuOhoLwTxBxSeOnV1J4A7j9fyIrvtssqw5X87fSMukU26n+MgoQ9EPP28wd6zcgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5WBwKoG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5WBwKoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756407178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ox+fdqHLvqvHkCQcV7jSITHMPKa6EWT2tpRcTnamaBA=;
	b=E5WBwKoGQo9zqO/HLEpsrkpXIOyUZpErlYEJrl85UZI+vKSRJUAQwMGOSSx7lqmu1cb2CU
	5fJc4OMGF0GVr4Wi8tvBRYFzTmMWW2MwRdrH7RZy/1YiuyYZ25Najtv/JZrrWbeSqGya4e
	4F4ikQb7l52dvkvpxswwKeBKqLFNOfA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-aE1sEyx7O8-6PjR1fbgGMQ-1; Thu, 28 Aug 2025 14:52:57 -0400
X-MC-Unique: aE1sEyx7O8-6PjR1fbgGMQ-1
X-Mimecast-MFC-AGG-ID: aE1sEyx7O8-6PjR1fbgGMQ_1756407176
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ebd3ca6902so3309635ab.3
        for <linux-s390@vger.kernel.org>; Thu, 28 Aug 2025 11:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407176; x=1757011976;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ox+fdqHLvqvHkCQcV7jSITHMPKa6EWT2tpRcTnamaBA=;
        b=HpXSqRqGto+jDjs8XYWE4yq0aBdCPll0LQVm8M3x8Gm2N9l5f251mLDz5ngDHkHL2q
         V6EVJxSvBob5eZA8ahd6PDroSFuYnkV4lSPOwT6dSC3+J0D70qL/ycqvmtDXwG7R5cMr
         zqq7U7cXSJMT0ayt3DzE/towKBGdTNHM+IUltP0ah61TA6DHJHAgnb7T5B3+MYefq6rc
         AhueOGAnZCWnDrB5tmGisxvrtFrAMdJGSqRCk+Gpysoqc+QqSLE0OPfkLSdcxnUp52an
         lxIJLnf4D7f6m4Yxk63uKFPmgTu9NqbYw4aUA4UkzXoB3Bodep0dEA2IPhjgLYX5U0G6
         K9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/bgrMc57z5g4kUSsLNjvoHmY7IulpTk65xwkHZrCurE/7/oPKwMJ8BSlU+w7/ByJnIRaq8s9SFhN/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwe2hw5Ta8xHqXBckOuv5DUP1251LHyeAIuU28K9I4vbHphXHo
	fj4Fh/ds3m7U98SboCG7Zgf6QnK9rmQF2ppQtXyvYImD18OJeW7bEsvssgOLPO4aiy1T+0bpYW4
	w/CUBi0/IzxXujWHaOkf254E82nOw+PiVZ4RCMlqi0w1a8LmP9bfXtKhvA0S4Vuk=
X-Gm-Gg: ASbGnct7OgQxigHVdRySnzFuFl/3ZpoZ95dWP17yHTIi0hwEQ3Y4ISV+dcf6kTt6Nco
	AAIsu/V93srec1BwEjtgrWgAxSEXxF4KwJXFTxZyztieXa8GRa/LyXBw0XjTXWl2fpuidN2E3E8
	4aobgCUa1LvQ0CyeLKxKGFFVVnsK2lKwDLbP+MVnz8eM6LgY1gsxU3KdByA4Q0KWpAaw6aCn+7n
	l714i6coCRtmUfuVh/AbnjZhXMPZ0cceOskID5C17xAJ+1NEgvVgpk7TL0Ru26t5SO6kylb8SXT
	W6Dsv9et7cf/Wt8bQfKO7RKcQjQVlSlHyF1dhW3nOEI=
X-Received: by 2002:a05:6e02:1a86:b0:3ee:cb14:e90f with SMTP id e9e14a558f8ab-3eecb14ea03mr61889005ab.7.1756407176435;
        Thu, 28 Aug 2025 11:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP6X5C8fKyFwSWmjzqPdfkbd7PprjZnYQm1xQXLb3Ss2KjE+y/MhfTqxlaUhO3jzRNfBiTrg==
X-Received: by 2002:a05:6e02:1a86:b0:3ee:cb14:e90f with SMTP id e9e14a558f8ab-3eecb14ea03mr61888495ab.7.1756407175934;
        Thu, 28 Aug 2025 11:52:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d78c67b4dsm47783173.7.2025.08.28.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:52:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:52:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian
 <kevin.tian@intel.com>, Alexander Potapenko <glider@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>,
 Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry
 Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev,
 io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe
 <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, John Hubbard
 <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu
 <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>, Suren
 Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 31/36] vfio/pci: drop nth_page() usage within SG
 entry
Message-ID: <20250828125251.08e4a429.alex.williamson@redhat.com>
In-Reply-To: <20250827220141.262669-32-david@redhat.com>
References: <20250827220141.262669-1-david@redhat.com>
	<20250827220141.262669-32-david@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 00:01:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
> 
> Cc: Brett Creeley <brett.creeley@amd.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/vfio/pci/pds/lm.c         | 3 +--
>  drivers/vfio/pci/virtio/migrate.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
> index f2673d395236a..4d70c833fa32e 100644
> --- a/drivers/vfio/pci/pds/lm.c
> +++ b/drivers/vfio/pci/pds/lm.c
> @@ -151,8 +151,7 @@ static struct page *pds_vfio_get_file_page(struct pds_vfio_lm_file *lm_file,
>  			lm_file->last_offset_sg = sg;
>  			lm_file->sg_last_entry += i;
>  			lm_file->last_offset = cur_offset;
> -			return nth_page(sg_page(sg),
> -					(offset - cur_offset) / PAGE_SIZE);
> +			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
>  		}
>  		cur_offset += sg->length;
>  	}
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> index ba92bb4e9af94..7dd0ac866461d 100644
> --- a/drivers/vfio/pci/virtio/migrate.c
> +++ b/drivers/vfio/pci/virtio/migrate.c
> @@ -53,8 +53,7 @@ virtiovf_get_migration_page(struct virtiovf_data_buffer *buf,
>  			buf->last_offset_sg = sg;
>  			buf->sg_last_entry += i;
>  			buf->last_offset = cur_offset;
> -			return nth_page(sg_page(sg),
> -					(offset - cur_offset) / PAGE_SIZE);
> +			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
>  		}
>  		cur_offset += sg->length;
>  	}

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


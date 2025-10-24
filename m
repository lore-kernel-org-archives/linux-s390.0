Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A435773B
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333134; cv=none; b=awJrH9uw7/v+t3Y8O4iaNrhaOiBK+sfzIjKv74I88HvJOQcGHUJ96zuV857y2sFfbRvN6WI/mOXbyYfHtQNv+P1eSTLiK8Ot3lVrJdcuuS3NwXCUh7J4RUTN0xkv6wEfUzgUkX4j/h9fCLwkVGtDXV90CCXvJGdQxF5ScahZVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333134; c=relaxed/simple;
	bh=1HPzzMYQqxXuYn0hH8eWdbKEvenGvJhB7Md6BvkK5BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSxFnF8hiTUWdhjEtHswDQepfmLyboyLr7TfQvktHdTU/Nyw9wq2Lp6m4EEQpB+E6eOzHR8kaR5wbighVhwMTJOX5QoanMlIRRDUk00O8hy5o937ENuvg9s7nhx2m2deq9pah4Vn71rEND/JZ7tTeddHB+wfYukyfjahE/ksYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=djkYqlQ2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="djkYqlQ2"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7f04816589bso266167885a.3
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761333132; x=1761937932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCR40IXSwb8+XBgjln+OQr+nWcDb8wZGch2v8uE7uTg=;
        b=djkYqlQ2uBE1MVPYP1auCvtzMJ0Wu2EtdfpvkXLGD90SupS9f9s9/4rdKlaMhfEJox
         DX/90A+NeF8nW1jkcJ3QJFRXNWojxQIuy6d97DSYvgLqJLVlDYpn0GN6Fo0WgvyM4pH8
         Do0eRekndgYnh3AbtIMo0dTPH5EaHXWzEFzHMt3jiqHF5oFC2dS27VmhFEggEA5KM5xM
         B5BT2gQH81z4fIfWm8uW8m/1Id4k3mjfbTaD9gvQUr+TESeom1DF+ui2wUjr/CgaY4+P
         T16BZt1efnbfpsmkhUb4PW6+F3Fh55DVIgQNJJeehyKgzH6KB2UkkUuOSU0AjqDlm1V6
         ebqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333132; x=1761937932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCR40IXSwb8+XBgjln+OQr+nWcDb8wZGch2v8uE7uTg=;
        b=mAgUFXIZCAf7+ZekASfUooQy7CHh07vpgX4xbOT+b2Uvu39oqW5eDwXdXXj3lKCV5O
         aMDTIvXKPsxE8z1bygeznCaF5bWsgWwY3k/JNrPuiPdytVOWGJ8LKieT3LXE5mEDTxFN
         FFwfJXAvRw0kCkBpASpN3W4engjdfE50/0DOgSrpIdME9LYquGUtKCncyyHiH6/zsOms
         7PfZ2iHro/IAJeuUsIdigHZeQtOEM+YXgsScFjMk160osDFfoOsQLzsgx0rp8TYMk0C7
         OHv3pVNQlhgiu8DC+UcddGSunUtiLnXriOdHIeeKqdtTCI1btutacQHkzQM6Td7V3TBC
         PgqA==
X-Forwarded-Encrypted: i=1; AJvYcCV8W9p6gvpONnaYQ4bo4ozyEnOBbTjH2TvFSiDSUpKBlHad4taMi608sEMKBUmX5i37WtqgaeceRIsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLE+bmiERVKDhvbLbgnC6bqLnCcDhqRiTFJOzRh5K0cpvlSUVl
	ijr0+plPAOEnSdsfW4JAfY9hO0k5WnWk9VyYBmJFGN0o/JxYdIgtD32QxaTfP3qEi9A=
X-Gm-Gg: ASbGncv83dBC/0qOd5TiCmzLC1MrpoG/znAcX9ySA0iK37O01FXadUNb2MjqejcXv6r
	eiEctWKhQeNUyBvI01TMOKUipQxAlXlIsU6t82o+G2Prlxn9oUnJJEXTurZkwdrNLcdWVkkyEak
	EPHnKNkeXLzlT23zjpW7PCxZAjmrLnCvsWfoyrpGv6EqLoiRnaoZC1/wKmjVng5OkGbSSJECQ+6
	LJWTcvOaydvpml0rLzQ+Ez6KJE51m7uneHvBckMfAOV/Ao+bN12e3j/nhTtMl/UO1cL7maLtD16
	JmyLuoFglWWeSWXAmWvDfctkJw1NULBc3bsOEJ/2YkBbzyeZqhCTmngSluPjy8TQuiZWP8NNcRF
	GwXvV1rL37R8FQdbnJZaYtjvI1MIbVEOX0rbZ6spAtvRCqERyxAUHXc1OBh3gdOoAhSKXKozT+7
	/qmLbNNSkGuUaljgmr5Sg8F0DErfosEgXAx0EG//kaVbGZLodHpWoMUoKbecM=
X-Google-Smtp-Source: AGHT+IE/iLPq0l1+7yrz/BbyhVyC9k5N0OQCI/Q9HFSHISzKMdQEsDIOj6nKXRkCdZrjDczCxThRnw==
X-Received: by 2002:a05:620a:178c:b0:892:eb85:53cd with SMTP id af79cd13be357-892eb855743mr2482012485a.42.1761333131934;
        Fri, 24 Oct 2025 12:12:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eb805e0869sm40330861cf.1.2025.10.24.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:12:11 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:12:08 -0400
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
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>

On Fri, Oct 24, 2025 at 07:19:11PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 01:32:29PM -0400, Gregory Price wrote:
> 
> A next step will be to at least rename swp_entry_t to something else, because
> every last remnant of this 'swap entries but not really' needs to be dealt
> with...
>

hah, was just complaining about this on the other patch.

ptleaf_entry_t?

:shrug:

keep fighting the good fight
~Gregory

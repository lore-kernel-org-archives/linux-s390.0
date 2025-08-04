Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AF2673B0;
	Mon,  4 Aug 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314778; cv=none; b=ImolvXPnvAx9FIRqxdAnpvHsEsZnKCJp1gwt/yH8Dz1u+8JhuPAK7mDxcdkA0dSWihWcy0z8ls5Gb8SJRf/EsAP6r5yNJeY3nbb5QMtYSGsSEJqWfg0MOByrmxhutNKyPO9jrNeCPCSyd4rLiYXxbh23uriFXgOQfGS4oZ84WvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314778; c=relaxed/simple;
	bh=OlWUAh7GICilysLofknMhfwrPXknwLkZAIquSsD6ayA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hlf1MnqEzsm2Tw5FO04EezluZgn/2FTKtI+IxmvYgLv97YVcEoBumtToqtAZkpgmPh/NoqfUkZrFpHM63zDfMTSVOramKSAfka1K/Bf0eRCpij64d/TPpGUc85e0rPlOlAlwIvj8sqUR1IAH82PEuJjUlI9p+soQHX9CPHePo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aAVFTlNd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aAVFTlNd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5745u2Lr023854;
	Mon, 4 Aug 2025 13:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EUyTG6aS9q1a0tmKCUOqPG42vT1QYZ
	vjXAgeWspdS+8=; b=aAVFTlNdwg83cVTP9cyUcgJo+T5AfpXbWqCsamUqpIfMWY
	I7l9jRF2F6Pc/lcGoy1a2bFgFqRK25Kjg7EVtqGWu0+LwhEShUYtXGqBD1lpdce/
	AhBQcUERnEESEk1fshzPCMViZlooexDfy3YbE7IDOVZyTpMnMPneYPe8xslrm0yN
	auxRLobt4r4FJcFYhz2HonlsX6h9QM+iBh7AIOgFYMyEVCHJkCMBFZJ6wBbT4Ds2
	tXip7bovQr/t/JUBLZW8zQEOCukQvT5VN+Ido0kaSxtJP9pTvzGvB/LLveRB68Ca
	SbBKAkZl+8YSgv/P9VSN/2HcVB9BtZNQFHRH+JqA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3h7qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 13:39:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 574ASL6V006876;
	Mon, 4 Aug 2025 13:39:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmdys8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 13:39:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 574DdP7h20447534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 13:39:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3DD320049;
	Mon,  4 Aug 2025 13:39:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CED820040;
	Mon,  4 Aug 2025 13:39:25 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.65.243])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Aug 2025 13:39:25 +0000 (GMT)
Date: Mon, 4 Aug 2025 15:39:23 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] mm: fix accounting of memmap pages for early sections
Message-ID: <aJC4C7PndXlcDIro@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250804090859.727207-1-sumanthk@linux.ibm.com>
 <1e259390-67b1-4d08-8174-a65f1fc9eccc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e259390-67b1-4d08-8174-a65f1fc9eccc@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=6890b812 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4jqXR_ZrKcS0ey4vrCcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fqmc2F5T_vGsYwpUnWewDSxqDOJSo7wI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3NCBTYWx0ZWRfX/l/TpmOTZmIm
 fhyX1WzCXwwIbAcCAAwAPrqVAfkoA7IPz6Llhi5sMoft1TRt6gJS6Ji8EiAomJpPC8ByHAcvmWx
 k54nFeZJoxo8In1Xm6SuU8sbHlINDV5lgRna3e0fBnjawqcj8u7dQBEnrAE/Z32X/3h4PfBOn19
 w5r3cn9YkiwFaU7aI+JIhLW4j+Vmx1yUjSMa0zwQ7cJA+UuNZYO4gE0EvFxgVqNWkIFdMXxqMDd
 3D3xHKyWSn7jrTLqQnxs1Yjmv+T5bhoDazuyjCIeo5fGkPYNlgQ0sF3zn7gFyvoUHiLwuECT2Yb
 mFWd6i7ResyKIYH4W8ww7onRkiRcNJbXAV0sUFsgQgMGHUx+04E2mP2oX/um4q7IB0uyjfkksFG
 PVsQRUv3nh0LWjv1sZAbNvMPlXvewB1OhUd2a2a45EbuPeiR4TtbY6rms74jdjypgXx2XXg7
X-Proofpoint-GUID: fqmc2F5T_vGsYwpUnWewDSxqDOJSo7wI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxlogscore=409 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040074

On Mon, Aug 04, 2025 at 02:27:20PM +0200, David Hildenbrand wrote:
> On 04.08.25 11:08, Sumanth Korikkar wrote:
> > memmap pages  can be allocated either from the memblock (boot) allocator
> > during early boot or from the buddy allocator.
> > 
> > When these memmap pages are removed via arch_remove_memory(), the
> > deallocation path depends on their source:
> > 
> > * For pages from the buddy allocator, depopulate_section_memmap() is
> >    called, which also decrements the count of nr_memmap_pages.
> > 
> > * For pages from the boot allocator, free_map_bootmem() is called. But
> >    it currently does not adjust the nr_memmap_boot_pages.
> > 
> > To fix this inconsistency, update free_map_bootmem() to also decrement
> > the nr_memmap_boot_pages count by invoking memmap_boot_pages_add(),
> > mirroring how free_vmemmap_page() handles this for boot-allocated pages.
> > 
> > This ensures correct tracking of memmap pages regardless of allocation
> > source.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
> >   mm/sparse.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 3c012cf83cc2..d7c128015397 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -688,6 +688,7 @@ static void free_map_bootmem(struct page *memmap)
> >   	unsigned long start = (unsigned long)memmap;
> >   	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
> > +	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
> >   	vmemmap_free(start, end, NULL);
> >   }
> 
> Looks good to me. But now I wonder about !CONFIG_SPARSEMEM_VMEMMAP, where
> neither depopulate_section_memmap() nor free_map_bootmem() adjust anything?
> 
> Which makes me wonder whether we should be moving that to
> section_deactivate().

Agree. I will move accounting to section_deactivate() then.

Thanks

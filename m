Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1783D891B;
	Fri, 17 Jul 2026 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284341; cv=none; b=D/JGDu6zbvKtq3+WJvFcvpuJUjxTGs+DdPq6mf5c98AoPPKZTgnTHwlSMMDK70PfIMqt/RWSosm0juLScv22sUB7QT8+e9o53PEwan6rOqvq81n10qDBvjAQHYrDJEEGlCo10vOlzWcUBZOzPgIeC16XmsRnFEd26PaQqVteICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284341; c=relaxed/simple;
	bh=C46UBqr0Mf+iu19SS+N/tyqFtIZ40VVzqDtF0Wahcmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9pBZ1lsns24n3Q3aDjd49oIceOT3+lTw1D75UuwI770Km4RHglt3jj7DeqtTaVDpF+rjAm6UMhSuZPx1cEwq5ao49z+D4pdx6awUhtSKKFMI+MOZuEgTskpr9uXrJ8XN04KQvzV7Uv2Gs4afrVcIX6s5xYWv+Xrd5eV+Z8iXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sUn56Fkn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sUn56Fkn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6fsBU1278634;
	Fri, 17 Jul 2026 10:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=32ycj5wkabR/zyHT6uGXLOtsByyh/P
	AilrRb6WoKBe4=; b=sUn56Fkn5YUuvpNo0ZLm/bl0F8/FUXmZKg10pN0RSFtC0u
	7SEilu3qK0An0hozLEDTX5plCwZJXcvQyiJjL42r7aoDEyceAxCghq0AF8euAUpZ
	py7FepNqquNpsK4pXoY9ymTU3gDrjmW1XgkVxJ6EpUqY9pNdrcIaZkxTlvtHGSOp
	qatE3zeUnbci5GakQ6DEnNJC3JyHND7ZuZearUfduxjNBvA5RwIiK04uMXgOsEft
	TmbCC8rgD3pQjJk2XRSSET8NsHSynVhz8LNeew2Zf10zZhAP1scLs5z9JozieEV4
	q4yLbNWCAOLiXb+KcXyc4RJ+JUE7XHZ5E26D1uDQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc4xwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 10:32:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HAJZHv007812;
	Fri, 17 Jul 2026 10:32:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhs5te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 10:32:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HAWCuL22217074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:32:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D68722004E;
	Fri, 17 Jul 2026 10:32:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A1FE2004B;
	Fri, 17 Jul 2026 10:32:12 +0000 (GMT)
Received: from osiris (unknown [9.111.76.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jul 2026 10:32:12 +0000 (GMT)
Date: Fri, 17 Jul 2026 12:32:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Message-ID: <20260717103211.9583B33-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
 <20260717092415.3039699-2-hca@linux.ibm.com>
 <20260717094008.03CCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717094008.03CCD1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5a04b1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=ekNSB3zd-DSi9SQrBuYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX7OCiI6xD4LA1
 4hMdZk1TJLtvvghWXtJcBNXL46va4U1ZkcIlJTXsQS8eDooMFf9zxFNYY8oPdeIC8KB7wQkqnNt
 +p7x2/emGSyKuHWmegKgk1ogbTG/swruTRQboP+hb5V5W/0BBO5L1WyvNf//esdnrJ+lWixwVVP
 2BBXlre1sB9Rk8HUDTuQ1pglXayMNVausI2bnTejoORfNJDvGYtgxqfXOrWDHqAdi/o67FenSMK
 AjOX5MJYWDKrzx1QEG2G4e7cp+CCeMvKw4lDhHGO1wnNMnxIRycGyLZmPI3jERSFngviesTjTu4
 fltBqwrvzSqdm99wKR4cA6+5U07Foi8nwVfhOLG4xNj3+48Sl6GQ0p3zXe4uaBxKckNLmo/9rTL
 PggB/FhuQwCyqB/Pljj7RVkP2gpSaKN9rL4sRorOyExiKh8qbBhmzmnk0pwWSsRjwfnAOXTqbJo
 I+G8AvzNIIDzFisUJkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX5Gc7QN6z7XaT
 uab6HDo4e1zQL22rgXSG9xHSEfkPj0Phj0yVOrAvOPHSgH14HodrEbGHPuIU23wnSBF3IanXXp8
 AyNGjm4JUnr4y4h2Mj44zdPaAeEgZjs=
X-Proofpoint-GUID: F2YDvbvWq3Gd56F1aBHo9oJ3X-ns3_iR
X-Proofpoint-ORIG-GUID: F2YDvbvWq3Gd56F1aBHo9oJ3X-ns3_iR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170102

On Fri, Jul 17, 2026 at 09:40:07AM +0000, sashiko-bot@kernel.org wrote:
> > +static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
> > +{
> > +	pte_t pte = ptep_get(ptep);
> > +
> > +	if (!pte_present(pte))
> > +		return 0;
> > +	/*
> > +	 * Note: do not update the pte here, since there is no code which
> > +	 * accesses the memory range, besides bugs. The invalidation of ptes
> > +	 * and TLB flushing is deferred like for regular vfree() calls.
> > +	 */
> > +	__free_page(pte_page(pte));
> 
> [Severity: High]
> Does this create a window where the physical page is freed to the buddy
> allocator but still mapped in the kernel page tables?
> 
> If another CPU reallocates the freed page before free_vm_area() unmaps and
> flushes the TLB, could speculative execution or a stray kernel access to the
> old virtual address read or corrupt the new owner's data?

Intended per comment above.

> > +static int uv_alloc_range_cb(pte_t *ptep, unsigned long addr, void *data)
> > +{
> > +	struct page *page;
> > +	pte_t pte;
> > +
> > +	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> 
> [Severity: High]
> Can this allocation sleep while holding a spinlock?
> 
> The apply_to_page_range() function loops over the page tables and acquires
> the page table spinlock (ptl) via pte_alloc_map_lock() before invoking the
> callback.
> 
> Since GFP_KERNEL_ACCOUNT implies __GFP_DIRECT_RECLAIM, which can sleep
> and invoke the scheduler, could calling this while holding the page table
> spinlock trigger a scheduling while atomic bug or deadlock?

Odd... this is not true if apply_to_page_range() is called with init_mm.

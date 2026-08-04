Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDEA448CFC;
	Tue,  4 Aug 2026 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839450; cv=none; b=gwAxCVYkIrZ5EOJrMCxTohR9/mXM9sbwGzGvie9cvM27+dwQsM0pYdDDUt6x6UWphwcEj4X071UTtEcf+BavL7WOuNoh0d98Sc15GUVjNTuKsTxfO05zmnT2rVeiSNqxnwgxfMiv+kPbfYwb4Oeirq+6thwEwqBdWSgUMe8+4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839450; c=relaxed/simple;
	bh=xhzo6GjDjrGwGRL11B0qdpwCqS3V7vs0CBugIHwzGBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3xhIUq0p19gnufbNHm7xr8k/EpgH/3YUBmiNq3vdpLwgbqB3QjumOb4LH3uyxGd26sVgEPtwiLU8ZSZGDpW27B/OeC3XECWAuUvlqG77DP/chU6kDUyocpzBPmpxi6oQjJQT05hhFJBQvIC7TuDQZUtzJdKKC5NUwTP07ub/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pmf8P4aT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pmf8P4aT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HXAK295922;
	Tue, 4 Aug 2026 10:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LsU7FG
	BqxypD3ZkZVMVjW43oMZxA7+UBs46pPbpdmwg=; b=pmf8P4aTiRZ4Zsm3UWYcPQ
	zVaqiwKLKAw1bwVnaPP/7hZ7yPefspDOg4OcKgmQbKrt4avgzp9uVyPYVdodQr7j
	i6e62ePNwmh1tMLRTI6LGT7dmxeZ8tn7DbO0d9EC3phR8XFeeLkMEUS/tYV7O8vU
	IQNBl0ufDshSLWvmR2kOvuk9z6D0iquUfFWLXkflOo5VOFFYqXM4EPlsZD/96LIz
	KQktZLMR/8yfA+epO8qEDG48R8kcCFOfzGxNmjfzeEaGEmiVTu+Sr8YTtMlkO19g
	3/EDvqg0wtGMcME//ISTOviKn7ISIioTkIyHgS9eFTQNchJs9dSkewlyGwDM6ecg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3wbtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:30:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674AQF20005285;
	Tue, 4 Aug 2026 10:30:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh9f10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:30:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674AUh2J42926466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 10:30:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BAA320043;
	Tue,  4 Aug 2026 10:30:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BCAC20040;
	Tue,  4 Aug 2026 10:30:42 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.36.91])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  4 Aug 2026 10:30:41 +0000 (GMT)
Date: Tue, 4 Aug 2026 12:30:14 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] s390/mm: Add __context_unsafe() attribute to gmap
 helper functions
Message-ID: <20260804123014.1f128334@p-imbrenda>
In-Reply-To: <20260803172144.827049-4-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
	<20260803172144.827049-4-hca@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71bf58 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=1zN3MVDBpoxeQZqGpDEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xeP0_4tqCDTxC4gh-YHdRmu9tPa0vb-y
X-Proofpoint-GUID: xeP0_4tqCDTxC4gh-YHdRmu9tPa0vb-y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4MSBTYWx0ZWRfXw7KAvxcFDftM
 Vzg9UIpgMrzwOAtxDJQ/WQ2Dh4ADza86IA3YbNv7V6My8HL45xqZExfU/p4lTuieSdDvKP13YvQ
 Mlh2Qe5LUYmw0sDvjorfes1L9bDnLk0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4MSBTYWx0ZWRfX0KULODKmP6qS
 MiYEr57hNnnadthLGUX0eVqTck9jtki0MBSdYMgwJ7krDSYKUFfyJKNwF2+QXZTizhVbqyQ4JVX
 Qa8YVjqvwZK9Pn3rF22SrJaPMNl7SFLHvGP03v9uZNDUzNCBOOLY9QVQwHLkEN5fOm2P8U5h8Sw
 TA2OpHiVF9hnRw3IBzKiMpJyDJmKrg3aZIu0c+UnLBQ1kRYOIxexyt+MHnvTCzQ9/q8oxhi84gr
 6oCv/vwCgk6EJRa5u3MbdoCXpJqApFJDu0naFcsUbklEqxuNVVKDIO9WBVICQcPcqEFFohHJS5/
 EqWUtcGUrVZcgK98JikDpE4sbehMqwoIH94+gbtD3tNAIP54z7neQFYfEMdX7c1cxWs03yYf760
 hO0y32Qdkw4Zeif0YQR+6AywPUbyJSUeYh7fjJYBubjLVG3NUTJbMH79lZTkW9zwwcyeRfdZWjX
 vXUq/H+dkjzIgZCtizA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040081

On Mon,  3 Aug 2026 19:21:43 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> Disable context analysis for various gmap helper functions to get rid
> of a few warnings:
> 
> arch/s390/mm/gmap_helpers.c:80:1: warning: spinlock 'ptl' is not held on every path through here
> arch/s390/mm/gmap_helpers.c:116:2: warning: releasing spinlock 'ptl' that was not held
> arch/s390/mm/gmap_helpers.c:186:2: warning: releasing spinlock 'ptl' that was not held
> 
> Use __context_unsafe() to give a short comment why for function context
> analysis is disabled.
> 
> try_get_locked_pte() is disabled since it may return a nonull value
> regardless if it returns with a lock held or not.
> 
> This cannot be reflected with the context analysis attributes. It is
> however possible to workaround this e.g. by adding a another `contended`
> function parameter, however this would lead to the next problem:
> pte_unmap_unlock() is a macro and therefore doesn't come with the
> required context analysis attribute to address this.
> 
> For that reason also disable context analysis for
> gmap_helper_zap_one_page() and gmap_helper_try_set_pte_unused()
> until this has been addressed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/mm/gmap_helpers.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index 4bf7c9012feb..f910c9584560 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c
> @@ -40,6 +40,7 @@
>   *   and locked.
>   */
>  pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, spinlock_t **ptl)
> +__context_unsafe(/* Returns nonnull if lock taken or not taken */)
>  {
>  	pmd_t *pmdp, pmd, pmdval;
>  	pud_t *pudp, pud;
> @@ -90,6 +91,7 @@ EXPORT_SYMBOL_GPL(try_get_locked_pte);
>   * Context: needs to be called while holding the mmap lock.
>   */
>  void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
> +__context_unsafe(/* pte_unmap_unlock() not instrumented */)
>  {
>  	struct vm_area_struct *vma;
>  	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
> @@ -161,6 +163,7 @@ EXPORT_SYMBOL_GPL(gmap_helper_discard);
>   *          disabled.
>   */
>  void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr)
> +__context_unsafe(/* pte_unmap_unlock() not instrumented */)
>  {
>  	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
>  	pte_t *ptep;


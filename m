Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993EA32;
	Tue,  6 May 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544342; cv=none; b=kGAgPbbbPYnX74ee4FmMLatl7A9VnEjpg9ey4aTYKa6A1qd/CgHirSKhipzzLenQVLS8WN9HJeFyEEixOmpoIF1owa5N/qnC4iBO1MjOFUrQ/PPwAp8N1GyFnerHGLxk2J8BKxZBSJmg6OOS2wWPPlkaEGQiQ1WWSzcfdZxFKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544342; c=relaxed/simple;
	bh=bl7NXRPrjzhZaD4kmbaD1MUm7yIwDx4c2piFZWFMp3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTJWFQoTLwXBgB64PryoyLXBgolq56Mu4vg3YqATiBrMxn2XHOtIQ/2xTfcEXpXbGvJd0zcsGwmsofzYHoKCk1ABZ4thp8ebW59/JEEW4kBKh9KCoeFwX3Ijm4jo4B7ZWYmGWcHt3xiPbxr+rgOZCcFxxBWRL02KU81/W1reoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IBGWaweE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IBGWaweE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5465gaaF006476;
	Tue, 6 May 2025 15:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DptX2UeZwcMMuIu3rqeAdS+aATNzHG
	t6NJTQ/66uAY0=; b=IBGWaweEygUEgjspn+NlOD05m16ZQ7NXtU/XUDgur97chj
	vPlotgnxZ7WaG09nGEnfZE6pvPp3hJ2VQxufXv8zZ5tcbFNvgm+wfqB6fsPpvb9c
	e85O0gX4X21MSJ8uZGs6no9iZ0S+aKfmtxdWhVYXUttgCNkb+spdi78lVuH2muJk
	LefkFW/zpGLSKM/ucFqi72Zd62MwA7tfDprlSNPgI+E8PdyGnpoi4Wn/flpo5Dd3
	amXaGS5TWtbRkPqttcLBi9tG9CTIfbxZb5Ko1wggL7zE9qPIQI025Mj/u73PPm76
	I5OvxQ9b0fCk5lhHjZx91jk23MXACPw6/zaRKTMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy2kc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 15:12:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 546F7FdA009118;
	Tue, 6 May 2025 15:12:13 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy2ka0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 15:12:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546EK3eN013770;
	Tue, 6 May 2025 15:11:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062bqn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 15:11:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 546FBUK835717386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 15:11:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A02820043;
	Tue,  6 May 2025 15:11:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0BB20040;
	Tue,  6 May 2025 15:11:29 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 May 2025 15:11:29 +0000 (GMT)
Date: Tue, 6 May 2025 17:11:28 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aBomoDkNgiEAJjgX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1745940843.git.agordeev@linux.ibm.com>
 <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
 <aBFbCP9TqNN0bGpB@harry>
 <aBoGFr5EaHFfxuON@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <d77f4afd-5d4e-4bd0-9c83-126e8ef5c4ed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77f4afd-5d4e-4bd0-9c83-126e8ef5c4ed@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gCu2k3kzWhwCVIxf2DSXQrISTGR2DThe
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=681a26ce cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=7FHASCDaF61PvbNbS9YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Gu4J50MXSzFrSjYitZme6bowNsEc1S8i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0NiBTYWx0ZWRfX63DfIGolAsmI wti07+s8BO9WtAzNDxvGO/1dKf56kvZ6IKPlQVij7HSGJUZxblTqIpVA1OcoyMOxWDrrJwEwvJs RcdN5hLk36bh1CGsIDPnMpf3bDmhJtWMt5hcvZ4F3BlD7gorA/t0S7yjvwFeHfYPr6SYppkvqWn
 3OEf4hDBbauqcJC5kjVGAdx7E2bDtvz6V/onIhQaU0TJmlcRkjUvVGAhMmW0MNYTYu3Xga1jcv2 zTG2PvOWegkCwo7Fmtr2u3E1LHxcSSd8mPJ0FVCdp+04X6/8yEAN165+5mHdqH8gBMy29N4mV8e Ya8VxBIuqa5kan5L91dB46ryq0d+SKGfEk03sPs6p0IDka6wSBQiq/9Z5qPx4gWLM3I1/+jBI94
 YF41ALJMF9Vtf4hZDH5yGEqzQhNpCtQQ/5hqk15VGTb2jnQcNvQIEdtlPxevPQLukJ7tbKJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=852
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060146

On Tue, May 06, 2025 at 04:55:20PM +0200, Andrey Ryabinin wrote:
> >>> -	if (likely(pte_none(ptep_get(ptep)))) {
> >>> +	if (likely(pte_none(ptep_get(ptep))))
> >>>  		set_pte_at(&init_mm, addr, ptep, pte);
> >>> -		page = 0;
> >>
> >> With this patch, now if the pte is already set, the page is leaked?
> > 
> > Yes. But currently it is leaked for previously allocated pages anyway,
> > so no change in behaviour (unless I misread the code).
> 
> Current code doesn't even allocate page if pte set, and if set pte discovered only after
> taking spinlock, the page will be freed, not leaked.

Oh, right. I rather meant pages that are leaked in case of a failure. My bad.

> Whereas, this patch leaks page for every single !pte_none case. This will build up over time
> as long as vmalloc called.
> 
> > 
> >> Should we set data->pages[PFN_DOWN(addr - data->start)] = NULL 
> >> and free non-null elements later in __kasan_populate_vmalloc()?
> > 
> > Should the allocation fail on boot, the kernel would not fly anyway.
> 
> This is not boot code, it's called from vmalloc() code path.

FWIW, it is called from rest_init() too.

> > If for whatever reason we want to free, that should be a follow-up
> > change, as far as I am concerned.
> > 
> We want to free it, because we don't want unbound memory leak.

Will send v5.

Thanks!

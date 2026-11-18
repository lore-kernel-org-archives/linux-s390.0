Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011994;
	b=dmucA3TUjj3ptVxIaBZaXh5zo9Jj+W+6FvWznpTiJ6WVCmA5y4uoL4FnXq7z5MJmn1KT
	 7hbNEC5tBYTrCjL23ihptow2wvGhNmrzgtW3K5XmOv+E97JqcwniD7gx64Mvi+4qDQoqQ
	 H+lNxoeVyEemQeRErp7R+AiqsejkWOmHjVk9ydJhQyyGxbl7q6IS0CdNpTJCJN57qjqMB
	 bCBwhjm129N22SlnhaMmhbta7y2VdgK1s6iTD8G1RENikaHKRUMj4XqQ7BdV77wTQJEn/
	 PT81Fo3mmN5CFUNpk3otDtfnfM3XGFEGtq4cyR0ZaWqXzVL/VrCRkpZFCxR3MxofgyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011994;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nETXuTUZePoLw4pXYNvsDz7unqCWR2e+XYj5vtu6Xbw=;
	b=vg1AndPri5savjyic/R7wC/nJsrC0rAQ5iLsU041dnQTwrxyVqaESYKupAvJD/Ykiz52
	 OY/gtziMVydvLdvmWpsLx1SUp8yR7W6e1yZqA+h4uPSen0I/v4urjBfg7N3xZb2H/2Y4L
	 N6DYI4XHdz4+OHh9OdQ8XKOXhhrk6/7kezZRW3w0gP4Huty3NNFyv3gCFKj83OhHvRsIB
	 c9Ek9nsiaYPdP/GcDKLfbKti60ieb2ckopnD1aQQwShIWrrkVZfKaenS0JJl2VqRotV+O
	 TOTbw9T7ztWLgCdo8BYYZM3rOaZZ5h0DGTuahXY202jtx0fyUcMDyE18Sz+bd2MbzrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b7nkb+ji;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BD60A2601;
	Wed, 18 Nov 2026 14:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 343BD60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b7nkb+ji
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQfZb1374452;
	Wed, 18 Nov 2026 14:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nETXuTUZePoLw4pXYNvsDz7unqCWR2
	e+XYj5vtu6Xbw=; b=b7nkb+ji0sAeZT+2Zi1PGSCXTbjkReHpVOLQieE/xWBB/X
	RyH01Gdbxor1wSF5iL0pYYAdyXtz+56AGUR/vj+BHprjnq7NmsyZY4pjZQrtcBo9
	pSNiYzu6hkbD9NZeTH2233UGObBdBG6doumOYcZ5VkzoKksdTiBEAqjqL6LYiyj7
	HFzsJYasMpWuJ67dpmq5b395JOr78Zn1L2NZ1k7UQGBNWvLS7DKVASWXTsawgaVe
	gZ13INipP5whutNZGT59rZC6+nIP+SI28oRaCeu0g/33cTRWbcVUjaJjGADqCfC7
	/yrX9zZldynyjP5SIz0GnyI0qM8iJULbZ0an2xuw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105naubs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:26:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYtAW3470648;
	Wed, 18 Nov 2026 14:26:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt8r1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:26:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIEQNni53019016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:26:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBE720043;
	Wed, 18 Nov 2026 14:26:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58D8120040;
	Wed, 18 Nov 2026 14:26:23 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Nov 2026 14:26:23 +0000 (GMT)
Date: Wed, 18 Nov 2026 15:26:21 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] s390/hmcdrv: Replace page allocator calls with
 k[mz]alloc()
Message-ID: <20261118142621.14542C9f-hca@linux.ibm.com>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-5-3db507722530@kernel.org>
 <20261116134656.125125Fdc-hca@linux.ibm.com>
 <avxMOsbgkaC_kQA_@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avxMOsbgkaC_kQA_@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX2Qs/rg4vM0I3
 4PYu/gEpES4RTiIuLHfARi8JW9C5camfvf2hLMAnZdwmNHhLG28liLJbcex7zeNvxCm9FsCtKLC
 9z1qdqWXjQws6YvkhkcjdQeW6+w1WGVrMftAYvW+pLARBJTa3VFocqHP0UHcqjKCwS5+nY5IT3u
 yu/lqXFEfjR24l4G9I38/erDiFnT7sqjIDDesw3oDYDdqc2yO37u1LRO/NEbKTvmo1s4aTZ0uWy
 O4WBxL/u7ZwRM8DRAFxCTPyFA8U5dPVPdUM1KWjlNr2zyyiWNzv4vSdM0DRrVg/MPAGH2Xxdc2J
 dtl7Mro5Y5TSdAc1nnSfKIWYrImtjgWQlYoDq6ehuVDTmqc7MuL07fH0LlyCppVO+BjDyDwjjYg
 0h/kdR5CVOY5PnJLmLNVpzcdI9I21rUu27OsrrZ1tWHeQHSwTCVy86JVvcbXAKXVLR9pYhHg6B5
 U8oAJEcIeSZ5yM1L8tw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afdb594 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=HvbnBzd4vKlcUxMVZJ8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ycwvVJyxzljRnT1qnHyPKQkasI4iuNM5
X-Proofpoint-ORIG-GUID: ycwvVJyxzljRnT1qnHyPKQkasI4iuNM5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfXwZ0e+uBJ6A1e
 /b/WamLh66iGO+8atRWLyWoHFy8H894CPhOC52WaqUaeufRign61EoRz5LTz2ct20Va6rF9qUwV
 tuzb2DdOrTjInEHBoNmPKEn1rMIaSGw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180057

On Tue, Nov 17, 2026 at 02:44:42PM +0200, Mike Rapoport wrote:
> > >  int hmcdrv_cache_startup(size_t cachesize)
> > >  {
> > > +	if (cachesize > KMALLOC_MAX_SIZE)
> > > +		return -ENOMEM;
> > 
> > What is the reason for this check? I can see that this seems to be a
> > common pattern, however the buddy allocator would warn as well for
> > allocations larger than MAX_PAGE_ORDER if I'm not mistaken.
> 
> Since cachesize is a module parameter there's a very corner case when it
> could have value within a page of ULONG_MAX. Then round_up() wraps to 0 and
> kmalloc(0) returns ZERO_SIZE_PTR rather than NULL and does not warn.
> 
> The module would load with a bogus cache instead of failing as it does now.
> 
> While it's really unlikely to happen in practice I'm sure Sashiko will be
> unhappy without this check :)

Ok, then let's keep that.

> > > +	if (!ftp.len || ftp.len > KMALLOC_MAX_SIZE)
> > > +		return -ENOMEM;
> > 
> > Same here, and as far as I can tell the Sashiko finding seems to be
> > valid as well, even though it looks to me as if this worked only by
> > accident. Also, as far as I can see, the reported "delete" command is
> > currently not used at all from the only existing user space
> > application that I'm aware of. But let's not change this, please.
> 
> Sashiko is wrong about get_order(0) returning 0, it actually returns 52, so
> __get_free_pages() returns NULL and we end up with -ENOMEM anyway :)

Yes, indeed.

> So it's either keep if (!ftp.len) and let it fail for "delete" like it does
> today or have
> 
> 	size = round_up(ftp.len, PAGE_SIZE) ? : PAGE_SIZE;
> 
> and allocate at least a page for ftp.len == 0.
> 
> What's your preference?

Then let's keep the code as it is.

> The ftp.len > KMALLOC_MAX_SIZE check seems bogus indeed.

This can be removed when applying - no need to send a new version.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

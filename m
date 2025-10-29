Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B202749C4;
	Wed, 29 Oct 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742214; cv=none; b=LGTycpiZKuVR170kMJcNujtsQglanvu7xD89/UGtfcUESPhUTok3jULUmhHQL8uB5+6Zr7wPIwQ7zqmjoQWI23WGz7wH0MsgK4nA9AJXV0VRRmIhm3ykTzZzXf9uhNFbtLcNSShGxJnGKYw2AZ/SPgBfeJQqd8uvsxIToDmOwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742214; c=relaxed/simple;
	bh=Rsoy6tjNujuBN7B6QxeADLkcKAPODBFZRHP84iRmOy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy/oz7h0AZwxP0kJUSTyHA4h8hoFfz903y78Zg9JwhHDnO6phHFoDte2y24QiII0LZ9DZQ+ZVF431MZhcJfQ/6KbwQx8OxpGslEU9P/MdD0pGe4AbE8Wd2wjzyZdZMu+CJAbJemybG4hfZFfpy49JTxrZPOuBTofGZplfrNh4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GowXhPmN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GowXhPmN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBHOBO026005;
	Wed, 29 Oct 2025 12:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KAgBTvcu80fXe1fwekyVRC1/bvwUvU
	T01UOXn7IaFcw=; b=GowXhPmN50B8D8idGyqNnq9J0FAlWPYP7kD2Rmh4Q5NETS
	derlG0pNjxRp1uOkOd++Up22tK2CrDqEQpb5fxpCV6OD4Q4Fng9RQmeK+qZVh1bA
	0hqpIczKCgL1O6IzzGIrZR8GmN1M5vY29O2iUOVu+eb4nif2WoW7LeuoFPCnKKe4
	yvOhdBTq9H9BZowPTjxlcS4ablwmRkITvbQrXBJrZ7NQwnPkpFf86e8jVHMyOsAW
	oU8DVPrGXqDWnwzBD33HBO78MUxOHoPqLIM/jPMklwsvGyy14vjb5QxPIi4iOaUz
	1s3AMTuTp0uzu8d5Seg/DiJCLCiAG+x3lkQOPtMw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aak487-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 12:49:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9kxoN030747;
	Wed, 29 Oct 2025 12:49:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwkb0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 12:49:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TCntFQ44433838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 12:49:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC9020040;
	Wed, 29 Oct 2025 12:49:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0CFC20043;
	Wed, 29 Oct 2025 12:49:54 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Oct 2025 12:49:54 +0000 (GMT)
Date: Wed, 29 Oct 2025 13:49:53 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, borntraeger@linux.ibm.com,
        joao.m.martins@oracle.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        osalvador@suse.de, akpm@linux-foundation.org, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
Message-ID: <20251029124953.8393Cc7-hca@linux.ibm.com>
References: <20251028211533.47694-1-luizcap@redhat.com>
 <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
 <20251029104457.8393B96-hca@linux.ibm.com>
 <9a8254b9-92f8-4530-88e8-fca3b7465908@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8254b9-92f8-4530-88e8-fca3b7465908@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=69020d77 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jL9k_VB0GEcHRAsgpWwA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: d7fou95aMW-uoHoBvQs44vXWPA3v3hlP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX/oTo6Xh50MtI
 tyftiHDyPqefL6i4ewtPwSFaHIfzYG5hcU61cVUCmE90icNKNJPTPq2CeETrBXDHeI0rfosiAQy
 K6ZTRo5A7we91nVh7IppPMSZN8yrpEPNjTjmrsrK28U9Xgz4MO2dRmcScvGoQx0iHbFV8ABTarp
 odLOX8K8D+KdOEOSAlIm2XNTojsSqNjGYdiCQOX7+GmbYtyHz0AnRA4jiGZ5u5KBbpTBWKEcgVn
 Zn7Bkm78kGwYsfxNvb/77vQlYtBAgylrI//8hvqa916XjUWCSw7QwYAw+cdvxUvYX+CI5G9jgnv
 OK2GtuYXvZhVIT81bggT50K+vpwF85EZ8LUrZ/Dx8caprN82Fr8OnUromFPNKBb27BB6p37t/TC
 N3kUgCnqtPVrQ5t7cUHB4gB/Jke0Iw==
X-Proofpoint-GUID: d7fou95aMW-uoHoBvQs44vXWPA3v3hlP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Wed, Oct 29, 2025 at 01:15:44PM +0100, David Hildenbrand wrote:
> BTW, I'm staring at s390x's flush_tlb() function and wonder why that one is
> defined. I'm sure there is a good reason ;)

Yes, I stumbled across that yesterday evening as well. I think its only
purpose is that it wants to be deleted :). I just didn't do it yet since I
don't want to see a merge conflict with this patch.

I also need to check if the only usage of flush_tlb_page(), which is also a
no-op for s390, in mm/memory.c is not indicating a problem too.

> > Changing active entries without the detour over an invalid entry or using
> > proper instructions like crdte or cspg is not allowed on s390. This was solved
> > for other parts that change active entries of the kernel mapping in an
> > architecture compliant way for s390 (see arch/s390/mm/pageattr.c).
> 
> Good point. I recall ARM64 has similar break-before-make requirements
> because they cannot tolerate two different TLB entries (small vs. large) for
> the same virtual address.
> 
> And if I rememebr correctly, that's the reason why arm64 does not enable
> ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP just yet.

Ok, let's wait for Gerald. Maybe there is a non-obvious reason why this works
anyway.

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CF35202D
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050428; cv=none; b=pqwkglGJr/iOu+auPwkBKzNW5aUGBn3VYj5sIilVIYV/jQy2tiO6KNv8tudCGbL1K8DL9P/TWQPePVxuFgF+LEPXAje0dj/QmiWiUElnoacb3yg83l+OihwUpzopActb8Q13u7ifZqSwU/PPqLQ6fDZfgv8JtSYxfQbcn2mDdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050428; c=relaxed/simple;
	bh=Bjq/rXvWtF9wNlD2vO5nz8W/PnZTsOuvHcgoM6M0EFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EblbNoN+m0ea14yGSd2R8uToGZrBWbN6AXX6rPCAbucxIbXq6d3aclJ2D5dho2n1nVjfUqttFtIBPozECk1ZwjWadVhfgtZHFlmNVowVBB5vi9duTjysM+0vtdcH9ny/Mh0qpGT4k83mqwJCZgveF8t2SoLhGQGzQbMbAKfAME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=clOhJ1My; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="clOhJ1My"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLmD392134009;
	Fri, 29 May 2026 10:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OEufYLFDd04BhnQ+E9+Yvwe8t7mAwv
	BE1pakbPLCjaw=; b=clOhJ1MyCSOLIYdd9JeebO8UwDUx0HlOEkvMOmLWC6tDGS
	IshR7fOAnd5d9XyxbBHDtb8bSdJNMPupOGJNSw5fqS8boo9AYbdSZJe9Q2cAh3mw
	co+eqhh2uG7lPA9+pasrm82CZOsd3jtlWww9Z8+a3STuIVxRcqVKLdv0felsF3Js
	3aCTkPf9h7G0Ycx0jrk7hAcDLdHBV0b0JSJwWYrVaf8AkV3R3ZzeQRjIHGeGFgay
	lKiOc5NMHX05U07iWtjmDKK9njHwsOifwyZHZumRJnn3pbnJ46JYx9/cJgdEwDpr
	rho34v7lpHTxug4EaKXN5e7H5ixW8ZbS77/4jzFg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887qs1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:27:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TAO7Fk007103;
	Fri, 29 May 2026 10:27:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbd432-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:27:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TAQxuW52298016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:26:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8BF20040;
	Fri, 29 May 2026 10:26:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 337DF20043;
	Fri, 29 May 2026 10:26:59 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 10:26:59 +0000 (GMT)
Date: Fri, 29 May 2026 12:26:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/6] s390/hvc_iucv: replace get_zeroed_page() with
 kzalloc()
Message-ID: <20260529102657.26496E98-hca@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-3-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-3-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a1969f8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=689iU_Db-G2QeZ7t9bIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jD5YS_llqLEqOiMZ0C7OjfEnCkb1jQUu
X-Proofpoint-ORIG-GUID: jD5YS_llqLEqOiMZ0C7OjfEnCkb1jQUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX7T08HgYaRuDd
 68pGDcwl3FsJQEqWI6xiI2aVDbNUIxj76fiMwJkRHH0NsCLscrpytcbeKTbQodp9Tpc+fzh81ZH
 eoON/Th0NI/8yek/ENXp/eCb0RbQ9tAgNVqtUu3wx7gCcO9npy7pDl3YeVdrcKTWWUJqW11T89G
 Xlb2q4ResYq1KD6do1mFrgAqHx2bJVKg1Uwx+sSJkfAi4rMpL8X0VBgGfzy5MZJ2CqxLeENZeSD
 weWzrgvz9klab9jTTFeRullS6J2NdjUYHfo8/vm2jEM09E6NJA5sRc3YauYZH2ylrxtoXGC7fxQ
 UFcfd30iHAkz34n+Mh0qq/pesI0CzmCnCxzNBQJ7NOnTzdpcQ7WDDhwVdKlETlDMgc64whRFQ+i
 ou30QQ4+ytwS0oqXyY05cXU3GDhGVwl8ZOpf9Gvi/f4IXMBQAXlMZWpydySURKZT4+E3/x/8oy9
 zruh5GVuglPAiUnx8nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290100

On Thu, May 28, 2026 at 10:09:51AM +0300, Mike Rapoport (Microsoft) wrote:
> hvc_iucv_alloc() allocates a send staging buffer for accumulating
> outbound terminal characters before they are copied into a separate
> IUCV message buffer for transmission to the hypervisor. The staging
> buffer itself is never passed to any IUCV function.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/tty/hvc/hvc_iucv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

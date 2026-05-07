Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10753E9588;
	Thu,  7 May 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149949; cv=none; b=MqCS+qFHJr2OzL+m/+cjszQfkZyahE44N28sbu7f1mNXFpoCx+w/psHWpUI6dOKWIolRmKvblHY1Gm1gtc9MqxE6pHAoP24iusgXHc/RoaYE8M7mzj3T9+pRbfMeJdd2Ld/1PbtgxOvofi0h3dsMrtR5u3U7CO4Our+1btLx7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149949; c=relaxed/simple;
	bh=Xp5J/nVAsEa1LmkDRxT/S6oEtNsiW1RhqOp2/SzsEb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaCcs85YELUhVenevr+6JNlMbZ6gpx+TIuN0p0Kc70H1QIXmXzcs7yGlIbg8LOMcz7MM+QIO6w/B4yQCAHtzmCRbGW7Kcey/Pp0lxE07iLGvAJpCVXyYs0NloWDdi+VH1Y8eFSteiFH0UMzBHWnkj2NssrmBzyopqWkclwHrdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TklwlF4e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TklwlF4e"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6478pJO81944676;
	Thu, 7 May 2026 10:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=b5Ddx+MuqAF6oUS+rxqJx6cEL60cvc
	VClEjL1dSCRSY=; b=TklwlF4e0x+q6seZpNY0NLQIC8wtaXYIqdVEBH8mZDp3Ty
	OqOwzRkVyi4jiq9OsOw0N+zgIUYR82zAXEYvJgHTDCkXoN/ZJ/dkLoU70TZ7pySd
	WmMiLGJwy7pIUNqSnN5gbCxXrKHtzih920PWJ+5A08JrUzyApmAgiR+X/FT3T2t5
	UY3IlIrbge6EwL/N1AVwNa8L9DtnqJS4eWMU5M5t+fZm9xslDHsglusW9+iXWRD4
	ftHp74KVcQhq2sgwGnhTe7YfrAvscOza1saAqJjtdbU5BSH//69Zk3bDNg7yUiri
	J6kbxaa1NVYPJ4GK6Khti81spZLF69Nba5EI/W3w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6mp2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:32:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647A9Yb0027865;
	Thu, 7 May 2026 10:32:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hanwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 10:32:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647AWBUL49545478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 10:32:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B81B520043;
	Thu,  7 May 2026 10:32:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDF22005A;
	Thu,  7 May 2026 10:32:11 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.66.252])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 10:32:10 +0000 (GMT)
Date: Thu, 7 May 2026 12:32:09 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <43815634-29d3-4fa4-b967-0e251ff32f73-agordeev@linux.ibm.com>
References: <20260504130434.2285053-1-agordeev@linux.ibm.com>
 <20260507093433.q5xybwumryxclnqy@master>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507093433.q5xybwumryxclnqy@master>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fc6a30 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=D19gQVrFAAAA:8
 a=7CFNzQo_ZtPcNetzl2UA:9 a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: 8QOWfc7k0b7o7pCZUW67IeWT83QfImhq
X-Proofpoint-GUID: qN--_Yog5Tix-ByckweoU--16gQTXerf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwMCBTYWx0ZWRfX2wTtXQzvHzvL
 xI8BnlJ8Pxm/3TvmS47XwcJZexg69P1SXrHM6Zyz/Lmif+mjbOqNI9O3UpjG6WHrx9tsMNzaTwa
 iVOWgkeh+TLRZO96TOmQTUGXaRJTIleMJC09wJpG+pvyIEeNo9qBC1Ir5asWJa4YNRDyJRHcb18
 aEEFXQQQ8pzT32KUPHJxQ2n2tT0TFk4Ocb/WCIhT3npPMra0Qf2kC6B5WasnW8oUbcyQDTziI+z
 SNERrdIjFWMpS/2q2Qf+S5EyBC4hQpOX+BvTvihoSsJxdx7Y+2WJpw1GmEmr8aZlDiqpg3WzQ5t
 ommhqmlI//BmBSpjvaZpeCcO7SXDU6+0HhVwFbJoel/lbDwN9tb0Q1Fpfjq3OJFvK1aP/mkkOuE
 P5FRJRKcna2FfalADhYzlKVSwAkrN54krW7KT2emrntOZZEVu+6VClcqx1cjQ1Uyi60W56xnqOW
 wVIR9MK2vEYAGnNYntA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070100

On Thu, May 07, 2026 at 09:34:33AM +0000, Wei Yang wrote:
> >@@ -310,7 +310,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > 				goto restart;
> > 			}
> > 			pvmw->pte++;
> >-		} while (pte_none(ptep_get(pvmw->pte)));
> >+		} while (pte_none(ptep_get_lockless(pvmw->pte)));
> 
> As Oscar mentioned in lkml.org/lkml/2026/4/27/630, map_pte() may take the
> lock. So probably it is not right?

If I read the code correctly map_pte() might take the lock, but also
might not take it. If it took the lock and uses ptep_get_lockless(),
then it is fine. But if it did not take the lock and uses ptep_get(),
then it is an issue.

> > 
> > 		if (!pvmw->ptl) {
> > 			spin_lock(ptl);
> >-- 
> >2.51.0
> >
> 
> -- 
> Wei Yang

Thanks!

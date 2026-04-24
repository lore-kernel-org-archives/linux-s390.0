Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CAD3ACF18;
	Fri, 24 Apr 2026 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030533; cv=none; b=ms2JJVbIqW+H3bGcZQazV/HjhAimlMoW8fIr1PBa07flWoc9dozlfVI2LU/CsDitXt6zAUmE3yAHszIqD+ySNSauGuXUk9CQUlwUnHfxQakUiCYbzJhP+RRZQYQw0T2zhMHDfzPt9p4cS5Lr4AihMqOsA9CPW9Fgb4mvY3eW8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030533; c=relaxed/simple;
	bh=tJx5CeS5Sd85mVqU64AYL9oHV5j0DD5T7PY6BgXLAXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmC+I0cLYpJdLSn4VB9PgQ7vhej8rEJGHPB9JbXzt9KKzG17tUit1RrVNiZgbU2QyZd48DpHUCmoKpxfICFDIinY1VrmFy3xhw5CsvjG4P6lnsrCp1UG7O+jUxOtKwuSkA9BVhYlsxrdSMy0SUNKj/J+I59ez25eZ7ECDhaEdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c7TxfKjg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c7TxfKjg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NJmmFL3944257;
	Fri, 24 Apr 2026 11:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kaUHNW
	PSayIAoxwlfIlVDCNfQb1tmYIwvhyzCBu0cHA=; b=c7TxfKjgaWAbt13HX4LJ/M
	hunw8CSlRcWLqYz1JrEQyGFNZwTKprI6bhikDwLyn5/qU4IeAiJe6XX7Sz3QcWHU
	AQjNjQLawH5xpNcbtGzA0e8wcRmoW2MzI4Y0Otq0SVHaIOpBnj9aGNEUl+45yQVV
	AR66nxMNq4gszcaMc9EiEEOxZ4Qvo4ueYJounGTXZRx0zNOAczvrEw5XI4EOP3QV
	MXS6gtO/5LyRHXqY5ttKvrJDa8eMDdhDm0IGk5nz6aUAzposw3sYfcIudaNzaAfD
	9bAXDAlXaw7+ZAm/ftIRedg5jykUpwp8ut3CdBclsAkyCFhHQfL3dzs17l8K6B8w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3vnxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 11:35:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OBKSVC031531;
	Fri, 24 Apr 2026 11:35:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky2kfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 11:35:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OBZHGE27263346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 11:35:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF922004D;
	Fri, 24 Apr 2026 11:35:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CE4A20043;
	Fri, 24 Apr 2026 11:35:17 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Apr 2026 11:35:17 +0000 (GMT)
Date: Fri, 24 Apr 2026 13:35:16 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] s390/mm: Make PTC and UV call order consistent
Message-ID: <d0a495bf-c463-4aba-9192-c32b3d24fd87-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <7b0e73e3c6f4000f9bf7cb161d8ca9a9f2312d70.1776264097.git.agordeev@linux.ibm.com>
 <20260423105409.10371Da2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423105409.10371Da2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t3s94L5-K4QOEY_wKDbbGdt5D2BGdSrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEwNyBTYWx0ZWRfX1bdyTOTi7Fv3
 JJjvP5hGxQdlvY8bFZaOTDDSfBkYqpkUCiA3+UimJXHXSNf1IdU1pYAme/vFzM9SrWuY12r4WJK
 I+dUiXRWkcTCUpCdVo+/XEDji39fGBoe6Iqvcf6eBpyQEtGrmRdC6rTXcW/qBOwXK6LT3pjdzeq
 a5/dduev5U2VEFaUnf6LlbM1/RRyAlnVVH0eVYJOiSdxmfXjztqt3nawH/ngXktzw+NEo1e6Z+9
 9MZT9R2SXVmkzKKZbVXf5e1xMYrXZJxiUmlynTKpr+bhEFvRyY4l2qN8v0bYyuSrShQ7zAl3gte
 IaIDKcvxxoG0krjfYtj9rkfZydFCZ4VMoRcJujdVFZv2Mbu1kyTzx7aWAPsqj/V/yie6rRr5XOY
 vrnAKqUnpRk0h9//ke5ySVipZJdPX1n7yhP/LMF987tyOis0eQmfhyDISo0ojUzUytLV3+Z5ORm
 L1oaYM4mQq8oWCGi00g==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69eb557a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hBe9qfS21CEMvM0OSTcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t3s94L5-K4QOEY_wKDbbGdt5D2BGdSrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240107

On Thu, Apr 23, 2026 at 12:54:09PM +0200, Heiko Carstens wrote:
> On Wed, Apr 15, 2026 at 05:01:22PM +0200, Alexander Gordeev wrote:
> > In various code paths, page_table_check_pte_clear() is called
> > before converting a secure page, while in others it is called
> > after. Make this consistent and always perform the conversion
> > after the PTC hook has been called. Also make all conversion‑
> > eligibility condition checks look the same, and rework the one
> > in ptep_get_and_clear_full() slightly.
> > 
> > Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/pgtable.h | 39 +++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> Why is this required for this series? It is anything but obvious to
> me. If it is required please add some reasoning e.g. in the cover
> letter or to the above changelog.

This is because changes to ptep_get_and_clear() and ptep_clear_flush()
look much more clean with this patch. Otherwise, I would have to move
page_table_check_pte_clear() before the UV check, which is strictly
speaking worth a separate patch - this patch.

It also makes sense as a cleanup. I would prefer to see it as part of
the PTC series, but at the time I did not realize it was worthwhile.

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6F330B11;
	Tue, 30 Jun 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839449; cv=none; b=iW227w/pjv3ATmvX+XCwZLP7iXgPUq03SZvYv4lK+uxbKqQALaS7Lk37kqm+XYgxi0wMRCurvdgwEGcFcgVUTWTI2wsQT6yK5dRE9zFH+6/TKHCXjdrw7cRyglhLomqON2LrplHLlZUEyvPkHEyvVHZA3DjFTUNPIIt9PLWacCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839449; c=relaxed/simple;
	bh=AjeDR9n0hLVk0iDfQ9zsi6JSqyKCnYSFWfOhm6iXF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqqlOnrtjBWXu/hkWgQkyki9zsBBwca+Rdtm6CkOHNQoIoAmzjJKsfRK3YQ98UxtzOjuZE2+AqRkbNybS6Cx9rI3WUQAolE7WMJ4j8Fh/OMSoBLUlnPAtPkSX4huexSTpKdwzf8vj79nevjkiRR0ey+tnGZxAYqf67u4zdnHmi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+mWU01P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+mWU01P"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIbvA2233969;
	Tue, 30 Jun 2026 17:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9aWzaJ
	PPdwO1Dih5AE3wt65kIL1EN6VfYGmLmbC27sg=; b=S+mWU01PvXWVwvBV3tZpVQ
	6V5XSDo//QAPF7Tx1vrkhG+HJ+xjqbKfg66WaoZpAH3Zuos2Xt4iVsda0F5Tj8aR
	HfZNuOsn+F80nxvIuY8ENz78VGM44/l3v4cvDR/VLCsLoPUbSXZtJ925tfefzg0Y
	mKt7Q0wARKRWkoO/Pw/bc4CDPoFr9CAiAyF9LEw/kX2UH5WbkoXBhrDSBc/FkTmm
	dX8pZSVQkBua9MZbNXVrzYmVWnmN1ShlMhCiLjNJ1LkKZt23kTb2/qM5mSYBkLbq
	XR/l9worO5sgTsom0JmS+IclbzVd0/WJhlCJ4IY6yI3+VaVcYc93QkZniGYM1pDg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5r3y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 17:10:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UH4edR015013;
	Tue, 30 Jun 2026 17:10:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gb6qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 17:10:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UHABA748890118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 17:10:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B17A62004B;
	Tue, 30 Jun 2026 17:10:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738B420043;
	Tue, 30 Jun 2026 17:10:11 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.224.89.120])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 30 Jun 2026 17:10:11 +0000 (GMT)
Date: Tue, 30 Jun 2026 19:10:09 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        Karsten Desler <kdesler@soohrt.org>,
        Muchun
 Song <muchun.song@linux.dev>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo
 Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        "Liam R .
 Howlett" <liam@infradead.org>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S . Miller" <davem@davemloft.net>,
        Huacai Chen
 <chenhuacai@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/8] arch/s390: Stop special-casing hugetlb mappings in
 arch_get_unmapped_area
Message-ID: <20260630191009.048d94a0@thinkpad-T15>
In-Reply-To: <20260606035003.529685-5-osalvador@suse.de>
References: <20260606035003.529685-1-osalvador@suse.de>
	<20260606035003.529685-5-osalvador@suse.de>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX592oA8o4ggrD
 EyQ+iX7Z5YvYmSUxb1xwD+K1MqTQWHzfST2MholpEAOaQc+zIkyV6TGcKXGXxLnPWnbU+l+XxB4
 Nr6X4FzbuV3Y24qxP7nX7oMtYoRWIymum26te1c4gX5RxchklpgMvKQHR/9FBMQVfTfdt1P4B27
 ovYdmT9T4mFQJWlTmXnZyJtfdS+jaKpxDkCLzQAL6Bz0RDHTYa72dDO551LEF8vuijnjX9M13Qm
 Gr5noHLkLj0WXsyI+ECI16OijuNTg34eKJag+K2CDsPvMD9yMJrll5DEtPz2sN0/TcyzPSdOhns
 eMClw7wxDK53oFC7R5OT2Ip41m9r/BbIM9ME3EQ79/oL/DQdVGfSED8EDYX25becp7nXSzxcir2
 8xCP9knD6CkV8NQnMM/fX/us47o2Am20T3Qo6+IqhY5NYX0j+5LQeM9soRCVYR7Eg5yG1I2Xfjz
 GQi74wg8sIzWmvPwIeA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43f876 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=83SsSGizDXAGF0wgWEoA:9 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: EjiqsR9Wp76128TiUVYYv-x6rwuxrSdW
X-Proofpoint-GUID: EjiqsR9Wp76128TiUVYYv-x6rwuxrSdW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX87CtA5i8EVw5
 vTuz7m4pl5Qikn/8qI/FE+LNFsI/me15F8p5D5vIYsGGiCPNaglx5B1lXC5eeMFWO02GNUxt1vG
 6NE/25UaX9hkvJwAXTA3bTUxzIaZZlo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

On Sat,  6 Jun 2026 05:49:59 +0200
Oscar Salvador <osalvador@suse.de> wrote:

> arch_get_unmapped_area* sets info.align_mask to make room for extra alignment,
> so that is added on top of the length we request in unmapped_area{_topdown}.
> hugetlb_get_unmapped_area() already adds this extra padding in the 'len'
> parameter, and it also masks off the address it gets to properly align it to
> the huge_page_size we are using.
> 
> So, stop special-casing hugetlb in arch_get_unmapped_area* functions.
> 
> Also, there is no need to worry about align_offset because that will be
> masked off back in hugetlb_get_unmapped_area().
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/s390/mm/mmap.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

With regard to the Critical finding for s390 in Sashiko review in
https://sashiko.dev/#/patchset/20260606035003.529685-1-osalvador@suse.de

Yes, I think crst_table_upgrade() could be skipped "If the original length
fits right below TASK_SIZE, but the inflated length pushes addr + len over
TASK_SIZE".

But subsequent page faults should then generate an ASCE-type exception,
killing the user space program, and not alias with lower virtual addresses
causing memory corruption.

Still, I wonder if we want an extra check for "addr + (inflated) len > TASK_SIZE"
in check_asce_limit(), or somewhere else.

This "inflated length" approach also seems to have other subtle impact for
other archs, according to Sashiko. Possibly resulting in failed mappings for
valid addresses and ranges. So some extra checking or retry logic might be
needed anyway.

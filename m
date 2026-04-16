Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7535919D8BC;
	Thu, 16 Apr 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322874; cv=none; b=kiFvOLPOOa74KdUe8XaTg+2rhkt9De+pgpBqh+9dzvhmiH1BmMYV0Gbjoq51oOp+ZbhJXnYNXAGWrhLiY5m7VBoCnq/fBXPzlwxuiyrY7ZsXSIWxcQi6nMRLARqh78a4zxK2KyFgB4+FBaxhfWrIISXgcjdmG3d8v8ztvRzxynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322874; c=relaxed/simple;
	bh=LpDKh6tYFqYkpW0TfpQlIw7BrV2maOfsDebFQewUeYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxIYHlI/yfHF6QvqwySrCdNMBN9/6PbRwXg5Oqxj4vmTEu4+FaLOeFAkqiLXW9iz5PdUEFTHkyhefqfshhrjtRoOjNKH2snWc6v17W8XlSEeXILDwp5egf/LpiXdjDIAroD3xfI77us+lAXe7Xl8ze6Q26sJH6PcStknB0YmLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eDBCBKzn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eDBCBKzn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6lfGh1804738;
	Thu, 16 Apr 2026 07:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tpWKg8ZeDbqHc+7JPbph+/kdcpPxNB
	q7qyNbqivMtDY=; b=eDBCBKznNt3jY/kLAZsk7N4s8l7xfVjF9Ic4BOjhJ4LAXt
	etIhdlNOwtAWaxJI4Nf/aU4FZs1S+ooUOLIlFceqgVARZD6/CgyKQ/66C8hQ5v4Y
	DAdv4GmCyaaoA6K7ztS4lDwDwq3cU2oCB3muhJXZH3aPdc71TTkh3vxjFQb7pHvo
	56ccljwkNFXShw4BYTaLYeB9EPxMmVWGqAbGkPTrz6ym3hwyIosLM09ehyR1PHdb
	35+PV15F1ZwIy/q72ojh1xDehTeYu4Cc/9xsgOGQifToLSoJfSv59tkRyHC9r2bi
	YhT2K51OUhBrfnnF7LDgUpsG8qAFFGSBJXZ5Jlbg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kbapj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:01:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G2iYuP003379;
	Thu, 16 Apr 2026 07:01:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh93ch9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:01:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G70xgm27132348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 07:00:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4305320040;
	Thu, 16 Apr 2026 07:00:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB1D20049;
	Thu, 16 Apr 2026 07:00:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.42.253])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Apr 2026 07:00:58 +0000 (GMT)
Date: Thu, 16 Apr 2026 09:00:57 +0200
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
Subject: Re: [PATCH v2 6/6] s390/mm: Allow lazy MMU mode disabling
Message-ID: <2a497bff-1773-4245-a63c-784ed8853b11-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <24d843c5568a8b591cbbe16eca092e7f45d18cf5.1776264097.git.agordeev@linux.ibm.com>
 <20260416054405.10407B6c-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416054405.10407B6c-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i30Fjl33Inahe3fkQUhSbi2uCpwkt34E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2MiBTYWx0ZWRfX/2vOhPPcKvXc
 WK6/l1A12P8h3ZP2yfx/j2LMudfxp0UCndGSoqXkxgtmZHnVs9cxUp78MM6DaB0xH83+JzQO/Fe
 WHmONGSbdOQ3fMjSvuZ/V44KzMe5xDDi3D3smgAEH5BeVD1GIJluOzjKlNK5aP5DWmi3zoE+/aH
 I4LSO4RHkWbVBYLwHZjBRZwgzHByL2vC4SRKbnP2NvKICgycje8DNJS9Evt7l0fGY2YmWuG7vUG
 SClN+gejL3roR3e12Q1AcEETd9lmTkmoEaUmSPEx4zz9/wa4c4BHtohF4o33tdLrBNNErIKuUfS
 F+knZw7WiHWvCr+9n8wU/kTHuEzvpbzaAiDMdmB0Jqyl1Mv4RbV+DWZ4/d+t3TGvP2wFpK97+Ou
 48XidNPdeJC1SJUx/8EXyR3WU4kFLyMP6U9r+P8UjciQRR/nkQqgqipRCNwHtU4u20Fx6GHgQ7q
 9Kw++wK02bkPuc1q2fQ==
X-Proofpoint-ORIG-GUID: i30Fjl33Inahe3fkQUhSbi2uCpwkt34E
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e08930 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=ov5kqanpoNFzf825lJoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160062

On Thu, Apr 16, 2026 at 07:44:05AM +0200, Heiko Carstens wrote:
> > @@ -169,6 +185,8 @@ void arch_enter_lazy_mmu_mode_for_pte_range(struct mm_struct *mm,
> >  {
> >  	if (!test_facility(13))
> >  		return;
> > +	if (!static_branch_likely(&lazy_mmu))
> > +		return;
> 
> Looks like there is an alternative chicken switch available: remove
> facility bit 13 from the facility list via kernel command line option.
> 
> Unless I am mistaken: that should be sufficient and avoids adding more
> code.

But that would also withdraw multi-IPTE from other unrelated parts of
the code, e.g. from __kernel_map_pages().

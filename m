Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B74BB80D;
	Thu, 17 Sep 2026 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640826; cv=none; b=LH9vXGv9bVpNSvLOl4RbN0YkZeGaKvo+5u/Ln6NKnr3nhS8KfaXBUZaq5LRaWwJsmPoWZ48lIxYNRLGzHrFoDViET1DEqiJQjh3c46sih7V5l67zc5A8sTCQ4WKhhDfYAZhWCVfk1AKRke1vpsePjRc21v0wXfj5RSPNIgOw/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640826; c=relaxed/simple;
	bh=x5l7ya7xw56g5gnif7JAAnQKZQ6cqi/AlRzaKNjjk74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPAGt7CQJrCK6L0wPlXjSDIA97+fC7wvMEHC/DupdagcnS+N5ZKaxcpyXBDVMtbUckDOXl4KDXf4EPrCoxLlf2QzZEen0IIgfVMa1hE25a208NHsVEz+q83sBec5FPt7JjtYpDT5CD1lWgLtYXEI0Wz/kFU2gIL9ojfkU5OV2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ED837hfr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ED837hfr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1tCf2233352;
	Thu, 17 Sep 2026 10:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5yeSauAX7eNw3n/zxCmuUyT1GO5Cpf
	etDInV9iy+zHI=; b=ED837hfriMkKg3JDj1jhpfIoWFsdCh34Zlk/UAEvhDBeH2
	EaUHIIskwEZJI5Q8d5LQl2SxCuE4cI0YPsEEwCPzbPj4C1L4TKp5/986u48VzKIx
	5LpuiVoAPPzDgDQ4hEOHSN/8PdgU96D90nNHD5j96SnQJCJkf+BKWq0VqNoWTwfx
	LflulunKefsYLFz66VdSc7sE90/UMOvpmOYwhac0Kopkzu94Wy7kzcdZjcnEYeCb
	xmgiEDHlKA48a6PU94Mz4nEnDl/oiQZkB4G723tGmkugaWzTGkrzt0QgiuMK82Mp
	uoxgwE1NrwzSswLxjjx6F1L40UZRNv9OwWX5/opg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv98qj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 10:27:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aW7Q2917943;
	Thu, 17 Sep 2026 10:27:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa1tx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 10:27:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HAQug247841648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 10:26:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7FBA20040;
	Thu, 17 Sep 2026 10:26:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 587092004B;
	Thu, 17 Sep 2026 10:26:56 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.82.202])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 10:26:56 +0000 (GMT)
Date: Thu, 17 Sep 2026 12:26:55 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uv: Rework page allocation for guest variable
 storage area
Message-ID: <1a53b72c-b215-496c-b9f0-04f3afd09693-agordeev@linux.ibm.com>
References: <20260915144307.2367089-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915144307.2367089-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzOCBTYWx0ZWRfXw4+4OEgFwGpV
 ZDR3m37k+cgad+FGEXCb5Vl8SJm2VrSVCLnpUA9U6vJ2k1H43GuaUtScHSSBjju0r/qwrPurxKa
 wQOBim8XIo/O/buxONbU12zYNe8AAEs=
X-Proofpoint-ORIG-GUID: qhKUXyVAELpyMr9x1DS0LhQQ2lO9V0gF
X-Proofpoint-GUID: qhKUXyVAELpyMr9x1DS0LhQQ2lO9V0gF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzOCBTYWx0ZWRfX4d84JFAZw5rV
 niYjygreJAFiKQiSbyW+lin4zui1+lcmHLEdBWzclxvSDD9dX9rnAWAiaZXVt/PfkCXGOyPjFdw
 BFuT+BtMRmytpMqC/9SYZMlxajTj7PNp5BdlqshZ2367S47XsoT86BsJXYYUSdIkVI9PZri1nH2
 2XBE/dZW8YMnri0mbP+5zBcwpw4EnNyE/jAH5j9Qi+HCCBlWwB81nW1e1KnVQdmOyR/v77HeUO/
 dMdk0nimR0EUKPlOPVtekDqpgfo2/CqNjiAukTVW1+yOU6y0G7glljV4v1QQs+UxFHJgeZy8r68
 316s2dYxQV1KoyDP1TNspd3RmMQXSG7U+2yMh5v8+9T4jzzdTrfOdyAYPvtm9pjoNQtfrkgIRVa
 yy+xru1PI7Qt7CPe4WmeNTf0yPtImOghaCRselY1ZBUHGJUDYeOpqwAO5hxcXgp/XC6qSeQ/FCa
 Ol3Ky5TKp/B4iPwDaOA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aabc075 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=mKMMWXabiHer8OlYMloA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170138

On Tue, Sep 15, 2026 at 04:43:07PM +0200, Heiko Carstens wrote:

Hi Heiko,
...
> +	for (i = 0; i < nr_pages; i++) {
> +		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +		if (!pages[i])
> +			goto free_pages;
> +	}
...
> +	for (i = 0; i < nr_pages; i++) {
> +		if (pages[i])
> +			__free_page(pages[i]);
> +	}

Why not alloc_pages_bulk()/free_pages_bulk()?

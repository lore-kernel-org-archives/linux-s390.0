Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DD4B2045;
	Fri, 18 Sep 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731808; cv=none; b=CiAH/s48AfgcnPToqWGDyKmB++oSntaG9x5qB7h/f8qzaeDhPJq0ydvu0qWdNcdZkD6U4jIYptUrtCMCOq0736zVhMPzwezHFmv294VMal876Tzfe1ZAYufNpsSwHHgLuD44ohLcfW9gYeU0xwTOQcKZjycUGzg6cg8nnaUNroI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731808; c=relaxed/simple;
	bh=QMeZrYDzre/+sEvhSk284/MnAA+Vg6kRV3OSduWrkkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h827/xFDja0EQkVyE41LQy/klr2XM/Bz87/wF8ORgGtTX2sOVrENuncPnk7vaz8K1LwM1Hb1Z1HAQ7IySwEOcEsnEb5FAsRHNqs4GwrFpS5TYGqnBiS+zocaQFS6Nr04y2ZmhLPCVziS/CTrDjbYdE+efhZ4dk9HgCecsvBBtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQCkn9lX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQCkn9lX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA2lqT990951;
	Fri, 18 Sep 2026 11:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2LoGXw0vF7PSPv9HSZL/ELxJsaHAFx
	bAysiISHbsK5o=; b=pQCkn9lXqPzXXAKuy1bFv2f5r5YKH0Pfc83IdXH2GehNi0
	SFSKVE3OiLTOcepGCq21AUKe35WmqgfEH0i463GDMMyJOhFprGzzU8+Ha8VBXjLM
	MC+ERFrhAt+ilPHo98zKu5XnghixoXtbVjz3iFuoOs9hx5yV0Q7o8SHzFT2e/Ihf
	L7Jun554aw4toSCdAUbhIra/nDj6FoGjLWDI0kMvNgP9JIuxH7ZHIbrU5YdshJ9+
	8Jm0EbMisBfB4Te5o7JugSQn+d7qB7WNE0EYo1CEOKjl5uAtTpJtOgCP0vzU4vHS
	GKKftHg/AjantG6j5MO3JyMQP5jqXr6yJPiF/46A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvf6be-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 11:43:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9oCpr507795;
	Fri, 18 Sep 2026 11:43:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yx6p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 11:43:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IBhJCC12583306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 11:43:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A15820043;
	Fri, 18 Sep 2026 11:43:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D679320040;
	Fri, 18 Sep 2026 11:43:18 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 11:43:18 +0000 (GMT)
Date: Fri, 18 Sep 2026 13:43:17 +0200
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
Message-ID: <b7e43e18-db98-427c-b34a-2fd0a3a89088-agordeev@linux.ibm.com>
References: <20260915144307.2367089-1-hca@linux.ibm.com>
 <1a53b72c-b215-496c-b9f0-04f3afd09693-agordeev@linux.ibm.com>
 <20260917193540.13842A26-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917193540.13842A26-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE2MiBTYWx0ZWRfX1vUZ0oYPn7Ul
 tiaJAJbkg0/uA3axkbz2ujoytWAowvlL8VWgzcaY8wnQbvByTe8ei4/y7tQF0Q1kKmJBhdQnzEL
 f2CqABzl+qYkkdwNoNlMYopXxy2c+Ks=
X-Proofpoint-ORIG-GUID: 0qDW1QWeFwf0ieSqupZb0xkiZ5tv5ycG
X-Proofpoint-GUID: 0qDW1QWeFwf0ieSqupZb0xkiZ5tv5ycG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE2MiBTYWx0ZWRfX3TrCqZdNw4im
 pO4TS2jY8+9+6QchIXJ7IBiGsuwoonMboq6Kix/hS7wk0oPG6kq6vlCrMFlMpQMnN3zb3Y7L+GI
 CF2CU+RttUg/he6CHIylh3TwD8kGlSio+vDVW7zT1+wNXHC3VLQOH07zSI37S5/U/9bPE465lAQ
 zwbheXyjxInjQ1Yf46kJIKc/+FMaqSo1AU8edUGcQebOqrrw6fWKiH0LRp/AFLJ6k9U4HWiqSHQ
 OueAvbEcKQ9pidwHqOB31WgXEv6LIwwcNEXbzV4VWXDVirgUDcPabr/DhQ7AsDD5/oSxTAkBJx5
 gpc2YKi0D1UYxBPSnZH2EoSNQ/QH6Jw69deZB00KMr1VRXo3DHgHsHum+CpElvoAqM/EDH9EDro
 58KuvEig9gZmbIuOAsUto0ofkcsccBVl0J+4EMtavW+0I22kVR4p0pEQzbYX1Zfzlpy4dkrgEen
 wuiNQ7xCanTdMPShLjQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad23db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=1LgmpdHpANVJ5neRkZwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180162

On Thu, Sep 17, 2026 at 09:35:40PM +0200, Heiko Carstens wrote:
> On Thu, Sep 17, 2026 at 12:26:55PM +0200, Alexander Gordeev wrote:
> > On Tue, Sep 15, 2026 at 04:43:07PM +0200, Heiko Carstens wrote:
> > Hi Heiko,
> > ...
> > > +	for (i = 0; i < nr_pages; i++) {
> > > +		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> > > +		if (!pages[i])
> > > +			goto free_pages;
> > > +	}
> > ...
> > > +	for (i = 0; i < nr_pages; i++) {
> > > +		if (pages[i])
> > > +			__free_page(pages[i]);
> > > +	}
> > 
> > Why not alloc_pages_bulk()/free_pages_bulk()?
> 
> That's because alloc_pages_bulk() contains this:
> 
> 	/* Bulk allocator does not support memcg accounting. */
> 	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT))
> 		goto failed;
> 
> Which does not work with GFP_KERNEL_ACCOUNT.

Thanks for the clarification!

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

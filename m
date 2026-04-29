Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989C3B27DE;
	Wed, 29 Apr 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452319; cv=none; b=JBWzSVJ6mJu7pMpG2OPsmq7Fgbk0W4E7TzF9EI8OEgVd4xrYol9fiEiCLYNhR2Azu0CZerFrHj0DF0tdc8BV/4bw7HLE93hAZm63pTjiJbbJCIE37g/hGPupA+YOXUgjn83rs4qtX8s/5CC6W4QviUQ2Wp0boUCCjSKsCPbrUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452319; c=relaxed/simple;
	bh=M7KgelbxxrGP3z9ESVB6DNvE5IvL0YWSGRIIUgfL4w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIWh3XKtWM3OfcivLBWnLmMrU3jDmMvu7SwKk5+kc1Ucbx166ac4E53chMKwDLfQTYlrxjtWZmTAKy+a+PUAb+RCMeIvJtBydTosBKdL4cDdhzUgJrsBUgY1Qs54uHfUY9SzyeIznFKBoXDEkh/Br87dm27CXZxnyYRH6y1uGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GcziRz1q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GcziRz1q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8BVxR2955054;
	Wed, 29 Apr 2026 08:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=n0D3U/J7t15YRpcKF2MF4gghBNWJAC
	V1fjDZAGFeZbM=; b=GcziRz1qUnKgslNZ/9v1khNBbvBMP53V4FKLKlcNE6MrIw
	x1GO+1N6oPmNOZvLw2J6MY7U79NbiYRpAa4njTXxg7dpp7G2YWs3gz0jHhU084/K
	S3ZN2aIv9RuA1BtcdhIcYhmc9Js+Z4s8kH++kwPir46cLuteUWnOhr81xZAhQZzJ
	iQZi3QFbp9nSajPoZlsVjFuPOvOGfElpXqbIQaX2//PMsmkK8dXNiF9hh/74iJB0
	Y05iJIhlvCvmN2N8XexTcFn2aR6C80zrqSdrmKxLudiQT47QBMgpyvUjHoWJN3tp
	nyCND96dRnbdEjLACVHiL8Q8YiszcDEYdaD9bClQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44spd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 08:45:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63T8cpO1013916;
	Wed, 29 Apr 2026 08:45:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avwmkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 08:45:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63T8j2Y242008908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 08:45:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEBCE20040;
	Wed, 29 Apr 2026 08:45:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 283CB20049;
	Wed, 29 Apr 2026 08:45:02 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.137.131])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 08:45:02 +0000 (GMT)
Date: Wed, 29 Apr 2026 10:45:00 +0200
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
Subject: Re: [PATCH v2 5/6] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <ea51a969-f658-45d3-8b04-11bb4990b617-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
 <20260423122824.10371E07-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122824.10371E07-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tUpbnWu9ai9c41_KVdJNahHjQn5z7oOQ
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f1c514 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=nl70jLaCi0zengCn-PYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: tUpbnWu9ai9c41_KVdJNahHjQn5z7oOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA4MiBTYWx0ZWRfX4iXlBQ9L4TSY
 HhPMY7UhZ2R1n/voAZW4ZdeQDFQ/lf5iDAtr0Bt0NQ90HIxgi46cTjTSbxdEk13zMySl8PyaHFx
 qHTF2ysp+XB2nx1ECy764XpH/N0QhIRgtrFmzS8c1qWyMZUdQ3R5vg40G2J8HB/X49ZzhS3mc1f
 LZYf7OPmuRBjlUXtKg4FUBMHc17IusaxW+BLeaZvkhESBmFtznashHAOAxim+YPtFkTVzIRQ8+p
 SaeZ98jHdhahWEYnTuh0KHC22/c8qfFWQK6u1T2Dhm1+gtm6GAq9dDRke/qyWSrINOQfsn9vX0b
 cWuqQE6H2SN1I/yEMQSe8rNjFKys33zRim5WKdsBiK/R25JwsgJNywQOhSXwLUpzrwrS6ay8z2v
 vZi6/Oeh9GkrOHpso+Ls+7omGID93iRDTkmgzIpnZ+dL2OdCzIy5kfDhfjkto7jlaMMjm03xChB
 bSauzcyb8XQzkyGrYmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290082

On Thu, Apr 23, 2026 at 02:28:24PM +0200, Heiko Carstens wrote:
> > With this change, the system calls do:
> > 
> >     lazy_mmu_mode_enable_pte()
> >     ...
> >     <store new PTE values in the per-CPU cache>
> >     ...
> >     lazy_mmu_mode_disable()	// apply cache with one multi-IPTE
> 
> I think what is not necessarily immediately obvious: this approach must assure
> that within such a lazy mmu section there is not a single occurrence of code
> which doesn't use the above mentioned modified primitives to dereference page
> table entry pointers.

So ideally I would do something like __private for pte_t, but I did not
manage to circumvent sparse false positives neither with a scalar pte_t,
nor with a struct. It is as well-known sparse limitation, if I am not
mistaken.

> Directly dereferencing such pointers would bypass the cache and lead to
> incorrect results. Therefore we do need some mechanism which makes sure this
> cannot happen. Preferebly that would happen at compile time with static code
> analysis. Alternatively your Kasan implementation would be helpful to find
> something like that after-the-fact.

So it appears the only solution ;(

> However in any case we need something to address this problem.

Thanks!

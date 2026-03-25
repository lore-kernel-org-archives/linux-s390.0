Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61041428F4;
	Wed, 25 Mar 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456684; cv=none; b=XiSX67VW8CDWx41e/RUOZWMEUyRdGxtByqVVoHRoxW86yWld5FQOGBfRYPXQLx8i6RzwRO5DJvNODpG8gTb3X6k001RJUtZMgEqFq4q2hCODmO6FZQsTuTpLc4kH4nuRGbJOO54Y/WhT8KcuEdzw1lB9DnjMqAW7zPCHshd5gtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456684; c=relaxed/simple;
	bh=BDnBoW1A+LwxKIJClHFiKJuP/8drhptpeDwotkaKgXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJBKMhsDnLhw8BFR+D+2EZ5xUQRdvPz/4ruu1/X9jJAHFzGT3vVtVzVTscxzeC0bnuwPYpu1mIJVOWBTs4Q4N+7NlRXQBiBeblSlhhFnQ4uFfAtq5llpdNZaSH8iK4cn4/G2BOOlDN1mnR4yX1uStXExWp7pol+xih2GbbiAhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PVCwoTM1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PVCwoTM1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P9vdu0962883;
	Wed, 25 Mar 2026 16:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FQtkmDxmslIExkFjEKNG8vtTuvQMZ1
	PB/p38zRImO1c=; b=PVCwoTM1GUxlYZzeY5gTWFwZkiK/Oq+MiK1gjafgzC/qkw
	8WIp39LSbjdNIMDwK5EXOLlC/qWbtQfSDxR2FHuXU8XVavmTFcndPaf2aOzUr9TK
	gktdUo1O1HbV998Zav8vZsuvFcmzCZv2LKBmG1IQrJLhVDVaaiHiXKmmCoB1sjfo
	TzNrLz2jQ/esbRLASo76DYtXsMJGjTRJRh99ELSVSTpTn7wcAQa+g+TwcWZ4pN18
	2MFDJ+ASPj4AcEIAa0eQ7xGXKcNrvgYoFGZ7ROarqJafbBWjiOicdfTPfXY5U7Ye
	o4MuuUruBFmmo62RhJR80Yo52g9tFniEU7321l0w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqhehh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 16:37:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PFNnix026681;
	Wed, 25 Mar 2026 16:37:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ky85a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 16:37:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PGbjRG47448432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 16:37:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6997A2004B;
	Wed, 25 Mar 2026 16:37:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 369E720043;
	Wed, 25 Mar 2026 16:37:45 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Mar 2026 16:37:45 +0000 (GMT)
Date: Wed, 25 Mar 2026 17:37:43 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
Message-ID: <939c4ed1-3335-47ef-a25b-6ccdbd48d464-agordeev@linux.ibm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ep-i31MGON5OlTVgHzD44qA7jGtcSV4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDExNyBTYWx0ZWRfX69MY7zL9dYkK
 OOwrsP2i3IO+E8dzEkot+WcOQZ9DXy4PWqnzre6V8fRHZ+NgcsDWCcKjWhulxWSQssOcczL/I8H
 m+kQ05AI5VajjO/mI+dww3OQfJP91uYmIvEDivusZ7/WA8Vu19MwNQeSxvzIBK2D8A1/OkUbifa
 h8OUXnMJRySj8732fani84Er4jcyo48Htb2YCBmNgdPPwIcUYG+VR2nh5hzr1euMb3SwSNuWMfM
 fYHlDiKmwXjTFVBUtSQkIf7AzXSZVwXJMuGUK9d+eUaAFIasW9smzVTPuCrd79vS2HPin+rC0xH
 gfjG/4/Fr+EPjDhjzdfBoZ1lvRhQrW+nzHYMKt+P/2N04uhZw8UVuoa7zdrV0aEp6hMpYica32c
 o9qpa0NT4SRYusS7Vx8766TyOXnLv+TsPB+IiHpeVdcAwrx+7xmR7urMUcXJVHpYIo2VMqUME7S
 BwNKTrAg4EWvTEd9VyQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c40f5e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VJWC2A9Rxtiui5an8dEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ep-i31MGON5OlTVgHzD44qA7jGtcSV4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250117

> Multiple different ranges still could be processed, but then one should
> continue using arch_enter_lazy_mmu_mode().
                 lazy_mmu_mode_enable()

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B4380FFE
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485799; cv=none; b=mxCwQK2yI0GMyOxFx+hVmhixDXsSHOOBpWsq5C4laMwWsXNQpavKKzmCT25ESsjDptNp+frLGxOQo1ESQ+clNprnFaB8ieqc1Jva99NrI5IITtly8g87QeBKujMedXqpFRtK6ldRImNnon3jLpQyn/qyZ2QJv8w8Y+mwjNs6mM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485799; c=relaxed/simple;
	bh=54JJ30JsDDP7G2Y62cJPXXCfbnUkAxc7HQZRh3khQu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlC5ANwdlrBmIE81WHcKh+qOW7wUIXqNfuQ2S2ZAsXUNWFOJxP3+Wv7UhYCvP0j14bgDgjg2VlTsezs9UGvZd/GpzPVUf5CL+tjBSQldrXp8ONyQBg9Tj3TnJo59zAy9sw23ppr5cblxO7j0LP0a3xxe0LIIXVidtfeTHYUNdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rYa+BxTM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rYa+BxTM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5J6t6952279
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1Zxlts
	V5FobUEa7ucX8dEFsV3Y8xXKIqrfRtYAnLINM=; b=rYa+BxTMHb6wyGW5+OCdHQ
	ZRiy+yxIiPmT0LJdG8gdQn5fnVm5uMZn7h4UZbR7H05YfKVBke2l6sg4+D4Px+GV
	+88YdX8j8iPRdoS4esaGndyFBFmqaHChmamk42DrIUh5T/kXdiA10Uot+hNCZ6Ss
	J8hjalmCmbMmaCAxqCOd6NBCHxb2ZTGwQZb7dlhWHUbr3I1a6Yaiq33OFS1fr2GW
	L3UW+1EdidHTEsC2wkMvUP5VkZmspR39Kr3N3fz9EFSxJ+/uZGoBnByMccFU0OAf
	vfjP0CRPF7b2oDOklfhTAVllUnS7K08EcZQosYinguU/3tWBOqp+ChwGrf8Atpxw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y430h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:16:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V8BFcv018303
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:16:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqq908-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:16:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V8GWsr30605822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 08:16:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 159C42004D;
	Fri, 31 Jul 2026 08:16:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD4B720040;
	Fri, 31 Jul 2026 08:16:31 +0000 (GMT)
Received: from [9.111.59.130] (unknown [9.111.59.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 08:16:31 +0000 (GMT)
Message-ID: <7cc2ccb7-abf4-4dfe-b0e2-5e237c431f17@linux.ibm.com>
Date: Fri, 31 Jul 2026 10:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt
 misc code
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260730141509.205970-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Twhyl6fA6e393aedgAo3RDaml9plK_pV
X-Proofpoint-ORIG-GUID: Twhyl6fA6e393aedgAo3RDaml9plK_pV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1NSBTYWx0ZWRfX4o6WP6QtT/zN
 w3lSiqSnKLr0/3N1E4Pz9U+frF+HFI9QbSKl78ChGWnswTwBeo5o0ET4z1sWf9bmJlT9Xjwu/aK
 h6rchoL+xd0/cV4MEWlb5lB90kizaqc=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c59e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=aKTq-h0dlwLBXt0rFv4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1NSBTYWx0ZWRfX8rGz7n1ZpQEF
 OP4qhXSTLoRlakHaooin1k3xLdvsVTqCpQvU5qNCbKftyrxslhq8CnIBE4ac/UBMLJwsISiXuJg
 nQBEDqcLtAMMTOKIhDSqWj3Xls4C122jUYvhBqIgeorneD1h9TplZPqYkhY9+KqMEA3sflCnHV4
 54yOy+tM76ZC/VtBTJ3nLxQnNrKWGnceuipRJBCxmE4h4OG6dWH8IlPM2FXCW7TX48qlk/TZ4eL
 oUrV4nKKlcgB1KObmiC0RuWzWRksj2ANja0h7CrcSTPMBDn3iYbbzCUymRJrzvo4RjB5dtjSQOm
 qfcipvjHMFqIedkD39pGBh7EAxHvfdI6xej+UW85Guet4SX0Xj0VDLdpvmKH20o/nJznWZWB0Pz
 /jlR5HC6dDzA7AEdRhpBnCiDTx4wxIPD+vXcbQkmOAML4M9y/3/mGZkKYoOW+6RsvwHFpyI1dYl
 sKdQtsUueB8qqT4Q5Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310055

On 7/30/26 16:15, Harald Freudenberger wrote:
> Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
> did not round up the memory allocation to a multiple of 4 bytes as it
> is needed by the zcrypt layer to process the CPRBs.
> 
> Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
> guarantee that the base CPRB struct and a possible parameter block are
> aligned to a 4-byte boundary and the backing memory allocation is
> rounded up to the next multiple of 4 byte. Also the free_cprbmem() is
> updated and scrubs the rounded up amount of memory.
> 
> Fixes: 9bdb5f7e8369 ("s390/zcrypt: Introduce cprb mempool for cca misc functions")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 6.16+

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler


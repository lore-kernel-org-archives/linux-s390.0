Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27683E5EF8;
	Tue, 14 Apr 2026 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182946; cv=none; b=ZOrjqTDi8IXn4Rxdgq8rfyp7hOVKVYZ1Gx5n5KqFXIzsiovPuXHUrFDqvabz2Gri1+eIAT51xWUO/FicSZxkggAE8nv5XABHGSAATWyqDmkZ8bkY4eBEyjMajG/JT7snlFDDloBsgN+9IgUwEiZmF1tUDcID+JsbJnhuEQ6KX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182946; c=relaxed/simple;
	bh=2qB7ccKO3WyiV8FP57HR7d51nyiWJ3ysIZGxCfdRyJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6oIvM8giJxQK1OdOiAWdiBpJrLG40O50v95qpHOfm+F41sYQUHXquAl4eou4QPDNPbbkM/vn8WdhTdJEy3RfpzZo/QS0RRD7SMT75fpSQ17cT4sJnfAZkAUHfvBow9nPglNtlhiq5zPjkXFqaopWFPTRWqVvFR5+bqUiOXHbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UQCEAFeQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UQCEAFeQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EDUuh91805230;
	Tue, 14 Apr 2026 16:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NOEH4v9NjjhJAHew/mjaIu3pWf52+D
	6D4Qn2ZEwR+XM=; b=UQCEAFeQ2d4X7BC/ko1mVwtXwDvozgQazLJmrwwu6B+E1h
	lEvfMLfmltxkp2wHUsE9cX+c06sI4E0JnJcPQZh1DGaOF+rD60/gZ8pF1sI4a8n8
	A5w/zRL4avtCc976GsqaZiTUbNe0crwMTfr55jitBKfpk+LZcmrlTe0QEf2iqKQp
	AaU6xGPgfXUY/D8hhDaJ5JyPrtgXB3m0JWScnyvF7l3xxlhhQMWxKtcc30CQi1Gu
	AsRf7JQf8KybzdxW1ZuUXGwxpv9mBXfvb7HjsSg4erL3WyG3rG36RkfubggNjaOU
	JbT8yHkf/qxpCPpMn+AVNnWokmrV49lfeIsMt2Sg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k3j5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 16:08:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EF0UMh025621;
	Tue, 14 Apr 2026 16:08:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujj4a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 16:08:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EG8pFH13238622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 16:08:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FDBD20043;
	Tue, 14 Apr 2026 16:08:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21FCB20040;
	Tue, 14 Apr 2026 16:08:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.149.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Apr 2026 16:08:51 +0000 (GMT)
Date: Tue, 14 Apr 2026 18:08:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
Message-ID: <384c5b93-7939-4a9e-9298-66397cc6fa28-agordeev@linux.ibm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
 <665a19a0-47c2-404c-bd2b-482ab51b8f64@kernel.org>
 <896b3d93-8e60-42e2-b8bb-d3d4e8c99927-agordeev@linux.ibm.com>
 <534ed892-a6ab-454e-831b-e207930c35cc@kernel.org>
 <584f0f88-aef9-4a70-b0bb-abc797f741ed-agordeev@linux.ibm.com>
 <17505ac4-c5e5-4046-b362-830369b8d401@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17505ac4-c5e5-4046-b362-830369b8d401@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l2htD7g09NdhV0U8xiO60AfRpB2sQ9Gb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0OCBTYWx0ZWRfX904Pf16kaZjA
 w57meJEwlyDesUl2y3OtaTkvqTum3P0R+CQhP2OqDmGmMoOm+C6Y/6D+ZP5CHib/7eDkcxVwDJ0
 6f5lCa7SnJv3ZvvJhmoz6L7qA5+4tcIm0lNQ8BAF6bRaIG2d+JfmmJlGybHeDaFagdr5GEVXbOA
 KSIc0u0S5HPNqUm3CrUKYSsxLDBOauBX2k0koCLMmxknuegAIh2IhzLODuPMK8PyZwTOJ4KvP9z
 qU4Zogqpv80oDt/DXWk0Bc3igU6xXPWvYcCblP0EhGxSo0a48Dts7lnTkXTMm1UmuUJY074MD0y
 yIEuiyA9RAP534p1DrKIzBx2X0aCUk1cD1QmgoCZ39Ta30CN0s00KZFXscdGbtf2mm0M6Sdcze4
 29Lpxc8x35SOvDlV0OcId4GErqcnIYsUW87yrJ7QnoyqLSPpLSRyA+xbEqJQ3dvghvP1QAjlAYo
 qZ23SQkY2a8rjO9fC+Q==
X-Proofpoint-ORIG-GUID: l2htD7g09NdhV0U8xiO60AfRpB2sQ9Gb
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69de6698 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=MNWzyCX_VJYSxvCe8oMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140148

On Tue, Apr 14, 2026 at 04:30:10PM +0200, Kevin Brodsky wrote:
> >  * @mm: Address space the ptes represent.
> 
> Not sure that makes sense, maybe something like "Address space the PTEs
> belong to"?
> 
> >  * @addr: Address of the first pte.
> 
> Isn't it the address of the underlying memory rather?

Will update both and also the clear_not_present_full_ptes()
comment, where I copied it from.

...
> >  * PTEs that fall within the specified range might observe update speedups.         
> >  * The PTE range must belong to the specified memory space and do not cross         
> 
> s/do not/not/
...
> Looks reasonable to me otherwise.

Thanks!

> - Kevin

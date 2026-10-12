Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DF226D18;
	Mon, 12 Oct 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811024; cv=none; b=F3C30UjecR6/xBrfplqaEHUkQYKNVaIhlrJfruNXPzrW5cCLEoiLC+5jNI5SRjyATTHQ2lzaOSJmR+yLymYdGZInlZvls5jxmWkD244Q8m/CKZLsTxYgfoDuzjz7/LBEw+4A9ryF74Qg6zNaF7PE15CwAxoTU6/n6lDsTKRhfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811024; c=relaxed/simple;
	bh=SVgNy3YQYJMTGRWbRaJKGPg0CAMo+JZtwEUd9/OfGFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ec96YNhKNZ17qwiqg8KVM5ZZLTOBFad+hfLYwn1GcujppaD3KBzS5qh3dUiWsURBngYbjU61yBZIv8ZoGyiRvfpHvcmCqHeUNV1sfCBZ206BE1GwDtesC1W6qCGo68BqGmpKVkFPaDVOccKomZSg39//2r2a9PiBAJRDdoY84N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kTTyRWP8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kTTyRWP8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEFtT231222;
	Mon, 12 Oct 2026 13:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wsfIHh
	2YNTPVAJvEzokZyCyRW5EDE2b60PLcGytNwkA=; b=kTTyRWP8wsVQ+c1qiNM9XS
	QEdwp8aWg2C99nE1o6LC67YclhlYdWH/DZnIXRu5gbdv5gIS8GEoUS0QSxgx5xS5
	l7LphTy2GOFrahI/kX3VJD1jqmSuBrBfhz9/z/OmSK9n5iV/2MAP9/GPC8uKns8+
	X84e7ZmwVHFrxWOIjxcmOMg5qocBkW4S461Je0KdrxMsUKrXEyzG6mx4D2WyBCHq
	PMvmCRrl8dYsfVGShA9kMJrg6z1l+KTb0NFYeum3jV8Mq/vad13KzF7RcISkIbNN
	1VqazOHAQQ/0gzF2iXZKm2afjbhPasT72S6wOdarZLhhNxrizPOvOOxbzQeqIAgw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w0pxx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:17:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4uDF013441;
	Mon, 12 Oct 2026 13:17:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfw3y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:17:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDGvfs42664318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:16:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B658B20043;
	Mon, 12 Oct 2026 13:16:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E1AE20040;
	Mon, 12 Oct 2026 13:16:57 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 13:16:57 +0000 (GMT)
Message-ID: <5ad9464e-8f43-4679-9919-ff0c37b2d7ce@linux.ibm.com>
Date: Mon, 12 Oct 2026 15:16:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/32] s390/uaccess: Convert inline assembly to
 EX_TABLE_INSN
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-12-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-12-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX9ws/51SFpeMz
 cwzllIQo339kLQMzot+DeXPvxY6RbCu/ZRKyW/L7nM3Ibnm49QhhFulYxqE/vjJawyZOfORIRGn
 +oiYULOuLJJpvM8S9MizNyd1j3NwdJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfXwWMIG+4olX0e
 WErTH36izs1dLLFSAbfGyf4iI6a1BnkBJD+kA3xYSqRC5PmPhqvAMnPe0o2WNls4U0BTtC6AY5A
 TrxnoKL0NnSuicNWnmQuELfgbVlgWzYlbHN6PYletMtYlrPmWqpxy9xkAsR+ANptbNTnmbeKR3G
 wJqA2Zf8RHEm8Bxl07UltKjnASMtryBcqXMcil+tsaZWQmWOaWrH0M39adCKYzQk9UqfCzVw1vc
 ZlY4ivzsmK8TGcOGFlh+92daXGDlnpKpax8Kp57C+rcMN7hb9+9CwISPFELmzLmb0IINI1rkpCf
 HDF5claO0yh+CxXUk5qe8btQrcq62641avyoRJ8PVtq9NSw08FvUrUYGlM1jDza0UkG6FpAGfdx
 zXBmI6Raft6dt3SXPIjeC5IhJUksnYfmy1MGUgH61AUZhIRJbz9/ZAROnbk+6e6ojDG8LfGWZwP
 dUTI/nvjL9rPMMl7FtQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accddce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=96qpflwuWjVpj6ZkvKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: b-5ethTWsfH-dDFaMRcWhLfaFUIc7rQM
X-Proofpoint-GUID: b-5ethTWsfH-dDFaMRcWhLfaFUIc7rQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120052



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all uaccess exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries and nopr padding are no longer needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/uaccess.h | 45 +++++++++++----------------------
>   1 file changed, 15 insertions(+), 30 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



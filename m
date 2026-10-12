Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F49346766;
	Mon, 12 Oct 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815620; cv=none; b=HeCgt5d6mhfVuox+4CTfMJFy3x5ohvgfcgbP7jCsppE2iAMGeE1OvRP1XlmX07S1r1EeF/3jL5FK/7PjHIFXqWBMXUzUz8JUBG8Uc7xAFCOtHMMAfv1Sx0I+Q3w7eV20OjfkAP2qoOBEINan1RM3hsJ6sogZpl3CBtLXcEqClno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815620; c=relaxed/simple;
	bh=AaUMV3jzEyV1AB9LdJipEBjoCi90vaF4Y7JMAwR3r9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saWYw9D6qCMNh49d3lRuvkSoZLCW2ZgcxmwR5dl84wwgWqMbMcUtJjAOvmZFZvcuBuP1rsKHeOaxeYrVUmIv2T0LnlWHdAno2Ft6JTnvY2W3S9XuI4ZXG7uDXHNPp6TaWQqVyiQrfkQhv0yZ6mC/2Fto5kFNBBpP+b+uSpg8bYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AJehOoH3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AJehOoH3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEJsn231304;
	Mon, 12 Oct 2026 14:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Azcpr
	jAcb1UYwWIQQ+tZHcu1MPfn2hmBB8lJH/eJ4I=; b=AJehOoH3gC5eqSiDmrAnlj
	OvRb+fkZMUFuf41qHPKh3qjbGSv5DhmL/OqIR8gPNRf6IwdFc0rKseu4bmAzm1J1
	h8R3/2ArgUhdMRi6D7fV63024N1kiEXaAfkRaq/r6EYylWFduos7YkEAeWOqBLWf
	U1h1xwP0QtpMKPri+jNGiB4EwnsZ3x3GW3MHkgrR9TKXAcLJa/MjMewg0JEmnh4i
	Gf4+JGIz0AgEx6zUeUqeXT2XU3fb8LHBd18ADPgU/UUGAxfFFHh4bOpwFphUOXc1
	VPFes3C/VJsHc7GBPapJCPVJxbmBupSe4fHOrn47rcpZUr7ng30rzcSrePoj7iOw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w11sp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:33:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4u4p013447;
	Mon, 12 Oct 2026 14:33:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwd20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:33:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEXYLV15073626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:33:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C01320040;
	Mon, 12 Oct 2026 14:33:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76D722004B;
	Mon, 12 Oct 2026 14:33:33 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:33:33 +0000 (GMT)
Message-ID: <385ef413-d0d8-4268-8ebb-5c1358e21ba1@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/32] s390/diag_ftp: Convert inline assembly to
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
 <20261001103247.1989111-30-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-30-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX1CMvO4PBZxWU
 vsShb/TcVK+sPKNg0p0zeBq3hpc0uBq30g5YEypf9IJwV7GVC6Isw0JERmb4X2gc5LJkEUhaWud
 wEDxb6XaPsyHNtlY2b0eETU8ZEvRxqY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX8zf3sOp3RaC4
 ZGuonWRZcyTlY8ys1BmCIKP4/yt09ms5H0/JHosE/YxSNDCgdkv1EyxCfVJBKOrOyX2x7w0cxx3
 fOg0m0R/N8dcHpp2cKpfMw3DQKlnQkIe6QDiVOlPPfzPNrtSZAL19H/nEveJlrcZsFn7K8nO1qj
 vUfq2RcbNYBmO4y48AWPuOyNU0kshMiJ7UE1eEvu6kIxT7MAv3hO0tjrtS4gMfWkWL1tS5HVGBr
 bkgWv1T4EBC/74GefOYj/m4uoC0Cx8uGbTip1Smbs6UEPU/8V1JX4ncXuOack/WaU5ISy+tGf6k
 17OuuIi6Oj45mgW+aJ7e+mOucOm6/wUtj7e/XMfcsQBjs+nF1xX5ORlt0wFGdDVpRID4u0clTzW
 PBpeZLzn7gNXA7aSTssCHPCZMRAIeIOBfgsmL9SiJ6C4yWTdNYZXrDRuMRrEj/QMC65C28CcsbO
 qS3ZqM1vsQru3yI6J9g==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accefc2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6yo22ysr3YPfnVXVWhIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8c482MBKtBqpKWko0tnPOz3rvaHpe1NV
X-Proofpoint-GUID: 8c482MBKtBqpKWko0tnPOz3rvaHpe1NV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the diag_ftp exception table entry to use EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   drivers/s390/char/diag_ftp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


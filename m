Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361032824B;
	Mon, 12 Oct 2026 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815121; cv=none; b=g16IAKvGe+7qUV7dlV5EzFMxa6BtiU9QCwQEfjX9obHArjATpPDGXg9zAr4xVQAAIDuF1MKcltXGeT6Klp45akgWJdI1+UPAHJMJFYza1UoNXYXsUvWPMBeQU9jPHkysRsRSqJ6TuzqoCaaGmj7jeHiY28MfxT+1iGW2Au2J+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815121; c=relaxed/simple;
	bh=xjPW/OeNkpnF8wsejYqEvuQ+WeKeWPNqpzV0CBZ7Lo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvrzPgaZieid2EhgyEqLtSHOqgMd7cikfqV5vFM5fFS9/M9ahjiHBMJ1zL0vAYbGMzRKiFWdnDeTVGCBhsA3GKvbmXbHpOI5khBKtK+pHw934mgZ/EuXiNZ+w1uvFY+kk8l5QWOxjRwZt+AyBF8Zl3slLCVMByVRQ1CF0e0Kg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iwm5FLFy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iwm5FLFy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEOeq316977;
	Mon, 12 Oct 2026 14:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PYyRi8
	6uKcFp7GYuf1WLZdpZAS5T4E1NVTalwrQWy58=; b=Iwm5FLFyMD5p9C7yLWy/cn
	cRV7vR4pl2pKn3LIbqpOAkprAa5HA9Qa3ZfVVFy70qzMsy61o0B89xE3zfIvKL5B
	pl0r9XfkDCR4/aiFdeNnJrMrJljrpGg9okY8oFRo1cqFTy04nhYGm7TODsZL+dmi
	dtb6r5KbDXnYtemQ/rl+nlDxLMT8VMkr4upCLcxpwE8AunZU1qq59PB/dlnBBoCk
	KbJzgB95mmGWl1VmDiNRzg812xuDa/heKyMaRqYtGjxtXhNwIhrCWHvQNHwlHxrI
	Zb9SwvqwgyvW1vFP/sim2GJsc5NWs2CkLGjRXSrCZ9ZycbGeEKeCn5tmfqdgywPg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug9bsd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:25:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4v0j1212041;
	Mon, 12 Oct 2026 14:25:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnhq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:25:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEPEJJ45220290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:25:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D4520040;
	Mon, 12 Oct 2026 14:25:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4FA120043;
	Mon, 12 Oct 2026 14:25:13 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:25:13 +0000 (GMT)
Message-ID: <373b00d7-ff32-4e20-9a94-42c2abec92fc@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:25:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/32] s390/fpu: Convert inline assembly to EX_TABLE_INSN
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
 <20261001103247.1989111-22-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-22-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accedcf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=BqXJmMTjngRBXJbfe34A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PPfRZUHuMfc3dQlzjS4hGG1Q_L4LsteK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX/l2msuvQINku
 VkBfDCWXuallm1g88gN6M//2tD0fWoeZU2X1J+2V9usttOaDL5Xs1424d4+vYqEIxVh6MzW4ngw
 O1gGTRiWqvU+INmq+uJJya8iBsjrv3bw8sIcNkrUfQGlQG7McakwQ0rZinUDOnsW5jFDvq6hlhC
 p+9jcjSy0dFpMXXNLDRHv8F/U4nRn8VbdWoJlv4OnrVa3KrHDBgNQNmg+UN9Fahp6Xw4p0aCNR+
 Ap8CfYvKuSh0Lu2CmMC87QP38WcY0GA0uIZkAyVuCKBfNIGsgo1VoM+j0nXIUNXIBE6K0cQ9MDM
 a2q2JepzDZcKpaV4FoHdYLAfZm4LIb/gKnTzqemthaRBjRSzaliX4V4n8BM5X3cm+ajlsJshbEX
 EkaTIdRileYKfSXeEIRN+V5MW4rbNMHBfjd4KW5XsdGpiiITPglrgdWa9RBCz11IpiGc4NDK/PB
 qJEW0CA3f8uDgJnlmlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX9GenelfFDtVb
 5FMLmQS569/zWeYVIwjlLqm3a6ZQFdcz2rZh+TG4+Uy41mp3X2kJOJLQ7Q8X5wzN+Uw/kA4igWG
 TxC7oQH96INVqWM1NtSuMAzOevwvmB4=
X-Proofpoint-ORIG-GUID: PPfRZUHuMfc3dQlzjS4hGG1Q_L4LsteK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the fpu_lfpc_safe exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/fpu-insn.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


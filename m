Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650B48C8CE;
	Mon, 12 Oct 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815078; cv=none; b=jsXYx9jRXqLIlJRZBAH78frpBp9pTDgZgfq3y0wcW1i+4B3lmFa7p5OOf++nuGfpCV3PpXXylxQfZwz+8e6PWhdo2hHt6gc6u40xQIZ7Rd7K+FJBhyCAUoKln8MVH4w7qKbPW+LdYoN5CrL1DdPE35YfI9pwKFFhgjzy3kMeH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815078; c=relaxed/simple;
	bh=2QoL7nRRa1pad96nZNWX529scXZNTnYWlkJSIGTMQeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdpNhje2pETD8qolG36O4qWVM9e0ylxzb/TlxVt4Au7LgnKYg5upxn0XmOu+JrhTJDJQNuda4Ukz4PamGdauMQwz0mL4HZpPNJtnPLCTzLPzG1zxAshgVANuwsCtdd8+/J1bfCa6Lm9jPCcaqGl4niWV29tJnsI/s6nCnA2+Pvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RjYCaVJq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RjYCaVJq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCET2n231410;
	Mon, 12 Oct 2026 14:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z0zqr2
	040U643kzjXUxh/wPHVOn0U8xux3ZlU3Vj0Ck=; b=RjYCaVJqcI431d52H9m85z
	HNIbex57BGCbkr4WS3pdKY45IsCbAfGOn2McRJz4sL9S+J3SG4Jk1fEheMAi2+BB
	jxfATMbc3TYHX0Q8xLOaEh2otBVeF/iMa+5Ze+yGFtFKtRfeAl+Yqax3w+MKlhXF
	VItFooj35V7trczWJRxE79ntatLzRymEAN0izhrlnOQ+xh2tYCf8DgB7qFaqAIAD
	WRuPBV2IURfMvcEWRKEdMKlcjpQz7gJieA0O7/1sjm9LaYrSi0tK9Ar7UmcaYTK1
	eox3g3wHPeyU9xIlhpHzb80YiEqLZb7ucMlBfpgLwocdrNh0CvyAAME1p+Cxve+Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w10ct-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:24:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC56Oe1238622;
	Mon, 12 Oct 2026 14:24:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnpfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:24:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEOWQe48431448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:24:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DC4920043;
	Mon, 12 Oct 2026 14:24:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 930DD20040;
	Mon, 12 Oct 2026 14:24:31 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:24:31 +0000 (GMT)
Message-ID: <23ca27cd-9574-4b91-bcba-8c735ef22894@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:24:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/32] s390/hypfs: Convert inline assembly to
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
 <20261001103247.1989111-20-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-20-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX2xveK+ewKL36
 2/20DzSAk8XeI8lVMe0wbMiXCoSrI8OlCNN87UjBNKydI8dyZXbs83fqAN3CoFy1szUenBgUzxQ
 v8UDjnlye6dHT+XVn251yD8QcJ8A/mU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX0uVScLcnJ3yG
 kUMG6hxPVdKMHdwhBawN0KXfZc4gqxaB+EfbWVjbe+DcD/NvNhlUVQsreZajjk6TYm7xi/Z9eGc
 nBIl+5cqC8rD0b/oLQU6QEtJwsyKWH3IpbFAWnZaA+6B0YeGCHXzvks3LsWaB3i5uMAhfgeONG9
 TZKONYLTLA4pfxWeENa88oDSPre+H40r0hwSgXL1GG1+p7d+WmstZpyKDpegG5juzz4HyMRhue8
 dYcvFQ4a/REqULDCmF3cqu2W7qvqJeTsL6bLmmwTHBEgRgFQS0T5x4zuZ4sLEttBcJDaopSdBGP
 +YlEcNDClVzZIikG8k+G0BtQ4UpM002zlD3krGPvWSTb8dQuMEWrYC16Or+AQA93kfGfdN/psdx
 Ipjx5D9+WKusCgBbSWYXij1E0cd3sq1Mhq19dHet5wnDGxDFDOcyhfRmHh8sQUoQqiLTO/JdvoY
 MKylmnC4NqgvIAKK9lA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acceda4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=vHXguKSWSAAYGWRtGo0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C-yvgY5URwjGOOxZ2MAPSkHLqHPoH7f5
X-Proofpoint-GUID: C-yvgY5URwjGOOxZ2MAPSkHLqHPoH7f5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the diag2fc exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/hypfs/hypfs_vm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


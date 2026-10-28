Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184631;
	b=ceSXSd9s1tbLGDbuFVto6sboMzRuECRfN6DjaVDzl1noLtcjLIP1k0yZ8CVU7xlBRFqX
	 ixYJBbJqJTRJkwjmrD+1VGoAWn/wFQc2tkwOQ7Sfr/4Q3GSpqtJ0w4wFXTzt7DyyueEC2
	 6g28s8b1g7Jt5LU8JY8zMDhxwRMRt+r0/xf3hVq1N3dBJusFRZjLJY+C8T8tb2PnLJ4MB
	 iImBj79ZRN10Q6mrBcV6jmAoFTPEXynMwE7BJtHAgo0fHfrj21L3JtcJprjOiYGXlSbYD
	 2FH+Mirw3jmdHiWj+xqmD7MJ0y/7SIp0U9P9g7G2b3hBn/XQ6UEy0kijdTMX/Ghpa0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184631;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gOVFTPmmS7Ky3X3ozx0t+VWTQerqeqQetF8EpO7bUNY=;
	b=FuVoylmfib3PcAjOxgaDVpz0138bdKly59Jsongk1yunfhOE6Z5GTFLvfR2jJjn791oJ
	 M6PYuJ6V2GHOOd5N4DMatKeMuJF/WWR4jOlv9OlNnXo2SrcjL8WkbB6YL7GQNw9r/gA62
	 jwOpwBbXGpSaWYpurHKq2Cw+Mcn++WRmvSyS653R10mcwNncNEEPb/y2HimA2mfmlGe1e
	 8KxUCxrmCLc10IWZG6HEQn8XJvRwB5NnlaKCUO75SzZqI89CUyusUl31uSTr1/uG/nj5f
	 bUIQgVebLfqbN2QY6jY3RJT2LxcJKO2rRzXmEiGxOoJc7dF+bmzskXu2uLHGF0uuIjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zr4HI8wv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E34606A31A;
	Wed, 28 Oct 2026 10:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zr4HI8wv
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8i9LJ979037;
	Wed, 28 Oct 2026 10:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gOVFTP
	mmS7Ky3X3ozx0t+VWTQerqeqQetF8EpO7bUNY=; b=Zr4HI8wv7/gAHzoRZ/3B6t
	qG6bVcV6yYF9iAz62thsSvJvrWKw7YB7uR/+2K8mjs9X9PeryzCe+c5XsZ0mTrnn
	lLtkONsiHorqKYbAtu5ofn26js41u7xVV/69F/A6al8Lijx8QXs+zf4IvraNSXzB
	6bOsaNOCOFwa1Urg8pIVqNKbpe2tWhtYZQ2edfpEoVPiyknZTLh7ZjZm/S0W5Y28
	Rh913bFSbt+uoa4XqdyVPuNhkkAD74stS/cnNG05parq/IEA3s1HuBmQlnLzBBgf
	Vsj2JY//e7GFncYgAAN9pCT59kdXN2bFDHuvD+i3sMrjSxQinPuSlwpOCzQtabDg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm6448sj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:50:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K1Y21323581;
	Wed, 28 Oct 2026 10:50:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh6xnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:50:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SAoPJJ51052880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 10:50:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F0A20049;
	Wed, 28 Oct 2026 10:50:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2F8220040;
	Wed, 28 Oct 2026 10:50:24 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 10:50:24 +0000 (GMT)
Message-ID: <8310f115-2320-42f5-9dd8-f8f23c38a95d@linux.ibm.com>
Date: Wed, 28 Oct 2026 11:50:24 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] s390/jump_label: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-2-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX2p4eYJqOCLYI
 /qHrnahcczaK14tWRO07VUkOAwS3qHC7GIE7wGWSh9hCUlZvpwNYsxdZYe24mY0nz59cVoo0ZgO
 enxT58TueMzVkQgaF+BdGTT025BHPjg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX/Uf+iT7IEI9F
 g169VpVjNFYZbr+uuHkuObBNqZxqAOiKZAC3/MtKlVQBgaFk76DPh7BwmMBYXwPGZ0hXYQcDQpJ
 H8VAcXt9F0GYCehuwIWAfGaV9mvwBUTkZ8BeqqCxu5wT+C1ZYnysOmPQpD1ZEJ3yEB8KbHbmvXL
 ybH76RnlTIcwbpWFz8hBVVi2L9ga/EiimKX55J8LEvHmQoVmD0fGtArY3RfzEA9+aKcCprVoAlr
 6kdmwGz9sNRIaWVKNj9/YoQ3k74tJHuzAzLcsr4l2jN9pwfqsjuAt+6dyFkzn1kgCNH94XodseR
 CJBN3wAePny6hJ3eeitpa1oJrX9C/OwW9DbhTRbH/AJKKo/1L1n5lt48pdAu3Cwkw9dv01blRY8
 Rk6N5TytEVHLI+lQ4szkhQEyVcwTT6rz1/2tOP93J4Ll0DyywS8mRJUEDUuxqpRxMrsgmL6r018
 WzcQcWHEbpzAWIalinw==
X-Proofpoint-ORIG-GUID: HQks9kt4WJ0cAxSJ3jj62Siu0AHcq824
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae1d376 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=X-ume5MsJspur9KCOK4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: HQks9kt4WJ0cAxSJ3jj62Siu0AHcq824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280042

On 10/27/26 15:30, Heiko Carstens wrote:
> Acquire text_mutex around the verify-then-patch sequence in
> jump_label_transform(). This way s390 uses text_mutex like other
> architectures and does not need to rely on other implicit semantics
> (e.g. no kprobe can be set on a jump label).
> 
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/jump_label.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


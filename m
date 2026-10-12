Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39F3264F4;
	Mon, 12 Oct 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811462; cv=none; b=cnyxhBA65qejhfzY7xUh5os7/JTmQL7nXJMUc3Fxp8zhoiNZntwoDhcOHwMnbNyogoNRZotkkHEo04TVtf6CqQCZEwqeEvwgQ4Dhr3g6dIERej6B1pvFZpRIyeL6BVF9/6ak4+qQ4Za4KChdHK8rxjjsix/DkOh1L2t4MT+oSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811462; c=relaxed/simple;
	bh=YBNkHbEZPsqh0Jd1xqE1mM9CcjFwBtt75I4Pbv0/FDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIIFXivy5nExYS/94P7t3Sbw2qGXU/kRUwYPutPWXZQ8p0/2ABpXWXy3txBZgCM+ThK6Cd7/f3YuuvRF38qJQVzA/cvWiTyerVacOoXdsxcJjZT6rsxD+19EOAJ4Hkb7BYjOjuoVxjy9/K92+McSBN46SfzCo3++HtJNeynNXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eMYLeD5w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eMYLeD5w"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEJ6p3209807;
	Mon, 12 Oct 2026 13:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pGUHEE
	s4gL6Umddybd+7K5An02Z75pQ3o/KZGJwSSsk=; b=eMYLeD5wPiQ30rASwKiDrI
	o56GH1T2rJklS54DyaElTaKq1ZUQ43ZqoZhm9jDvsJNdU5d7UH2KP2MfLv/AiMf4
	42cygwqpyWGw3j3vMd2gtgt5xDX1LRcVHCEvLP9ZhjfB8H5pRs1slWW6mhRVlm57
	u7YQT3zb8uiU1dqLNC8vSzqpyt40Jfe3v1SrE3Fc3otqLWuKfkbc9cSpr2WFmefT
	y1fwEdcBF1Jh/RxpIYpaWFduApYQ1JjyJ9Dm/p9th4LMXIIK4CdWHcmanTe3IgVQ
	Wv41C5zRP7J82bmsasw7Z9liS4BXOHF6rD+9ygELjAAQPqZVdKlthvok1YeoMjFw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv08rvk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:24:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCJrpP1255390;
	Mon, 12 Oct 2026 13:24:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vneek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:24:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDOFCo43909580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:24:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9207320043;
	Mon, 12 Oct 2026 13:24:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077C420040;
	Mon, 12 Oct 2026 13:24:15 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 13:24:14 +0000 (GMT)
Message-ID: <e2b60d29-bf49-4f58-83c6-6899a1079156@linux.ibm.com>
Date: Mon, 12 Oct 2026 15:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/32] s390/lib/uaccess: Convert inline assembly to
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
 <20261001103247.1989111-13-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-13-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfXxooNvt22xZX3
 ohN6uIIdhsFeWIidBkkbC2OtqWvNoO+4Yexs/PivchUSE6ocS/N8ztuo5Cz/ZnCCqjEu6AsRUCe
 OHA+qMIdxgWEPmX4L5vCeF5TbZSvnPR7+nAvJ6pFk6YKiUvblHANZ6Irf2SixkeDw8rLOPoEI2C
 hM+kHTeA+pD66zsa2cRt7BZBl8yf6dZVLmYcYubR48uXtuC7MUu7BFzFEeBDTG0p3G20GEFuuvl
 8uh7As6O5cOZ81lKN4Qup6gg6uLVPdWUmxTqivaGKR7T9CdJUpiGiMPWYPNXf1HVqq4oGWhE04K
 YEi9Cg0eHjPg2LWt/GF+iAKkQGyac4fl7bGfl2Mvh28RV4aG8tsfrcQsF3MsBI6ko1LJKcy8sPj
 h5ll6r+c6xEnuzFaehcv0zsNtQAlT9lS8sTdIA+72jTtVbKvHKmQJMrO+f3WVoNF+Eq6OcvVsi1
 a4Z4vVwIb329CUd+e4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfXwezRul7r+ZXn
 kTbfzMslF7rraP7Nhs23aTBlmfl/NDMou1tqOAollQZi0QXROr6s2HusIaaDdFKl8nUJeNTmIgW
 VkTQe3PaQwmr30v3N3vQpu5yebXC+ew=
X-Proofpoint-ORIG-GUID: _cPOcdzj20g98XEY4JA_J4DvsDQl9Gio
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6accdf84 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=96qpflwuWjVpj6ZkvKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _cPOcdzj20g98XEY4JA_J4DvsDQl9Gio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120052



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all uaccess exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/lib/uaccess.c | 29 ++++++++++++-----------------
>   1 file changed, 12 insertions(+), 17 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


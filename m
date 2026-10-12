Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C7346766;
	Mon, 12 Oct 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815587; cv=none; b=XYn8wgIIhd5uCG7sPwfVNtfS7T1x0Kganqjg18zQtcROUJ+Xi+5reUSNDqqgMbjiusVBB3nsFKZznIySyOWVqA+WQ2GwT7/A0y6gGLFSC6DLR4xM7DY2O35PfL8zd/yp86qLiBSgxWzge45Ntns3dVDIyCPX7yIsfgHGqFDwXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815587; c=relaxed/simple;
	bh=agqpFrj24mwZ0WUrIPVwEm39loIODG7wDy4nhq00sVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CojMWJzFvhKiavoM6A2XQ0JSPYPT1CINIkNq3xAMDwgSI2z6P59fCTlzD5Bpc2ZKQ+WPQF3G+KDwy5z/ai5fs8cWBOLEvbxsujbujPKrFQANN/2o8MIs/qky8zgsdIpiJ7sjhbX6nI+/7+oJiqGOkEs75wosOwbB6c2A+kzy6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L5L/pXW9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L5L/pXW9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEP9u073672;
	Mon, 12 Oct 2026 14:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UaCFAp
	JwKobffJ1/pU1nnA2mPxE0PvnKmwiRqmBR1sM=; b=L5L/pXW9BbbyDZADheH/Fv
	eX0JRjdWGUYUgBKsCkQR8tdt2BvLGKrhM/mA54qUplTHQiWmTsVo4zNKmZ/3e1Xk
	Sc/NhxcLRbgwdmlNYPZo0D0n0mdsAoZSGXBQM7vuAI49s5qmMBSsoe7+NxPzsJpl
	4jnmg4ce/4Wu+3IKUupFgqZ8QjlIqZlIp49IxvQOTuqasWBQC/RXcmdap0NZ2ph3
	afwxplVn6qaWZAANggr/3ASck5LahTBuEN1pnh7VxY0NJC8KnxK2ZvwK9Txm9kYA
	HFAtZrzPrVC6pfI/LYeCvCCMdzhkauHlYfI0t+HbkbT6770onK0KLiK+HPDpdfaw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhs40b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:33:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4u87013446;
	Mon, 12 Oct 2026 14:33:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwcyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:33:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEX00l31326470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:33:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B81162004B;
	Mon, 12 Oct 2026 14:33:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CF1B2004E;
	Mon, 12 Oct 2026 14:33:00 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:33:00 +0000 (GMT)
Message-ID: <ad75a4c3-49e8-4ab4-873e-470cecc50b25@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/32] s390/dasd: Convert inline assembly to EX_TABLE_INSN
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
 <20261001103247.1989111-29-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-29-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXyobSBVUgTdkg
 Yhg6HunmENozSGaZsURouf1suQumOW+K/SqvO6j9dVmE4H0bTpnc2As1DxwYV/vnhulEgIBvZuc
 vrNk2nHOLFlOqkdaS41ZP5X4S6o6Uvr8rjMkF38I4unxn3TvKFadVEvvY8xPbZa/8RWNhVmepHK
 XbV5RkWDub9NHIul01460SIU/8RU1pJM9/vQD8nORMTDxdIZkT2UPy+CdaznZxpdYkT3/XXSLWG
 FHeaY/08q7ExVgk9woi+Fk35zjyxbm4NmXnr3fz6wSrjwpMh/9EeIwaydy6a/1up0FcudItVM8h
 yzw1WUb14DtTCMydG/4qjLOpHfITlcUPjhB8JgZW+N7yLencYf5v7Cx5PD+Kwo9gK7LT47u83bj
 SCU1tNx3Ck0P7K6H6gxGL19iYG6oCaZKHn1o3AcFXe58duH3FNnEXwS4dQ6H5/0yWXIjCGxfESP
 XWjgqyjXx/RxLOwWFBQ==
X-Proofpoint-GUID: 8e4QnfdxwHbEQRcooFE--bfCqzwPHOwh
X-Proofpoint-ORIG-GUID: 8e4QnfdxwHbEQRcooFE--bfCqzwPHOwh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX5vQB/JILO8wt
 orYgtb8DlHa+n+X/IaB4Fn/PvwGoeqwkZiOKrY97N6kNNYW5KgcrNqg3iPexeM6m5nZ2kyosK3T
 5Yup27AVQZ1LiKl7V8ItWdJZLq94SlA=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accefa1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=znH3s2hi4nPzkZuFxxwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the dasd_diag exception table entry to use EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   drivers/s390/block/dasd_diag.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


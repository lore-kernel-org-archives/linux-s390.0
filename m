Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B93537C4;
	Mon, 12 Oct 2026 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807103; cv=none; b=ZtXv1galmwgNzTFvHot3DhTa3x2D5SFUIM5Ya9M31oWhwwNxJyulDALJQE7+J1X9cYOB1D2lkpzQubQDhLvAK0Ka03f1mxZc9wBmzfSsFt7D1sR6iK1TQj6/q7yVv8Do+osqBg4TuFW3RivVt4FRL7+3goJUL+qAzYwDae7lI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807103; c=relaxed/simple;
	bh=4hDGihHuyaNS3UyIQFy4UdI9vNOxdWkxsuNSw8QXViY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbIR30zVUKZoLovGlnjNl4wzbWRx8FaTttPjQciLYWVrmXPOOqwE+28d555rKs1xMxif94CFd7/aeKIduuysGwb/ra13S697451/j09vLrulQnSWSUquvJleTWPwjXelJl/X7+RqNn82QIG1eBJc6d+ftUAYA1E4JGzp+Pmyr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=njPktDKR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="njPktDKR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iI4M3968333;
	Mon, 12 Oct 2026 12:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oMN7MI
	v9dpYNnwg2lds6x9f/GCEQA2KGSG0wgvP6bwY=; b=njPktDKRt4mNDTLSEIXlQJ
	uM+RHavAwTkmWSe7RyJqK81Sta8MNzI6xy6fj1EYuTgvsgUUGvEiqhLoTIFGud6U
	1osRdq7F0znlCUgVaHxJaVG7OYwyL6fIXhEesqDp+MYO6h14ZmUmQNpJvxctpztM
	IHYwfr5VMMau4Usb7OkWq9heTXnNqmpEMeyiGPhu+4UfYNvmFGZesg/VrHjVc/i/
	KFf9EufWSd78Q8NntE/QAoXr3AfeUefj2xuDII76Yc+ZxS7qM48bk9RbgZ7TP/qO
	K2AfLP+Z8sx/8fsSRBRr86iRJ+CHEZtdnmLatWOq2hr3oGeaqXaJ99KBJrHSkm/A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w0dxf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:11:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC55BC1238612;
	Mon, 12 Oct 2026 12:11:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppn714-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:11:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCBaOa46727532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:11:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF95A2004B;
	Mon, 12 Oct 2026 12:11:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5417120043;
	Mon, 12 Oct 2026 12:11:36 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 12:11:36 +0000 (GMT)
Message-ID: <beb58d72-f966-428c-be22-34d63c10de08@linux.ibm.com>
Date: Mon, 12 Oct 2026 14:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/32] s390/early: Fix early warning handling
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
 <20261001103247.1989111-3-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NiBTYWx0ZWRfX+ghTqVG2KeCb
 T537ZD6xs6+FGB4k+MeelozTobDjXVDJRvDYeFryAcU/2Yt6s5uss8hl+qxCAARFaNgw42GV+E+
 VOHoMQXa0WrK6uWttgoJVECGeqe1oHY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NiBTYWx0ZWRfXyQNfYapD5R3a
 QnOuvp8HrwB3bAT/+hW6piSDz2Ns1lSbuMwF4PSWfO4d8W4dmVgLYD7YL7nYcX7tsn7MNMxpFI2
 6zozchUs8mTtBLu54yA8AAigktnzv192m2PjU171pC9qlYhrfnB7QvGSsg6B9xyLbl5pEHc0CGA
 XHf7KdfJELPPrhVSt9mNTBuzzgn/4KBnd/jKkY2cz3P9MrbSyB+u95IW17Y7x7jCG/DO2RONtTr
 ed3IsIJZXSH2Q7ca0a1YkSszkRXTjxCtxy53XN+VZQeh8XKb309p4K+Xt5qvNhRycFeX7XzjveM
 WwowOep/9icj6Iz7t5YFfhK0bR07RSy26BxdXQp1K4/HGORAr8p9bBSLmy5P+YG1uv90z/j2Dbt
 /gr1EGkVQTQKTvrR7+XdG1avsQoThy43T0YjnpNiQ2IxbCTK66viM8Evw2CjVVa/kFCOipoT+q7
 a4wmkZ1K+lOuDZL1UoA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accce7d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=yfuuVOs28KkWNWq-VKEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: f0NFArJoTHhxFl2PxoqcKVsIBL1zrRf5
X-Proofpoint-GUID: f0NFArJoTHhxFl2PxoqcKVsIBL1zrRf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120046



On 10/1/26 12:32, Heiko Carstens wrote:
> When adding support for __WARN_printf() the early program check handler was
> not taken into account. Add the missing support to the early program check
> handler. This avoids that the kernel crashes instead of printing a warning.
> 
> Fixes: 04dabb4261c3 ("s390/bug: Implement __WARN_printf()")
> Fixes: 79996065cfa2 ("s390/bug: Skip __WARN_trap() in call traces")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/early.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


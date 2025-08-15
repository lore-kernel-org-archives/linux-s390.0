Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E161C8631;
	Fri, 15 Aug 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267129; cv=none; b=N6pDHrCPXx+p/bzRkRAumTCDEryKiduZiteRrWs0hNbt3fNbCIsnHX07gV7govpSnIpNvBsXrr53CRO0MmJ/RAoCDJ1wx6XsWfey/Mzn+GbDrv4yQ4jTDQZwAKdCfxFdY30U1GEqtSZt2PBeWD4hCmYSt/LQDwcHexVfM4jpghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267129; c=relaxed/simple;
	bh=YFvmHVLuMDSoUrcpbBl77p/LvN6/nuUPF5EhuAnakA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNXRvqH9nmMhnehDD/fi9e+lkJTQxqug1iuEa3ecYIbqtxYmzkcKxtNaNVjcCpCN0Dn6P3+5fmVZyRoIIJen5LO1PjkAVs6DDeWEU3VSIlX+wjAXTCzZC1wijqg5nMOK1tcg1b8cITUmOZw/fN7XxMzbxIWr0PTVzkOGxsMJFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ps1mX7d5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ps1mX7d5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDK6oP029887;
	Fri, 15 Aug 2025 14:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YFvmHV
	LuMDSoUrcpbBl77p/LvN6/nuUPF5EhuAnakA8=; b=Ps1mX7d5VIhECb7sQFJ4QX
	j13zRoR7BH7qxG31m0LdeC1nfao8gZyCbHDGcbSSDdDfHz55ZcOS5NfyWUhUVWp3
	yUbHYI7xh/Rfqpr2lJ4O8J+gfQnL0wlnHhMjtB1BbrGL6alLsOPCt8uNjePcHB6h
	Df7zDRqeTwO829hxn3objrniKC4u6SMT5+ckp1IDTpU9zt0DA8xI3o3zJ80xOCKD
	LhWyUYtgtPllJ1DlZ9ubzUsO3dhEvrNQWj3hIrna+033g9Uw6OcMCzXnnnxeIPdo
	c4SFRJ4uD7EISb8HKYihBAcuxRk7QRMtIPHtLUPlz77AXZdHRdylJRTkv974ue7w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrpfe5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:12:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57FEC01O012526;
	Fri, 15 Aug 2025 14:12:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrpfe55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:12:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FCdO0t025643;
	Fri, 15 Aug 2025 14:12:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvms01c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:12:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FEBujl20185552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:11:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66F692004D;
	Fri, 15 Aug 2025 14:11:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F2F720043;
	Fri, 15 Aug 2025 14:11:56 +0000 (GMT)
Received: from [9.87.144.27] (unknown [9.87.144.27])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 14:11:55 +0000 (GMT)
Message-ID: <76db63b3-489e-4ba2-bfc5-280c04f1e91e@linux.ibm.com>
Date: Fri, 15 Aug 2025 16:11:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: use IS_ERR_OR_NULL() for debugfs error
 checking
To: Yang Xiuwei <yangxiuwei2025@163.com>, hoeppner@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiuwei <yangxiuwei@kylinos.cn>
References: <20250814071247.2572569-1-yangxiuwei2025@163.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20250814071247.2572569-1-yangxiuwei2025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX0870+aIn/hY0
 1JVeqnXDlx+IBm0qw2pARpas52qei0/fuUhTBJq2QBzQ1h77nSJ5m/VMKyAQdL39sSTOLhotT+F
 8SY4dMTqWFOAbh0fdZV+9iNA7ZcMl9wJ0Wag2/pAiSuvZHPU9Tb8vm9WV5CT/7D03WrJJ1nwrKt
 YH9ZSWuO8WzGCPr1zAlVfC9PU4GNgi3tGDh9sGAvKMism/61Yx6iQ2vNYZlw7RQU7rNME3mKHSp
 TCyyKKwLToRDq0fK1r25/Ji5RGWCzno8818ltjNt2pd2jiF7CPbqOsmxvu/RDSHtgtsX/Zd+8eW
 TkmqB0uH+MoHncXdwu7yYhhq3eZP9Koo37sdaXpL7sEy2vddc0/5Zt5OFLcqcQhsBrAvCkqipd6
 HLyTquhb
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689f4031 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=W5eW2l5LTO-9rmyNepoA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: _5mmtJqsWuhVZ8UuyjBBKk_NsrqNR31g
X-Proofpoint-ORIG-GUID: EGvzj27ZdJ3aCIEAVT-yizTBLj4QkL-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219


Am 14.08.25 um 09:12 schrieb Yang Xiuwei:
> From: Yang Xiuwei <yangxiuwei@kylinos.cn>
>
> Current code checks both `!pde` and `IS_ERR(pde)` separately when
> handling debugfs directory creation. Replace with IS_ERR_OR_NULL()
> for more concise error checking.
>
> This change applies to:
> 1. dasd_debugfs_setup() helper function
> 2. dasd_statistics_createroot() initialization code
>
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

applied, thanks


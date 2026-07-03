Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEF3C3C07
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078766; cv=none; b=od8qoInE0MEljwwt9u8uzDO37qfi+JbhGiuXEw+zdkdPJhW+189SoUm4LrezsfEZd/+amGL8pEBg3mQ22g1ivhsJ30agTcaaLIFC/T2awJe6yaD0bYSdevm6MF6IBhoc1oA4ymytlaSkOtvc/Y7XAWapmlrjSs4ZVrF6mv8Iy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078766; c=relaxed/simple;
	bh=14v8R9r4irCLARmuPFJmBsQhZIH9tO4xHdgFM+jSEZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGkWeKcmi+dZA1XwaSQTDYK/qTAqnC8Z76LmR7eBdj+u6ZUIEJht0rX8qgLtUobhTUJ5ds0plyVw+3gh8CR9QYv24NJYWs3WxK6pElc5NRVEnfY6PlwpBDEzAZHJLmzDxaUd2zdhrhZilHF0npB8jFHviDIAKl37PHnVoNXskDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i+wOUm2C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i+wOUm2C"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IStI1870141;
	Fri, 3 Jul 2026 11:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0x64qo
	d7o9r997NWI5ZqnSvPDmT+JwSm2wDMsvgP0/A=; b=i+wOUm2CGecNXXEVshQxK0
	6xqBfJQ3ub9/jqGIH74LG2rS9zWsO1YJpRXmPjgKnft3up8A1lo2716P+F5KOGP3
	JpryF+mHz7ampVdTlNARjSYslmBBmhtow05kDsDf77teT/Rt+Z75d3yUj/NjI1qP
	vXr/wDp/SfQbw1l6VjigFEntvuUXX52IYWvyiFdWM1j3+50SnV8rslHczGOKDdfZ
	kgoIl1ZZFpgG6tWiX4bUiDEOeSykb2m8zwXjTetkmHijlx57MMJMqd820OYy64JP
	ttn5FjKxO687VPWoz1KbK/14UZY7JQRFQ6M05xsAZFB2UETHry+jCAvqacgVWIJQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n671ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:39:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663BYbUA020840;
	Fri, 3 Jul 2026 11:39:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyrbve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:39:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663BdGV945482260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 11:39:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F10B20040;
	Fri,  3 Jul 2026 11:39:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E799C20043;
	Fri,  3 Jul 2026 11:39:15 +0000 (GMT)
Received: from [9.111.83.9] (unknown [9.111.83.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 11:39:15 +0000 (GMT)
Message-ID: <28892518-5e79-4410-8cd1-1873da752818@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:39:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/zcrypt: Delete CEX2 and CEX3 device drivers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260703100320.qvFoxNbp@linutronix.de>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703100320.qvFoxNbp@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX0rsCohzHJJ2b
 0EoxTrIc8EPkuuSbx0aamM5FjEPQaO5tLafEEv99e/OUVTy689rBgjIJowJL9TjJfeqhz4Q89PM
 Azp52Y3/JRvoqoBV7pCagry2ygr5+WUBFTOopnFCr2itd6AvS57WSj7vtU+M2EJx9xi0lCP/172
 jBjv0Xp4VpRyegUtE6rQXdMa8MKlycsxpM6nZrHJKUBTmU0ouojsKQ5Q9nWBY9QL9FIyvx+uKkE
 u7RnEYcXIbG/ZM87wSuzTSV8/tqftnGCDleFwk1ytpiG1decGuAoks7FlR8NhOIgFU9o42ywAwU
 2iWAUbFGOtdepk00KmShhb/bJUbvIOaO+cdjpcyIbatlUXKuiZKClrRHtcQ0g/mmU/EZP4e4AU5
 16rNqVrJwB0r58gZl+2pw4xFUPmsmFS9z17MSMSn2QaJFbJ0luYKF7/FnSo1770r2/3nP4jTRSu
 vwvOjpZmHei7so8czcg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a479f69 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VNLLYBs6zc7OFa8GzIEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _syCKEUiHc_OqbRnV7R-oj1J9C5ZnuBz
X-Proofpoint-GUID: _syCKEUiHc_OqbRnV7R-oj1J9C5ZnuBz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX4c2gmU+lNLBy
 W6J3NiDk0bmjgXosLgCRgtUfV5vHHQbq1lhP+1tfcga9cxRv3WoYoHHb6ytPhfhAfi+JwjjiobG
 YIfDUTB7M6BusdTs730EqBTcgoN13AI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030110

Hi Sebastian,

On 7/3/26 12:03, Sebastian Andrzej Siewior wrote:
> The two driver were removed in commit 5ac8c72462cda ("s390/zcrypt:
> remove CEX2 and CEX3 device drivers") but not deleted. That means they
> are still around as zero sized files reminding everyone what once was.
> 
> Let's delete them now.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for your patch, but we already got another series from Rongguang 
Wei [1], which has been already applied by Vasily.

[1] https://lore.kernel.org/linux-s390/t@ub.hpns/

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler


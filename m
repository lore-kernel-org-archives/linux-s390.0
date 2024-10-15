Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851021E3B5;
	Tue, 15 Oct 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030441; cv=none; b=aafQArHegWgM5xCkQcHswZanwJ0vA060TTo9S7f4X1gGyBzN5S1sYAaF65oy0t6Qq9fccx7c2PNQWoHJmVVxRK+TrkccuECx7cUmIAFfF35HSltdShJtrjDifJvEJAi4iQLWN9x72K7bM2Z2JrHxltwSj1EOU8Zj3AOTH4ZBHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030441; c=relaxed/simple;
	bh=k1EsMZe1XUkxGLt8opKdc74ewvH9uoQMBVzNOYwwl40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UBJrCOD94/Etn8n56jOFOfuWKgf7Zev+I2e5sVH6+zFO1+TNYXCriYASfFDgy3m6eUHGXmsIifjtfwfHbcuwhCRLl23SOP0Ijbo+Y2OAj3JLZgdBUqxJGV/BN8gkPkF1Ub4dv3LtO1BLuXAjOynPK/D7vu04JMRfXIM3OD1Enfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hBhkQn2f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hBhkQn2f"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCQaoT028136;
	Tue, 15 Oct 2024 22:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1EsMZe1XUkxGLt8opKdc74ewvH9uoQMBVzNOYwwl40=; b=hBhkQn2fRPP9FvVI
	esHuHMRTWfZgGz0nQjVNv/otNyjnP4qRrWJQa0S1yj6Rl15hqPMBgyX44Q0mHLd1
	pfn+Mw5TRCvpvmcE2jo31ALSNFgnF/0+bHzMkvsYOE2JgBGCCAWLFHHJ/tp3nwhf
	O8nykgil+PRGJyomPfpbLRiAkdJrhB8bE32IGnUylyzxL91EFpIMkwk/ub/ZF5/d
	96YVqm92VrQqaKZ4PqXaVCDFzkqcCYUB9BYZYUKRZtDNio2d6B7tsOd7ONPuPiwP
	n9+An4Ud/JpQ8yKkOfpB7jZyN82HqSfKg1kBUEsRcTXGkKekeXM60R0lyrQryPNb
	3ozpYQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429exw33nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 22:13:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FMDrsk014566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 22:13:53 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 15:13:53 -0700
Message-ID: <9ceb24b8-6579-42d9-875c-649a1342c587@quicinc.com>
Date: Tue, 15 Oct 2024 15:13:52 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390/time: Add PtP driver
To: Sven Schnelle <svens@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
	<agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>
CC: <linux-s390@vger.kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20241015084728.1833876-1-svens@linux.ibm.com>
 <20241015084728.1833876-4-svens@linux.ibm.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241015084728.1833876-4-svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9D-3asZBwZdBXM-sUNwMfhd0IUW6QpFu
X-Proofpoint-GUID: 9D-3asZBwZdBXM-sUNwMfhd0IUW6QpFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=818
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150147

On 10/15/24 01:47, Sven Schnelle wrote:
...
> +module_init(ptp_s390_init);
> +module_exit(ptp_s390_exit);
> +
> +MODULE_AUTHOR("Sven Schnelle <svens@linux.ibm.com>");
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
(if any) are left, so please don't introduce a new one :)

Please add the missing MODULE_DESCRIPTION()

/jeff

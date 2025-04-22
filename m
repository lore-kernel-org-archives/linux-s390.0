Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D81D515A;
	Tue, 22 Apr 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314068; cv=none; b=N/Jk/Td56mPMZQNS9IyS/yLlaHez9lcm5KmWheEYBxmWF8wfw8z4R/+uFtfcQSFcru1SrKmk8/Ew33xQ4fVBZfeYmOFi2/fduBE9M2CxZiGTGpX0LMkhkzgdsNzFEESlHNdHGyHLTrw0moMqs1KTJ7hRqXK8TFEg7j+bNubsjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314068; c=relaxed/simple;
	bh=4KchaIzpg7IBqCJtwPjfUtXENe/CWpa7t4FcESvuxrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8qZopp8DHyGKWERKfdD3/henvqseiwl+LLOV5Uk85xjzXpiXaVKt4HEBXVv4NMarpgwmwQM8TKyM/L9Xqw9e6AtHCogxT991p7O9w0ZSuNPf3VlXbVrodjPAPXTJYqyVlVnnhePQjf6M0p2RjllOdZdeCHa5EjeluE539zHCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZQx+M3h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZQx+M3h"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M47fZn017074;
	Tue, 22 Apr 2025 09:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5/45Mj
	+33FTBtQ0LNiuxzP/4nDml3OaYkd587G9IpBg=; b=dZQx+M3hp25oP7/dMuPPvr
	RT5Fzh+4TCI8tYFkYfYnRTiidy04fCzl2fqqGXcjWOEa6O9GQnWlgxQ82RSWSYKj
	3asp268bBZfvmPhCSHUtrx/jaHhKQqgVldTl5izUH5OyhxQQqSW4kTRzDVIr933B
	pahh6Vx9iPIFQZap3NFEKaD6PZZVESZACPB6EL7bu9YihYmm0qwWYvnaMzv4ChpC
	c9zdnu66wEIv1qEa4OA5poFx1qJqTt2TBX5kFsrtQ/Rb9/fF1VJagkrSxqY777dP
	PwSciIGWu15Y5++st6aO8jiLLcLmTPNGRMKYjBtE4Jz0KjXqSFdWfc0Ab42k5T3g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663t6190k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:27:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M9R1PZ030155;
	Tue, 22 Apr 2025 09:27:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663t6190g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:27:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M5pvtM032541;
	Tue, 22 Apr 2025 09:27:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464phyjc2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:27:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53M9QwOH51577172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 09:26:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B722004B;
	Tue, 22 Apr 2025 09:26:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA13B20040;
	Tue, 22 Apr 2025 09:26:57 +0000 (GMT)
Received: from [9.152.224.20] (unknown [9.152.224.20])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 09:26:57 +0000 (GMT)
Message-ID: <42655472-16ab-4573-a5c4-0b07ff580d98@linux.ibm.com>
Date: Tue, 22 Apr 2025 11:26:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] MAINTAINERS: Update entries for s390 network
 driver files
To: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GCWXrMp8EhKUKKis4ujQhhWHMfF_-HEH
X-Proofpoint-GUID: SlvUn1BLFqG-sTNdE4VLQx9bow7LF6ru
X-Authority-Analysis: v=2.4 cv=GsRC+l1C c=1 sm=1 tr=0 ts=680760e6 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=uK2A46cPTsoq16aZV30A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=503 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220067



On 17.04.25 12:15, Simon Horman wrote:
> Update the entries for s390 network driver files to:
> 
> * Add include/linux/ism.h to MAINTAINERS
> * Add s390 network driver files to the NETWORKING DRIVERS section
> 
> This is to aid developers, and tooling such as get_maintainer.pl alike
> to CC patches to all the appropriate people and mailing lists.  And is
> in keeping with an ongoing effort for NETWORKING entries in MAINTAINERS
> to more accurately reflect the way code is maintained.
> 
> ---
> Simon Horman (2):
>       MAINTAINERS: Add ism.h to S390 NETWORKING DRIVERS
>       MAINTAINERS: Add s390 networking drivers to NETWORKING DRIVERS
> 
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> base-commit: adf6b730fc8dc61373a6ebe527494f4f1ad6eec7
> 
> 

Thank you Simon for this improvement.
I would have given my R-b, but Jakub was faster ;-)


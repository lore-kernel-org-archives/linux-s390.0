Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF42DEA9B;
	Fri,  3 Apr 2026 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235261; cv=none; b=aQjJXJivD6LUuVyw/J7slumAoBxrcWNcX7moy1KkKW1J9vTQlJTkllxKtES9Tp+xS7ZJrIlLMAWJoVwDo5RN0b7KlkteTCnsLvDy1nS9HvX0wOMExT+cU2mxLl88QMDGrn5KKME9fNUpLz4MM72fCMMquJgysfNGncyTUQtljAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235261; c=relaxed/simple;
	bh=r1FVPF1SnkUniApeSY1Xgo6UkbKKvPd2CZ6kcg61h9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Faejuu+wWObp8006xNSavmTiAQQmdK86lYlbmMWFpsZvwGY+mIC9lkJVuGu2Use4ofVZQ8UR93dfKTT+ULW1XBS39fIg6xvzCHNxF5SBH0kO98lzIUJdrcDIBZgwCR8+xDEFO6qkBxSClcY10/x47T15yybCXQnmhKOxglZZd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ElA/3vOt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ElA/3vOt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632MEmTT3639069;
	Fri, 3 Apr 2026 16:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dzmb4f
	pyHSGcBpjCWgcSEnS06xDWx8zweQ5ZLNwenJw=; b=ElA/3vOtcKq+S9lthsVgEd
	ctxAIHzG/MyqbZdf/u0Mees5196rDCkflBtNgEmn4hgb+jPNjSkAMkKZlmgb58rL
	BFOKYPFNoAE/FNb8nEcDSvALgTKwCC4bvGHMA39jI4iMU9C6w/xUBcDvlyQYkUbd
	jmFKskUN7/+0GkTYJ+3KdL18635m5uEZNdz3nuK1sIvLwKdPaJ0SB1G43NGROI98
	w1FiJt49NOlbX6uAILKMwqdPjxjKP6zSUrenzECSLGkSBnQLEmQOYO6xGBShHtOH
	aNxQad2EEtPGW6fDd1Asgu60lazHFhjTSFB+0yB4iMAJM9tWmtQr+v4eZ5Cuz7Kg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msgf1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 16:54:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633DZefs013987;
	Fri, 3 Apr 2026 16:54:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkxqd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 16:54:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633GsEvZ131812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 16:54:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3D9E5805E;
	Fri,  3 Apr 2026 16:54:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9585058056;
	Fri,  3 Apr 2026 16:54:13 +0000 (GMT)
Received: from [9.61.255.240] (unknown [9.61.255.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 16:54:13 +0000 (GMT)
Message-ID: <a3e9dba9-135f-4385-9c26-5a6124457bed@linux.ibm.com>
Date: Fri, 3 Apr 2026 09:54:13 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] docs: s390/pci: Improve and update PCI
 documentation
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
 <20260402-uid_slot-v6-1-d5ea0a14ddb9@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260402-uid_slot-v6-1-d5ea0a14ddb9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cff0b9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=OYrjuxTueeVGiqUQM9MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1MCBTYWx0ZWRfX1PG//TsgaB2w
 Me8Gl7vofevTGMaW2AT2Nb/IuQDoYOml/PE1LOw6ntenE5KgvAU+doRjhNfKNcFGshBhO0524ft
 dSCIsV2BIMV8OkwEjTQRHzu7ga0ANCyz+PpgZL6iDWzwJJXrpJSYbJVZbgtyslSd1LVLVlCJoj2
 kAHIKaJnY2ZlEaWNW6WOs2GIUd//vk0MBK1zRs+C5+kxNEj6p22ZJ0XX9Z3FCcyzf85ra5TT3IV
 mRpYdkt6SDwSuT8cpgNSt6INYU706Xk2iRUjiWT6ABC9mVE49Um6BbTmGIwvKsLpBRYngIwQGFZ
 AWo5IVXJMmL6oJyfQ0BaLOgentlonv0YevL+6TowoJ6cAJ6cIHonBZ82b6AcC41XxDx93asCc+H
 m61wxhUDs+ji/taQkLiXIGtr8QVCqAMpiFapfu6NjGx1n8Jskgo63qCjozujQ4emTEUcvak6HDh
 nMSxGQ6V+tAiToQz4DQ==
X-Proofpoint-GUID: Yrf6opRGyg-WjLzVF2u8PuAAV2eVMrWt
X-Proofpoint-ORIG-GUID: w797PbUa0vtLHVwoS_DxlEmJDFtePBOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030150


On 4/2/2026 1:34 PM, Niklas Schnelle wrote:
> Update the s390 specific PCI documentation to better reflect current
> behavior and terms such as the handling of Isolated VFs via commit
> 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs").
>
> Add a descriptions for /sys/firmware/clp/uid_is_unique which was added
> in commit b043a81ce3ee ("s390/pci: Expose firmware provided UID Checking
> state in sysfs") but missed documentation.
>
> Similarly add documentation for the fidparm attribute added by commit
> 99ad39306a62 ("s390/pci: Expose FIDPARM attribute in sysfs") and
> add a list of pft values and their names.
>
> Finally improve formatting of the different attribute descriptions by
> adding a separating colon.
>
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
>   Documentation/arch/s390/pci.rst | 139 +++++++++++++++++++++++++++-------------
>   1 file changed, 94 insertions(+), 45 deletions(-)

Thanks for updating this! I wonder if we should update this 
documentation to better explain some of the nuances of PCI on s390, or 
more like "intro to zpci". But that could be a separate thing.

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



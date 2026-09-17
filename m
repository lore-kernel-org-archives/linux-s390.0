Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CCA4E73A9;
	Thu, 17 Sep 2026 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668504; cv=none; b=uzBgGOIYa4HYJbLfwT5WAhPEMq6Zs4WfeND62g5JWXIFZltvlBhDBT34K0XN5ccfN3MuxG1wlnU+RqGI+mQaVZKiqB0Xlnj3SqZ69deLbWos23pwHZk5ZCv0M721SldOzOLjNJ59th/23PzIiw88wbCL0YVMzRZeAYvnRT2ueAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668504; c=relaxed/simple;
	bh=fhL58jgtvL1dddXrA20/eQLD4DACWKB2bp3h0acSLwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYlZoJ54GUXZK4C9xuGFJaqcAjL0T4k14kOZorH+yo53wDRFF2da8m9WPwfy+KuzbaDrEPVwQ69tDLEKhXNg2tRrMWDOgryVUustoATPszhahI8B9FIqvynTMrp291kiJFOaCO/P6QXXYUY73thhIukPHDzBuc62IkxOiEWDV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=abdh4N/q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="abdh4N/q"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVdGp2998402;
	Thu, 17 Sep 2026 18:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GhoL6V
	W6zauK2jjrPKHJ3zzBMgo00GMyDSFSKueWuTk=; b=abdh4N/qLpnGTiRFJ3UR5J
	HMgymQxhanli1DzpUltLT60qkAIEpeQZHewi/7epAZSTZxKQutPZVzWPCdxb2c7o
	b7fG06JKFNjS1zva5otXY86GXIINt9PCe//fiswREfUoyRtrP14EDxfV3J7oOPuF
	GfG/mJXz6G2sHXKYiZ+SSJj6u7m5xhFptLLMvTB1QlavkcurVz4qVy1ixlNbyz/M
	AIyWOTv4Uz/pAVQB9BpwkeykaRgyeT0dUJyrkHPAfDkhzZATsz4/Zmwkpb7GtklH
	vcOCzotQQga2BE0y0JMfLDl9zRkib5YWrQsdtMiFm+6EhdiMVzuiEBfogbBOUGaA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j3tat-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 18:08:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH91w23510127;
	Thu, 17 Sep 2026 18:08:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa3kjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 18:08:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HI8Kci45482420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 18:08:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63B1058053;
	Thu, 17 Sep 2026 18:08:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD23D58059;
	Thu, 17 Sep 2026 18:08:18 +0000 (GMT)
Received: from [9.61.246.38] (unknown [9.61.246.38])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 18:08:18 +0000 (GMT)
Message-ID: <4870421d-39dc-48f7-ad34-6e9f642f1c66@linux.ibm.com>
Date: Thu, 17 Sep 2026 11:08:18 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] s390/pci: Don't report recovery success on skipped
 recovery
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-4-61a2f980e71d@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-4-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1NyBTYWx0ZWRfX7SFncSIUTg3y
 oCrcCCVoz7g+ZrTQ79SbtBtU3SKnHcMACirdL8uqdvQj1pWIecMJosiZRdZinDrVWAz8ThnkN9m
 KKyUCKJKDIcfKhxBooMenWXOPQeQ0vTYsoCPxsyxJurmlgEPg//1R4VYiu+V0//8avCJ71rY9uO
 CfH6U0TC3ZxkDaPryXYRymyj7wrwTPFbXQwBsaq0RRjQugn1Y/Zr+q/QVdsApBwSiUFOgFHHhNY
 NZn+EwkTB0A7p5Gco52PuYrsdONVCsH+1/1l4YC6f5zRJJed+jSGXBjAXepxY5HijAZFP5cvKFv
 1zhwdnV6VOUpKWK6YJN4sqWiHdlkcwnpxlyG+g1U6tx4QPRcbBv0Rju7IVkhB/HU8JBCe1z+thN
 EJOq58D1gYxfpxHQb+BepeZN5/IqNz/udJdvWO5l7G9ddQRQPZ3+HW0yu3GOOZ7AWMcETd/0FeG
 e5ezDExmty/k3Wszq4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1NyBTYWx0ZWRfX0cBnemsB2Ae8
 kzGXc2QZk0IOdrw2RJ+WGbAemCYGyKZZH+o6vMWOLJDT9a+Mj/RcQ85TZCF4If2mPFp4LNOFd/C
 PpGj5hUQb5M19/npbyDryLbi9NnqZas=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aac2c96 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4Un3bHBAJC8VMyDCUI4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iNnBuYcvmudzLkOq1bKkm9jPu2CK0wdD
X-Proofpoint-GUID: iNnBuYcvmudzLkOq1bKkm9jPu2CK0wdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170257


On 9/16/2026 8:14 AM, Niklas Schnelle wrote:
> When a PCI device is already in the permanent failure state, recovery is
> skipped, but the SCLP recovery report still shows success. Fix this by
> changing the status string to explicitly state that recovery was skipped
> due to permanent failure.
>
> Cc:stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
>   arch/s390/pci/pci_event.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



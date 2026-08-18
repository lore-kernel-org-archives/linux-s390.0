Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F0B348C7B;
	Tue, 18 Aug 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082755; cv=none; b=Av1bCFvuyDfo9mM9bkD5jVR1LRzATRyxac2Z8C+e9oXuIYnBGKh9CdIJkqDcF6Xaxc3TciZgNbFhxcUhZ8fWAAeEfBomMZ881n3FZznddRF7D/jbj73LQkN4QSAZinOrWLeZG6J9S0hFvOhOrxZOyZwepbXYH1EJNipgk6/WlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082755; c=relaxed/simple;
	bh=/fTjeZiy4J7Ry7AVowp7jrpQHmfqEAnCjJQ02GMRhKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f06pe9dXc29r+37jCJDalum2iRqnK0IMZtPTKO76IBVMk+s728znJAcsOyyuRlTnrRX64T2Ni7VQ/8KtoTIw/ohj2xTr5qEMYnPTTbnwfQp3k5foTtXVSn40Wu31zQb0Z+P22Au9Z0NYt9tMQZLOqB4JfsZ/tr0yboVrpYLfXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xecszw6o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xecszw6o"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IJXPUr1296031;
	Tue, 18 Aug 2026 19:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YmdtNZ
	3HyBltPdPsBmVNXzF/5ChvkG6IVO9DAzeYYYY=; b=Xecszw6oHyyqm+xR9Od/oD
	fUbHVk6DC2c1/AkNkbro3d5hyj08YUi7eUK/+4qKQ+0JX/RR2h2ohwx2MvoDF6B6
	3d/oQwsN4tMhBz9uYF3Hh9BkoQwlXwdNlg4evFLoZVJ4hWEBxa7hdQpibaLK8kJw
	MKiYsDWt0FWB32BguSDwC4F1t+w00Ls6P/2RCdHYrzRBZwWxb0l6Vvv0KBer1DLf
	ivRx4a/x8wNCoCo2nZFsObN5RoUzFFf+Lxo72hPktWut3XivfXOswjbVWsLAaYmg
	ffbyZy07ZcxQsp+iOa8iJQXRlPhssMtLfONU2j2I4uXRVDuVQhi5KYZtF3NGIelA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt9y5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:52:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJfVdT023950;
	Tue, 18 Aug 2026 19:52:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek56c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:52:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJqVoo59900364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:52:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25E5258059;
	Tue, 18 Aug 2026 19:52:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A8FC58058;
	Tue, 18 Aug 2026 19:52:29 +0000 (GMT)
Received: from [9.61.242.213] (unknown [9.61.242.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:52:29 +0000 (GMT)
Message-ID: <5f66ed47-1324-4d95-a816-e1afb420e838@linux.ibm.com>
Date: Tue, 18 Aug 2026 12:52:29 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pci: Fix missing pci_dev_put() in
 zpci_report_status()
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
References: <20260818-fix_zpci_report_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260818-fix_zpci_report_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84b800 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=T-YNbzpsWdRJuaMA0tkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX235hpXbiKjk1
 MGwCQ2G7ud3inUm2D/h/INrkojiY6cQfLjZNdtUtufgr5WNOh9Umv7rQ+tcTD5/FXQrly9E8SSt
 v0KXOb+wdr4mpA2IzNVShq7DSk5d1vE=
X-Proofpoint-GUID: -nhFrcPktT7r9KevTOJyAxF98foPxDob
X-Proofpoint-ORIG-GUID: -nhFrcPktT7r9KevTOJyAxF98foPxDob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX3MqAoF3NBmo9
 S39TeDVwrjRvv3dTpo0/gaslm31cYXaODebtCY48r+YSGnpSxD8alZa80neYjrui/5kGLAg7WCi
 /2sUaujReqFZnc+ulYuHgjTswQi/l1YY0Ul1hIqIHboEvZtrdWhiTECyD2eINIHpmVdR1olkYPI
 VmGrXrFnTUYeu+0Ckln8A14DoT3bpmtzfUKwf1x140jWHdgn5z9gNmNF/hnFXrEvmh8eLoetATf
 JVzqkJ/Ay37OCG1O3ojq+CLHECk87MWUNfE/j+RRv36LOQIPry4p8uFQzhCLH8UcNSwdEQXqDR6
 +ATNWB/0E2tOvSloSouXAP13AuO/IeVXWPY9Ml9vrlICiH5392qxttvP1Wi+jFIb+4NWn4zxm13
 HK29b0aFEPPAWOyIBlN1UhRk0QNFnb9Z5ScnwBtybqfjQnOjtNlzbmkZz7PQBDGdb0HS4srNHcy
 NE4zLo3QWuLGF3g9g9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180143


On 8/18/2026 12:17 PM, Niklas Schnelle wrote:
> In zpci_report_status() a reference to the struct pci_dev associated
> with the struct zpci_dev being reported about is acquired using
> pci_get_slot(). This reference needs to be dropped with pci_dev_put()
> but this call is missing thus leaking the reference. On subsequent hot
> unplug this will cause the struct pci_dev to not be released leaking
> memory and potentially prevent reattach.
>
> Reviewed-by: Matthew Rosato<mjrosato@linux.ibm.com>
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Cc:stable@vger.kernel.org
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
>   arch/s390/pci/pci_report.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43032E126;
	Thu,  9 Jul 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607048; cv=none; b=uOXQISzXLg0DDTNRTCKCOyS4PcdyDvPrBjsF4vzrkj/TLB/6lLFXDaNKLJI+WRTHQS4KUTDPys0bolGtDkc51/vycaE+fb03Icv6i+jFSIoXv8WNJkHZRBK9difRZm3/zClOoARjdrlvkVWf6Ak1b7c6gEz7XKqFCybOs5YfiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607048; c=relaxed/simple;
	bh=dDKsjE3RVjCKGokvF66LLzqTtaVf3fa5Sz41h206St8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+yaHvStFoE0dWv6vsxFxLk2qJVBS2hFikoUW1RHXjC95WFZ00six4Oxg382CxTlg4LqfPk7XYyCP75pLUjWtsesNVRx0EoEyNX+qf8O2D8LrZNK0ktv1czxVhfGAcInK/Y9lRXNHcrhi5qcAlgsJnMxoLv2Rwrs08FEk86OxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AdbMNwpr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AdbMNwpr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EJ60R1771144;
	Thu, 9 Jul 2026 14:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mQkrOb
	J2v8zQSd9F7DLB1UOYyBJtCnKpr8TxmNP5rKM=; b=AdbMNwpr5mKkCFgD9fTsym
	zEuqAesgQA2KzI0sqZ0wxa9COC0CB4DdBoMMRUeDVJSf5Ah0QuIiw9rj6qZdiaff
	7IqGPMyQokGIX+Y50E0Ai3aK7BH5CYzqjBK977yNKoaPERGe38OfTBx5bA0WPZ4H
	dbPTwxI5VUyiAb5PaMem0bnkVPpeu6kN2NfK7PAQDt3E1crIwM8qrjNWg5kUMTxW
	y6YbXTw3RVK+z1AnuPZB9CRcojCyW6kr/Yzld9DnrXun8bR6jd4E7yl/c82CxAzl
	GdUZeOQr84LgyOGiWfUvEiMor+ni6IDNGg6m4mZhqMfoHRfBEVOd6UDp54/QDH5A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke2fs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 14:24:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EJdcQ029834;
	Thu, 9 Jul 2026 14:24:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqdq4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 14:24:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669ENxA752101514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 14:23:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 443A020043;
	Thu,  9 Jul 2026 14:23:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F073720040;
	Thu,  9 Jul 2026 14:23:58 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 14:23:58 +0000 (GMT)
Message-ID: <49866675-0dea-4980-af50-f085baf77e1d@linux.ibm.com>
Date: Thu, 9 Jul 2026 16:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: pci: Fix handling of AIF enable without AISB
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260709135404.2255136-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260709135404.2255136-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4faf03 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZzQCogtDLUch3_FqSnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX24+YS9bkLchL
 tQC4kBFEZ9WhzYSh30MTbciKvcf1P+rG+AGEybioU3J1ijLaKeJKkMP7uVUD3r4/4JOxoD7lNEx
 sZcxcr8jVNLVUdrg9CnmH2vGtPw+OlnrnnpR3GABEjMpNSFR/l88/ZV5l2CSvUW9rxi5nzgAmPB
 GoP5pWZxEH79cuWXe9P6vYNE0yM3Qv7Dq1XJe0o66SXZYKFaOutxhZtAuV8yRKIx8nLVkNtZ7C9
 xqAWBKB2S+tkCPiCoe6e4rrrwz6+REI+oKqRSSYFHV70Fg4tPaNVQjVtWLK9VYAQz+mgVwxQz0r
 A+zUyjcYP3vqUxZ5ZUoWqGEjz8nNZhfEQ/wqClDcuukd5z+dPsFvdAitY5kFwTx4xNgUhVhSydq
 czlNahh8lqA50Cv0WF0xoftPwA2VnFnJ3j7L8yZ4jLlJ2mOJXHDCifE13ou+YEri8uTDz3mP3OA
 CWJDU5P9dwB4eXZmoAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX9ZQebgoj1EQ9
 MNPdm8chQHSWUMn3e9ZPP9roBEefjj2IU/kYSQLz8zmqjb1eVmU4rNAqhWAgP9bilxuhAWqjWgo
 mxG2LkxV3u2xPf/wwAlbt9d8N2R82yE=
X-Proofpoint-GUID: C4MDguPGkiwHef7-Y8OTAhioIWEUN-Hw
X-Proofpoint-ORIG-GUID: C4MDguPGkiwHef7-Y8OTAhioIWEUN-Hw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090141

Am 09.07.26 um 15:54 schrieb Matthew Rosato:
> When a guest seeks to register IRQs without a summary bit specified,
> ensure that the associated GAITE then stores 0 for the guest AISB
> location instead of virt_to_phys(page_address(NULL)).
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

applied and queued for master.
Thank you


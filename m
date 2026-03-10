Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021EB39936E;
	Tue, 10 Mar 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160621; cv=none; b=MGC9EMXeyoQSnpJBcW3dRZ9Ja4PDJA56ap7DCrTcbptnSuXbdgjFNk0jCYRDrbDIfwm01pqVAs7Hi6zEzOMRUQjQkACwAyQ71f9KOfRu7Q8nWxYSmsT5vPJzlKUKOWqf0w/dI4/kABGQ58d5bJj6uaCp1vqXWT2ZUY9nEAjgKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160621; c=relaxed/simple;
	bh=uYCP9UbvcLVkUv9JwAMUSdxhKGPnYkOdQe4zSvQZ3f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3+YZ6hy6kHVU4rEWkxojmTmnTkmZZU3SJVp/fleslB4DRBC5DkulBPb4fdsvhYtrkdHlXCTpfuRMqDZLv9GxE3H6CyVsAnKXUrABuO1MIhqTziTcenV24FMVgwBPfkotmuMZwkPtJKfFAc05zBvLH4u8Bs6/MQ9Z0YshC5pyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pUBtn6ov; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pUBtn6ov"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9gu3B1596414;
	Tue, 10 Mar 2026 16:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sMPMqx
	1teufVbcGCcAmWkX1e4ZNd9cyxX4UkiDIc6wE=; b=pUBtn6ovKzCPLQ44RJwwKu
	n9GuNuARTge+vrnvvpKETZJzWUk2GrzoC+IkpaMbgAhustqH+GKipE2P3RxORtsF
	lLtDehf3BiFNVvYYtzrFPzfGA2lBeEXgt6C/GEB3ExdfUGOpK734QSigJhCy2VYu
	3HY/b2ViWl/gkYcW1xjwXRolWUJ7EtIlFW0wMkpCyVssrUHWWMx9w5alPYvICFlo
	4Wa9RGzJsMRjs2GbfsI+gfeAyPqCxV1DsP52F4bUver1SVM1xYmbGdkHD+nheh+M
	6S5WY8j0qWDg7rQKyD9yxTgB7IsAGk/IgFO9Q8U1a+ZA5DLI6UngH9U1oEz6v1Lg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrbhhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 16:36:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ACwn8g015750;
	Tue, 10 Mar 2026 16:36:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1221mft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 16:36:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AGartk37749140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 16:36:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB6E12004D;
	Tue, 10 Mar 2026 16:36:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680FB20043;
	Tue, 10 Mar 2026 16:36:53 +0000 (GMT)
Received: from [9.111.22.201] (unknown [9.111.22.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 16:36:53 +0000 (GMT)
Message-ID: <a366bb70-6ee1-4b62-82eb-df8178b92170@linux.ibm.com>
Date: Tue, 10 Mar 2026 17:36:53 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/mm: add missing secure storage access fixups for
 donated memory
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, imbrenda@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20260310150408.160722-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260310150408.160722-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE0MyBTYWx0ZWRfX0asGVgFrqD2I
 iNWjce9vKHAUlrbh9VhgXQQzCQP7nDPCkYS2Ac1b4H83F+XPgrSgEQdvk4AVkHp4MgS61feTNGz
 bWuReOArRhfxjIesxi3JlVebJ8vNa4WRlvP7ECarruUZ54IOUuB6bCmDu7t09EbNHWLSHs1QkuB
 88yD2S5rRTsAoUTTraZYdD8qAf6bqIe7d2twU9NBD/OyyjlxxARzLfVAdMI9koPy3EQgTe+jJf7
 AFvHoX12fyr5YrOpysltN8mWP7/B++2M2GO+Hs2krz19yclK1oT7f7O1WVJZaoyU6XX2LOWN6YV
 9o34tj+7UDhZ2sV17PnLhDnD4ZH21+kT/d6ytzH0nU/S1mB44oLdQv0tuuMac/n6AoJOzc/mPrd
 AFil9J8rQ6y+8Uwlhpq3fKWWzs+NxfJMZiPVIGsc4EbyLpZ/lQ3o628+XNgy1b2aCv4bEzh3+Ve
 KYTgdVAilTId3y+werw==
X-Proofpoint-GUID: 0vSgnFpVk7gXx3wCxpo2VC8Hh4O2un4o
X-Proofpoint-ORIG-GUID: 0vSgnFpVk7gXx3wCxpo2VC8Hh4O2un4o
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b048aa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=TrE2I5bt53qSS1KpehMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100143



Am 10.03.26 um 16:02 schrieb Janosch Frank:
> There are special cases where secure storage access exceptions happen
> in a kernel context for pages that don't have the PG_arch_1 bit
> set. That bit is set for non-exported guest secure storage (memory)
> but is absent on storage donated to the Ultravisor since the kernel
> isn't allowed to export donated pages.
> 
> Prior to this patch we would try to export the page by calling
> arch_make_folio_accessible() which would instantly return since the
> arch bit is absent signifying that the page was already exported and
> no further action is necessary. This leads to secure storage access
> exception loops which can never be resolved.
> 
> With this patch we unconditionally try to export and if that fails we
> fixup.
> 
> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>


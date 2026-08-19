Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578F1684B0;
	Wed, 19 Aug 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148545; cv=none; b=jwxLJzZ3wk+ts7NdHX/YV1jQc9/uMHc/XNqo4+0IQi7CpBYJjZp5KMLdJto9HfUpgtCvvp9n+iOl/QdA5hzLGw4ut/6O6Knpd2qNUfB65uHFXpp08fFRkmD+qP6lvX/ldyNQCg6/DeocTtxX9RQ+NKxjAUJprATl4OgFFTGGFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148545; c=relaxed/simple;
	bh=VWSNga7k9g+SzhIt+edn7RGgIQYJNa23a5SlqakkVZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sjz1UhE6a+nSnzq8W43z2NDAtRARlU9GkF8cGnD52rkXp3epmvnLelp3bbGQ4gMnmY8oKTvgiAHGqpBYtqrRspP/cu+l4rrDd0ehH4aXV8ySKpwelSNHlA6N0x4bwYHvdaMo+gxidEGbcMKhlaIeujFZXHIOTR6x5OT69Tyg3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Er7EBiD9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Er7EBiD9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD1Xoq3480118;
	Wed, 19 Aug 2026 14:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6s4ir/
	jIBmODDdJSCqvaqMx569HiPe0e697nq8vdOts=; b=Er7EBiD9mX2Kmw8jPdvbbI
	U2NSQ9nUI3TeeT27DmLn6Jq/5F9XG8feoAc8WOPUeCB/99Nm4u+tRWy7HDUeFt1X
	4TDYCKqPjvr8LDv6xovklbRuPtxQOcI/Wn8pAEE+t5ieQaaOmy7j3Lt9OkpauZ8m
	QxMVEiY5tv0LmdcuCij0eVeNhUdv8X7BNYpu8Urn6qptKVnbNK+YuE/BYjLG4c2m
	hspBTj7rhWVtXqI34KOeNHddswOmq3fLrURr3FvK4cHYhmhE2GRVd8OEEIpfCtpv
	06TQGR+wWs1f0jglxNZHJqQ0yNm82Vg2Jagf2e2j5MNwOouxGogipVatjrIJgNUg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1c6hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 14:09:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JDuH8h003462;
	Wed, 19 Aug 2026 14:09:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngh2wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 14:09:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JE91FV22413972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 14:09:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E160358051;
	Wed, 19 Aug 2026 14:09:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3765805C;
	Wed, 19 Aug 2026 14:08:59 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 14:08:59 +0000 (GMT)
Message-ID: <1a97b500-6c51-444c-9da3-023612d8a5f4@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:08:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/pci: Extend device lock to cover
 zpci_report_status()
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
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
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
 <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a85b8ff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iqEJ4frogEVWk84FnvQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ztlsLhqrDhjoXBe4ILcOdsfzLQ1-OZAB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfXzrpXgNN3PxTc
 +ME2c9ugpGke7Im5W9WZ1j0dosHiubnHlLOpBiyvt1m91UInm2OdJSNYZivrEcHK3qsVbIHAU21
 PGGtvBxO2HzaxjMn+UWvWE2zYeK9V+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX1b0s83apW3uq
 7PL5iPTyr9p1ml6aZKNqJJ50lDfDF7ckeWTE0dMGU1TFU8p8pDLppY90dpZz+oWBLN8RP7fbd96
 Zzzz4MOLppkKtiq61ngbGPvvlbDinOqh552llMaoil/tSwnbcap2VRkA2ZnlwsnZwejqhVD0lLa
 l81s+A5kGLXhOL9leQ0zr0S41yoQVaN4yc3dCITG9S8pTzn1ZgxtqCg85uTgY1XLNSZOunwYYnZ
 WZYGpkSjvHPN/LtvQDMD2PurABnYJlzbfXsq4PDkxNzhghZf2REEHrmml5j2of6QQxQBIFx8gRe
 enrBcDG6/JZnXDf4sOZuDCj08DSlB9dmdhuGb07Qhu+sIQ3pEw0HrMvUB766BVQcGJS4FQo5P3f
 vssuRoT/o+Hg9Ljk+mf8WjF2U9nGg97qxvLoOP7L7DuUjSFr86Q+mk0xyp3ft0jvu1OExTpucCF
 y7ADB956FoHmI5ZKskA==
X-Proofpoint-ORIG-GUID: ztlsLhqrDhjoXBe4ILcOdsfzLQ1-OZAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190109

On 8/19/26 5:58 AM, Niklas Schnelle wrote:
> As zpci_report_status() accesses the device's driver the device lock
> needs to be held. Extend the critical section to cover the
> zpci_report_status() call.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



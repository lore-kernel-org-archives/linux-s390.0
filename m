Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB25375F82;
	Thu, 17 Sep 2026 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668422; cv=none; b=NsKnAVKY4vbaqSCdm/oPRFt4QBZYFQa+B2cxl2ASCibIw5WeAkjc45y4o1lBzY9dhNH8gGMTzUJvEdYttb1v3J9J0fTqq+P3I5XELvydvaspUFkbUHFSP6JwXdhOWZpLhh+LQa+P0Vo74I8RTWKBAoEOhGfJmUU+gDlkmC7y0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668422; c=relaxed/simple;
	bh=nfRJr1dD/o/gWY2MFrIDXJsOWNWiwhl9Pyl1HXvPh7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcfD1g5B9U7vz1tBq40kH+EwdPAEukuAey5aRo5QEzVSgazKLfVax+3rwwS0svhsnN1lLDV6U6JQQ2orcHa853DMMMD3n3WvDDxSUO+iZVsdqf3anf515ckh53OZJYeEUsoAOoOmzH9GyBlItlePrbtfZLWdnt9eAGtXb5F7icI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iznGmB2N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iznGmB2N"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVV2J3143311;
	Thu, 17 Sep 2026 18:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MHzGQF
	GfRwvuU+trBlqWC9WuR/t/VNg1zoFSY3G+qYA=; b=iznGmB2N3G3rQAwx9ZP2c0
	UJ/csDC3tWgtguOGG9ix7rdas+zy+ULUk9rJzsebGeMgsFZaAGBhaSAZqHqQegkz
	tOh7tyEziaKxht92CRant5DL9i5K8OPKA9GoiefnbqWpTig9QT+KWawiCkLZeO0g
	Fkf6xpU7XkKB4HwhODrEXwYaq4ZMKphumImhO3tol2vTfr3pzh49IH6chjXMkJYe
	l6zHlUoeGVhxvc8yoEL45kOhYcCwVfNkIKzsf/lbNiSAnsG+ejvgS/trDalrQKAs
	A4t4xbeec9daH1MQLgXOy/C/RyR+Ba2Qu9Y9PdHmv63Uom1k0UaqGznFaP5HRF9w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx8441nu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 18:07:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH8w7h3546797;
	Thu, 17 Sep 2026 18:06:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffbpcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 18:06:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HI6wtq24314368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 18:06:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81B3658053;
	Thu, 17 Sep 2026 18:06:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D38CD58043;
	Thu, 17 Sep 2026 18:06:56 +0000 (GMT)
Received: from [9.61.246.38] (unknown [9.61.246.38])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 18:06:56 +0000 (GMT)
Message-ID: <453c7aa7-5354-46d5-89e6-f3bced610bb6@linux.ibm.com>
Date: Thu, 17 Sep 2026 11:06:56 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] s390/pci: Report SCLP status on error events when
 no pdev is associated
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
 <20260916-fix_zpci_report_status_pdev_leak-v3-3-61a2f980e71d@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-3-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1NyBTYWx0ZWRfX65aCPUZz8opw
 Kv7r6d9sIr1539pNvSGd59sAaG5tPUdwTpvUr1JdgGVcciDgeq1UWec1K/dJ9qQOVs0jr6Mydmt
 kOXLEkqg10d6P4kafgzPqUmJx8MYGRQf3ikKthSSut6fRNSoBI5yjbug857cu3tGJGr/bpLUYfU
 NS92bDCIoSb6IK+iqTBU+PHFWXjWMpLYDATSo8UibFMvKntBdoT0W9ohFefhLf3d36gPJvyXz2C
 8Gg4yana7v8JDli+XrD/Y+/hbAOS0Mj8WwxhGhUSy8J7D71lFhvoZcoQkb8d7KZn7ex603pN2jU
 VUvZXKXTzRv09AeTxOj05QRV7EdAaWsX4RAtcx4VlnuqKYNS4/ggjf32bDsBAR8RQXi9GpSI/Ta
 ZYZC9xMQhsK5B8plZx4cR4CyMvyhLIJMtcKIoCtSgXOK22tA66Hfdk5eeygZXwQ7mwmj9m590lQ
 y1bBWLkYG0H4eEmh0eQ==
X-Proofpoint-ORIG-GUID: jqcoZROTyKv3-U1wvL2QdfZc-6rgtgyL
X-Proofpoint-GUID: jqcoZROTyKv3-U1wvL2QdfZc-6rgtgyL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1NyBTYWx0ZWRfXx/0RWt34konN
 MyA4xW888rWf+crqyef85jteHOtvbUyYUs4Y2IdzV0pS2r3YOp2ncWaLemR66nk96pStpiDLQbk
 6+ZvAzUzyJv8t1Bn67DCRLEeGUBP7u4=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aac2c44 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vI2uHBHCT-f5pMl-voMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170257


On 9/16/2026 8:14 AM, Niklas Schnelle wrote:
> With commit 4ec6054e7321 ("s390/pci: Report PCI error recovery results
> via SCLP") SCLP reports are generated when recovery is performed in
> response to an error event. If such an error event arrives but no pdev
> is currently associated with the zdev, e.g. because it was removed or
> not yet probed, no report is generated. Fix this by generating a report
> specific to an error event for a zdev without an associated pdev.
>
> Cc:stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
>   arch/s390/pci/pci_event.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



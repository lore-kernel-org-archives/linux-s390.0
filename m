Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19537475B;
	Tue, 18 Aug 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083249; cv=none; b=HQSnJjZUTOWtDb0O27Nm4RBSJ2PD4zaHtTzrJa5Qt8A/w38LtrtkO258vpC/5pj0WmZSGhkMjUxdU0NOR7KaSklBQXubr2iMUXOurQAgYzas5ZlTuBPcoFfII7N84cKI1aJJziuYuc/HjJTkHvkqGE8rPw+kZTR8wcoy/23yzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083249; c=relaxed/simple;
	bh=tpEYp48UxfqbRCgTng2kOXYen8Nn0pJlZWedCCZAlQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOs6dXYGMMWmNiZNMUFzLcYoOHKG3F5Lg4IYNquD/fgjXxzkk8epjAEI+F8HieiqZUqp+fWyiwBdGWCX3U+N4jyr2XEK4rnRE+mUFYnlR+Xi5Rm4jOt8pmjkoY/ckidATVUhv7qVuvYoagv/eYtTB2UMKjf8ACAWrxddaFhQB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUmeVMu1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUmeVMu1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IJW26c1210895;
	Tue, 18 Aug 2026 20:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q+qnh8
	0w7oS6RYx/Rs4v80gbyePqozQH1iG8XJR8vv0=; b=RUmeVMu19pOke9IFg9g2JJ
	d+f/s/eUcu48RVFqwcEUzlZIhdDHW8D1iPE4MFNpyR4IBeAwMhQ08tBiZjNVGXYc
	XftbPZliHR5qLvX/SAqFrwF6FGkZn221FPQ5tF1RXheW57CV87kMqqWqdjc4gJJW
	3c5rDdiXoc53Vj4Xzi0zebbNsYCcB/YqVgtTslF52RsKjuP6HQ1wEFTGfH5tYpMs
	PFM7k+GJvHbseq8adof5EczYXEJL9DMeij3ulJknUuQo3F0VpxLlIFxtOYQSsbLH
	UabmNQvOfwlbBS1BqrbluzSyZx9+R3lARmWfnBKVLTrPcyMosEYtTEgAhj/AoirQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3tkw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:00:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJuMx8030601;
	Tue, 18 Aug 2026 20:00:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq5c7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:00:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IK0WlS19137176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 20:00:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79FD55805B;
	Tue, 18 Aug 2026 20:00:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C16E58059;
	Tue, 18 Aug 2026 20:00:30 +0000 (GMT)
Received: from [9.61.242.213] (unknown [9.61.242.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 20:00:30 +0000 (GMT)
Message-ID: <1649e578-1395-4986-a82a-10231c820d8a@linux.ibm.com>
Date: Tue, 18 Aug 2026 13:00:29 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nzIkLRkuKYur7Rjj-RhHB90f5GEhlsUx
X-Proofpoint-ORIG-GUID: nzIkLRkuKYur7Rjj-RhHB90f5GEhlsUx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX7C/MJOAHQxc6
 c5j0GQBJ59FJslLs2uAlOtbj+ZbeQoyJSUVhrtq0kb45mMfTsuHRlea+Mhm+ag77Q7XSLpZm2sf
 WYmDf5ph9qVsgGXGL7Q1rToezmMQwVA=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84b9e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jGXHogcpe6aWH39FzsgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX6D6kHqm45UEK
 z8Dl7zX1Nh+ByjFj9SOEF+nwVwyeHLGhM+b9bau3CE3bFjU35bzON1uByhdca6GfxolRSTB7nWg
 ARnkpZsvVPsjWjpYJF4jdS5b62ws5O4gQ1Up/8zcEhNHlYtoMFC1TkzvJD1M+uiy9OOjHQHCAPW
 qVZQ8g0qfWsi6uU7kNENWjwbxZU97KQWasy0Ms+cEExiNwxoBiuxjwG+zm3PT6S3UXBeD36B5a+
 lpURqu/TSxDHLSUnzUQniPPJxNi3mpB84VAJONKOCCQxFKARZpCwAlzVnoSFHLvHS7Ui80SjQPM
 TG5RdXa5K3mqeVSyuJYjO7dd58sp6pbjcBHs8po8u2/sONvfIYfc9GD6Rabp9T33JNQXYSy4HZ9
 k3fnvU1+el9JY/l5JBfdM8NdUB1mlsU1P5a3Cix54FerEWWyLOx8Me4ZNgQ4EVpqo2UpKR+bNlV
 5o5n3GvMUGW4o8/n+eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180143


On 8/18/2026 12:13 PM, Niklas Schnelle wrote:
> When using a 5-level translation table via ZPCI_TABLE_TYPE_RFX
> get_rso_from_iova() returns NULL when the region-first entry is invalid.
> Yet in get_rto_from_iova() the region-second origin rso is not checked
> to be non-NULL before accessing rso[rsx] leading to a NULL pointer
> dereference instead of a NULL return when iova_to_phys() is called on
> a unmapped IOVA. Fix this by adding the missing NULL check.
>
> Cc:stable@vger.kernel.org
> Fixes: 81244074b518 ("iommu/s390: allow larger region tables")
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
>   drivers/iommu/s390-iommu.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



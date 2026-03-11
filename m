Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539429405;
	Wed, 11 Mar 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255120; cv=none; b=R3oddz9Z18Soaepd4/9sUg1WO51nMGBcWtzvsd4n32z4IEhE2nrkdUiNuuuf4tVfpQC56QErwRbQS9p6jtxQ1nL5DNsLWzzaiFyIjaNm+sNhX5QBFLPD3l0AaQErwRc1ix17SYA9gJJTIgnZvyGg2jelINGtsKQD3/7Vf8CRQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255120; c=relaxed/simple;
	bh=PwcZtP0WHqNaz48bDl9VTJD2CVjV/nRLjC3XExO0+tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJN8ndaegOxxYZu4fg/f6JB7WQTX5nYrxdBJ9iPjHIPxChOUkYqCHi9Ree9vOcs5/RA7BUZ5Xv66M7K/FWbiJEKqq2pMknJ9BQ45AkapsLnAvKUlccsCTu29pU9OvVUBcFWXbheThEr9m/z56fK51zVcBMWXfzddNTG52lYK3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p6buk0Lg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p6buk0Lg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BCb2FF1561657;
	Wed, 11 Mar 2026 18:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mq3X7Q
	mX8t2oW3YX9InUVhX62CwI5Y9QBx1rgaG/Q2w=; b=p6buk0LgDtaGb3N8f055vf
	MGdYFqIj9g786wwBzUjEHhMMFYvWQkdyX2ANVl4Az9Pd2vNHGYbrzoZytXyQKqAK
	iyaNOS/NSSqvSjrBYDLIBfYX/vfor0km5U3EqYOzTLCL6qnM5BUDbyRgdtm1ePCS
	QOahQHYFO5k3E+SRqTC2Flo5ydA30OH8cU3RbNzQSTSXPVS1hC3tElyJj2BTKVGN
	zTGKECCHaCUrPtVhPD87drpPBOsvnvFN0KzqNsRkng+0kUzkSHzcI7q1N9UYUXwO
	J3WeebsEMf2h/7oM8naq5+LD4uJSuSh+0F8smFHt6Qx06Et6RaSR05vPxkN3OFzQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmhk2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 18:51:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BG47fn029356;
	Wed, 11 Mar 2026 18:51:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6uubkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 18:51:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BIplgr40501634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 18:51:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA40A5805B;
	Wed, 11 Mar 2026 18:51:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81FFD5805C;
	Wed, 11 Mar 2026 18:51:46 +0000 (GMT)
Received: from [9.61.244.205] (unknown [9.61.244.205])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 18:51:46 +0000 (GMT)
Message-ID: <c3abc18e-ebcc-4233-931d-c8f58ce04d28@linux.ibm.com>
Date: Wed, 11 Mar 2026 11:51:44 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/9] PCI: Add additional checks for flr reset
To: Benjamin Block <bblock@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
        kbusch@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260302203325.3826-1-alifm@linux.ibm.com>
 <20260302203325.3826-5-alifm@linux.ibm.com>
 <20260311152407.GB2161595@p1gen4-pw042f0m>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260311152407.GB2161595@p1gen4-pw042f0m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MLnCtPjEp6005SyXRGfNaqT0tbUxVybK
X-Proofpoint-ORIG-GUID: MLnCtPjEp6005SyXRGfNaqT0tbUxVybK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1NyBTYWx0ZWRfXxOn6pBw+rZtw
 LJ6krFLDpjNzcmm0z6jndOMEKhDatvyEqq8BuHeWZLdD3mx6pGG+IFrBu9o4krb6SCwY765JX8T
 6pP7GNku50i2zDYfucuxO4ZbdCSzeT192GN+P9PVHfSJUATs1af/wwIHRiT80u3pCIXtF4pZVLH
 ZlKqAjFWe266u4MvrX5BdlUifdF8pvite8x0Wu1tVCRjSwa6rIh7ZNSLAfZaRRiDx+rqZWJDbpX
 gNJCpDFS9MjKfuKg12pWydf+CUUiz1rHfEJr6QEE0AnklzhavIL6OaqS4RYRgl4YiwO53NkLpJ0
 0pII6bjtCmzPLQCKGEGgLIaVjUSwPpDYgNWvNijubvaLL3GTMbAgbu4FfEcfdh2k8uYKJnUIPuZ
 BQ9bFmtxtlo8BeW6O9IgdhPoIzsXTBV9QfKglt4Azv+cYbGcGrkfsySHAaNgkubA4h9min/cs4D
 HKYFe7tUAvvJ6TA7cVA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b1b9c6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mE1mmq-WpfiY_7YR16UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110157


On 3/11/2026 8:24 AM, Benjamin Block wrote:
> Hey Farhan,
>
> just noticed a small nitpick:
>
> On Mon, Mar 02, 2026 at 12:33:19PM -0800, Farhan Ali wrote:
>> If a device is in an error state, then any reads of device registers can
>> return error value. Add addtional checks to validate if a device is in an
>                            ^^^^^^^^^
>                            additional?
>
> In case you do an other version roll.

Ah thank for catching that! Will fixup. I do plan on sending a new 
version as there are some changes in pci/next that will conflict with 
some of my changes.

Thanks

Farhan



Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E345D5D0;
	Wed, 12 Aug 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548666; cv=none; b=XMmYcEj2cxFj07jUlCaFpsYRMNWNrrFouiO39pvmr6MazqjetaT8GVf+K2JMvhOtzUwpP0G6fDhDRrZ+9iAX9XF6zdOs3AT1oh+GoHDiXBH8Q+yDNrSVD5BB+ZbKT8qKiuA1EO901KBE/iyxsci5uQOXOciQxEVrQra8gDD+SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548666; c=relaxed/simple;
	bh=TVxbkX+sPB4HzLaXUZbEcn3x49y4oOFBlIe4vZ8RX+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buF6bskN7QJ93amT0xHyW7nQq+L5/Pz5LLWgqsw/Ong6dYG4k8AcK8O8AsQJ9YbVa3Uq8f89KPAkEfLGp1PgIGAVgtZW53yJt1kFvERWeVUObxl3jcEpVrqWJDdyV0+akqg6j4FBK/sCXEq/Vp3Cfg8iHTPyjMDco7Ntr0AfaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lr8Rlc7N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lr8Rlc7N"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1hJP1816625;
	Wed, 12 Aug 2026 15:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uzL9LP
	cjhheg2W7+sVscYEgucggxDjrEbDeRJPhzSzQ=; b=Lr8Rlc7NVTx7q87IS7mrS/
	Z04tM3nC42mNOOFEq7uUe/q+aszVbL4IN+bXzHmKbXnBCHG+o6f/Xtxu2QeV0kLQ
	OA10RLLKqFV+kuwNAdbcyy+MY1UxUwRHLmc3RNWWxQ8BgL/dH6citehV41gazwQL
	5Lh1M5gEQqIPPgBL5mChPZKu3k5SADtBywqnPCEYChkVWb4mIaR1UnWrfsgq1tVi
	mWKzj7ngLUqa2fuP0WBEL/TjCdRKu2FFifZYOCABj7fmg0eEq1J8AuT0YMRoi8MS
	KrDAe0L4EZk++l7SuHh0kw040IvjNPJIjGQYhXh2Kzdi64KXbpoDOehfWCelyPyA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk03706-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:30:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQP6m021756;
	Wed, 12 Aug 2026 15:30:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6f8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:30:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFUlul38732256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:30:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677932004D;
	Wed, 12 Aug 2026 15:30:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAB562004B;
	Wed, 12 Aug 2026 15:30:46 +0000 (GMT)
Received: from [9.111.47.51] (unknown [9.111.47.51])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:30:46 +0000 (GMT)
Message-ID: <14e82371-8e39-4af6-b220-6f0d1bdf25d4@de.ibm.com>
Date: Wed, 12 Aug 2026 17:30:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390/vfio-ap: Fix bugs in vfio_ap device driver
 callback functions
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX9Ui27WPDKeZp
 TLUp2qwz8x9I6aHV27jhszAawb/fG0MAt/fMUUkCKbVRh8WQyHkm+p5K+EiVMsJPJEKdYCTLZDe
 bLycEPNE/trYKanddYaP+YsGX617dZ9Pr2gan4Vp4GYJAJUOPqYYl6DBS8Wg1xGuEvLo7ieDHeI
 L/vyWxDoYmY9MSs7+WREMG+52C6ZnjyNoKBJznoHEE4jboGNqlMf9ZetInY1l8E/MoT+2OiRfRe
 GH/E+UsNQPCcG/aUu3GjIYtMlis4anHE7i/EdJUuQng9GNzqme5TCc0k6NWvDsV18zLOfe42Ypz
 8OnOiLWjJAxUfNaetjZXAafCyPj6zU41Wm64RQ8bGZ06umNmxMf9Tf5k4gzxtePtvsMsYB0cmry
 PdfZQK45sHpJ0MnfPDnR49T5clw32CnBLI6hIH/xinHj8t1sbW+PANtInSHold8czKLr2CPQiEs
 IjegMhylSHoxfQCSdCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX7UWeBTlOuzlN
 BRrm05T26T4mmXiG5DYHcWzB2bs//Cj7tG6V4+NFc20F2UumQX0PQbZldZt/GdrmcuW50uHcjlS
 zQp+2IOGTu7SzbkYQa3YxCGR09pKYm4=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c91ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=JOdzOVN4DxgfuSgIMUAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: k-nxs1ohh1P__QnurkYDMOEGGmgneiLx
X-Proofpoint-ORIG-GUID: k-nxs1ohh1P__QnurkYDMOEGGmgneiLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120122


Am 12.08.26 um 13:51 schrieb Anthony Krowiak:
> During review of patches by the Sashiko AI, several pre-existing bugs were
> discovered. This 9-patch series fixes those bugs
> 
> Change log v2 => v3:
> ~~~~~~~~~~~~~~~~~~~
> Patch 3: Fix use of wrong lock in mdev probe function
> Patch 7: Fix required lock not held during display of sysfs status
> attribute
> * Squashed these two patches into a new patch entitled "Fix missing lock
>    required to access list of ap_matrix_mdev objects"
> * Added two new patches that fix pre-existing bugs:
>    ~ s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>    ~ s390/vfio-ap: Fix memory leak when queue removed from host AP config
> 
> Anthony Krowiak (9):
>    s390/vfio-ap: Fix stale do_remove flag across iterations in
>      vfio_ap_mdev_cfg_remove
>    s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
>      NULL
>    s390/vfio-ap: Fix missing lock required to access list of
>      ap_matrix_mdev objects
>    s390/vfio-ap: Fix required lock not held during update of
>      ap_matrix_mdev object
>    s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>    s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
>    s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain
>      removed
>    s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>    s390/vfio-ap: Fix memory leak when queue removed from host AP config
> 
>   drivers/s390/crypto/vfio_ap_ops.c | 110 ++++++++++++++++++++----------
>   1 file changed, 75 insertions(+), 35 deletions(-)
> 


Sashiko has one new finding for patch8. Everything else is unrelated.
Will you do a respin for this?
I plan to take this for the next merge window.

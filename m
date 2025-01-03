Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19031BD9E5;
	Fri,  3 Jan 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913564; cv=none; b=I+0PS2pQT/gTFUgFU51Lk9Nx7gkhNRW2L8YM2liueX9SJBv1dT/+Zvl/REb2mQzAX0M0LS2FybfVD2Isg0KOeXc0WB7AhDzGWIcbfF346rUnWks6nWs6YY2Xj6T2M9NanEEDVt5ATGLApJw68bIOsAQbifPWlppBpMXBwlRCKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913564; c=relaxed/simple;
	bh=LnUzofE/+glc/F/49WY89reoIqsWGosoWsw7G0OpoPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2sSLBJ2a6g5gydfjtjjtNlCRZnwvSV8vEIo+F3JFxqwCu+rWP3MlDcfGAgYnx2SiNCPHSeK1G+Upwvvl0axFAMev/bW4yIS41UdqLnZ+DWtle5IV8j6X9o38at0O3X5Tsx9XGSi4YrI1x70MW4zqeL1pkCbBtDVLkZO/x8tEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DSVraOnJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DSVraOnJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502NwHos013693;
	Fri, 3 Jan 2025 14:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YE6cpK
	4BNP0XgKDFuPVYzPzA8tB1Hni2uRwUCO6mhC8=; b=DSVraOnJWLLCEgo91Mzncr
	5B8/T/+j8oPgs6EPT95bcg2snmaFqCLI4eGiI3aLnQHEX7kYFZ+9mQfOFjU1nwS4
	HYrye9xMSl08p92Llybl+okpEd/obxpQeWJIrmANVsZ+Fp0p6vdp7zEQHQ8uPWdn
	vwdARO8GUPRJKifglYAcfnjBfL3WYdodLbCraKGxvCYelDDmJRAOKej0vAyIRvHe
	QYCTPTD5FGerN0WgBduzd3lhXxBcfDTYGxAiI5JpA2Z0px31pmvBPf8v4kKifm83
	uRLRF7yWvvOLa2c6GF9x4BIjpd41hZqhNWw8E2QIeEk+RWLkyWYPCarJ5AFoq6SA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43x4xh2nms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:12:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5039g6hQ014584;
	Fri, 3 Jan 2025 14:12:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43tunsxqth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:12:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 503ECYAR54395370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 14:12:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C79292004B;
	Fri,  3 Jan 2025 14:12:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F16912004F;
	Fri,  3 Jan 2025 14:12:33 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jan 2025 14:12:33 +0000 (GMT)
Date: Fri, 3 Jan 2025 15:12:32 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] s390/ipl: Constify 'struct bin_attribute'
Message-ID: <Z3fwUAfxZX9M0zAy@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-2-be01f66bfcf7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-2-be01f66bfcf7@weissschuh.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gBSVeM0XpQWpg5C2snAPFK-vWtjcDwzc
X-Proofpoint-GUID: gBSVeM0XpQWpg5C2snAPFK-vWtjcDwzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxlogscore=479 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030124

On Wed, Dec 11, 2024 at 06:54:40PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  arch/s390/kernel/ipl.c | 142 ++++++++++++++++++++++++-------------------------
>  1 file changed, 71 insertions(+), 71 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

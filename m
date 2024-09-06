Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8181745;
	Fri,  6 Sep 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619552; cv=none; b=uIPBgQk+HUfrbfo4s+DGLgrdTmKKqMqGpPL2whEt23eF8PxnKxuDQ/JcpLMigy+cQoMnWeQSObU5lrvzwfieu2h5cOoqAxnwWVDW9JLv0Pczqis27nsKTK9JIqjTW6uFtpEMWfTzprtOL6XXycyhFIKmA4cs3+8w2Nri1BBJlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619552; c=relaxed/simple;
	bh=J5IbnXsl3zAcetvo/WgRtJuA9QV8d8317nSQFOr+alA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDC8Yeur6KgO3cl6UXFIfNXPyKbqXtcMvoLSqiyHtTPnMmXkaUyXNB6CIIH/XVsLhY8/IpduZoKGnAFyM4/rrwDTUxw0My3gIuBAgnQLw9Ok4TNFgnpA2Wur9vjq0M/7CFZvP7PbRBnjtWhftrt8qNQGdGE3pa2194eWOBH1sXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmJ81Heu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmJ81Heu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48675RAi029038;
	Fri, 6 Sep 2024 10:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=pWBWjrkysi2l5BVPBSJcfU9xbay
	JrDCXg9/bSvW3Fqg=; b=rmJ81HeuuCjLa4Lm/99nWSossjDtWCb7djCZM6Mttv6
	N3XwaLHmK9hYu3ZDnI6xgYu6zo/w3XfZXxvod/T/5h2u6F+OEd3pbjCJTi7xhGct
	d1Y1PNryEOkhayuc5ahrTG+7xy/C+MWNdTTTjQgzMvHUFSYDO38cxrCTWxMSwu8G
	GGubZR2MEbLUvpL6Y+JVZvadK7sYv99B2uZNKCQLA2VTghm8sPm7KKnrSwnOgaZo
	Q/y4+87PemmUfEr6+sOLj+9UjMLyu37B8QkBC2eW5hKfMtHXJIAAgpG/YE/+0b/D
	sGQTvkDCIxU7R5ZVeaG3bHES2n4AJz/htAaE8pVkIIw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj1m3m18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 10:45:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 486AfCZ3014216;
	Fri, 6 Sep 2024 10:45:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41fmf2tp4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 10:45:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 486Ajg4a47120694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Sep 2024 10:45:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B07AA2004D;
	Fri,  6 Sep 2024 10:45:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B76A20040;
	Fri,  6 Sep 2024 10:45:42 +0000 (GMT)
Received: from osiris (unknown [9.171.9.1])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Sep 2024 10:45:42 +0000 (GMT)
Date: Fri, 6 Sep 2024 12:45:40 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: Driver feature advertisement
Message-ID: <20240906104540.9510-F-hca@linux.ibm.com>
References: <20240905124351.14594-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905124351.14594-1-jjherne@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8eqfousuizJUbXnuSjbdpQ7phTPQmhi6
X-Proofpoint-ORIG-GUID: 8eqfousuizJUbXnuSjbdpQ7phTPQmhi6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=588
 priorityscore=1501 clxscore=1011 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409060076

On Thu, Sep 05, 2024 at 08:43:51AM -0400, Jason J. Herne wrote:
> Advertise features of the driver for the benefit of automated tooling
> like Libvirt and mdevctl.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>  Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
>  2 files changed, 47 insertions(+)

Via which tree should this go upstream?

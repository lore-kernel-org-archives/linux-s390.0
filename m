Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD714D2BD;
	Fri,  3 Jan 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913688; cv=none; b=Ezuel2mTA9zZN8xJ0f+X7Y3gF7guZxLB345x9a2CbDYsWFMo7Wir31rf6/2UR6DWV1FjZzVqt0kNgqi+2N4Rc2gA1AIjlRaqxVcZx+dmym7UcG8fVveKrw4HM3RdKPHrwL7OyIUJrHpVszOooKdjZm9dAzOhq2gnuqgUuZpIwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913688; c=relaxed/simple;
	bh=wBnKl2jNHmUGhYoDSGYQl09kER4WE49IDRLvXCrTz6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5yZR3jnWLk/NehxDCWnf8F9j++Ktndg+yYX9w9N8cLy0VVQjYsT7/1pqG9IU9oJI4ae5mwP+r7SFLB6iVGfniAbFTrdKsPuRjTPj0RVmK3DbxW5UXn+k6i81ZO52XnqtrJXB2TJrX/MMgAPnnzAeA8Bba9EfZBsDu2poQ1yufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mcucpe+2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mcucpe+2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502NaBIN024521;
	Fri, 3 Jan 2025 14:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fwgrKd
	e4DMN16OFc/OedqwlMj48jiykEof8uvJHxB9g=; b=Mcucpe+2bBnLUJomNrWYEu
	N4jSXhYZLhfx2cVa+H8vMr9e9IGs7P7vqbU231VlN8Q7dFILi2gJaYCCmo28/ewX
	7uNnOufTu5eh/C8w+mtnH5qiYswKDmD7RxCVDy8buEuztkIUfh22OXQxalHgnboi
	YPUs8IH6HHdJH458C+HATZSUH17gxCmjSFLqXyY+5tYP+u6rsbPYQub0WbMu/qE6
	B3dolHk+/Q9jyUbZNOOqGFYIJAnScXBvHjvjDdb6mfntz6cmHljYYn6sH+jwYRlg
	ri261RhAt4WMN31FfadRtgkgKC90p90wODMrYPfH8arC2yoxuJgZoJfgJuLYxbDg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43x4maaj20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:14:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503BGL5a016763;
	Fri, 3 Jan 2025 14:14:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tw5kpfrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:14:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 503EEfjH64553216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 14:14:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 708E52004D;
	Fri,  3 Jan 2025 14:14:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF62D2004B;
	Fri,  3 Jan 2025 14:14:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jan 2025 14:14:40 +0000 (GMT)
Date: Fri, 3 Jan 2025 15:14:39 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Niklas Schnelle <schnelle@linux.ibm.com>
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
Subject: Re: [PATCH 3/5] s390/pci: Constify 'struct bin_attribute'
Message-ID: <Z3fwzyYcXG6S4TgE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-3-be01f66bfcf7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-3-be01f66bfcf7@weissschuh.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GVYGXSU4xzTNkrJFqM0i-hSU5i7taOah
X-Proofpoint-ORIG-GUID: GVYGXSU4xzTNkrJFqM0i-hSU5i7taOah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=534
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030124

On Wed, Dec 11, 2024 at 06:54:41PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  arch/s390/pci/pci_sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB2199FAB;
	Tue, 28 Jan 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738072611; cv=none; b=op3/fFp1q5YkRueKZxmMNtYyt7Al0HIC7IOn2Hjul/paJ9+zfdRJbNLkipIy3KIpmt1+75ABgahhXEN5NMR3kFEcJq4BLTzbZYaTggP+pfbqqcdN41iI2t2teaOTbwfQXI6kNsxQ25z52S0/0KH/PZcb46MXZ2HDmM806qc9T/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738072611; c=relaxed/simple;
	bh=0Psdc0X6HSTyYPpwGvfGQy93sgANDoxb4M7yMIZrlV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNUDwrK4rHnL8oAWHru6rv6WcSX8hGnVQxQkPFqr5PLdCbIyGlIWgEqTkoVVWanjPR/nhBPyvw93GpOWnnoKRfyq4qxXIL1P+nexI9B5H5nPPGu70LcnHlcuU/TrjWFKJDSBGFF4gHPLsjvEhLkO1Kz9dcz7qsngu+U+WXTy1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hl5SHcTS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hl5SHcTS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SAw3Lg018740;
	Tue, 28 Jan 2025 13:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ftt86SRZrpGFXT1q8Trgh8dS5i1TpH
	U0oqWDg7R1gmw=; b=hl5SHcTSY90yejSG64hh4YNo83JwaQydVL7MRmmy3hioMT
	qFfkiw1vKwpsU+iQM1kC4PDGfr/+GWE0ZHNoxkPFwEzvhqnXc5gBOuQ74cwVqA5c
	qwsaxf86hfbHAkAzyJow49TpvL0c1HrkGXZy1xTRYgDT1+sujAKQ+6JQej5DDOFG
	4Y1FzzKApVHQv/qk8T73yOztUtATemN4s8WVP9FbNdpCWhm0SH1nGVnnul7pCWlG
	wf3wiCRk3wBD1upP3NuMLGknrDtfeQBwCAE9r1+Mfht6x4CPPA6RBZTv5CIvt10o
	7jmMe1HC1jM1M7bFyhlobWHlxQORncHDcLC9INbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecytd2bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:56:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDbwWI019210;
	Tue, 28 Jan 2025 13:56:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9muh43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:56:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SDud0934472230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 13:56:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F16F920149;
	Tue, 28 Jan 2025 13:56:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADF342012F;
	Tue, 28 Jan 2025 13:56:38 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jan 2025 13:56:38 +0000 (GMT)
Date: Tue, 28 Jan 2025 14:56:37 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
Message-ID: <Z5jiFcbylhWSs5gq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116131859.105756-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4jDw1tI4C23gwd6acMk_53izjFN-Q6Ek
X-Proofpoint-ORIG-GUID: 4jDw1tI4C23gwd6acMk_53izjFN-Q6Ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=759 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280101

On Thu, Jan 16, 2025 at 02:18:59PM +0100, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct ap_matrix_dev.
> 
> Use struct_size() to calculate the number of bytes to allocate for
> matrix_dev with a single mdev_type.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 2 +-
>  drivers/s390/crypto/vfio_ap_private.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Hi Tony, Halil, Jason,

Could you please take a look?

Thanks!

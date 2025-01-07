Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFC1DE894;
	Tue,  7 Jan 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241508; cv=none; b=cni0xI1QFQjKvVbfBHbti3m/FJ1iE1K3WY8yPxt/YdY64BRQMxrJTehVDIvEprMo4D5cSkBIQbrldHFT+PiltVt9OZHjXwmdd4+IQAn75n2k2orHQC9RNvDXRQ7ImOYRlT0NhQ+N70v3EZIGXRIuBL+pA/BozLfAXx76eZNR07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241508; c=relaxed/simple;
	bh=hZ6ba8pk2p4WBzSKvsSlYkilxlMNOpzWDK/U3wxiJ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtbl0t3wtBWKiMCXMz0MUsoM7zXwZgy1Xl5ZlRd942HCqj0AWnyFPXB5sNvb+9/veuYIjwKnWYdvd646HHLxBoWjmGFRpWr7777i5QpSc+YUNccYfBe57XtpD1CIlLfWCDhz9AADLasVIfy7F3KoG1CsbWElzwSTABv10ZsVQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h4HvMYgQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h4HvMYgQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5073qnVb027181;
	Tue, 7 Jan 2025 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4lyxOp
	YQ75JT8OEE6xhCKFu1Jxqew0usX55cT6Vu01I=; b=h4HvMYgQT9OEoy6D8oo4GH
	2pweNMwDZBoyXfGifZ9NmogxHcLzkC9WSJxRbWwFhGcR+o2ODlWVPTpHmTXPQybj
	l7TByxMbr8JguZD71WKv7kNglYqbxyOB7LQOBApW0e4zBABVBhd3AH0dSioKp/8O
	7sluVD//3rt+Yff5/J6SdG160HgXj3S79Sz64w49xxaRwvnowuHclFGB88ben6l7
	mLJ9ln/tcqulS1p4aHk1BYfKFbe7sMCGuCPRWcpg82Sr4F00FmRlAXVLYmLX0f6m
	N0HKNw9TRO0W+BgjHKs5YSke1mKtadidqlaj9VO/UOKcDXg0XWU5a3ldn8UPXb2w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrj98q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:18:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50760OX3026176;
	Tue, 7 Jan 2025 09:18:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj121f59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:18:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5079IJXK53412196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 09:18:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7384220043;
	Tue,  7 Jan 2025 09:18:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B98B20040;
	Tue,  7 Jan 2025 09:18:18 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.22.234])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jan 2025 09:18:18 +0000 (GMT)
Date: Tue, 7 Jan 2025 10:18:16 +0100
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
Subject: Re: [PATCH 0/5] s390: Constify 'struct bin_attribute'
Message-ID: <Z3zxWMI+t1D7rVfJ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OT1Pn_LVjMPgFbLeCym2SmHlw1D0N7w_
X-Proofpoint-ORIG-GUID: OT1Pn_LVjMPgFbLeCym2SmHlw1D0N7w_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=735 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070075

On Wed, Dec 11, 2024 at 06:54:38PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> drivers/s390/cio/chp.c is handled in [0].
> 
> [0] https://lore.kernel.org/lkml/20241205-sysfs-const-bin_attr-groups_macro-v1-1-ac5e855031e8@weissschuh.net/
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Thomas Weiﬂschuh (5):
>       s390/crypto/cpacf: Constify 'struct bin_attribute'
>       s390/ipl: Constify 'struct bin_attribute'
>       s390/pci: Constify 'struct bin_attribute'
>       s390/sclp: Constify 'struct bin_attribute'
>       s390/pkey: Constify 'struct bin_attribute'
> 
>  arch/s390/kernel/cpacf.c         |  36 +++++-----
>  arch/s390/kernel/ipl.c           | 142 +++++++++++++++++++--------------------
>  arch/s390/pci/pci_sysfs.c        |  12 ++--
>  drivers/s390/char/sclp_config.c  |   4 +-
>  drivers/s390/char/sclp_sd.c      |   4 +-
>  drivers/s390/crypto/pkey_sysfs.c | 128 +++++++++++++++++------------------
>  6 files changed, 163 insertions(+), 163 deletions(-)
> ---
> base-commit: f92f4749861b06fed908d336b4dee1326003291b
> change-id: 20241211-sysfs-const-bin_attr-s390-f8949a9e39cb
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>

Applied, thanks!

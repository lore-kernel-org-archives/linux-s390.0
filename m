Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CBC147;
	Thu, 17 Oct 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158381; cv=none; b=LxJtw7GPG7xm3fyJEGeu6Mc0j0eJ+5lHjE+UBXFyNrjn3uM3vz6LxIcfT/XbNcRvH9ziv7wQfhHmdU7RalFCN6SPfendclIaplaj0ixIUE5qRqxx4TvzvCQ/SyiLqer04/eK0AVjbpIOtxg/ANEE7A0hX2pgve/LogOvY9dca9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158381; c=relaxed/simple;
	bh=wAu4lUH2ZdAEXqz/CGQi+vr7whbypoaU3diiPTqlLEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSMrfEXJNLiOthNCGg7tz4wvyB9gxrBnF4NQM3fvFwheaFTPJrdystB/IOHQiWttWLLXFTNvPP0GKU8ax7cymuH8SGQnqajE6KqXfFJneWphW7im4vxEynM+UNTh3WZwEKcUJJQ8ilBqg+htFCqzAN9buwzQfr2c3vyLRZrGRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=puWc0Sfe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="puWc0Sfe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GLRH8V000899;
	Thu, 17 Oct 2024 09:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ba5YfAfV1i1Kts3hR/V69uV8ukSuTw
	UlftkXc9gcqO4=; b=puWc0SfeklF1O5Ue+nuQRWg7XXTuGEfhpxsJJ4EgzgUrXw
	shXS5A1uYl9WelR/IEplKkTifUrc2QGBmHKVai5khjg+RpR2i3PCDkTeXAMewO5h
	CuGwyG5IZ9zohzZSMbKAtgCBPC4vpfRcymPrJxcCFzPl4kzligLyATqlW4EyTIov
	uC4zfuj0c0OLJUVoyvHXqwkEr1si7vAyf0H89N4pGaX4pEC3nABCJriO5DCAXWAG
	vScLsq//Ad5/D4xPttlQb3FfaCZOuBA1iUQklD3mu1CG1ZT7p5j/A2I9ZnF3TiHr
	FmjZo8lAbq4kpCr1Ua6QD/eqMrutns+sr10gWm0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42and7jj3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 09:46:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H9kDHc010398;
	Thu, 17 Oct 2024 09:46:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42and7jj3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 09:46:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8xSmG027444;
	Thu, 17 Oct 2024 09:46:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txx4pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 09:46:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49H9k8Kf30933714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:46:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22BDC20043;
	Thu, 17 Oct 2024 09:46:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFB6320040;
	Thu, 17 Oct 2024 09:46:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 09:46:07 +0000 (GMT)
Date: Thu, 17 Oct 2024 11:46:06 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PtP driver for s390 clocks
Message-ID: <20241017094606.6757-A-hca@linux.ibm.com>
References: <20241017060749.3893793-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017060749.3893793-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9v15hzj-vzCxdfm87l2gIIuW1M6_icYy
X-Proofpoint-ORIG-GUID: 5LTXIhDXDiPeVgwLIpNUxVmAgMHpL_En
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=620 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410170064

On Thu, Oct 17, 2024 at 08:07:47AM +0200, Sven Schnelle wrote:
> Hi,
> 
> these patches add support for using the s390 physical and TOD clock as ptp
> clock. To do so, the first patch adds a clock id to the s390 TOD clock,
> while the second patch adds the PtP driver itself.
...
>  MAINTAINERS                     |   6 ++
>  arch/s390/include/asm/stp.h     |   1 +
>  arch/s390/include/asm/timex.h   |   6 ++
>  arch/s390/kernel/time.c         |   7 ++
>  drivers/ptp/Kconfig             |  11 +++
>  drivers/ptp/Makefile            |   1 +
>  drivers/ptp/ptp_s390.c          | 129 ++++++++++++++++++++++++++++++++
>  include/linux/clocksource_ids.h |   1 +
>  8 files changed, 162 insertions(+)
>  create mode 100644 drivers/ptp/ptp_s390.c

As far as I am concerned:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

Richard, if this looks good for you too, how should this go upstream?
We could carry this via the s390 tree, if you want.

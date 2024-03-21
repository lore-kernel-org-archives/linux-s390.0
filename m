Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AF883C
	for <linux-s390@vger.kernel.org>; Thu, 21 Mar 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003522; cv=none; b=VYkbLowXW3s51dzpihX8xpqjzb3D1AwGvJXdlo0kHiidzuOwYybSi5Me2DDf+xxF+H6ZRY5IUE8yUn15vfkjiM/nvxkY/Edvi4p3VQPvq2i4b23o+xCrWwLkzoYbBTctKt+RV14TSDYYKywO1viquekiTV5rfFUCp5K3E/CQhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003522; c=relaxed/simple;
	bh=2w7fpKn9wrhWt/zgHloQFQ3iM8ITpAf6qcsift0QVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnI+3gJHa9Fz1jLxN4QI/YFmBTQrQGTtmFnxZXaRG0htAHN9GRW/rRUIVbxCx1xMio8XDszYYF8qxpbDy3hTVRotniU5rPR4mvGIWMTr/IMcaT3StJMXXVgBWFQcN7WSZN0AoAkK+hrkgLwwyDZ6JDyn/Y9jqkZbEAIpJLnrtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hMxvLHn5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hMxvLHn5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L58Nqh002501;
	Thu, 21 Mar 2024 06:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=H+iS8CTfvv9wqtT0MR+kMVmGAmbkE4hNBrux1UFuaiQ=;
 b=hMxvLHn5mAYL1eSl2F4uL/pgLwGGenv8+q/EV20NcjGl9ys0t8jjmFntDJ/QUGJ+IbsW
 U7GiA11KkFAQOe9i5+r5qa9OvZKkoF5v1oYTt0WMAH+7jsRcZMvKfLQqlBwcuAVz7Jde
 M4UphYx5PjFhnjEtKWoRALr5sYdWwsmpQFI+9Vmo2b11fBG43Z2b8vrVl4TOHJX/o2ud
 XoRRUjg0auYxaL3rZ9RIQs4Y5nTQH3ORF4LmUxfflIYBPe/iypM1be9hXRsjh4ycRKnv
 kYgX2Ih6Suazpcr9H5hxArPRiYl6IegOCNlj3WTmbhBDkukMfVVkaD2nNyZjrIz6pHQJ Bw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0e9106c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 06:45:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L65Ja2015801;
	Thu, 21 Mar 2024 06:45:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50bgvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 06:45:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L6j8Se40370474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 06:45:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4735520040;
	Thu, 21 Mar 2024 06:45:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D562004D;
	Thu, 21 Mar 2024 06:45:08 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Mar 2024 06:45:08 +0000 (GMT)
Date: Thu, 21 Mar 2024 07:45:05 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390/preempt: mark all functions __always_inline
Message-ID: <20240321064505.8101-A-hca@linux.ibm.com>
References: <20240320230007.4782-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320230007.4782-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xMhg60rrmxVyDhS59iUyATzgRT-3y7Sg
X-Proofpoint-ORIG-GUID: xMhg60rrmxVyDhS59iUyATzgRT-3y7Sg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=390 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210043

On Wed, Mar 20, 2024 at 11:47:47PM +0100, Ilya Leoshkevich wrote:
> Hi,
> 
> This series marks all functions in asm/atomic_ops.h, asm/atomic.h and
> asm/preempt.h __always_inline, and is based on the discussion with Mark
> [1]. It's one of the changes required to unbreak the work-in-progress
> KMSAN support on s390x after commit 5ec8e8ea8b77 ("mm/sparsemem: fix
> race in accessing memory_section->usage"). But it also makes sense on
> its own, and may prevent issues with the other sanitizers in the
> future.
...
> Ilya Leoshkevich (2):
>   s390/atomic: mark all functions __always_inline
>   s390/preempt: mark all functions __always_inline
> 
>  arch/s390/include/asm/atomic.h     | 44 +++++++++++++++---------------
>  arch/s390/include/asm/atomic_ops.h | 22 +++++++--------
>  arch/s390/include/asm/preempt.h    | 36 ++++++++++++------------
>  3 files changed, 51 insertions(+), 51 deletions(-)

Applied, thanks!

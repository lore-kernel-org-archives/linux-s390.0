Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217B130E29
	for <linux-s390@vger.kernel.org>; Fri, 16 Feb 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103406; cv=none; b=hbqFL5VnQfdCQi4psDXm6FqaSLPZdP08r2ySd1Wlsg9lBsiwFoWnyRQnO9NjtzgLJdfUTgonVjxP9Lt7PX6HnVKmhalovcl6DdUmHQyoSBf967j5zVMTsYJufNymrr+2k6ObvFFK2WkXxFQHyow12V8gZ44GLGx3AzRmGmIf1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103406; c=relaxed/simple;
	bh=CErY7fIJM6YUtOpb2jFFtVYOzGU9SRZLIeP5AWzSBpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=okw3HwSaoI5KeOFlc63Xsb/gy0F5GTfPxkaW95T31O3ymY2DxJnFEFhZRBKzHUYeUy2a1eXyPYhj6x02FtbKXjcge7rJMqpollG3Al1Ecvg8djFK8OyVYObl1FJZF4kRDUNY/TE0Xtqc+9k1af34VONEB2Ke5Le4cbO3kTg/+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YSz4DXbs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YSz4DXbs"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GFrfLB006981;
	Fri, 16 Feb 2024 17:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=SdHIbU4N/6n38Hnyh3fi+HnWCAxBgDueG8t/ZcIKe30=;
 b=YSz4DXbsEqGed6SkYOoSyntsyvmcqvyqFYhyn6DPJhB3zR6Y0kwPHKikiXnNscLXZilf
 InCo9UfsbPaxvc0PEQF4ycYWmkswPOyZB8MuHhUmp5fULMzbaqa17jfpmQgSj3M+GKBu
 RJd7g/CIHQBV2ZVYl73Iy7pDTQ4BbBpqdF/Km09b50i3NsP1O8bUo6kYGpOqY8p4s1pr
 YTNfdJfrSoJfIbzDGzhAXWnHnVgfimp/bbz2H9OMmTxc5Z55R1ttRdIWToYTkb7PRfvV
 ucGsTIi1NfW0bKUJJve3cjq/zIgUhmD7IoqN/w2ZyW7AdmZuV266qeB3Lhl03Uzbw7qu mg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waar69tx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 17:09:55 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GGNFIL001307;
	Fri, 16 Feb 2024 17:09:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waar69twq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 17:09:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GFOQ2F004329;
	Fri, 16 Feb 2024 17:09:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0vu8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 17:09:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GH9ngL63373700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 17:09:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10BAD2004F;
	Fri, 16 Feb 2024 17:09:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0492004B;
	Fri, 16 Feb 2024 17:09:48 +0000 (GMT)
Received: from osiris (unknown [9.171.20.191])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 17:09:48 +0000 (GMT)
Date: Fri, 16 Feb 2024 18:09:47 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH 0/4] s390: compile relocatable kernel with/without fPIE
Message-ID: <20240216170947.8060-D-hca@linux.ibm.com>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213104707.673053-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a4Y0yuXOmk1StzQJOIOIkGqi2Gc8e5hF
X-Proofpoint-ORIG-GUID: NilyVB1aIkel4DD7FWWqrE8k4vP_VYh-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=713 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402160137

Hi Sumanth,

...

> Josh Poimboeuf (2):
>   s390: Add relocs tool
>   s390: Compile relocatable kernel without -fPIE
> 
> Sumanth Korikkar (2):
>   s390/vdso64: filter out munaligned-symbols flag for vdso
>   s390/kernel: vmlinux.lds.S: handle orphan .rela sections
> 
>  arch/s390/Kconfig                    |  15 +-
>  arch/s390/Makefile                   |   8 +-
>  arch/s390/boot/.gitignore            |   1 +
>  arch/s390/boot/Makefile              |  14 +-
>  arch/s390/boot/boot.h                |   6 +
>  arch/s390/boot/startup.c             |  80 +++++-
>  arch/s390/boot/vmlinux.lds.S         |  18 ++
>  arch/s390/include/asm/physmem_info.h |   1 +
>  arch/s390/kernel/vdso64/Makefile     |   1 +
>  arch/s390/kernel/vmlinux.lds.S       |  15 ++
>  arch/s390/tools/.gitignore           |   1 +
>  arch/s390/tools/Makefile             |   5 +
>  arch/s390/tools/relocs.c             | 390 +++++++++++++++++++++++++++
>  13 files changed, 542 insertions(+), 13 deletions(-)
>  create mode 100644 arch/s390/tools/relocs.c

Could you please resend and base this series on the 'features' branch
of the s390 tree:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=features

Please also add your Sign-off to all patches.

Thanks a lot!

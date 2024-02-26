Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3F12CD86;
	Mon, 26 Feb 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965657; cv=none; b=HhzIT+4LGyUplVPvpXGnbEzJjstSGMVkBrX0sfI5JpHljmykbjDUfZK3gXvMvTlyqPvp5o+9KemjbWqfVzCr/kIEyRcgr6OSImpyhjfeEWaHH1oiEsWqYMDBHnSDHKiHG/ciGAoAoAC1SlW8zL2zlHdS+faecEcRvFvWUuPlKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965657; c=relaxed/simple;
	bh=NhJS1d58cagQSyhvpckhN9WZoEHeLpN0eEhpNUPwLCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRyaGt72hNXwlB4cDL+Ct9GYhS838h6ipdThEiChzPD2La8DehtPCvT8uWES787jRW9J7hBZF+jgGWMdY/OX5J50zL0YNmQgZczKeq7PojTwGz2WyhEKi0kqGaJ0iGz2WWHtTh944Va6HBA1qAGt/TlrQU1VDPVrHXlcuxpHk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nYb7tKvc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nYb7tKvc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGSJfI015093;
	Mon, 26 Feb 2024 16:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+X9bPE0gncwXQWw8LxqbvfbFI/mdodtz1i9EZTUOWKU=;
 b=nYb7tKvcb/bNJBfuLqw+evszO/ps52sqQ7Pz5RCl+A7Q8rz7HeBHipk9SklaIze7ap2R
 jOpKWyFgpvoOLSlcuqb60OZvVui5vcO+NuRRYOHsIWxT2Au4TwVdYHoPdA5LLzmfmgyp
 gLs1wR4m4JWV9qH0QMjAGCsEa/0WVvtgSyNu+S92gnyy67Ws+A/S2QArGuwQ1OYBMADA
 1qJamiGF3hg5MSHW8VKgpA6lG/ADz78BEoGC6pCldpGnt5dmLT4SCbbKf9d9exqrq1Iw
 20eMOeCn688gN3d2JWcc/8xUvoshV9lW1ScHnAMb8kMAI1yS/MM3TMVfENxuQ6hV/IMC Jg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgx6g8dx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:40:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGRM3J021756;
	Mon, 26 Feb 2024 16:40:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu5ythsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:40:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QGelM949807866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 16:40:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFCD558061;
	Mon, 26 Feb 2024 16:40:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A14D58070;
	Mon, 26 Feb 2024 16:40:46 +0000 (GMT)
Received: from [9.171.88.168] (unknown [9.171.88.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 16:40:46 +0000 (GMT)
Message-ID: <9d222f24-ab6c-4eab-a999-808bf5909b9b@linux.ibm.com>
Date: Mon, 26 Feb 2024 17:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: convert dasd to the atomic queue limits update API
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20240221125438.3609762-1-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240221125438.3609762-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IShq5lJW6joX1Lf-RkwCaUw4B-LhoOGZ
X-Proofpoint-ORIG-GUID: IShq5lJW6joX1Lf-RkwCaUw4B-LhoOGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=970
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260126

Am 21.02.24 um 13:54 schrieb Christoph Hellwig:
> Hi dasd maintainers,
>
> this series against the block/for-6.9 tree converts dasd to the new atomic
> queue limits update API.  It is compile tested only as I don't have any
> s390 hardware.
>
> Diffstat:
>   dasd.c       |   74 ++++++++++++++++++++++++++++++++++++-----------------------
>   dasd_diag.c  |   22 ++---------------
>   dasd_eckd.c  |   29 ++++-------------------
>   dasd_fba.c   |   33 +++-----------------------
>   dasd_genhd.c |   13 +++++++++-
>   dasd_int.h   |    6 +---
>   6 files changed, 73 insertions(+), 104 deletions(-)

Thanks for addressing this.
I corrected one thing in patch 2 and let it run through some basic 
testing over the weekend.
Worked as expected. Please see comments for patch 2.

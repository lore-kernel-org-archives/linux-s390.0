Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2B13473D;
	Wed,  6 Mar 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736754; cv=none; b=u3ExKoVmF5WFmsnmstDG2Zfj84BVhKOR0Wb9lOoo5pH6Vsautuh372fEpSYnX3tWaKV/taAufx1OgiDpHjZOjqoZIs69ZtedsnfHb/SR74uCMMLNC0l4AcSw61cHmusopPNGOHQEs6Fb9ivk9EkWG25GE2VT1mjflXuDwFdvnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736754; c=relaxed/simple;
	bh=DwpdH3GUNLqgbjF87Hp9o/MPLsfQtHFGmNGZjVSj3Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBB/lVOZ5PRlkLS1MXzf4rlGYa7nUxlrikScpgzOlS4rLFGRhIdkmIuBlXdqVhm+o0NGaslVEduDSA/zd8BTZZ/+F4pxBwzb8AjEGgUUsCEHyUAGYj8aO3ISPg5FJ1ssQVEPQLqwyItg4mth36QG/2NhiFYAyN5wzkq/K6+my3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hrB3Orvd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hrB3Orvd"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426ElDSJ010999;
	Wed, 6 Mar 2024 14:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DwpdH3GUNLqgbjF87Hp9o/MPLsfQtHFGmNGZjVSj3Cg=;
 b=hrB3OrvdTjKNKLXOztVvguPwo+waZHMi8ovNeHfZ65L7QZWbVSiAs6vgeNHMDV8IlD7I
 DGkPHPeU4j+0X/2iCHunMY88nOe7tRhi34wQTf4DHJAplDTOucl0tkv+qKyXC+iYmGU7
 FOekOTRRGJQFOU5weEqS8ASW5Dak1IuYE8VZgevC7V55L3lpHHGrQvZK4BSJhPv5qHIK
 fCBAkBQrm7lz/P2A+HpWGX5uDn0f2da5jbhDAMEnOMhgQWbIZwe3heREHP3RoZJAptpA
 MBeCWwL3jVxA7hqMB4wmIAuVwuDGv/0z9WHywAqcnNXxYuGNADNaKhzwSPG3obHH0nsR 3g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wptj806wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:52:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426Cd548006051;
	Wed, 6 Mar 2024 14:52:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeet7hyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:52:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426EqNi914745966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:52:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 809F258060;
	Wed,  6 Mar 2024 14:52:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AF8A5806C;
	Wed,  6 Mar 2024 14:52:22 +0000 (GMT)
Received: from [9.152.212.230] (unknown [9.152.212.230])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:52:22 +0000 (GMT)
Message-ID: <ad1bb116-59e9-4c8d-ae1e-613cb0b8ee2c@linux.ibm.com>
Date: Wed, 6 Mar 2024 15:52:21 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dasd: move queue setup to common code
To: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20240228133742.806274-1-hch@lst.de>
 <20240228133742.806274-3-hch@lst.de>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240228133742.806274-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qn-SO5VVXKM0Kn8MzGBpzPkvBKJIlAU4
X-Proofpoint-GUID: Qn-SO5VVXKM0Kn8MzGBpzPkvBKJIlAU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=799 mlxscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060119

Am 28.02.24 um 14:37 schrieb Christoph Hellwig:
> Most of the code in setup_blk_queue is shared between all disciplines.
> Move it to common code and leave a method to query the maximum number
> of transferable blocks, and a flag to indicate discard support.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

looks good to me, also did some basic testing.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>


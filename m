Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E53A9013;
	Sun, 20 Sep 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921352; cv=none; b=UEhTCJpGOtoFM3juBAe0woVrGMokeSqmtuoY0BZhAizo6kWOjJfNiQNq2CNBDDrPTNlTQEjl7DL3pUe7Px704WxjSjBxFvYj531hFipSuzJj4m7PWUal8AXiMgIpLE9GIh6aKDEaf0pvhbk8pQAZFP9f9CUNABw24yHd8MjFc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921352; c=relaxed/simple;
	bh=J7YeMBK5bMRUKKMH2OIYRfGWuTkesPMKyFxf7sl5YsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1yFV6KYECcfnPCFeDBgEAws3pXU1OZ7A5WofzB/iJvXiW+H+HJhxDIpf+96cDCRYueNEu5utgEF6DMHsxvnvnE8wDkHKWOXI0lkoAntYehSKc74UpQid2e9J9tAsfYOvjAZvadE8yC0bMFe1/Kmqntj7lPYSlGrl1Pio3AFNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EoVyfqd3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EoVyfqd3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFbs9E3078636;
	Sun, 20 Sep 2026 16:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=H9DkwSl0Mm5JTOKGFEhoRcTKAL8BXj
	mZYD6xSS26jcQ=; b=EoVyfqd33XolmUCBLTtt6mALfMZaQpFuGrWfMPtbXUiT+2
	axgXlHYCfWkwwoz8gp8ukx2b5Y6oOToVEom9Co7fB0lALalJFSl3+o7rEhjV0eWg
	DdzbQvFK1VrcZ2gyvudrBRMuPB2uUC218wFuEpeYcY+/Fvxao47xv32Xb5EtQLx8
	D7Fikk2R2RAwtOVke/6o9b14fnzWNeufgzZsKFlESoG2AwdB5m3T7wNMHYv2Yy5U
	0fz/F7UwTei/4yVzPZU3UY41EDdwy7ltAL2/5GYZNu6ajSlFvuRpvOMHsBJtCrMM
	LhkC24lpJrtPBddEclqWuzfu5zCitIkYiTaWUI+w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduvw0f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 16:22:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFHcZW4072899;
	Sun, 20 Sep 2026 16:22:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67ghytj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 16:22:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68KGMIaI29098468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Sep 2026 16:22:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7288220043;
	Sun, 20 Sep 2026 16:22:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15FB420040;
	Sun, 20 Sep 2026 16:22:18 +0000 (GMT)
Received: from osiris (unknown [9.87.137.215])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 20 Sep 2026 16:22:18 +0000 (GMT)
Date: Sun, 20 Sep 2026 18:22:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/time: use assign_bit() where applicable
Message-ID: <20260920162216.18515C2c-hca@linux.ibm.com>
References: <20260920022804.3145894-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920022804.3145894-1-peng.fan@oss.nxp.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vLVNE_A7xRbXzx23oA9P7Z7ItI8IXzRt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIzNSBTYWx0ZWRfX4n1XwDr5B9bD
 9jaJ4IyBahHH3HdNYr5RO9dTt+p+rRU9QHZI+l3AWcH0q9w2p3O0Fsj77BXobA3VVmScIYl6rch
 A6pdGiroguVVb3vFhc4Vu3RAhq6EjeI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0083f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=8AirrxEcAAAA:8
 a=gdQy6pdEJGMdJgbn8y8A:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: vLVNE_A7xRbXzx23oA9P7Z7ItI8IXzRt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIzNSBTYWx0ZWRfX2FAoQjr/UqYM
 mS0dp+fELkUz0otrFLEqzI9pCewQV+YHSMv0D8S1CtBTGkauqvhC09rmSGwFt3PQ7cmkSthJYi4
 B9OzJdhtntVP9Q19OiwL2VmaAizKDm3JCS3KUEeWQF293YLg8dzHHkFhku62g1SZ1TaKxnrux6v
 8QkOcoL24UNIJ2DTmWEqbriq+BX2sdyA+R/mIapAoI9EV3oVbJ5QPruabSYu1FeR59Me7GxenfO
 cff4M2R8M5H7Hrs8QpSktm8xhfcgvCMtJpgUgDPgmiWOk4ov2vQm9CcFflhtedovO6A5Qr7b9U0
 1zIyNIqOPh43T/18L8OZPO9ame5WW7hU56wuEl33v+upRuF53pIpWpeoL1BLLO2O4LAmwVa62O5
 poYju3KOy+9Og6wW/b8SQw0lZHuAovwsuPT6lBjFPBTpOLvwM5aQ7snWZqJZgve2P6ZUuAbFep3
 Tr38Wf+XjKPwDlzNhFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609200235

On Sun, Sep 20, 2026 at 10:28:00AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/s390/kernel/time.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
...
> -	if (rc)
> -		clear_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags);
> -	else
> -		set_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags);
> +	assign_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags, !rc);
>  	return rc;
...
>  	mutex_lock(&stp_mutex);
>  	stp_online = value;
> -	if (stp_online)
> -		set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
> -	else
> -		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
> +	assign_bit(CLOCK_SYNC_STP, &clock_sync_flags, stp_online);

I don't know why all those trivial helper functions which obfuscate
the code are introduced. Before it was very obvious what the code did,
now I have to look up assign_bit() just to figure out that it is a
completely trivial helper function, with close to zero benefit.

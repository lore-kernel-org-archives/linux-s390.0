Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72959357D10;
	Wed, 19 Aug 2026 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139646; cv=none; b=lu+44+zjQBgIWz/LPgY4TrA0aVxRegroEFKn2BIt1gV7+MhmAmRlpuJYLTUuohphhCp9t84rBRc03DYc1E0r2buk16FMTOfRD2F2Smean9A87hGQAff+8IopWuHtvxPdwWX3H5kEQOL6KsMcyVJHLmPuArBxTq9PeN2K6GhR5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139646; c=relaxed/simple;
	bh=r9TNEQtg86en8rlSGP7PDYC32L2IrLWyUBPQsCHV3ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gipsSWbtRbMdv8mBbuluwIJRNGBu6I6+F2DDzRE1RX1CHK8ovtVu40OeLiK1upFWy1bkAjdxK5M0txl7k7LoxnxCLyA915yy9NuRdvDveh91ruM1Bl34yS+BHDkOPYf8XZLV6fyyrp/updvWZCkhbUdwPW8aABTH5A/l9dDJNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kFlcQ7D9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kFlcQ7D9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVjUX3228291;
	Wed, 19 Aug 2026 11:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ukg47i
	7KvmIA6RseooDPi8jZv0ZiBYLTZtw1/r4wpz0=; b=kFlcQ7D99ZX2tRM6IMxgxE
	IV3tZk3GNK0+yKAn5Z0WkkJtEcIE9M7u0FB39Jhul+sV8NqNfTNQGJkjAe+CFeyV
	LLcwV4hv2oOCD9+/Fryxquwdg/4YWALIskQv/ECKwJLPK6nVmpVuB/un6NToWdA4
	QqCLBIeaCbMHdN+jfQvkVoD7rSMkPURQD9K+iSiJ1vaoTfegCFJHflKLS7Pv8bef
	J8/h+REtUWImrGk4Apb1/ERa5OOy3bmzhe12LEjUxq3pQddah2IVKVFM6xE6lUZK
	t/ThOWQCA2X9WuUVOC91a82LAjv/+zg2yWnsJtWQZXjSCkvlf1Vkxf012swsZlyg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu43aa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:40:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JBQLwL006718;
	Wed, 19 Aug 2026 11:40:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh8mb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:40:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JBeZ5942205440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 11:40:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EFBA20043;
	Wed, 19 Aug 2026 11:40:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4DAB20040;
	Wed, 19 Aug 2026 11:40:34 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.134.55])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 19 Aug 2026 11:40:34 +0000 (GMT)
Date: Wed, 19 Aug 2026 13:40:33 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com,
        mjrosato@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 7/9] s390/vfio-ap: Fix hot-unplug skipped when last
 AP adapter or domain removed
Message-ID: <20260819134033.535fc52e.pasic@linux.ibm.com>
In-Reply-To: <20260812200240.818004-8-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
	<20260812200240.818004-8-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a859638 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Gm9r7fe_Tw3zQ87jZCMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: stXROtBFUUAg5YgqItTK5zeFD5MQ-OcE
X-Proofpoint-GUID: stXROtBFUUAg5YgqItTK5zeFD5MQ-OcE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4OSBTYWx0ZWRfXwXW4BG0GiNba
 Gg9AqOmK5pYObF1e9V5529Uqh6g5rKsotUao+cSfLCE6nElNyiB1f3mxdp5rUAiFz8Ggo3/WZPe
 8QiQ3J9tRrL2kY4HzdgYY62TzHIYoNQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4OSBTYWx0ZWRfX3Tn6ws+i7nQ+
 6zlzctdOJp5vHVUupRxvlUMqqoR1teSa1M/zcT1KnV2deOlUb1AVLhRF85cZCBP6tdfLjI4m4F1
 2sSTjgv95/cLmPQwj/LOqOBpmk0oImmwASLEymGQYC9zqwvMMfjFx/Bukjbdef4JJ3n2O+cxMN0
 2Vn82NvNttL3FH8wsyicVE8H1AXCvGcC/V57xtFupbhrJ7oxguObXWdpeLMHh0BG/yI07s3EQhE
 cSCelQqhWdMvwLDH8qvbhORQ13ntNHrh7Vf85+sXNZHumRCMT5YnYTk9EXqGAAtvSVLJ8WhKli1
 QXkjJqRSKS5exrf6xrEjJBQlEqfJbZIW267fXGuf1ydVhH/HjfHPGOz91fayFqCEf5VrQ0i4xzM
 vzjWOBk9L5+L1KD40mENwoU3WeG1ssZtRBCnlkfbdNzIc5bzDP2A9VFACW7eWnVtfrTT4UPjXkf
 NVncn97G/CKTuIQSwtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190089

On Wed, 12 Aug 2026 16:02:38 -0400
Anthony Krowiak <akrowiak@linux.ibm.com> wrote:

> @@ -2568,24 +2568,28 @@ static void vfio_ap_mdev_hot_unplug_cfg(struct ap_matrix_mdev *matrix_mdev,
>  					unsigned long *aqrem,
>  					unsigned long *cdrem)
>  {
> -	int do_hotplug = 0;
> +	bool do_hotplug = false;
>  

Nit: The name is IMHO somewhat misleading. If we are already touching
all uses of the variable and its type maybe we can use the opportunity
to change it's name as well.

Some ideas: update_apcb, changed, matrix_changed.

[..]
>  
>  	if (do_hotplug)
>  		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> -- 

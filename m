Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF643183092;
	Sun, 23 Jun 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163275; cv=none; b=e39v/rkmUkkOzR3oJpMd81lDu2OS1pY6LsxTxWUnsrTTD4uMd/vlFO0DBLCVYoCoTjUVGUPvPtTNoVg9v41p3rzPmOp1pnQURhU2nj9DCaA6Suq751BuEICa9Vk1gj4wRWjqkuiAdJ8z2PzovVVkm5KhnrMZZJ/O7xVUjIAN8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163275; c=relaxed/simple;
	bh=84+5N4wriQMHf+onQg0cb7dDDC8UcClEfUjEqDHh+lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYZONt6dxrUsjr8b4ZIuRtMuqLXKtnJa1Hb/WfyxwEjdWqANLw3YwNUAd2tpwgoX4ZekP+iE/43bFTndcjjf+Lif74s8LevJYrGdjux7kqu6MC8WR0IvoNcsCyFRpHMBf2PeTcI3aVBPZ9FvQFhC/XGXtWMVP9wwJZ5JkUdBpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y5E9or3D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y5E9or3D"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NGtTK4022930;
	Sun, 23 Jun 2024 17:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Ljn5wjBgwbRJHQMUWyur/3GUNfs
	gXa+6AncwQAz1SS4=; b=Y5E9or3DCwqSewSoRIexloRQYem3qgCYzfyyRqZiyZC
	kIm0mFHcK2S5RPWnXbClkKb8eEuGgqJFY/8Nc5VONRwmtSE1QEYDnj9zXLgefLHK
	owOyuc1nGzLSedz1YrXNXJQtxH1Y2gw5E58ewVMTOsm/vfcgqMSTYKzlxghfzvv7
	Jn3hJJQuTllMkc0xTsFkPQCulDrsR6BbJrXHqmbKCsbhpGGDplsUYcltlTwj2pyI
	m2PkAsV3TyCV+QY8RoaYVBJrERbCaXbZy90s6sMws/AIP827JfdVvoJnbp7xX2eg
	duFXGEjNrvIKhRojxletoBmvIxKPGkZnhhohlV+w1YA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yxn2rg98p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:21:10 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45NHL9M6028168;
	Sun, 23 Jun 2024 17:21:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yxn2rg98m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:21:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45NF0Wik000564;
	Sun, 23 Jun 2024 17:21:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaemk49w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:21:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45NHL3ru55837164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jun 2024 17:21:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 718F520040;
	Sun, 23 Jun 2024 17:21:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA57820049;
	Sun, 23 Jun 2024 17:21:02 +0000 (GMT)
Received: from osiris (unknown [9.171.89.14])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 23 Jun 2024 17:21:02 +0000 (GMT)
Date: Sun, 23 Jun 2024 19:21:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: yskelg@gmail.com
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, shjy180909@gmail.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/raw3270: handle memory allocation failure in
 'raw3270_setup_console()'
Message-ID: <20240623172101.5874-E-hca@linux.ibm.com>
References: <20240623122447.35847-3-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623122447.35847-3-yskelg@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: td_CFSUY4HSjjtYTYHaTaEbJdoP1RLXa
X-Proofpoint-ORIG-GUID: UtxQCzbWABbFATz-IWZrSh9I3EPXWQ07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=566 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406230136

On Sun, Jun 23, 2024 at 09:24:49PM +0900, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> This patch handle potential null pointer dereference in
> 'raw3270_setup_device()', When 'raw3270_setup_console()' fails to
> allocate memory for 'rp' or 'ascebc'.
> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  drivers/s390/char/raw3270.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
> index c57694be9bd3..4e81040eea81 100644
> --- a/drivers/s390/char/raw3270.c
> +++ b/drivers/s390/char/raw3270.c
> @@ -812,7 +812,13 @@ struct raw3270 __init *raw3270_setup_console(void)
>  		return ERR_CAST(cdev);
>  
>  	rp = kzalloc(sizeof(*rp), GFP_KERNEL | GFP_DMA);
> +	if (!rp)
> +		return ERR_PTR(-ENOMEM);
>  	ascebc = kzalloc(256, GFP_KERNEL);
> +	if (!ascebc) {
> +		kfree(rp);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  	rc = raw3270_setup_device(cdev, rp, ascebc);
>  	if (rc)
>  		return ERR_PTR(rc);

This is kind of pointless since such allocations won't fail.. but
anyway: please make allocation and error handling like it is already
done in raw3270_create_device(); this will also prevent a memory leak
of rp and ascebc in case raw3270_setup_device() fails.

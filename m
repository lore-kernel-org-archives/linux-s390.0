Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E820B7EC;
	Fri, 21 Feb 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150838; cv=none; b=G+QL5QwGMn+sxdETVGu35Go0Smua9RBy4UbSL/HlrM6WTW0SHxMr7wdOeM+UNEzdROuFcNheaShyquxtawR0whFc93eOeMlneXkskFHcugdba85PbdcZviNFVgIntn7ts+2hx7jaf7gcZ9BqODqCVbBtukfDLqjN+TP2UDzzWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150838; c=relaxed/simple;
	bh=YnPo1+zP4R+BDJN+AsbIJ43w8ViJH0a7Uh3tBOwEca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqcYrBb1iCEfxw1S47GbRsdP0qmkAPcgSBZ7cPhUruZaSgPAH1GIXWZ1I8dG13/8R+GxFhV3rWDUJUkqq8UhIY2667hc4wGM4v8XKAsAMDrV2gCbC+47m/6x2BAJpTcYgxCJC+m0uv+GcaJ742UxuY7IcX4W9My+CLCjoXo8QZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hz4yQCfv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hz4yQCfv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L5OjmU002802;
	Fri, 21 Feb 2025 15:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fzOR4M+IM6YAi1rK83cNA6lvnRgfTM
	bWJ9VcA6dXwxM=; b=Hz4yQCfvuETZ4GASUYZcQ7sZhXvzZen4RElGeqd1Bc/bpJ
	EsFjMvgzBTiIYdKygZo2i8EvlCPs/rUfrnHx5ZDc0EFJhyfuV++WcqudD+W4OhTf
	xxcH3qZGjLr/X44CI5gbZhgihjcq7mb+R/RRbrTiDsylmctb2HU8evMsSqsw/3w/
	DzOYzgnoFMf9+yemeo96+rjJXNFp4epDMqCBpNFsXM1Ke2FrzDVk4QDFsRrcqodC
	Kon1MsfKvbEIgHoJjspAizAVcMWeTg4BVE50Myt5tKto+S+r+mt941iotzBQQc1n
	XhvsDN2YXyam4InvVGBSZAgQHHok8AnD5aDv7FNA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xka8jtkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:13:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51LFDt89002328;
	Fri, 21 Feb 2025 15:13:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xka8jtkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:13:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBwkHi030118;
	Fri, 21 Feb 2025 15:13:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xgnma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:13:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LFDoo444761500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:13:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3187F20043;
	Fri, 21 Feb 2025 15:13:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA29E20040;
	Fri, 21 Feb 2025 15:13:49 +0000 (GMT)
Received: from osiris (unknown [9.179.14.8])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 15:13:49 +0000 (GMT)
Date: Fri, 21 Feb 2025 16:13:48 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390/tty: Fix a potential memory leak bug
Message-ID: <20250221151348.11661Dae-hca@linux.ibm.com>
References: <20250218034104.2436469-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218034104.2436469-1-haoxiang_li2024@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DuOIvNRpalieeDDtj2zmsuyhFeEKOKQK
X-Proofpoint-ORIG-GUID: hCTMIvRyWYUVEbnQuBaujGB6FS0cIHOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=477 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210108

On Tue, Feb 18, 2025 at 11:41:04AM +0800, Haoxiang Li wrote:
> The check for get_zeroed_page() leads to a direct return
> and overlooked the memory leak caused by loop allocation.
> Add a free helper to free spaces allocated by get_zeroed_page().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/s390/char/sclp_tty.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Same here: no fixes and Cc stable.

Acked-by: Heiko Carstens <hca@linux.ibm.com>

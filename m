Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874455884;
	Wed, 19 Jun 2024 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837163; cv=none; b=A7hmsYFsUxGdEkP/Riq5c0pIrZb4tGnG1lKPS9XbberKNAe+4Frd0OG6VIthikBIiBx8o0HNgU+4zv04tNmxi68Hci5zJjJrd3QU2+Y9g26oSVnUmGqq3xvUN2BL2IKQ2lTnIwtIZYtldXnX45A42xkY6YhEbfGfo86ba9dDTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837163; c=relaxed/simple;
	bh=2a2/cNvKSn329kxXCi/efrjcm3wAL13ye8VmOAxqrSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jF1nuzG9D0BR5xfkOK2iJ2zTDEHRcBtFMxWfyjkfF2rbSCfb0s0dz+a2mwOpQYlp3KYyNVSTBCXHUwzTyN4DvtwdgTgwRDZd/cSpk14x1VwRo9YuiqDZqtNdT8y926EiUuNAV/kjEY8S/V+rxB3bf0RBWG1mg9CkCstRJzX6sWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i1YGcRKy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i1YGcRKy"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JMTcNe030789;
	Wed, 19 Jun 2024 22:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=0MV59EVSWeFhUpGUHroLY7Dl1dF
	htQfZcU0UrDPxTUw=; b=i1YGcRKypKsF0aNaVBgaAAh8GpfsUEzoBJanKms5NyA
	LmhAj8gvZdN52iX4kDrMVHfABiB8Q2sO/uUsS7AzEQBBkePVhBhq55hUtkvNJUdP
	zwB1N4Rj9SYFMNhlHNVJtCpwVrFZClYG/VjRVHLKwpSLdU9QLsZxyUFaYl/pApMQ
	c3ZWk9aW7BA8+NF4Ne5bXwsw/Mu5J19yNl+sXF53Pm2prL9Xl9k7Lue9qU2IB5fd
	qFjqMi9ghS19Qsj+UyUJZmj3G7ND352Jf9S+VDbV39CgydCIA4J1nUUp2M+UMeor
	zp38dRH4DJjDNHk4DoLldqUz+9YM5r/y1QmZWrhH5hQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv85cg173-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:45:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JKMJpb011027;
	Wed, 19 Jun 2024 22:45:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsnght6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:45:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JMjknX31654518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 22:45:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D334B2004B;
	Wed, 19 Jun 2024 22:45:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EB5A20043;
	Wed, 19 Jun 2024 22:45:46 +0000 (GMT)
Received: from localhost (unknown [9.171.70.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Jun 2024 22:45:46 +0000 (GMT)
Date: Thu, 20 Jun 2024 00:45:45 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] s390/3270: add missing MODULE_DESCRIPTION() macros
Message-ID: <your-ad-here.call-01718837145-ext-1145@work.hours>
References: <20240615-md-s390-drivers-s390-char-v1-1-d1cd23ff6476@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240615-md-s390-drivers-s390-char-v1-1-d1cd23ff6476@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rn8aRDV4gc5gD5RF4QlAdyYi_I2Y1s3C
X-Proofpoint-GUID: rn8aRDV4gc5gD5RF4QlAdyYi_I2Y1s3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=577 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406190169

On Sat, Jun 15, 2024 at 08:01:17PM -0700, Jeff Johnson wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/raw3270.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/con3270.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/fs3270.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/s390/char/con3270.c | 1 +
>  drivers/s390/char/fs3270.c  | 1 +
>  drivers/s390/char/raw3270.c | 1 +
>  3 files changed, 3 insertions(+)

Applied, thanks!

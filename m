Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9D1CB332;
	Tue,  1 Oct 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798982; cv=none; b=akBhxl91nxaYSLfniFObCOHoIAAsvhVITAXBZ7bX5QVtdTvzAvKOa0KPj9Xp734K2wQ5G9/ePnc/f2/+BQ95PRGhxYTibYty3j7BEAaotrLebt22MqwVzR11p41YFLtqm+Q8xJKdDhZJiz47l2QaAMJMpCYZSKVnrT3OtlGyWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798982; c=relaxed/simple;
	bh=WbOfI/NDN3qc7B4Pu5UYwgun3cxTpO9A0RNwsCOCPAg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=Pog5aWRNp1CpF5k4Y7nyAS+qfMU1uzfF0TGDjGUdwPp1lNydtKOMxejeilfB18xijTWAGk+YLBY3NmKeb0VEfJqJskLlsGBcBoHQqcS3Vd1mDtfvh7jHfCkDSf/rhThrMD+TI2o8apSjB2FV9Uf+NmgWG40RrMC/J0DVCkD9y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FwnsqwWw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FwnsqwWw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491FppcW025088;
	Tue, 1 Oct 2024 16:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=eBVUYbBTM9OQ8cz2mSqelnIU53yIxQnsu31Ui7agvZ0=; b=FwnsqwWwaf8U
	cB7bplH3hevt30/zr//w3d3C0C/10ZmiLObRLri5Jq7Q9baycdsp3uLnw3j45rtK
	uFrUxSNHP76jESurcNTti66LNi6xp8Kw8c+2HDht36K0GdLvwkP7Xg3rY10caMNd
	q9EgoP0H5HG61j6pbRdAcQ9hOC4s3K/3Qxx3E5k2eKw9rBhpksHjVa+iDX/JnRue
	BPnUAH7l87aVeP6spS4qwqexFUybVAOU+FyW0D+MpY0LoNCJn5UXeSoluDmd+Fzd
	PIpJgreBMngtDa17eF9p6h1onB8hVC86TW8WSyCxuHUsXgQiUffvDDZQusTsXh4u
	1It3ZgYQpA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420m3d02h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:09:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491ElO15007923;
	Tue, 1 Oct 2024 16:09:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxwhys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:09:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491G9WH016253322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 16:09:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 606B620049;
	Tue,  1 Oct 2024 16:09:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D5F420040;
	Tue,  1 Oct 2024 16:09:32 +0000 (GMT)
Received: from darkmoore (unknown [9.171.30.50])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 16:09:32 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 18:09:26 +0200
Message-Id: <D4KLM7Q8VANS.PJW8BMVASTMC@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Ingo Franzki" <ifranzki@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>
To: "Steffen Eiden" <seiden@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 3/6] s390/uvdevice: Add Retrieve Secret IOCTL
X-Mailer: aerc 0.18.2
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
 <20240930131909.2079965-4-seiden@linux.ibm.com>
In-Reply-To: <20240930131909.2079965-4-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9zdnHsLKIueQ64ACiZ4xmUhskha202F9
X-Proofpoint-ORIG-GUID: 9zdnHsLKIueQ64ACiZ4xmUhskha202F9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=300
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010103

On Mon Sep 30, 2024 at 3:19 PM CEST, Steffen Eiden wrote:
> Add a new IOCL number to support the new Retrieve Secret UVC for
> user-space.
> User-space provides the index of the secret (u16) to retrieve.
> The uvdevice calls the Retrieve Secret UVC and copies the secret into
> the provided buffer if it fits. To get the secret type, index, and size
> user-space needs to call the List UVC first.
>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/include/uapi/asm/uvdevice.h |  4 ++
>  drivers/s390/char/uvdevice.c          | 56 +++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)

[...]

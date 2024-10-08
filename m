Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BA1DF75C;
	Tue,  8 Oct 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395462; cv=none; b=lOF2JYc9GQRP4NNXW8v9TGOB7kb+WxXGwPSZH42ThkRUF5WkN/yNPBFRL4Vohy0v+LhJGcHbKiRo412xDBCUuLcCQTnfM3XPCiWuEKQ//56FrpOO9/baQ8t8xA5ZP6n23PnEJmKNeADHO6s3V+qiFapjtSWvX+2h4dQFEZOEybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395462; c=relaxed/simple;
	bh=bO6vW4Abf4X5mB9TcdyV58xfqnHNBaYqM1OOD/jiNmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMQ69JbFJYogUryAIQexmg2Rdk44gtSYKFFycGF67RXcvhbJj93Mbw5M23bqn51L+G39xlLSv7ZSEl2mcv/ENtr+RIEMa/pYB0aZ6Jp4CwJsk+Mhz7h2ntKJ1aKBW/E0i+AwgQJNsNLmhiuGCzTxrJokb2VijR4TbwUrIypfXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZYqnJKeF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZYqnJKeF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498AnbZT003576;
	Tue, 8 Oct 2024 13:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ksKek3Yk9KDvw/jxO1OJfoyJu60
	wSkwDQyzfPjRyGH4=; b=ZYqnJKeFZO7Erc4Ibg5WDaiTCFBAQvFWRc8lkZF/q7s
	KovjBIbwV8RrKJQxxEn4X3DlWy4bjVzZ9fMrWO9gwPpUSGZzHmWKlTgAbRJTiSzw
	OnW7WEH4z5Fkhf4JCO2Py9nFRQODE/2zTv3ZGr2/OMLr9p5avoA9nhmDZygqgH+X
	KEJ0LaBzD+sDvRI+etGw5UhfcA4hJKE1U/WX3zHhMD/loG0G0zjPOrY03B5emaTG
	FemKy3k+RGzcr0DO5NVjCV38wKuxYayAZmKvYnsyJXYMPx0QqPenr/7wZZxQLa3k
	FvU7FyjQgv2Qu7yg3wJ0Ls0YuPEdK4bw7WlA+hRy8Jw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axs4q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 13:51:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498BxR3b013798;
	Tue, 8 Oct 2024 13:50:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss4s04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 13:50:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498DotiH21692728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 13:50:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83DE420040;
	Tue,  8 Oct 2024 13:50:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EE5A2004D;
	Tue,  8 Oct 2024 13:50:55 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 13:50:55 +0000 (GMT)
Date: Tue, 8 Oct 2024 15:50:54 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: vneethv@linux.ibm.com, oberpar@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] s390/cio: Correct some typos in comments
Message-ID: <20241008135054.7472-I-hca@linux.ibm.com>
References: <20240929080353.11690-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929080353.11690-1-shenlichuan@vivo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZP50kymOIPQlc7MgK1jrnQg2eaFGf8tt
X-Proofpoint-GUID: ZP50kymOIPQlc7MgK1jrnQg2eaFGf8tt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_12,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 clxscore=1011 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=1 priorityscore=1501
 impostorscore=0 spamscore=1 mlxlogscore=185 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080088

On Sun, Sep 29, 2024 at 04:03:53PM +0800, Shen Lichuan wrote:
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> -in the code comments:
> drivers/s390/cio/chsc.c:379: EBCIDC ==> EBCDIC
> drivers/s390/cio/cio.h:22: sublass ==> subclass
> drivers/s390/cio/cmf.c:49: exended ==> extended
> drivers/s390/cio/cmf.c:138: sinlge ==> single
> drivers/s390/cio/cmf.c:1230: Reenable ==> Re-enable
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/s390/cio/chsc.c | 2 +-
>  drivers/s390/cio/cio.h  | 2 +-
>  drivers/s390/cio/cmf.c  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks!

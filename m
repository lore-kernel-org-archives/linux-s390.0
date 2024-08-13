Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9B19923D;
	Tue, 13 Aug 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549845; cv=none; b=EXYtg9x1iJP4WOWiO+M5EdeL3mTgpKrRezD2+ZDfIANTJasSPfa01GymSFDr8lkGAVHkdLKCBuF1SjicoNCWdx+hEHRdQ5yaCuVUlvlfZ5e9+usFSmGOYnb5Fapwl2ilUHOby3LvWMLw75crZ9ljKiXsRLQ/0ddmBwcLp/+xV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549845; c=relaxed/simple;
	bh=momqMPg58eXRuraxzLRA5+Vm9sT9ngqIOc9ZLV6IMQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GaXz/YN3nYKJ7zcHnfeb29EM4rB0Cwosa5UbFd49yYoSO6UhC/a8WJx2IKhsMtvphq35+Hl6773gdYbO3mBk/Fgp5EAdTTZnCOq6ilgbvz9w2KyDktwAZ3MScWu2xxMq2YtSlxeRaGgbTr6qPcZnRSEYu94c7/S4IVyTpjtyaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YW1I3BSi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YW1I3BSi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D6Q7VH002444;
	Tue, 13 Aug 2024 11:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:content-transfer-encoding:mime-version; s=pp1; bh=N
	7TwkXSoYtsHI6ke9wVuBzCSrBwOGWPut1J0RcJCaA0=; b=YW1I3BSibDiUF3IyS
	KhhE1HsKhpQKteQI1egfqknCzyNBjy39TP7kkPmrJWTXmIJWdzb+WevR8oRVGIyb
	f9OnIomMqb2ULgd6AG3SuQt7/SWQrOIuxIUY542XT0AA6W4KjbJRFURawnQdo6rm
	DqgN78vWJ6dQqQII7IH6bcXVr+tEq1PeO1S3Al2y2h1dIhqp4xx2hnZjX92GhsQV
	Dw1i86b8r8+YNpXFY9GA/XNWgSLlLu46RRz6BKvsPcuXc7AzTbn0C2DFbc7Olemu
	jLrMhadaK925+jJlGUVaXj/otl8wV3MAi8xjBwibs3ffBANdKRSNIlR1gyrVdoTY
	ntlwg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpqr4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 11:50:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47DA0G9S020901;
	Tue, 13 Aug 2024 11:50:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn832yfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 11:50:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DBoTMp52691220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 11:50:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9376720043;
	Tue, 13 Aug 2024 11:50:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 375E42004B;
	Tue, 13 Aug 2024 11:50:29 +0000 (GMT)
Received: from localhost (unknown [9.179.17.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 11:50:29 +0000 (GMT)
Date: Tue, 13 Aug 2024 13:50:27 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <your-ad-here.call-01723549827-ext-8444@work.hours>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
 <2024081331-bonnet-fiftieth-9a14@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024081331-bonnet-fiftieth-9a14@gregkh>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PE4u4Rl_NwdOX-Jb7eFQ4UuuSWBXnxAa
X-Proofpoint-GUID: PE4u4Rl_NwdOX-Jb7eFQ4UuuSWBXnxAa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_03,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130083

On Tue, Aug 13, 2024 at 12:52:19PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2024 at 12:42:37PM +0200, Vasily Gorbik wrote:
> > From: Heiko Carstens <hca@linux.ibm.com>
> > 
> > iucv_alloc_device() gets a format string and a varying number of
> > arguments. This is incorrectly forwarded by calling dev_set_name() with
> > the format string and a va_list, while dev_set_name() expects also a
> > varying number of arguments.
> > 
> > Fix this and call kobject_set_name_vargs() instead which expects a
> > va_list parameter.
> 
> I don't understand, why can't dev_set_name() be called here?
> 
> Calling "raw" kobject functions is almost never the correct thing to be
> doing, ESPECIALLY as you have a struct device here.

struct device *iucv_alloc_device(const struct attribute_group **attrs,
                                 void *priv, const char *fmt, ...);

va_start(vargs, fmt); initializes vargs to point to the first argument after fmt.

__printf(2, 0) int kobject_set_name_vargs(struct kobject *kobj, const char *fmt, va_list vargs);

__printf(2, 3) int dev_set_name(struct device *dev, const char *name, ...);

dev_set_name is expecting to receive individual variable arguments
directly (...), not a va_list.

The (...) in dev_set_name is meant to be expanded into individual
arguments, but when you pass a va_list to it, this expansion doesn't
happen. Instead, the va_list is just treated as a pointer or a single
argument, leading to undefined or incorrect behavior.

So, would it be okay to reuse kobject_set_name_vargs() here, or would you propose
introducing another helper just for this case? e.g.

int dev_set_name_vargs(struct device *dev, const char *fmt, va_list vargs)
{
჻·······return kobject_set_name_vargs(&dev->kobj, fmt, vargs);
}
EXPORT_SYMBOL_GPL(dev_set_name_vargs)

The bz link should be:
Link: https://bugzilla.suse.com/show_bug.cgi?id=1228425

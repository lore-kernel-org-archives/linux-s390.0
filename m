Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB86524B0
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418046; cv=none; b=Ip++1Rhxq1zUyv7bs1g4ymMFIEG2Yh0xeeyIcZGwDYdE5vjk4W/MU8pUmY/Rkx4D6rfSl95zaYsJm8Uv19EdDZxGXbjZvPZJGuBJ4AEIkXmhO12J19XgFptowrwEeM0m8Cpqz8Ar9OAenwr7P/M4mACmjwPIBhvJXNyL0KOyxio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418046; c=relaxed/simple;
	bh=AEzjvVmQ4L8rzJi0azsi+VuWEYy1rTQhJeukslGLTgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7f2pBICioA9FdwqrRsF0AJwS+1L/17tHgnUG9wsv7jOGHFM50gvwuPZJcUDtTN3AbJdvE9AZ07Vp/NY8Wg72adwGJPaFcbbfo82/Qa0bStiaPIRw+pIE7Wqw03v4uRuNJ6Kohpw0cDqY7Fv87DHWSAwA0RxwTyNqU5pKPwPXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kZSEKgng; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kZSEKgng"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V9hFal029671;
	Mon, 31 Mar 2025 10:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AEzjvVmQ4L8rzJi0azsi+VuWEYy1rT
	QhJeukslGLTgo=; b=kZSEKgng3L9yUqOoCl9x4TV5Tqo/QeMlBtp1nMv2xoJaqc
	TJkUSenmqi/PN2wLdgvmMCvgxMBp/ZwzWQBJuBJx5uwRdEm5WSnsahwJ39QtF7/t
	Ttf22Wkp1TUeEHYwAvIleDxlTxzSj+l71ZC3hmHDzLes7UwYiDO7bR/IVpbSMYE1
	zLYJGnUHYhPJZfaPYqts+Nuz/WJRobIKR3olWuPcMqTnIPlx3vPNn1A3W5R06K6U
	kL0ec4Os2I3QbZmDqE4doz8P5OLTVknUr3c4F6PBYaXzHWRagSxTQ3FwHnVHk3le
	vXd4GxXSeLYc8+9KZy783ZDNGDF7yE8PeYBOM+yQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qa4wu6ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 10:47:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V8ccHp019405;
	Mon, 31 Mar 2025 10:47:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6swnx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 10:47:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VAlGWl52494778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 10:47:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E531220043;
	Mon, 31 Mar 2025 10:47:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 893C820040;
	Mon, 31 Mar 2025 10:47:16 +0000 (GMT)
Received: from osiris (unknown [9.179.29.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 10:47:16 +0000 (GMT)
Date: Mon, 31 Mar 2025 12:47:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v3 02/21] s390/ap/zcrypt: Rework AP message buffer
 allocation
Message-ID: <20250331104715.25223D3a-hca@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-3-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327143941.45507-3-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y_rcEER7StBvDE9oWH4t06jb4V-wKFWJ
X-Proofpoint-ORIG-GUID: y_rcEER7StBvDE9oWH4t06jb4V-wKFWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=631 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310074

On Thu, Mar 27, 2025 at 03:39:22PM +0100, Harald Freudenberger wrote:
> +/**
> + * ap_init_apmsg() - Initialize ap_message.
> + * Initialize a message before using. Otherwise this might result in
> + * unexpected behaviour.
> + */
> +int ap_init_apmsg(struct ap_message *ap_msg)
> +{

This is incorrect kernel-doc style.

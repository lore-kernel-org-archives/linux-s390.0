Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA917A924;
	Tue,  5 Nov 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822850; cv=none; b=q69wxeZLC+RqEBHKLiG+IcW5nZ9uD+MAFqyhGiovXp1Awj67AywLvF1ZTJsrNzVFiXVA7TfKb1o/5woctIPN4KnolJgLS9usahSgwuhHFExbdT6hiVfSVxpcLSWy28QPxC1f5vVg33CXoZNJNVk6L/elXplML1bbXK3iV7RVKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822850; c=relaxed/simple;
	bh=6OQvNqTpN8uqUK1hbKZ0v9eYgcCNkpgWYHioBfV8FTU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=uFxyKNmAV4UuZdmjLseNBcSSY23xHjy9jWySVU6rfNpB3McwSsT7aWsCrD5yenvBb1AXpUupSuXBJhV7vu63M6TtiXMKJz80jwZOR+sQn/0YvXpAhyCrilshyx6lvzUN5VpulBAztkgn3ciFnB4koO4PZM2iB5tlDKwrvRSYnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cd4QlNsU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cd4QlNsU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5FA0hM019130;
	Tue, 5 Nov 2024 16:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wF/fPG
	kKBN5sySpfK8bBILXe1QzDXs7brHOuMBHsKSs=; b=Cd4QlNsUlQAoBgdjNBDB7F
	DxA90tsinOqm9eU8Xl4dMeEOtDAqEzUcDYC0QoiTqpnVFGcJdpHIbsqM9ageT4c2
	SneCfKJbqjWKP84T2ceCyZjfpVwOMg2gT0jAzfv/BCWltVuEVk/GLQUu7j/EMTvi
	sIHC3aN6o5NS7nYsRT5pR+Gb5pg3y7zGKJUWk359Z5KODqD6wyXtUwWkiGYctX1j
	f0ZIwfwWLHyx4Tcl1FYbqHoewtkatzjq3v6G85oEcUCGHWUWKlFiYS/t77MxgtxN
	XPOCkmyS0z7/DU/4XGWu5nlTotC7a7skOxiyHnFJZ37bAbKxWrGJeDQtDRhxqgPA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qnrw0daq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 16:07:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A56jZmQ031980;
	Tue, 5 Nov 2024 16:07:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmmenj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 16:07:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A5G7NXk15728976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 16:07:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88ABA2004B;
	Tue,  5 Nov 2024 16:07:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6475120040;
	Tue,  5 Nov 2024 16:07:23 +0000 (GMT)
Received: from darkmoore (unknown [9.171.60.76])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 16:07:23 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Nov 2024 17:07:18 +0100
Message-Id: <D5EDHMWQTPBJ.1R31D5Y8ROTUT@linux.ibm.com>
Subject: Re: [PATCH v3] s390/uvdevice: Support longer secret lists
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Ingo Franzki" <ifranzki@linux.ibm.com>,
        "Janosch Frank"
 <frankja@linux.ibm.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>
To: "Steffen Eiden" <seiden@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
X-Mailer: aerc
References: <20241104153609.1361388-1-seiden@linux.ibm.com>
In-Reply-To: <20241104153609.1361388-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w_e6vVSWoEJaWCPSNZix8VqEqH60qlKq
X-Proofpoint-GUID: w_e6vVSWoEJaWCPSNZix8VqEqH60qlKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=613
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050124

LGTM

On Mon Nov 4, 2024 at 4:36 PM CET, Steffen Eiden wrote:
> Enable the list IOCTL to provide lists longer than one page (85 entries).
> The list IOCTL now accepts any argument length in page granularity.
> It fills the argument up to this length with entries until the list
> ends. User space unaware of this enhancement will still receive one page
> of data and an uv_rc 0x0100.
>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  v3: remove upper boundary (8 pages) for arg len
>
>  drivers/s390/char/uvdevice.c | 71 ++++++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 19 deletions(-)

[...]


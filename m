Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E51DFDB8;
	Mon, 22 Dec 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402941; cv=none; b=EhtlNkEddWBYJrrxJVDoGSTS+0aL6uL5MDRek4kvNX1YQ2hrMrjxtFBCoFSJB+tq+ZGDZSrKxSpf+ZcMRdX6e6AvA1kVwdX8SemQAgJIczbmFwJkqJT4dfDC3uNgcL4VNV2i513qPPxHE6btDWmXqZR/uSTLsfoUCK1f1dB37vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402941; c=relaxed/simple;
	bh=e53EyLwzQdHqSMMBbhLCitMJ5QCQIMgUq5OMlXdDTLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNk3oE9gn1TqtVFvJwr55uqttSi/X1KTrFvNKkawrVWDmUCTauIgBB0mX5Ssh7iYFKFgqwJ0RF/NWz0ynj39cUbKy0ZTTy/ZhY5PUvgnte3gtuTqnu2+buIHs8KydyhRPcoiiCFM1cpkzKqV02cNXEjH5ZOyfwzczgR0QtZQwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j8ltm1yd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j8ltm1yd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM7vY9w010834;
	Mon, 22 Dec 2025 11:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VFXDz6
	f3G9dw/7k7AYvZCced+F0V8WAVd4vt7+i+3is=; b=j8ltm1ydwadfQXvV9xFkA/
	QwWgOUzu5XdEx1aF1cxXpic5qq0uij/J0N4XCmCGrEU1lAz84kgaTlxCBHc08UUN
	+a5XRXco6egkSOHtN8GBOyEOjKmIFAx59D6Ig+WlqcGSbUU7Lt7d2SR5jp9iO7Ui
	lo7s01OdonZZKzJbK7kSc35DwR+0EXJVTYzf269X+xegs2vMAkZQCjdTUjkTIPTJ
	EJ0gG+XxusXNyeCro2kttoUIzzbdjLa+Tla2NkMI6pJdlqwpUwsAZ5X+c4nAeYl+
	bd1/3qH/frD9+nIF+6l4dbYRD6hNMooMtcf/kR+wiQspNrRyzlttzH1p/KzYPmvw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5h7hqtgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 11:28:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMARbWU027024;
	Mon, 22 Dec 2025 11:28:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b6r932vdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 11:28:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BMBSpsR27132670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:28:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE5A52004D;
	Mon, 22 Dec 2025 11:28:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C46A20043;
	Mon, 22 Dec 2025 11:28:51 +0000 (GMT)
Received: from osiris (unknown [9.111.59.181])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Dec 2025 11:28:51 +0000 (GMT)
Date: Mon, 22 Dec 2025 12:28:49 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Implement ARCH_HAS_CC_CAN_LINK
Message-ID: <20251222112849.16440C5c-hca@linux.ibm.com>
References: <20251222-cc-can-link-s390-v1-1-0b2c4998c066@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251222-cc-can-link-s390-v1-1-0b2c4998c066@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMyBTYWx0ZWRfXzND3w7/U+krU
 2XMsXLwyb5rZjYDmtViCfjN80g2tPmGetqXj9FeH03XTtTXDMdYiwVngbeJcyErCV5+t1WXz+vl
 1xOyXeuIYv3LwIyfAUK6pHBpIqJymDR+33sl2CdgbR3mRXbz7IWTS9qanw31klvk0J1E7pT3oaL
 5r1BhOxqfshJcK4knWZmEbKQf0yKL1k3SmD85MEjEQ+s55tCY85jQkRnalYY4nH5wM7CZgNF8we
 uELw09Z4F3QwmE3YN6CkIcm5ZC2un4zpgCSZufX7loBUMqXbVsS5kryoFztGc/2v6AlxnHgpM/O
 ehMVRr5QOExS3Jxunf+7wiQUZKkxZn9uPO3t2d1pnugXZgFlunJ3otLogw1zojDvLdY7Ss9AEGp
 gF9IFt04IHJdS/Ls4lHnyZYdkUjYQtB1lA6is1X6XuH7AaHM/nKmNF1STkyN/oz97Q+l5geo/pD
 zrb/quFHWjw/ZRwp07w==
X-Authority-Analysis: v=2.4 cv=Ba3VE7t2 c=1 sm=1 tr=0 ts=69492b78 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DtSwU3RMzSsuwpdqjt8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: vXQFVDIBLdB0H518S5oU2Wy9ikYxTKt2
X-Proofpoint-GUID: vXQFVDIBLdB0H518S5oU2Wy9ikYxTKt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220103

On Mon, Dec 22, 2025 at 09:28:17AM +0100, Thomas Weiﬂschuh wrote:
> The generic CC_CAN_LINK detection relies on -m32/-m64 compiler flags.
> s390 toolchains use -m31 instead but that is not supported in the
> kernel.

Some s390 toolchains default to -m31, depending on how they are
built. Actually I'm only aware of a single one. But given that this
one is used all over the place for cross builds it is important
enough.

> Make the logic easier to understand and allow the simplification of the
> generic CC_CAN_LINK by using a tailored implementation.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/s390/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, and scheduled for the next merge window. Thanks!

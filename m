Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D5155CBF;
	Mon, 14 Oct 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896595; cv=none; b=DZPzEba0MtPdbIvLxuu65Dl4PDE9qINCCXs+kwlrnKR566+q19qBKxC+nHhhUOJrTX4reA04wbMw0DANT+yFtV9b4lpVJaWJRIklNDbShGiJNxz35YhGaaF1RrToKbnu0qTWmmrFeGhwmpDldiWu2L3Gw9Y0MQuMFmZjHoUiP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896595; c=relaxed/simple;
	bh=5elTMt01Aki3kk14P8SHSdGRTpOY40lpslAYHcbLMG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR+RRzv5dh3aD2stQV7iqnkTLhI46C2s6pDWn+n4WUPnodUWVQj6GB2VxX9RpCm1H+8Ux5FroxrywT0tmTJF2NeVj753QLgZqNnB+ryCIawCjeBw7FNQ2Hh3dnYnBVisDBwawF97WN3A4EwfdPxamsL48f4V5kaX0Yv/tW9mox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B9UnPdcz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B9UnPdcz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E7otdv006293;
	Mon, 14 Oct 2024 09:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=R
	U+uECu0rrkZSlpIp/Dbc8F7IDrEbZGxlsfDv1LtZPY=; b=B9UnPdczKPZxehmOG
	ZQaU/d2p5NgMyxi9xUhVsKmitt72bpQz5BOGdlSaEWnstVaG8CsVw3Hcm3mu98gi
	MyqRwkHRblj8agmfXZUsmEn7hWALaKOeBy1E8bMR0gfBCosBiPbrEoUHVLkB96wq
	7P3LmN6CEM4ZIc7gTcq+PpOuXpWl9g3AkrNQzqghYtHnmyJY2KRWKUAXx87qaWwg
	Euvc8hZU1J6aZQW/zLeS8LFwgFQ8MPNB2qi7nIUjs7ADMW15mte8ElFW7WvL0Gxq
	6aOW2xR2hiPLo55GUPRc70XDTnEj7xADso0ZZGNFtHnmo5+Tc3agTkjA673XPbfE
	BohTg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428y8w09y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 09:03:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49E7TY5J002408;
	Mon, 14 Oct 2024 09:03:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emdjfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 09:03:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49E930Dm56361398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 09:03:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF0BD2004D;
	Mon, 14 Oct 2024 09:02:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6377A2004B;
	Mon, 14 Oct 2024 09:02:59 +0000 (GMT)
Received: from osiris (unknown [9.171.92.92])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Oct 2024 09:02:59 +0000 (GMT)
Date: Mon, 14 Oct 2024 11:02:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/2] s390: two bugfixes (for kunit)
Message-ID: <20241014090257.12624-A-hca@linux.ibm.com>
References: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rK0zS-Ue-5Ty-z3sr-nDg1XlhHWaRFy7
X-Proofpoint-GUID: rK0zS-Ue-5Ty-z3sr-nDg1XlhHWaRFy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_07,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxlogscore=324
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140064

On Mon, Oct 14, 2024 at 07:50:05AM +0200, Thomas Weiﬂschuh wrote:
> When trying to use kunit for s390 with
> ./tools/testing/kunit/kunit.py run --arch=s390 --kunitconfig drivers/base/test --cross_compile=$CROSS_COMPILE
> I ran into some bugs.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weiﬂschuh (2):
>       s390/sclp: deactivate sclp after all its users
>       s390/sclp_vt220: convert newlines to CRLF instead of LFCR
> 
>  drivers/s390/char/sclp.c       | 3 ++-
>  drivers/s390/char/sclp_vt220.c | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Applied, thanks!

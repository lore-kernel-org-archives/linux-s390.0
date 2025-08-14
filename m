Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AA2749D9;
	Thu, 14 Aug 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159601; cv=none; b=q9IjCxgWM0JQsarNrs73HrtBvIoJ2UwO1rrcNuYWINmbFwiqete8ZxcgPKFNf9xVOQNgYEBYp+jEXS9kOFHimsVud6CXblcvMHuYh6nv7nj7ZnFcXh2hqRTXX430NcybrkKuxIrQc1RGGMmNSAd7Lcy8+iOSUzC6BWKmkgXUP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159601; c=relaxed/simple;
	bh=5TdMWLNyvRbzRkR4/6Gl/84SFQDQIV/AtAC7R47cjUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch/SUIinzbyOzJN8MDBv3tA4aQ49X8ZJZbnB9jxVAhzhKo6zF9JRmjuJ/XjX0Z9jAUAku25XiH67tSYzceaNLrC5PEf3rsQfSBKL0H38U+3Ygf0qsYuRO1Vy5uXQxZ3HNn+iQokLzSUv/QwHeoo8m9gfh81QyyA95aLTGplQBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZFsi5XMk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZFsi5XMk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DI7Blf016749;
	Thu, 14 Aug 2025 08:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=c1cDrcCciJILEK5837EGfN2uW9SDKC
	YV8qxWLUygYMk=; b=ZFsi5XMkvT8Yt3KRf4gOcZn/90XvHIMXoRndnWsmJsNuOr
	cbrdZX+1KRdpj3K31Xj455PrXYlRC/BAdpoenTeRfKWaWZVffVplYWCwCawbzaVA
	8bptLzQHbvkMVPKbmnZZj3DwaAZPY+4GVNpDYZ9hdIC+lqGTGPw+a1Ucv+RXSM31
	3fbRQ1AnzoLim22edULm8v6pee9PJowvIdDChMCQgLiHvAn3pBFnK/ATL5afQpCn
	52nX+hddRfsfM6o5Qq6qhvOrx2/wUOD5j6mgaIECsm/pxZ+XtMbXd63YTfJbvhF7
	8j+y+DVcBIwm3PJ/lR7nyqxiBsh17r6Qfcu//Nhg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48gypeaxte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:19:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E4ojRs020612;
	Thu, 14 Aug 2025 08:19:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnq39p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:19:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8JpnU52691450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:19:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD8C420049;
	Thu, 14 Aug 2025 08:19:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A548F20040;
	Thu, 14 Aug 2025 08:19:51 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 Aug 2025 08:19:51 +0000 (GMT)
Date: Thu, 14 Aug 2025 10:19:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 16/16] s390/char/con3270: use tty_port_tty guard()
Message-ID: <20250814081948.7684Af9-hca@linux.ibm.com>
References: <20250814072456.182853-1-jirislaby@kernel.org>
 <20250814072456.182853-17-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814072456.182853-17-jirislaby@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eaU9f6EH c=1 sm=1 tr=0 ts=689d9c2d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vj4iyNoY2XoMar_OaJsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: o79fJ5Lv1ee_yjyj5tNBHRFTMkK3KCbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE2NyBTYWx0ZWRfXxcw28h2QwDxl
 J5WO9A0+I2q2f0VAVhxT5+0Hw8quYbEGDIJLb6WiEtVVYYghuZQA05/dytR3VHwjIS+B478QR+E
 tvj5L5s2GIyIjHP54h1ZHyzFzQZw8j6MJ/8RDiceZRECyv3Hw6sb0D6b0mhYjAg8Jd0oLvs9t4X
 8LxUHHxj+9XZQjxn9N71FxWq0/NozNL5aYZVRf+CzcMIHO4MNSMljmtl6Tkyb3Vj9rK6L+2sxOF
 T3bgMjk0Vp+nwd+bhF2o+cm3c3m+R1fUkOQU0gOWStyw8dYh36K7qJN/kKjCWPj4sasabP6/r4+
 ziV1H5W/I1dMsmtcsZMqOSVgKSsoQBgcibnlla9zhZUZM6RBKg7TKUAbgGbtSPznLv1FaD2KsCU
 ME8/ah+l
X-Proofpoint-ORIG-GUID: o79fJ5Lv1ee_yjyj5tNBHRFTMkK3KCbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130167

On Thu, Aug 14, 2025 at 09:24:56AM +0200, Jiri Slaby (SUSE) wrote:
> Having the new tty_port_tty guard, use it in tty3270_resize(). This
> makes the code easier to read. The winsize is now defined in the
> scope and initialized immediately, so that it's obvious.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> ---
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/char/con3270.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

...

> -	tty = tty_port_tty_get(&tp->port);
> -	if (!tty)
> -		return;
> -	ws.ws_row = tty3270_tty_rows(tp);
> -	ws.ws_col = tp->view.cols;
> -	tty_do_resize(tty, &ws);
> -	tty_kref_put(tty);
> +	/* Inform the tty layer about new size */
> +	scoped_guard(tty_port_tty, &tp->port) {
> +		struct winsize ws = {
> +			.ws_row = tty3270_tty_rows(tp),
> +			.ws_col = tp->view.cols,
> +		};
> +		tty_do_resize(scoped_tty(), &ws);
> +	}

This generates worse code compared to before, since an extra not needed
"if (IS_ERR(...))" check is added implicitly. For this particular code
it doesn't matter.
Just wanted to mention it, since this is not stated anywhere.

In any case:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

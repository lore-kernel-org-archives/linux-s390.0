Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9F431E41
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559875; cv=none; b=ADW9gtrlbB/HofU3bIsQnQyoVTJ87z4mX7tHeS48VdZtUOsLX+OW9TrNbSdXaScW/2dI5ZkUgAQODDE7JqmUuEiC4LePrEsnSrvGzRl+I7UK+kzZQDfNtwPAV/+Thxp1SN+l1qzkkQdqZfW6RHSxXU5ZTlCm+AahUP4rWdeAqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559875; c=relaxed/simple;
	bh=bxKZ2CaIOlfMvAvBUKeYlmEvzGb7WDxe2IN/Ml0ZiDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKRPwCcqq7UuWHJq/pE20pVhdDYrB95x/TssTgQV2KGpdJ+JW4DiHPaKohmTxD5M9ffU4p5RTOCSNO3AyxBWVSeVyMncImcrPBwkA2D+B43Gmy73hh8LOJlpnfkQD+IQG5WMphk8RpY1j84O6atCxYgx+Ogk9WRXn6zYVjMonq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P0wTmeeW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P0wTmeeW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KECDIa2324919
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 15:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oCfbLffwSxojTGMAqK91Ck/Phgjhdy
	IatWX+HWK9WaA=; b=P0wTmeeW2syLlyiDwVKmJpWWP8T0gAiu0WABpUqVhc12kO
	j7y78A28i4tR/tTMDneGhxX5GevVPoIQjaFTx+xU0NvLXqoIuSSFjT3pnRTYAlXh
	4dWokqizTDdGxtwBCW/GgJTitHBypSiRgbVwrCAVB9iVis6iUKz1hnk2DBeVOc8E
	14JKbdqL0q5qMrBBMXgo4t5WcCBgwiSmKLxyrXCT0nNI++BMWmBaiRuu698EULxy
	NRFMHlgHDEtdCIcSu22KJRvUDtRsg6/uTbBSvL8d/Z0F/Iq3BOyKaFHDtbOuwgeM
	7BmsZVCe97rOQwnNjMo0PMYV7Lay0fJZvRsBtNcA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fyt9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 15:04:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KEne8K003045
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 15:04:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagx2c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 15:04:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KF4Swq53019036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 15:04:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A32020043;
	Mon, 20 Jul 2026 15:04:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD2F120040;
	Mon, 20 Jul 2026 15:04:27 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 15:04:27 +0000 (GMT)
Date: Mon, 20 Jul 2026 17:04:26 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, fcallies@linux.ibm.com
Subject: Re: [PATCH v4 0/1] Use mutex_lock_killable() in ap_bus_force_rescan()
Message-ID: <ttihb7e@ub.hpns>
References: <20260709072500.55706-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709072500.55706-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MyBTYWx0ZWRfXxdj7AHCVysZV
 1A6AYE1BOJzGzDd83LfDqbWkJPB1HMkHegkSIO9IyHtCYGxx9YsRo8BNendqXaqJkh9md2PrJgG
 5BZ+Y4PHD7SQzt5Tzgxnh3hdei8W3Yjz5/sTfgE3RWKNlrsc8rwNAX6qdvGfXzD+mDeMo0g7maO
 CDXNFe2IkxgsQrH3l2vtOH9rWqFIc90s/ZrjQqgsJKkB3Uy1mjinhfzZN5BcAKdfpKcEVb6ZTwb
 sM9D23YWFJ3wrRWyefHEk6E/emd7bxsHYEosuiLUhfneCCebdOxyBxGr5Dptz0nEv8LVi+0zOil
 u0VHgZPe1kAsw9OdX3EJKGFcQuPEYe0Vy5K0v8rmMhCJFtVzV0y1R3S3uQT3Iesgw7PDc+Gn0zZ
 Ku9SiJ5sU5ARxoDR20YFBB6Nba7MRn4WCi7aIn+6fL//wDq1/5Rq0E2wsafOx9mfzj/XOOR0tvc
 qys0ZuANOZRzWE44ySg==
X-Proofpoint-GUID: jPGMaefP5lk_2pNr9z3znyxG_zF9jRz2
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e3900 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=79eZy6gn7Uk8yBYMtSgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MyBTYWx0ZWRfX2M4XsMNYJCWd
 WCosnjDlu/AWZsUo9vYKOu5QBrw9YdbtSEVdlBFD8p+Rs8Cj0Qdesg0oRA8ecWCBlwmBI9Oy3Ae
 ASO1s7wB5NiubOmUtPpWQnFn71WXhZw=
X-Proofpoint-ORIG-GUID: jPGMaefP5lk_2pNr9z3znyxG_zF9jRz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200163

On Thu, Jul 09, 2026 at 09:24:59AM +0200, Harald Freudenberger wrote:
> A deep dive into the AP bus code and zcrypt device driver about the
> usage of mutex locking showed that there is one questionable call in
> ap_bus.c in function ap_bus_force_rescan(). This function may be
> called in kernel and process context. In both contexts only one info
> is important: was there a AP bus scan running and did it result in
> some updates on the AP devices. So only true/false is returned but no
> info like -EINTR. But still the mutex lock call should be
> interruptible to be able to kill a user space program blocked forever
> on this. So this patch replaces mutex_lock_interruptible() with
> mutex_lock_killable() to  be able to handle SIGKILL especially in user
> space process context.
> 
> v1 - initial version
> v2 - with v1 came up some discussion from Holger and Heiko. Heiko especially
>      wanted me to rephrase the header of the patch.
>      However v2 went out with a rewrite of the code as discussed and suggested
>      by Holger but Heikos complain were not addressed.
> v3 - now and finally I rephrased the patch header. Let's see what feedback
>      I'll get for this now.
> v4 - Rephrased the subject, Reviewed-by updated
> 
> Harald Freudenberger (1):
>   s390/ap: Use mutex_lock_killable() in ap_bus_force_rescan()
> 
>  drivers/s390/crypto/ap_bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thank you!

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511080;
	b=QaFwPSyiHj52Nt+WbsINIeIzGa2wBuWU6jV8ujA6YhlC+PC3no6fJdEfcJpcsO1xqdVv
	 rPAKARXQJY8uMhHXmdQWvSQgDY/NQ+oETtwTz1JJK61KDJV3te0dHRQQDyYn1MuJfb0C2
	 /TBIJ+ozX490TVPTCwUPyJD3Fue2QvqEX0MwjgEZ48hyqr4trXy/1IGW3PawewCcanZf7
	 4xO76guyleOz4UToODgekMpJzNrPhLRd+zpXHit026IlKVoZqdoZ/ZUVZV2Luc1MT/Yki
	 tRz6RqzlT1W+Qn5T7ykDAzG8Y6nhMIKU+BMLwRuZD/U1mdm8VjbrROn8s6apYrO2j1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511080;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iRELXzO7m9kSgGv8YZd/fKnsAUdJpPZMK6ooUW2tEbk=;
	b=bvDYKZZqf/4Hkl1ftDgmTFUk+03i+1I1QRjdImODbXr0Un+N2LwNGtpHz2NXmAa+AyWV
	 foclko1DEgqjgY+91PuHMrGb4Xn6i70K9LRLhy4/ztnPewd3Mp7v4BN5Wy7NSErRWo/Qs
	 tIW16n9yincT56QrA0mTsBQk7DRWHacx2xNQ2AvG7QYkd8GHsjcCckNt2chve7yywQ7O7
	 WSj55/kd7xNxCow7SsENjN7268/XKaDFfLGez42qxMitw3f6+G/5cpnwOszqd8UkrN+Th
	 cgNHGQyqRU7ELKCJk3FSFUP4vA+zPFbHMdQ9eipP8hC+9rZoc5FzMevZ/LybNThQszw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mRXh+bAZ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82530606A31D;
	Tue, 20 Oct 2026 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82530606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mRXh+bAZ
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDEFgU870693;
	Tue, 20 Oct 2026 15:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iRELXzO7m9kSgGv8YZd/fKnsAUdJpP
	ZMK6ooUW2tEbk=; b=mRXh+bAZU4+GgxVOYzMyMsm+YfXy50JOpXgnJjvd/1A1Hw
	LMnI9bZI5t3WNiTa+nIOYC45grdw/aWI7SvvfIKOD/n1AlvTQiCgtV/GdrI0GLp2
	kjsXy+IZlQYAaBInjkA8CR9coS3vCwMfhqTVBt5M645/2+jLw+xPBZDsC2neWpbz
	MrssQ7zz03YTqLdbGBYg13L9eMMSZk/H6yQN24L3SXJdNBTIRVJS7MV5+1/Um7yT
	J3d2+52tP9vocwEwzMaCLuTOaBntxIfr5nXucOOXtpxaTZ9e+JZsbp8W4Qh7UYdz
	W+iow87nKlIyNf14XLo/oAuSYEXnH40IVL0ryqpQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bbr7n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 15:44:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDJrTk1500996;
	Tue, 20 Oct 2026 15:44:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs0u1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 15:44:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KFiQvf50987414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 15:44:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 067882004B;
	Tue, 20 Oct 2026 15:44:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B193620040;
	Tue, 20 Oct 2026 15:44:25 +0000 (GMT)
Received: from osiris (unknown [9.111.79.24])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Oct 2026 15:44:25 +0000 (GMT)
Date: Tue, 20 Oct 2026 17:44:24 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2] s390/tape: cancel delayed work on device removal
Message-ID: <20261020154424.11179A48-hca@linux.ibm.com>
References: <20261019225606.1864082-1-tristmd@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019225606.1864082-1-tristmd@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: q4Nsocebnq12uBN_x8eXUjFn_4IfsPlZ
X-Proofpoint-ORIG-GUID: uPohOZ3M8s2GzHMkn8y74xzP51OgZGLS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX10mq3McSe6Rm
 ys5zq3MVjYiekdU60yh7axc+GejGgn2QpLh6gQswp3qNzGrrbPSwB02xQzO/M2MjgZdCJ+GIr2Y
 yrdspkXPgS3Hic0WaCNelBjvN6KRNNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX1sDFhXajdop9
 lbK8ehdpCKTxdhdYCbnwdU841DBhtqcqArB7mmrJJuuLrInJ/q8UsTr8Cf881ouEATbPrVg6oBQ
 KESi0gLO5c3LQn+csHJZ180Mmeq/BkphimeY6JYgNYmR+PcuP9PRtg494JY9/RdZiqKhQnnqh6I
 97A3OytaD2PTJBS/rTXzZkcHnKXKIxd1S3tqgK0jwVQTmL8P+NL+F97gQ6wXS4ZAwSQ7nUslehO
 PJlUFP9apnkdXTbZ1bKYLn+FEwcDV3cNAozr+0Fh1Oe5PYHopbQSoLqJ3E5GGpYq33jdHg2BoiZ
 DMY/BFQzhRpAH4NbUX5nE0n9yNlSP415Lzb807Vg53adg2+AoTTL4dKE9OsNtRM0fZqgh8Z+Zog
 yyRkoOboM9qkSildApy/wvGyR3exrCIe5N+h6DNU/hzxtT0mkGshJCXv96/8zu+weNcVT/l5aTj
 oJNMfxrpqA/F7ryzceg==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad78c5f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=J_-Nd1mkAAAA:8
 a=VwQbUJbxAAAA:8 a=lsLW7AkFJFRMs5hC4yMA:9 a=CjuIK1q_8ugA:10
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200062

Jan, this is for you, I would guess.

[full quote below]

On Mon, Oct 19, 2026 at 10:56:06PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> tape_generic_remove() drops the device reference without cancelling
> the pending delayed work tape_dnr. If tape_delayed_next_request() is
> still scheduled or running when the struct is freed on the final
> reference drop, the work function dereferences freed memory.
> 
> The cancel cannot go in tape_put_device() because that function is
> called from atomic context (under get_ccwdev_lock with interrupts
> disabled) and from within the work function itself, both of which
> would deadlock or sleep in atomic context with cancel_delayed_work_sync().
> 
> Add cancel_delayed_work_sync() in tape_generic_remove() after
> dev_set_drvdata() clears the device pointer and before dropping the
> final reference. At this point the spinlock is not held and the device
> is no longer reachable for new operations.
> 
> Fixes: 4111796d89b8c ("[PATCH] s390: channel tape fixes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2:
> - Moved cancel from tape_put_device() to tape_generic_remove().
>   tape_put_device() is called from atomic context (under spinlock with
>   IRQs disabled) and from within tape_delayed_next_request() itself,
>   so cancel_delayed_work_sync() there would deadlock or sleep in atomic.
>   tape_generic_remove() runs in process context with no locks held.
>  drivers/s390/char/tape_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
> index bd8e3deb11993..cb5db2cabd21a 100644
> --- a/drivers/s390/char/tape_core.c
> +++ b/drivers/s390/char/tape_core.c
> @@ -662,6 +662,7 @@ tape_generic_remove(struct ccw_device *cdev)
>  	if (device) {
>  		sysfs_remove_group(&cdev->dev.kobj, &tape_attr_group);
>  		dev_set_drvdata(&cdev->dev, NULL);
> +		cancel_delayed_work_sync(&device->tape_dnr);
>  		tape_put_device(device);
>  	}
>  }
> -- 
> 2.47.3
> 

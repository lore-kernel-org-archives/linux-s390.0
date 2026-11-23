Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442145;
	b=jR+r0TWuYbM3jri02dMeYMetXd356Gf+zadxAHHTIJl2kMnYlpAKu52+MmGnIQ9Y2F2s
	 Ovq/msANJsz16acAdaU7XDPW9QhR2xCYFFNP2Z1xe9RoCRHGQb76oKT7BfDppFsqUy2zI
	 axLxnuUARAlf2TUlJRqbRI3Ml1JjvXGNY2NIyoBfEkgxjT+tcvXjvJ/n6D9DHVd+dkSwo
	 PjdDoDsZxfQDDaJTXnWYUnPLIYMfkyCUKJTU1UMR3QkrcDE5emI3UYFAa1GQgzmk8vDlv
	 ZFmOKc0DCQq9f9FWVU83ofjpNErrsV4myEYxZ38S2rYCLmYTh8IiPimzHjKx8WI3hCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442145;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:Reply-To:Mail-Reply-To:In-Reply-To:References:Message-ID:
	 X-Sender:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gIPXt/+bM63fjGxIjoB7JBdhrAARgaP5EU3/iuA05zo=;
	b=mnotkLN1hHzk8WNOMmNblK4HHZ3uBXXmnR+MfGeQpHJ9EO29d51jqKgk2ARZjW+vDVql
	 Tec/W/chrKnzTZHPJA/KxoMepOczpdidCGaI50/WAuv2StNWvK7DE9EKjpzS2vjQ9Ij3z
	 7xtqkfgUFdlGzRl7kg3ZmdzidNAB5fdMtdBo2U+w45R/dtQY4NN6PfhzcDpIA9OU+8NA1
	 xDG8QSUZXUztDCuatnaml8D7lKDNzn/QIqvT/DYyAuVETZW5QFEG29S4McGAcuvEa5LhD
	 3xmwVd+Ntw/6m9rnNIbwZJ6BueKNfi5sOgBWeNDjwYMTwlS5RY5VWW1kZHOgPY0Q0zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kzmfZLKr;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC4606A31E;
	Mon, 23 Nov 2026 13:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DFC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kzmfZLKr
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDYvrG3885567;
	Mon, 23 Nov 2026 13:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=gIPXt/+bM63fjGxIjoB7JBdhrAARgaP5EU3/iuA05zo=; b=kzmfZLKrIP3P
	IY/Vco4C4kz9q0DhbAHYN9ii+MJQp0a8piSCdgJAiir5LLvpA1t+ljXpc7Ofnl/C
	839cXmy25GBw5UtrHQxdD7RUjiIVViGf2gX4fE6WkqpJ7hQ4d+JYeeYnJ7EqBjqI
	08uwg0BwdEfYMi6uSA7lp0iiWRXOdlLpdWpYKDp3oVtqBmZFL0KRrF+hKfFWIR79
	Yi1Js9R7LufzsPTApVZIt4lWV8L/Ub8ScvJ3iOQVGKSm5pIfMHmKjdzH1KxALoyP
	hhLzWKO9NkE5l9jlM1hQAOmwrMcslmHWGktyANPqd4c+eL97b5XjNyZdXlwm3mvc
	uAmO5Kjp1A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa3ey3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:55:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDJds53030689;
	Mon, 23 Nov 2026 13:55:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h6x5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:55:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANDtbnI29360752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 13:55:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC9EF58068;
	Mon, 23 Nov 2026 13:55:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F077D58056;
	Mon, 23 Nov 2026 13:55:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 13:55:36 +0000 (GMT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 14:55:36 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Farman
 <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tony
 Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
Message-ID: <7ff78d9a05bbec91fd494938508c1567@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX3pPKp3I7tVkg
 hFcsQZiHl3zIM/agLnjqmqyoYftPBj4H49EUyzylenB0BFxd4M/2+SAB8FMOY0hKLbSwapgNWjX
 ZTzWX+2qpAfIK0JdlB2Jl2wgkJ3ok0JIaBtI0lhlh5Cf5hYccbDTSLhTgC80pKWTVilZWCBcIja
 q26jlJ/IYHXu7UOl6Ru8oAfqQh6egiWlXEws80ku7A+2BzqMlC++/zzbaOPxBZS0sdonwSf5ogx
 rjX6ai47xSWiYU0cg16+5n+mVC/7pWcAqA1uH4D+5b31uXjr4BETb5+vZsPxNj7L5uTsBSOLOaJ
 80UjyfPV/2u/knEaUTT5qX+eQwWSkHzXLKOnc11jiSneM1K42RWtfPkTK5eL8lIce7MixjBHdXX
 iQduG2pp1QD7GK5pRVofYSg62BtuCbOhyQCUczQj+pOza8788EwbhNUzoWGcwEuJiTdTTSV42DF
 JQAjk2ndQhilxMMyyDw==
X-Proofpoint-ORIG-GUID: qLSMTyvi56QssC3yRpKR7fgW4Y4bsn1y
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b0445dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r1p2_3pzAAAA:8
 a=IpJZQVW2AAAA:8 a=VnNF1IyMAAAA:8 a=b35nFPcqQqUy3iSUCi0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: qLSMTyvi56QssC3yRpKR7fgW4Y4bsn1y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfXwBl6q24OZao6
 5Q+QPE+snqQMSKKSVl9qRZKkDInI+wj7pX6QpDjtoScvAzmZIkUzpFRTczXp57bLwTftm5g0ipr
 X/F/VzFiYKIZYDotqWBLGpr5lpwOcnQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230054

On 2026-11-20 12:11, Uwe Kleine-König wrote:
> From: Alex Williamson <alex@shazbot.org>
> 
> The vfio_ap and vfio_ccw drivers bind devices through driver_override.
> With the introduction of the support_driver_override flag in the core
> driver struct, it's now required for drivers to declare themselves as
> driver_override compatible, otherwise driver_override bindings will be
> denied or generate a kernel taint.
> 
> Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
> structs.
> 
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c   | 1 +
>  drivers/s390/crypto/vfio_ap_drv.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c 
> b/drivers/s390/cio/vfio_ccw_drv.c
> index 7546bd137e4e..77765cde87f7 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver = {
>  	.drv = {
>  		.name = "vfio_ccw",
>  		.owner = THIS_MODULE,
> +		.support_driver_override = true,
>  	},
>  	.subchannel_type = vfio_ccw_sch_ids,
>  	.irq = vfio_ccw_sch_irq,
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c
> b/drivers/s390/crypto/vfio_ap_drv.c
> index 8e69ed286bb9..2d47dc643269 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv = {
>  	.on_config_changed = vfio_ap_on_cfg_changed,
>  	.on_scan_complete = vfio_ap_on_scan_complete,
>  	.ids = ap_queue_ids,
> +	.driver.support_driver_override = true,
>  };
> 
>  static void vfio_ap_matrix_dev_release(struct device *dev)

Please add the s390 zcrypt device driver ("cex4queue") to this patch:

diff --git a/drivers/s390/crypto/zcrypt_cex4.c 
b/drivers/s390/crypto/zcrypt_cex4.c
index 43871cd89b04..2765f82f32d6 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -746,6 +746,7 @@ static void zcrypt_cex4_queue_remove(struct 
ap_device *ap_dev)
  }

  static struct ap_driver zcrypt_cex4_queue_driver = {
+       .driver.support_driver_override = true,
         .probe = zcrypt_cex4_queue_probe,
         .remove = zcrypt_cex4_queue_remove,
         .ids = zcrypt_cex4_queue_ids,

and when done add
Acked-by: Harald Freudenberger <freude@linux.ibm.com>

Thanks

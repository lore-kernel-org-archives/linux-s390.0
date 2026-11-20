Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175939;
	b=1T4l7zPqfIrNgXuuvkdStA8+peFWNFouzjBFOVJcYkA9w+oR5tCpx4C+T3yoP0cm+a7U
	 th4HYvw5SYeC8i7mOjFl1DuHIe/l4IzEMBQ+hiTTpCVd0Re15GhyakeUW8p5DONna1PjW
	 nN1hu28JQebhBaDg6rzw+ovjPNEGTcylbFZwrUarwewFL4hV5VoIiVKsiFh7fI/1hHtwi
	 dmJ7kj7YPovYMIuhVXBJ8AI3FSqfIYSQBQoTNNiNXE+hOj9xIMrhajEVfPuLkhijYPV/G
	 2BTs2q37VwvbaFsCbWuKynMHf8ysb843V4w2bwacqzCe4qQnqJJmAS9tEQyBv1AvPOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:Reply-To:Mail-Reply-To:In-Reply-To:References:Message-ID:
	 X-Sender:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=643jHikEVLMh3nZMvT4w/7bz5bdTWmQiE5NT90PD5uY=;
	b=5l5SGEK5nA8pZWC3SiH9KSKb1Cl2dTRrrvvyrZ6sldhb+NOE484KBs3toOzWmLj76qpI
	 Ew9va/t0awSibr0bBTTeM4os8E+L9gtaacw5gBIStWpd48JSMIZ6AMzq+8WCoJ4PI8wSx
	 qId0EmI/tC6tutL5wovk0lXnsp8ZKKeEQvGN9vXdOJvFbfuUb1YYYzK2SVWuMO4D/KagA
	 cObNh5EzUBH7soc3aF1JLfLjrg2VhFT1qJV0S6Y5m7YTlur+ymzid0Y5L7ieUkpfwirzi
	 UB4nljpUVOnBHY8e+m00BEbhb5qGLJ+oNhbgygZyqXdF30KEL7UvNTQ43r0MQQBk/YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ro4JhA1T;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E0606A320;
	Fri, 20 Nov 2026 11:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ro4JhA1T
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAuP931669033;
	Fri, 20 Nov 2026 11:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=643jHikEVLMh3nZMvT4w/7bz5bdTWmQiE5NT90PD5uY=; b=Ro4JhA1TYx/B
	1g+VmTWKXhwJVyrOkv6+EdiFPoLkWrnisOJgb7PPIMq615E6LoY0XPEvZnl+LO0z
	a/ghSLE5VGDbjtMeOphp2Fg76Lf84WSzzUeq2w1ekXHeN8A6dVzRXKVBOp+tVQ9+
	i5ZawEM6Hx5pKvC6f+I6hyDcOn15HLjBOdnT6Qw/Cp2mA11Qy5x0hHcTTxxITCF/
	9zkswU5COTs3iZvIeZPhCl4+1xgxLIKuvGUgi5FL6rRuqb+EXaJfodZG5O6+NnQp
	pCFXen8h+eG83aX/gWOV4z0D6Bap0B9I3Jf7oaSHavzAAqwzBWgeu1ZDWwt/fp6w
	8W8wouNm3A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w7rkc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 11:58:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKB4pcs355201;
	Fri, 20 Nov 2026 11:58:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j23dwdgvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 11:58:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKBwsG519006146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 11:58:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B4555805D;
	Fri, 20 Nov 2026 11:58:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEAC05805C;
	Fri, 20 Nov 2026 11:58:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 11:58:52 +0000 (GMT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 12:58:52 +0100
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
Message-ID: <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vA3rAfGQn9UEbNMBDcHBKe_wwTnqCVkR
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6b0035ff cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r1p2_3pzAAAA:8
 a=IpJZQVW2AAAA:8 a=ewj62i4Pj_Zr8X8fTNkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: vA3rAfGQn9UEbNMBDcHBKe_wwTnqCVkR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NyBTYWx0ZWRfX97j6kTSozYTV
 nucn4XEuzVRo5Xl62ReCJ63S+s5CBD07IcfHV6Wz3z/n9Gcb3ZI8bgjpIlXZ5Yf+HFVgswLfy6t
 dAA+WaaQj8xO5WWk7zc1vMD+U3Jj6SM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NyBTYWx0ZWRfX+stVmO8EEaeo
 blFE0ltcfvUPWRGbzD7salvphryKkg1BLQyYe8Juu3vbItFzCQzumsX4uiobLRbJrpAtIPLCo1b
 P83JzqPlebXHaTLHmcS7dDn0DHTsQPEXUQJ4kCZ3O/lMae+G1hJPRRBhrRCPzpQ4uHjrXkrMaeZ
 VYxzbHsAI88O3iW0WoGE/thArgu4r3HCtfRqSOeqz3lqRgVFu/tKnfeGfH9Z/yMF9zE/ZtAV4jH
 ElidfSd6zzrEJM520b2gCiMsjFhVPG1Itgr8x9ORcNLshHSLuwQwznAQLPito3E2unKE3jl7WPl
 Ih06aStvrtzkaJIWHHLB/Y535g/xom5ng0cPy/vRV9UwG1zUkaR1QLhHWks06oI8EU1TTTALbRJ
 pRBSC80x+nT35cc17R3473Kat0mLIwMcTrgxvJOPDMUFIyEE7L/WweRQOUVUDPqFh1f/Z8HkPsL
 MVeZcQWjWYXLppafOaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200047

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

Hm, honestly I don' get this...
The driver_override is a bus thing. So the AP bus has support for 
driver_override.
The sysfs functions are in drivers/s390/crypto/ap_queue.c. There exist 
currently
two drivers which shall be bound to an AP queue: vfio_ap and the default 
driver
which is the zcrypt driver "cex4queue". It sounds like the driver needs 
the
tagging about driver_override support and then similar to the 
vfio_ap_drv.c
the static struct ap_driver initialization may also need a
.driver.support_driver_override = true line.

regards
Harald Freudenberger

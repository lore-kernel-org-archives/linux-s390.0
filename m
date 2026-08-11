Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13093358AD;
	Tue, 11 Aug 2026 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471377; cv=none; b=oDWetkQFwWVXhkUNX/EOOoHCk+Nce/yGHcMMAdZ8F7v7ZojrN3cHXouENd5J7Ybr4C5ke8ZYeIFIWogbQnlPgSrkI9tRt3R61JGdA6fqWhlJWNpgfLEwSV+e5VS/VvKubc6zmPQjm3T3b0hBzXBioaM/njWDgchaS1zlEjF7/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471377; c=relaxed/simple;
	bh=5xuQTa1hwC1m7EVud254pZfNU6iwKoZto7/fLlOg60k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt6HO/q0fP/E3JRFien86NxB/fLuwQ7DxEmhO1igfP3GJ4OvgG8Oy20KEhtIUvH+BRfOJ3A4u/EFFUhjrtczbsjDy1wjp4MFY5vV/JsesvpTO9oQtKXUUnRVvwO3ZQtEUsx06dzw9OfGIiSruB7QTw5AG7LGtmjup42GBkrmvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gkH/G3yx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gkH/G3yx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGW23t890268;
	Tue, 11 Aug 2026 18:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BcIOmS
	gmesnI3d0IRJR7Bk4SJaaTExv9j8reBhOTBNU=; b=gkH/G3yxuqbh65QajaIUB7
	O5OjKst9Su3kaFyXiUGq9G8NTbKaNxjT9nvd62HGJ8axZpcNyp7xOdEgsAjsCvbS
	q72pC2FtSlUJLGX24GWKKISIFS7zwXiL6o3xjQqm9+mVpA/IiHfreUIUUHtVkaeu
	dGEcDUswtUyh5sUFUp4wHhTWSCTMRC9otWRzRbXMVz97Dvl6q7UgF1qmI52LUphs
	anHs9G/GUqvk3efhvY3GlDHEfFTFjD8oM6YYblrOMpD9DeVlRU1XPKRtshPbAXSy
	sLtYJSSIb8+abNoNLXF+zOBRgdl8tT5+WUFmoBBNY541maraaSpsJ0qb37+imHCQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9eaf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:02:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHuRPh031337;
	Tue, 11 Aug 2026 18:02:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w274a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:02:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BI2kfH48759274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:02:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EAD45805A;
	Tue, 11 Aug 2026 18:02:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45C1158056;
	Tue, 11 Aug 2026 18:02:45 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:02:45 +0000 (GMT)
Message-ID: <2b37bd31-9626-4f05-9ffe-61193c045078@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:02:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] s390/vfio-ap: fix potential use of uninitialized
 apm_filtered bitmap
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-7-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260810192257.1208410-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Su3bFIzeLoWsb3UhQ0OxgyEjRb-yVyj5
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b63c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=s7ZnpbIa9i7d6vXNUKUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX0ES82WMtBNXp
 e5K9K6hAXxbyfGTXbte0gDZT3oX0E9m+8K561h6b4aXx0sem8jcfcrv6ELBR0vuooBrGc/U92h3
 x9CtdWOzbxm+jcMslCazUdukNb3fxH88J8fEGAjgyDziNv/ZAjNBc6p1JWpmFp9VMhlYcyJ61T5
 6eMAFMG+nEFZ+80Mw9A4Ld+SJrv/b1jPH/ISNTzDShEiFnlrBtuYM6VIjKVO2RTaz8vxGrav3oz
 CvQnxUIkmnvK4p1iwkpo+ZQNpD+6kjuDuRNgQ7mX7iAzqrRyU6De5qE7Qw3+bUqZhoiub4kHB/D
 l4B2kfMR7N0tEJiiPbZdPyPmYGvW4rH6DUEsu//3QqfUv+kjplb5XHejB7WeNrdDVuTYp/lUxm/
 6OgBJpfyM9FA5b/u8cswk3N0OrdLAi47erw3oz8F3Xl9uRfcqx4fP6+YJIJ1hPNRjmsa3xmeMQk
 ljrRyWxA6bteEtEUo+A==
X-Proofpoint-ORIG-GUID: Su3bFIzeLoWsb3UhQ0OxgyEjRb-yVyj5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfXw8zaaZLIcgGT
 UtnYv1P9EqesS6xST4yL80rBF8j5iRYJxAspicVUCkXfbTyYqkUusymD+NiyIWG026b9V/4ak1p
 R3+QWjNQY5uPOskQmEw2SZWL3pFt3FU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110151

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> The DECLARE_BITMAP(apm_filtered, AP_DEVICES) macro allocates the bitmap
> on the stack without zero-initializing it.
> 
> In vfio_ap_mdev_hot_plug_cfg(), the vfio_ap_mdev_filter_matrix() function
> is only called to initialize and populate apm_filtered if either
> filter_adapters or filter_domains is true. If the hot plug configuration
> change only adds control domains (meaning filter_cdoms is true, but
> filter_adapters and filter_domains are both false),
> vfio_ap_mdev_filter_matrix() is bypassed.
> 
> Consequently, apm_filtered is passed to reset_queues_for_apids() with
> uninitialized stack garbage. This can cause reset_queues_for_apids() to
> interpret arbitrary stack garbage bits as valid APIDs to reset, potentially
> performing unintended guest hardware queue resets.
> 
> Fix this by zero-initializing the apm_filtered bitmap at the beginning of
> vfio_ap_mdev_hot_plug_cfg() using bitmap_zero().
> 
> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko mentions an unrelated, pre-existing issue with cfg_chg_trigger
that does not appear to be resolved by this series; please have a look.

You do not necessarily need to add another fix to this series, it could
be a follow-on.

As for this patch:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



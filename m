Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A843AE6F1;
	Wed,  4 Feb 2026 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206401; cv=none; b=VL1672O4FXufyWFSbgOaNlVbiiYZihD6qDzIeF2yRCugCAv/HGU1T/8E8/jB1ACVmgnVstC5gJVhMO5yxICF2BGgUUKhMIWNXaXdEyDC4cd52twMQnlXcCsNiJKHvj/u7OtVoBz0a+16JrjlhDS0FEow/SM1a5RP/pexoAsq8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206401; c=relaxed/simple;
	bh=Vr7Y8z/YxVKaTuEgCuqaV1FOq3SduDLqthQhz4KUgbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f53uhB3dOg3iuFpFkqqtskX2ob5ZvLyjHorNT0eLeSwQ1NAUKg/aIvad7OZWTt6gGEvqMyoozdfx+nAcoM092fepQoiE/Q2aIGqcQwAonK9JSrqOX5IYEK6kWADhPozMyZvurZUHXDq0M8GGDK7muGukYmNwzSUyiFoNjHhqqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NRWqldaZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NRWqldaZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 613NvHrk003772;
	Wed, 4 Feb 2026 12:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ujrwkeYUTf+dclfPXBLK/OTNQuTO4s
	ANa6xetfcXDaw=; b=NRWqldaZrnmQ3zscDxwZOOTaEOlLkgCYAC596pNmjHo2gd
	Njmln5DKSVr/3ctiVUN94S4l99QI2BGPcdUKLh/t/so+SzMb8OVycYv4QGX/5Zwb
	qyb/XfXv8Ly4E2mFxQ0WJ8nF9ghBT2ROdWxolrw3WyTNFRfrSjZoaDcDGmHV4UYP
	SoKsM2ns5C1WP8owJ9Ur7nFFVYlqLcdqdwYMQUqKfaa9HtxTyeHVAqnoXk//RXOE
	Hf2ys/bopXZnvdcWOyB1lofu0Bo9Lqh9+fLdN4E0f62w9+//JsZpGKFKLAhGFtF3
	l8XmxzAiG9mTh0UVRetJazGHRUawXOXTvG7bJC+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6hrud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 12:00:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 614Bxxs6016546;
	Wed, 4 Feb 2026 11:59:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6hrub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 11:59:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 614770Hv009115;
	Wed, 4 Feb 2026 11:59:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vey55qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 11:59:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 614BxsGT50987458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Feb 2026 11:59:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62FC720043;
	Wed,  4 Feb 2026 11:59:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B3120040;
	Wed,  4 Feb 2026 11:59:54 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Feb 2026 11:59:54 +0000 (GMT)
Date: Wed, 4 Feb 2026 12:59:52 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: fix device lifecycle handling in
 css_alloc_subchannel()
Message-ID: <20260204115952.6906A12-hca@linux.ibm.com>
References: <20260130204800.217395-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130204800.217395-1-salah.triki@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j6pJYB_dMME3BRXwEWgI8-pPWHYkB2V0
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=698334c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=8-j6lBzqcow7hk2kIeYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: YiGDQ8oau9l0eS6hwgON248ixZ5MUKAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MCBTYWx0ZWRfX/bk36/HxnML5
 QX1BT0+INjiUaAfruxY6XzLBZdpCf2AEKQdIJh3DA9ctQVmQkLl5Ncl3IkjKV8CC9Ik0Q5uvwtx
 1uosJldQGiJmoO9lmmc8IKrlFyWPXEPYmuoJbDRO+7/3aeoqDjpIpJi4Ts3T8qYV0cSb8jBBeYZ
 voSVtDPMjsRqKQASrSnL+A/3sdjCnGB4SGFxwlACANtC3WKUJb86pkrKJ1EIsCQ/hpiaf4x3Zuw
 M9oz1RIiGGLLhdZnsqdLVou2x5vwACynEvILyVvymeoa2UrmNq049t72hjUjJri9xo2sOQZJjtz
 2EHyubN2cksbPr4YjZnsMomcs7g1ktPr5Rat8vBGrsUjpHyaTUQJ1Ryo4ZdIRxEKqr08/Ckva9n
 eaozMmwb1dvPU1XLUmfs2VxzhOQlFnnzju/Bf6ZmqiUWoyjnTXjYMXyStlizWDyOW4gelmtjVN+
 OqVPyUu91xV7ERZUo1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602040090

On Fri, Jan 30, 2026 at 09:47:59PM +0100, Salah Triki wrote:
> `css_alloc_subchannel()` calls `device_initialize()` before setting up
> the DMA masks. If `dma_set_coherent_mask()` or `dma_set_mask()` fails,
> the error path frees the subchannel structure directly, bypassing
> the device model reference counting.
> 
> Once `device_initialize()` has been called, the embedded struct device
> must be released via `put_device()`, allowing the release callback to
> free the container structure.
> 
> Fix the error path by dropping the initial device reference with
> `put_device()` instead of calling `kfree()` directly.
> 
> This ensures correct device lifetime handling and avoids potential
> use-after-free or double-free issues.
> 
> Fixes: e5dcf0025d7af ("s390/css: move subchannel lock allocation")
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/s390/cio/css.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

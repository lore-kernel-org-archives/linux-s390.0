Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399F385D99
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225221; cv=none; b=WuFuIbmIuXAH09m6MCUKSXP6OzerJ+3RZ2DfXykbjlm2BFQnMPydTrznJqX3SnXsUhhokGlDA7HRAbDG2E9rhc9ZHWgD8Effu52CHoCfCp4YF4nMEWOL3ACDydRj4dGZ2P13TKio3Pl6IIhiUGztKVIuNxMXs8XHmyMdi3h8jqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225221; c=relaxed/simple;
	bh=kzN2PI9PUvSpUHxPwn6a8StE4UysaWBSPZmb5r1FuW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHBywmyUQuRghDKsbPsYYKWtvx+gQe9nZbuGhCZmZgRCq6/XOlrPNp5/6KIEVrNhgRinlKO61vuay5+HIQA/Yze6XWNOqpj29tYuISBkanzovV53MeOGFzDjjGr/OC4umMO/ZJSP4/mtWAtVZhlIuy4DZY1tZDP3srMc0dzgUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FY8aMjbb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FY8aMjbb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBn14W1858416
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7V7ydY47YFoavaImNJphW2phlHK26Z
	MBifLvNDrKgyo=; b=FY8aMjbbmylojZmrjAf+Y40p0TMzYaWjLVe4U0u0biwa8r
	Uso8zZr9saXXrtZ7yVRDFLmKHF7KG+5KABbC2Zt2+YMgSpjlI4pY2XkXe0BdFAkM
	F52mGCl24GHhwR8d3kqJU2c26i9tr3tECFcGhlOH3BpJXrc7zKMF0M1Lg9+6A9Br
	egKAVkRX79YKTqcH1Eoh7HzhmwJNLI+OcmXL/WAWRbAI2JKrMwI1gzKHkLizHswq
	Dtio3bSGUe7dnopCJmQQq8brVXmTDkC6XUX9gQWHNnevP1XD6BUjCAsVYScvgVL2
	yGMlI3G9TV5WUmDntHwloK9owREZYngNYvDYbeYA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hqa6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:33:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEPU41006678
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:33:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phbnq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:33:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEXYt853543254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:33:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81CB320043;
	Tue, 23 Jun 2026 14:33:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 627D820040;
	Tue, 23 Jun 2026 14:33:34 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 14:33:34 +0000 (GMT)
Date: Tue, 23 Jun 2026 16:33:33 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] pkey: Move keytype check from pkey api to handler
Message-ID: <32d01478-5635-4e6d-99be-b0c94b15d1ec-agordeev@linux.ibm.com>
References: <20260623142031.4053768-1-dengler@linux.ibm.com>
 <20260623142031.4053768-2-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623142031.4053768-2-dengler@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _SKNFjIjtbhw0JYiWYd4fUuoWUYlorMf
X-Proofpoint-GUID: _SKNFjIjtbhw0JYiWYd4fUuoWUYlorMf
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a9943 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3E0XOnSsFRViUpdKzuwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXxQjfqIK7uKcl
 CVYcryZrSF2FHZxr+yiy5XtrTC+z/43W2uVToZHjh0qf2WZ6cCOPGet22/KS40j+Q3ykYjVMDPP
 3jIDrKJKEvlbbKaJHRGJOkxbnGv9Dh6pNE1lB2AD+NUeRBlDA2r3D6OqlJGkrHyVhlwJsOtK61O
 XPaEHN/hIIUQOu/+caYLKsC05TxD/23ck24mRvXsf6dDRcPsaIW5vcNpsA6P24nlrze/KWGneGr
 FfpVxQZNX4S0n5JkrYwzdI5zT84aP/0lBx7ZUVjwdJEQrFL9hdHqBCYQV2sP4vR5iLw6RprnJr6
 bC8SprxOG5IvA7jM6+DBj2DotqFEbS0Fn6aFIBO/GRIKTQdcKMddvEGI5vw8LpmSSHD/R0QqE7x
 NvlpIJ6FhugY1Xa0B79zhOlKwA6nr+Etbi2fzcGpZWs0wlN5obq+rCQGf54tzdjlE/lmVv48eNQ
 sl9AQ9MnfXFbUlgUykA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX/9MLg5TnR1fk
 3PrWEtTjps6q19vEAxq3UuN5TjR5C9BaLMSYayDhXFM1WzzfOMho4IpN4zEASAERmupKZXfOJxd
 wxTQ/8dFWhaF37AijASNeWYQ2t4uw5Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

On Tue, Jun 23, 2026 at 04:20:31PM +0200, Holger Dengler wrote:
> The PKEY_VERIFYPROTK ioctl takes data from user-space and verifies the
> contained protected key. While checking the integrity of the ioctl
> request structure is the responsibility of the generic pkey_api code,
> the verification of the contained protected key is the responsibility
> of the pkey handler.
> 
> The keytype verification (based on the calculated bitsize of the key)
> is part of the protected key verification and therefore the
> responsibility of the pkey handler (which already verifies
> it). Therefore the keytype verification is removed from the generic
> pkey_api code.
> 
> As the calculation of the key bitsize is currently wrong, the removal
> of the keytype check in pkey_api also removes this wrong
> calculation. For this reason, the commit is flagged with the Fixes:
> tag.
> 
> Cc: stable@kernel.org # 6.12+
> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
> Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Applied, thanks!

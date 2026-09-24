Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C544E042;
	Thu, 24 Sep 2026 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266140; cv=none; b=uR7a0SY2O2ARgIJtT2PXngbjiQiVrRKWhC9hiwaxqb7vcvBvbbaSKKgFhuViuy7mDlf1prM5Skm7wNIMr7bx19EilZRN3QsfpQtILt4vlh+LxTxl0gM2ZR9U4CKyv/04U9FQOH4ZKKLZ9TFmEFjhAm7Px2TkopOO5++AKdAWsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266140; c=relaxed/simple;
	bh=AhgTXSLZaE7lh7aB7BwW98rIjwORzXntV/jYSOkKadk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbiUTclIz39+M+LSzq7hVrs1R1v5SOTcm+KGDWeLLZOSCfDj/KRY5GtAyo/fNfVKQGkvpppbM5ZxkKY9wq+ixvbv/PxLM9KGx4B5fqAzo9HD3cFU+DRkJO1UrsZHv6d4bxpH9kMD8V+0F7W778vziBFuo9wwDejQT2PoPvxVgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hBICohN9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hBICohN9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5bK81519358;
	Thu, 24 Sep 2026 16:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UZRqKzukrqaIKiXxi31ZptdXf34p/3
	d6InWbp5gz9TU=; b=hBICohN9FQTcJ5FwqJnLMyUapGdafi4sLvGRUEDIW8M8cL
	1E7MwsRhEWpsSTkz+7QL1N/HSVlSaRZy+djxh/pYgUrQK/czAjeI3awd4BKfMxOt
	+f85EQGFM8nCsx++i67JoMwRS7gIypXkrFLfMn8oUCjv5HAhX5Wc3dNdNgb9+Gm9
	JqPFQG9ORp2jeNv5r6HhCP/9i7ITaAogqyQmQXMdyCqCzjwLWqslSUf4VfLpx6Qr
	TPXCwOzYpQTsSxYWLe33bXxuw2dUoLbLzqebFJWynXr6XFNYnyAdvzh698LCfTtU
	t2QsCOGtH7jrPEkgs8GzuozsU0mFkY355oXWsMCw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqscdx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:08:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlhmH2359209;
	Thu, 24 Sep 2026 16:08:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jxmbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:08:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OG8r8t38470118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:08:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1430720049;
	Thu, 24 Sep 2026 16:08:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E4A120040;
	Thu, 24 Sep 2026 16:08:52 +0000 (GMT)
Received: from osiris (unknown [9.111.55.6])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:08:52 +0000 (GMT)
Date: Thu, 24 Sep 2026 18:08:51 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: Re: [PATCH v3 0/2] s390/sclp: Resize for sclp-vt220 console
Message-ID: <20260924160851.18402C86-hca@linux.ibm.com>
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924104732.1978942-1-maxbr@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab54b19 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VRWe4RfVVfz7S42VascA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfXzAdXWMvK6Uff
 pqFIAu0Fc3/4MDPr35bDvOByu4gOB42EDygor685x90AC1/zHGvZuDTAb3PXKEetkJzsyB7Cfe3
 86KG+uJ24+FLNeCpRoJ9YJfxBwynMhH1Hb56fAn12+zo8D5H8Uxnb0W6X1Ge2B3q5o7qSXhxpd6
 rIuJZwteUhuoIWBj5LBrniHcXuDJlf/Kpu59TPNHehxtrNhz8HIdYAzQssYpEVPzsvkc3fJxgdh
 DdueqYe9OgkLZTJ14732+w5nAVZ38O6cIn3iPzZctHFNZGUm0l7pOhnWLdWcSWNXUKfEHV6WzAG
 uuFDHBblB0PUDd9uq64q0BWyfxXbSkBcqXq3sG/1pFRtJRyq+k99pwnhr6sAvkLX53+djsrsP0g
 tokHyw0t8Do43HWutFywYl3wLYZj52nRWHXgVamGGWyxDsiEFL68g9BjHhu+/YwW3nTkqRe3akb
 jxmTYwN0MqKq21IRePw==
X-Proofpoint-ORIG-GUID: Pouz4O6aQNRn8Dm-OUAyRTgY0cion6CO
X-Proofpoint-GUID: JlfxRZvi2jH_bkEJcBFv1iOKRmPywgS5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX5MExj4wAm238
 cMb9wEf0B90K0ehzi8yLX6ERnqGT01kKqAh5fZ1doQkk4zOqtGPo3rMnwH3qS9YvWBGI0RI+dXF
 4fPTs+CsDbMLCpJkxuHquVFlWx+NCAM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

On Thu, Sep 24, 2026 at 12:47:30PM +0200, Maximilian Immanuel Brandtner wrote:
> This patch-set implements resize event handling for the sclp-vt220
> console and refactors some of the surrounding code.
> 
> ---
> v3:
> - guard against races when setting the initial winsize
> - validate sclp header length
> 
> v2:
> - don't set the initial winsize asynchronously
> - validate sclp buffer length
> 
> Testing:
> - Tested on QEMU: commit 38879a667f with the following patches applied:
>     [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
>     [PATCH v7 00/12] virtio-console: notify about the terminal size
>     (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)
>  - Tested on linux-next (commit c1f49dea2b8f)
> 
> Maximilian Immanuel Brandtner (2):
>   s390/sclp: Introduce dedicated sclp-vt220 event buffer type
>   s390/sclp: Implement resize for sclp-vt220 console
> 
>  drivers/s390/char/sclp_vt220.c | 87 +++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 13 deletions(-)

Applied, thanks!

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E711D432D;
	Mon, 22 Dec 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401223; cv=none; b=sdpBHgd3I45BXK/KUO9EsIQjj/vjpx8elunBNiIUwgF/DNoOWvIhs9VFtEss5XtqW0OP2uv1d+MkYwOonMn1sEeBwVzyKBvHbLGU+53c3BzAjDeIc3hDAtZWKVl7h6CpBIFYt9J44YwR1afMAWr8N3MAq0OGKeyZKp+NmTY4ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401223; c=relaxed/simple;
	bh=aKWMyekD5e/maeRyJ6MbVXRhe6qDt9WMRW20m7Zvyzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKzRNl/N1wdalKvLiHP703zuhVvvoHEGc4TDQCQQMr6VMTYtRR67Lr/nKqQs4FGVRoNAPWJgjsl7pnNeIpfdvvE/EbzCLHxLEcp7vMresqbuTZyxOjwl2o4+wBtSta392+3O2jtvdcGrwdS1ZMDzhdCZJjhwPxvnbgnyICmrHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rkf7S0yS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rkf7S0yS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLMQERo010872;
	Mon, 22 Dec 2025 11:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CChJc9uNp8TenXITLN8y2en3Asn4wp
	jIepbV4iFLDtY=; b=Rkf7S0ySEYFiezSlqqvigBTA0hbRKQh7rM/zdvWdgaQDA+
	MnVuxSXrC0gjBf9aHtSKKLrJpPfJQgI1cZZnk+NChlSXpF6xnj8FuBlyYbBDWcAQ
	yJxSE4mELfm3eAk/4Q3zl1eih2TaaUN/EEnKWM5lmK+Wn+REr5F39E+HcpzilLX1
	sn8O7+i65j5ckkuDCWhv7BhjR3Q2wzDRZKAtXTxLECP3IEgQTylSLnDEzlNfyq3s
	/HUbBJGqxCAt1sppuutCbn/MOVzFD7Y/WDy6cuQODeudn+KEyOCdaHdpXXCuaa0g
	W/w3+y4t6eLZy0043iQ2FerfmTHTsME8rJ9pipjA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7dyftm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 11:00:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9iR1M005249;
	Mon, 22 Dec 2025 11:00:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b67mjwjur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 11:00:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BMAxv4h16122258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 10:59:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57B6E20043;
	Mon, 22 Dec 2025 10:59:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2D920040;
	Mon, 22 Dec 2025 10:59:56 +0000 (GMT)
Received: from osiris (unknown [9.111.59.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Dec 2025 10:59:56 +0000 (GMT)
Date: Mon, 22 Dec 2025 11:59:55 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cmm: Account for NUL when calculating 'len' in
 cmm_timeout_handler
Message-ID: <20251222105955.16440B52-hca@linux.ibm.com>
References: <20251215122214.381098-2-thorsten.blum@linux.dev>
 <4b00c8c6-e50b-454d-985d-0a5e2c3d77e9-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b00c8c6-e50b-454d-985d-0a5e2c3d77e9-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G8YR0tk5 c=1 sm=1 tr=0 ts=694924b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=q-r3hK-U3-Jjxpw14rsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 50f3vMze2XK2Hpz3Bdh9DxrbmoknDRi2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5OCBTYWx0ZWRfX5DLpfswyvSVo
 FyY9YCcqhtIuz67cmRnDHbNJkLDRkS37UDplG3ttoYAOEkF2/1UvZkR8RSH6bD4SN9XWW2p1Ge+
 +duJiLRitKGOFOORDLQ2W4Lk+VGkIqJDSyDImhwi1PKOPPVbvRVGos0s3E5P+Kj7SwKZ86fvddj
 B3MaFGZGFP/2RhhLwnP1ZwffuMXMFCjU/1XYlA1vcMr0Ij2mtRzs2sHGKEke9ksMPePDnsJlO0s
 wJYCYikR4nQQOYtsyRa7IONEsVpavlMTwWzl7aqvPGR+FgXjJGjACrtxa4IBDevh8TDKxAvAXD0
 wQZzTnyotFWX3nuLeUXbcrZqS8ulhWWSDii91j/0T9gIT4DueAcJBi712nIvCvxfxr87zL8EFim
 pTcb8ZkHs2G+4ydIfQGZoRuML0EJI4oGP7lF9H0vMQSDCI/XaLUy46BU9txIdS9I/ICGWGIeGIJ
 uAZvWzsmBGA6Gl/uNXQ==
X-Proofpoint-GUID: 50f3vMze2XK2Hpz3Bdh9DxrbmoknDRi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220098

On Thu, Dec 18, 2025 at 08:57:24AM +0100, Alexander Gordeev wrote:
> On Mon, Dec 15, 2025 at 01:22:14PM +0100, Thorsten Blum wrote:
> > When the input length 'lenp' equals sizeof(buf), the current code copies
> > all 64 bytes, but then immediately overwrites the last byte with a NUL
> > terminator. Limit the number of bytes to copy to 'sizeof(buf) - 1' to
> > reserve space for the NUL terminator.
> 
> I see you point, but can not see much of the benefit. Besides,
> to me buf[len] = '\0' rings like a past-end-of-the-buffer access
> (although it is not, it feels like that on a cursory look).
> 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  arch/s390/mm/cmm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
> > index eb7ef63fab1e..06512bc178a5 100644
> > --- a/arch/s390/mm/cmm.c
> > +++ b/arch/s390/mm/cmm.c
> > @@ -311,9 +311,9 @@ static int cmm_timeout_handler(const struct ctl_table *ctl, int write,
> >  	}
> >  
> >  	if (write) {
> > -		len = min(*lenp, sizeof(buf));
> > +		len = min(*lenp, sizeof(buf) - 1);
> >  		memcpy(buf, buffer, len);
> > -		buf[len - 1] = '\0';
> > +		buf[len] = '\0';

Well, I don't see any point at all: the compiler is able to tell the
same and may or may not generate code accordingly to what this patch
tries to improve. This patch is pointless.

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48F3EFFD1;
	Fri,  7 Aug 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099727; cv=none; b=d18XZ5gdCSJ66SwJUt0mDeV7k6i9Gf761NELphmvJ+kPNgsaHfNA7eWfCwDVJlLpumUcpT/I313mCJbSwyUGmRNlFWh4DCcbF2w/0g1+EI8k/eX/dadirkIrVrqzuue5YltDLl60MrodO2nUSJyU7Q9BylYp9XME4vITjcR5UEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099727; c=relaxed/simple;
	bh=5LArYFi4acBeYqAwpim2HGgGP3D2Q01pT9ducvEak9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPnpKUIpc+Tu/33SQRg/1qN654KvPv/ivl+KfZFUg123y1TDow3kyoKKZXPciALggpomiEbEHTclBITeS4QkMcaKlfQeShp1wqDqK+uRrsR/x4gnt83K0jHL5vjMd192stWg7rVg0DYFED53hEMIbtOCTOym43tt/Xc8ZSayLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JRv9fdmx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JRv9fdmx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hina016221;
	Fri, 7 Aug 2026 10:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CEnTG7gcCpfEaEm1oCaX+iKoNvviS6
	ytOpYlv736kjA=; b=JRv9fdmxabQnpaAnCLsdmmER8qtrZ1mh6iQDlM0BGOG5/T
	oVNKS3reWXO1L/QdnBMC2fizkdYDxGhkWAnW8sfj+gSTk/EBPXAkSbjX1y5BlVQ4
	e2VfiZTf7amjDB6PbGrq0JH/+jcl6NHAwhv7dOMjQqbfhykJTrcc2zbZvMbS9OcC
	+1nJmSlR4786meAR++pYJ0pfywNlMEq/SDU1oxLJN6jK2KBwbp5d5xva4nJQuAht
	1pc8QAQcl+nHlT4oJkmPd4KmJaPiP5xq/TmjDNe6o6pgJHZ61yvj+/K8auJDbJBX
	VygfX96HKoPlx0inptkFp+rAVUaLs+boR2dw9D2g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00bcdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:48:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AfKrK007490;
	Fri, 7 Aug 2026 10:48:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyy4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:48:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Ame5g41681262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:48:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0516C2004E;
	Fri,  7 Aug 2026 10:48:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1AED2004D;
	Fri,  7 Aug 2026 10:48:39 +0000 (GMT)
Received: from osiris (unknown [9.87.138.170])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 10:48:39 +0000 (GMT)
Date: Fri, 7 Aug 2026 12:48:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] s390/pci: Enable CONTEXT_ANALYSIS
Message-ID: <20260807104838.17243Aad-hca@linux.ibm.com>
References: <20260805133627.1216607-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805133627.1216607-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX3NKd0gBuxWMJ
 visFbqb5AEgXLE0m39I0RSsY9gzKRpBHLbSBnRaUDpc1Urukj8HcT0ZRC4TtMthI0i7Q8Eg6TCr
 eiVPeBN+zBkhxzegsZedHY0QJFPb1ic=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a75b80c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=fwKqR1jjidjahWb_HmwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: CMcdk6Qf_J4F8LU7O1kPpJ11SGbMD1f4
X-Proofpoint-GUID: CMcdk6Qf_J4F8LU7O1kPpJ11SGbMD1f4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfXwELHCpUACwV1
 9IU+PaqAz8eBloziPT5Vaw5zDMFkzbDpUFMQ5wdeRKBaQEw4lbN0T8GoOrBIMNKmuN3CR+T57w/
 jjz2y3a7WDGLW2btelmn/wTQrAsdaRFg0meowCbm3dc+ooFEzH34niPc6KIW4q5r6UWmp9gz+ic
 hEZAxoGvgGZA9r9r44onZhOtCiOmez2z5O7rLe0gIwxz0b9WFYvbxRNK45nsDkR1HIkilCQ32wX
 PBxflz1SyLinO4EyA6TLqHVf7LlbH1NcxiB5jPslqePXJ9JGuI1rZB0jPclhrjuzN0AO0hPeodw
 hCHF98Bcc6YsO5C/HOx8QjYUlule+ADJ9l6w1MnqWCS+MBNcagNVrzxY93QCsERa/GnaGamoaEU
 j82lLSZGpHeWCV/zClM2DwHbI9QVtyx2sSE+aKtTFXaeetHuCGRwNtl7mXLME+uF+BlMcHMi0ma
 uw47yDVxBlppgw5Bw+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070083

On Wed, Aug 05, 2026 at 03:36:24PM +0200, Heiko Carstens wrote:
> Enable CONTEXT_ANALYSYS for s390's pci code.
...
> Heiko Carstens (3):
>   s390/pci: Rework __zpci_event_error() to remove conditional locking
>   s390/pci: Rework __zpci_event_availability() to remove conditional locking
>   s390/pci: Enable CONTEXT_ANALYSIS
> 
>  arch/s390/pci/Makefile    |   2 +
>  arch/s390/pci/pci_event.c | 205 ++++++++++++++++++++------------------
>  2 files changed, 111 insertions(+), 96 deletions(-)

Applied.

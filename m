Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03592432BF3;
	Thu, 30 Jul 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417857; cv=none; b=YQsFGP/dpDquP5golkjeseSK0OrqkHJuz96qCRkmNbAcxwqX+7Q4dp5k6EqH2+WFLCl4ZpPlibfRNMmJbWrXgD2+02Qi8mk3xscvV13OCczIVMbsFsOzIiAq0mm78ODAjoo35KXxUYphMATDyEVtEXL35a4Uac0QdiPgu89XzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417857; c=relaxed/simple;
	bh=CZBlwVlIeFXzsIw7gzLI9TwH7N2h4PlidbH50ajEP8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKG1e2G0V9R52OBhu7D/kqVDkcJjit9rvOWd015g+u4eg9skQcw7MbkEI0n7I1YkbSR8Yf0iWflXRWFyP4Y+HXGFJXV2/JtuP/wsBpQPBOQnY1/q8S1PN6HB6qcGQGvwvJhBGVr/GmM+kFX867nnSuqLDE1Ol/DFGCOKEAov1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pl0CFUC6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pl0CFUC6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDIOaY3021640;
	Thu, 30 Jul 2026 13:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BeRZ5d
	agiHSG6Z/ztL01CYE73JO9yHVfQytFgXQerGU=; b=pl0CFUC6CxMlsEODM1FcFU
	e0Mqj6v8T0wb2TvPzVy1/3WfmK1zY4V8I07yLafJZvpFMcAbvNWzo+AaiEaHmHVw
	1aszKJG/8k7BTykX3ccTGVOo9oHvu6TrhE4fa6I+OC5RBxEBKn2hn7WskQshNze5
	sxZ7lSUbBRuIrCYMyIbXii2i/YJ+nrsCNPxsbEWfpU+x5C3djyfYh9P7/m1Xq26v
	Y564YIJZirxht7wB3bI8oOevELgOV2lyIlQRzHjkV39BT6m9ZAhKqmsrWGAZORls
	0+ujnNZrRCjywi0BTwHYE1E/mCaIYnFttsIBfjuj/OglVCVbKMI2rPj5tAWsMGwg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjf11w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:24:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDFH3h007123;
	Thu, 30 Jul 2026 13:24:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yb738-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:24:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UDO8u132244118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:24:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5BC020043;
	Thu, 30 Jul 2026 13:24:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66A8520040;
	Thu, 30 Jul 2026 13:24:08 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:24:08 +0000 (GMT)
Message-ID: <ec968933-5f9b-46ef-a9da-32f7566b73eb@linux.ibm.com>
Date: Thu, 30 Jul 2026 15:24:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update s390 specific vfio sections
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20260730053437.3288650-1-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260730053437.3288650-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMSBTYWx0ZWRfX2s67mPWx57Vi
 Q3doPJTr7QISwAzwalpjvpKahTfpafBZ3juaTnx9ISMBw4Sh2X5ykMNa90U3ErwsreCloFJFJ0P
 BPXaRgAVXm4Wq7L1XwBFd37s2nMZaIk=
X-Proofpoint-GUID: jZGwNqmGCEmoz6h0Q-jUEt0OLMtxHnKM
X-Proofpoint-ORIG-GUID: jZGwNqmGCEmoz6h0Q-jUEt0OLMtxHnKM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMSBTYWx0ZWRfX+c3bOENO/mO7
 Ep9xyI0SVPo6ImbtcMl8lzIHbvwUMvz0T0qOCex7OnsDcMNPuH9SBCxtSMhuXAEDjOI0pt3DmfP
 4hXe6o8QCtj5Az1yLGEZHcq3ungIDCKxJZi/B5cQvLPTLrSEn0URAfppLm6FfkeCnvOqblshh4W
 wWnEE5P1VY9OdSUelWtaIYY6WXcIpSRZSxWdfYtlcIPIX6xD4OEYlgI9qAfKkZHCU7MZjYXSAur
 e9y64u9e0xwtw21Gmf+yCcyVQ2fV2THqSjI0Ez9C995/j+4Ns0S5oSRGEnCQS1v+ZIbTwXMRu9S
 u01QjOJ3o2qf1oUx/Qd2mjLzn6+jAWqotLl+aYe18li2V/zNzLEoSnRjbxQyJj48gFFDUCo6fyt
 Mfv6oB8J/joMM10/LtblUk8wSSndANr26jp3JZGyjqU52kRSRZOkTmNRNRzEZ+YEkHNPVNF1HdM
 ZiDgX/qAL63HJw3XDUA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b507d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=SRijaa11Sq0dWenywQMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300101

Am 30.07.26 um 07:34 schrieb Heiko Carstens:
> Update all three s390 vfio sections to clarify that s390 specific
> vfio code normally will go upstream via the kvms390 git tree.
> Add a corresponding T entry to reflect that.
> 
> For consistency with the other s390 specfic vfio sections rename
> "VFIO AP" to "VFIO-AP" and add an L entry for the kvm mailing list.
> 
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Acked-by: Eric Farman <farman@linux.ibm.com>
> Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

applied and queued for next.

> ---
>   MAINTAINERS | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 716acfc3d7c1..b95bebe8a78a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23890,12 +23890,14 @@ S:	Supported
>   F:	drivers/s390/block/scm*
>   F:	drivers/s390/cio/scm.c
>   
> -S390 VFIO AP DRIVER
> +S390 VFIO-AP DRIVER
>   M:	Tony Krowiak <akrowiak@linux.ibm.com>
>   M:	Halil Pasic <pasic@linux.ibm.com>
>   M:	Jason Herne <jjherne@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
> +L:	kvm@vger.kernel.org
>   S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>   F:	Documentation/arch/s390/vfio-ap*
>   F:	drivers/s390/crypto/vfio_ap*
>   
> @@ -23906,6 +23908,7 @@ R:	Halil Pasic <pasic@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
>   L:	kvm@vger.kernel.org
>   S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>   F:	Documentation/arch/s390/vfio-ccw.rst
>   F:	drivers/s390/cio/vfio_ccw*
>   F:	include/uapi/linux/vfio_ccw.h
> @@ -23917,6 +23920,7 @@ R:	Eric Farman <farman@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
>   L:	kvm@vger.kernel.org
>   S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>   F:	arch/s390/kvm/pci*
>   F:	drivers/vfio/pci/vfio_pci_zdev.c
>   F:	include/uapi/linux/vfio_zdev.h


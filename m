Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3A3E5574;
	Fri,  7 Aug 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099247; cv=none; b=sgtytDlWoXH3Go18OQJ2W4hQiHZa+anNuLS9XakC8QrpONjnNs2psHvz0ikut3cXuXSSdhBqL1gHb6KkeGMD6rK6usBwm4WXhxMRZQjdH4Yj12hB4V1S+6ex8fdPyLwoL78WM6jQymjaYX/9uAZIJrWD48+4zHEKOmZEPAWriLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099247; c=relaxed/simple;
	bh=Hh0qIkcoGuG/9FgUsK7ThhAsyDprPES1Nz75Xd2hKA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iz3kEzAn3Q7mk65HOWTfrK5PXy/t69XEfF1vYphq550S7HMbAYeYhYQvHRunhZ0aXyx0WzxlVY8e5im3vX5bkLWKEqx4l8QJkj08sOQ4YZ78X26A5LUx4ip6NyrZn6rcfc+vcaFanBR/WBOEYF4JnrB9B9YlDKOFGTZpXBMJ6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nv67Dm0E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nv67Dm0E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hude4060714;
	Fri, 7 Aug 2026 10:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UynQnt/bJ4Yx3CyZGxdwOvILJYVewh
	nDkKv5XfvsVUA=; b=nv67Dm0Ek1v1ETFjxqCbX032KNUZKtRVBeuikBX4RCLf8w
	NzH8xu2TYu18ZijVJQRPdWo5rAw03VWCal1tOM98SAuDbJZJlTDIQuMpOexNVYUZ
	z3KoEGeO8dHCADDCbtqAly+Pedv1P732mUlp2NK+bBL5f69LPp2zvIxvuUHAXmJf
	iJTe0TktR4nvIJfp7oMFGEcs8vM4Sx1sw0mFOtmIDlIewGYRIL5WU13tCrRJ8mVa
	zR0bAZ67z2GnxfSAEZWBYlL5WmnsoLxuYudh5Sj+MErVBZrAwNY9eIsV4FaxDTZg
	801y5RnHVM0QzammSp675ARPr/bR/oDWO27Q09yA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02bc0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:40:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AQGjW030372;
	Fri, 7 Aug 2026 10:40:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwfe2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:40:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Aecik30212492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:40:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B7142004B;
	Fri,  7 Aug 2026 10:40:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6003E20040;
	Fri,  7 Aug 2026 10:40:38 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 10:40:38 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: s390: vsie: Convert shift to phys_to_pfn()
In-Reply-To: <20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
	<20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
Date: Fri, 07 Aug 2026 12:40:38 +0200
Message-ID: <yt9d8q6irz6h.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75b62b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=UGrD17pmr59hAtnjh9oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX4xO2E6DWbH+Z
 FKYlJbcRnlSDvIyBNXZ78ZVCywAwcXOEpPFdmhSfxRfTLR1jIexkNokCslvLVIUEXyQ/MzWU5Vz
 aK9SWlT6oXgcmGBwGgdPDJCf9BVBh41odSo380gTsAWxHO77V0xy8YrfMR1vkCBtDIouv9m0fNL
 cBwFXQ5vZiMkZTOCSqZRJoVFmzWHvNIcwQblvtdIhBtpCAHq+GKr/7Fo7sRTVccCsmYAfpxltLY
 P3ObN6Co/Skv1e1y33PS0TTZbgq81k4DbjHgH+xK7gSHceUTUK5qHYCtCy2rx13QLI4bKOJWVtr
 48J/2pavqRaDt04L5CkSP/y0igM8vQXfhJYsxnTZLXH4NuFKeIo/cQjPRWtLwkp7eVjKxISGEyh
 n2LNR0flCEp3o4Lr19lmL2r/FD7kAw+OhY1S9idovqbT467czqptUEuvddlBa0ognMS3DEXbEbU
 sUO3inB5va7cvZUkB1A==
X-Proofpoint-ORIG-GUID: enoMLPpnjYBDLFEGmFmBZ77zuILmoaRo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX75j01NO+bw7f
 9yy+lNgYbvDRX6N3m2otljqprQAPXnCdp/W0Ads2IQSbAiu3d5IJ3VWd0iJ1T0s7WxCL1At8fvV
 gHF92UOro405QZRiuNbx4nJahqeUHpA=
X-Proofpoint-GUID: enoMLPpnjYBDLFEGmFmBZ77zuILmoaRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070078

Christoph Schlameuss <schlameuss@linux.ibm.com> writes:

> Make the code slightly more readable.
>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 3e956c7faa4b..937f9c99bc00 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -701,7 +701,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
>  /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
>  static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
>  {
> -	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
> +	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
>  	/* mark the page always as dirty for migration */
>  	mark_page_dirty(kvm, gpa_to_gfn(gpa));
>  }

Could you add to the commit description what you changed? I.e. use
phys_to_pfn() instead of the open coded shift? It's bad if you do a 'git
log' and get commit with useless descriptions like 'make code more
readable'.

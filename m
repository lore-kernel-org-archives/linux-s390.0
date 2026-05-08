Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52338B7D5;
	Fri,  8 May 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236203; cv=none; b=FJaF1xMz9ohMCkkXDAUqTJrg1Xbt4BB35etA/c8c+gGOB8ZH5XplOOFgrqui8Cri+hq3h0LNqF326tBANX8xrYtuxP0ho01Kqoc9+6oaNBiV+7lJHZQ7NfLW0TFkCLtpfM8Xo/D/6/vDqm1NEdY5rj0RTpeahrSyN+q+I2rzIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236203; c=relaxed/simple;
	bh=UQicpKz6NaMb0vl+84NL7EFuVgWqepaV0HDhdju/6YA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5Sm5fKDnoHNWxpVtWxdiSyFwMtfegveDQae6p7R0yyD3CKTkF9V0RSIcW+6QyE9z3ktjDOPnJFG0Dl4RgrYigzRIK0qDSfPpfylCxdjS7pdwwdvf3hCrB6/RDcmjYR/Qd6pdQdTy7k+UiKOmwJu1VJe1R3MUAGpdhXbPajV6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SjAig4lj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SjAig4lj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6481RdBg3011871;
	Fri, 8 May 2026 10:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q/M/s1
	+gyab9oLZqgrq87ZZmc+UpaK3UW1AYSJigi+o=; b=SjAig4ljZ6+DYrr7y2FcKb
	4hGcyHs3pPs2SxBmtJuzJa+8a/AXVHiLMzJdVycDyIQM8rMkFJR67rfeY5r85rmb
	xQKsKVZDIKToCl6c4taggas8Yy/B51v+4P5wtx8rT/Y9rNv7cSZBbIGFzrpQ3Loh
	GnWbwYcG6ykA4D1sqgE7flD9eACNj2aVmB6T+2zqSGIXFpdTzjX56KpnBqnf87Fw
	Iu7JSQlXYSATg3cNei9W6ayTlcrBxuIs51VgbUroJ1e/oERgncsK+MzAShVt1MAz
	ljVlyoZvq12W9hMvC20jGHiT2BhEKZ7TiUYnSWY6/xlC8PZ/y1Qs2XcRK7Mhtfdw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6sxed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:29:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648AOTdZ027249;
	Fri, 8 May 2026 10:29:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hfqbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:29:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648ATrVR49676722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 10:29:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3BB520043;
	Fri,  8 May 2026 10:29:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63B820040;
	Fri,  8 May 2026 10:29:52 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.69.232])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  8 May 2026 10:29:52 +0000 (GMT)
Date: Fri, 8 May 2026 12:29:50 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: s390: Fix typo in UCONTROL documentation
Message-ID: <20260508122950.716f02e3@p-imbrenda>
In-Reply-To: <20260507200836.3500368-4-farman@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
	<20260507200836.3500368-4-farman@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fdbb26 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=_Dt9Di3Ks-NIZECnt_4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: peVtmnkvFFyztc1W8cowCDF5fnjzGEHK
X-Proofpoint-GUID: peVtmnkvFFyztc1W8cowCDF5fnjzGEHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfX1RFRfdEO/Fbe
 fi6Vfn2EAWwcf6mPWtiRBSj1iu+/6y3uYB67BMfMe0Sp3RZZgCk2GIXvtaAvPgPW2C4xUfeYg+i
 /a8dIH8DSE6qou4JL1UEc82MHo0LtpFBXCNzKViC6TXduKIb6hBn8RMcG6MMbBHvSyUbGELm7KQ
 GffDLQRssN+mjybFT7shAUUCSdvqsC0T6fhfXm3es22Z5B9pKXV7yj1FKIbw5Yjtpz574WELBMC
 FWYe/1ivQdJm3ktdEI7VNf3u0Ir0s9719/RZ12MulPgyVha0Oy9dIWqnw10VgDcaY9RiQv+3p/i
 ytA/G/76Lee7g5mwE0Q1rEVK8AVlwnb5UeU4XkqNMf6aHJEguhnr+AGAK2sVPiH2A4JWbG7fRZg
 ra3SAhgVpVSgYB8FL1PXVTpvxRP1t95/18N2gZiDuK2zbEMOSLkN1SW2MKX8D+YFqitGrfAqmvD
 1kgCM9Il7qHQMSTe2KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080104

On Thu,  7 May 2026 22:08:36 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Small typo noticed while writing the USER_OPEREXEC selftest.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


> ---
>  Documentation/virt/kvm/api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce1..f0eba90602f0 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6827,7 +6827,7 @@ s390 specific.
>  		} s390_ucontrol;
>  
>  s390 specific. A page fault has occurred for a user controlled virtual
> -machine (KVM_VM_S390_UNCONTROL) on its host page table that cannot be
> +machine (KVM_VM_S390_UCONTROL) on its host page table that cannot be
>  resolved by the kernel.
>  The program code and the translation exception code that were placed
>  in the cpu's lowcore are presented here as defined by the z Architecture


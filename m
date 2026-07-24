Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3583A9D8F;
	Fri, 24 Jul 2026 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881064; cv=none; b=EIPiNpaQcwQVndHAFhBAQjp98RPHOdpXMcwFcDyJdy0hmgLz0La8u+UrwhRJz88kSwkp7tYxd2Hq2M8pZGWnSUByeqfWDIKAfuq8713cJb3ZApRuZKKc01jw86YtxzB/PRogdEyHgmPWw9pE6uRH0Z4kqZ+C/sqHRi2yKOWmlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881064; c=relaxed/simple;
	bh=vg6yhHy+ypGFxAdIdnzyO0TJEKjh+TrkcBPxm//0m+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYEVMYE4mO/n3LVcm71Pi7bvbMCHSTZBznysSE7n5xCcEqObGVkwOB2AENUh4/8+5rUgMMQ11/+ml0xGOKab/t352rcf34QqvbZiXNAXgnHRy5KypmDDNKucYpVPydMf5jOUe1D5QJdJ1uACjSE3gpbOJS40yW+j7yvwsm+C1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IhxJthy9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IhxJthy9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Brxn914123;
	Fri, 24 Jul 2026 08:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UOWJ+X
	4sg0ZAtnuuIkLy8Iu6I9hZeKpd9NgEjLm3/R0=; b=IhxJthy99aARPxa7Tp4pr6
	y82sBDkk74SE7Pz+lphiCHlIXKniZH6NwuVb6n6aGY65v6LcP8cU87ghmlpe1ZIP
	jqAf1MI/C5W9L4ZoGADnq4aXmCAgR/RjagUm6g1dp0bDeTThJyByPMikTN5vxVes
	ftT3FsVltugMls6UODDhO8yLt4LaU79wYjC6DKxLkyzrQozZYG/qoxXbUgR2c6xS
	F5SWFaBmZDwOllHB6q3FmCGaWBpd6BJ1KV4J45Mr2ggFOa4h8A/ruAFu61xKum6i
	EoBIUAhLztGWpecm9HHifLlY8hFCgBV327qWpuAEpqt4riwmvG1rpe07RdEn5zJA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahk2kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:17:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O84dLR012293;
	Fri, 24 Jul 2026 08:17:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqg7xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:17:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O8HYsv30278388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:17:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E24C20067;
	Fri, 24 Jul 2026 08:17:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B88020063;
	Fri, 24 Jul 2026 08:17:25 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 24 Jul 2026 08:17:25 +0000 (GMT)
Date: Fri, 24 Jul 2026 10:17:22 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] s390/mm: Remove folio handling for kernel faults
 in do_secure_storage_access()
Message-ID: <20260724101722.363655e5@p-imbrenda>
In-Reply-To: <da93640f-4fd4-4cae-bedf-921916dd4682@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
	<20260720085834.898025-6-hca@linux.ibm.com>
	<da93640f-4fd4-4cae-bedf-921916dd4682@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: qupa1iDYGK9lhvlWto5MfvPZqI0CLsfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3MyBTYWx0ZWRfX6KEt9X41m3bN
 QnQENmb2/CMNOkUZRioOI34vxD+IDZDAn7JsxQBhrd878Ju96h3OA+EFPjkJVMkoF4uTNKAUS8w
 4yGUjEYsQ2ZPNXzec0Tj6y4VYqt4uM/RRIOP3+8fpQOi1wbQyuog1Evlsu2/CdBibWme2wXGT/y
 1jH4t89/d3xEfD+gKRql18LGgoEBo37Fmp27wHNZiiSm6tpsmaTIOCnK12T1amAPjH5zQyLBHAS
 CF5jkCQ3wcDOGXDIbI3g1r1Fz/tbsE20re1yNOkFsIlZHLpaXtMe8yPq/KXA231vgILlm+q/y4s
 2vrmSm+rsWbLHNnrIM0hOEITr6jNM70TWGxkB2ogNTAeJcStRRj19IkhT8/82U5zm12d/KcAH41
 QO26Yz5ztKvSTnUAyrhaugGDYl/7UjecBaMGdp8sKuJIVxTCNAgCoObI/Po/Cc4dKP3qfvdnuLy
 uRTHKePGyFX+gDmAmzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3MyBTYWx0ZWRfXySChLbt9kEdD
 2f9Ct0UNC2s3mlS50H84wZNLDd8c7922JPBqBQKjC55Ol/GY+bTonYCorEio3LXwRlFGJDhc3Ef
 ye6Qx+L0Slcd4KRZG+aVdFLnRnggdD0=
X-Proofpoint-GUID: qupa1iDYGK9lhvlWto5MfvPZqI0CLsfT
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a631fa2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=uVMGJkIZJPMhafez8PoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240073

On Mon, 20 Jul 2026 12:53:29 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> > Remove folio handling for secure storage access exceptions that happen
> > via the kernel mapping. Using folio_try_get() for exceptions via the
> > kernel mapping is racy: for example such an exception may happen on one
> > CPU, while a different CPU frees the corresponding page. Subsequently the
> > page can be part of a folio of different size, before the faulting CPU
> > executes folio_try_get(). This may lead to data corruption.
> > 
> > As of now this scenario does not seem to be possible, however with the
> > upcoming load_unaligned_zeropad() this is possible.
> > 
> > As a side effect PG_arch_1 is not cleared anymore for such faults via the
> > kernel mapping. However given that this bit is over-indicating it
> > shouldn't matter.
> > 
> > Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>  
> 
> Ideally Claudio should confirm that PG_arch_1 is over-indicating.

PG_arch_1 is over-indicating.

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> > ---
> >   arch/s390/mm/fault.c | 8 +-------
> >   1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index e650cdfa2523..776549d55c94 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -440,13 +440,7 @@ void do_secure_storage_access(struct pt_regs *regs)
> >   	if (is_kernel_fault(regs)) {
> >   		if (is_vmalloc_addr((void *)addr))
> >   			return handle_fault_error_nolock(regs, 0);
> > -		folio = virt_to_folio((void *)addr);
> > -		if (unlikely(!folio_try_get(folio)))
> > -			return;
> > -		rc = uv_convert_from_secure(folio_to_phys(folio));
> > -		if (!rc)
> > -			clear_bit(PG_arch_1, &folio->flags.f);
> > -		folio_put(folio);
> > +		rc = uv_convert_from_secure(__pa(addr));
> >   		/*
> >   		 * There are some valid fixup types for kernel
> >   		 * accesses to donated secure memory. zeropad is one  
> 


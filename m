Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BE42B725;
	Fri,  7 Aug 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102143; cv=none; b=FST/bLJiDTxHxZdLN9KSgHhd3wn/+NT7DZ9AyYscvqJvCfvu8iPuT53+VccappCFpKnD+fY4fLnLyvSKFPTfIq17D3Ahhn5cRKxd6vUgpld5Y98qHjAsqd2kngk4SeCLL894HBC2OSzauQhNeuzty8BX8VtIYqqWZeh0m9j5G1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102143; c=relaxed/simple;
	bh=nGXJQpv9p2O2Ysdc0SMOK5OkGae8wrGuSo05owwd4l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTxW8eSMaJ6JKg9OMHK/CkLmMO8yD0/8gVqp4IgeSPpfrHdjFNUd/g6bnetspf6d3+rb9OtQNFPklln4sgQRX/6YwR6J4EdlxPvxs0pFmi3UhsYQzW1d+1ftJRqdb0mMTxXZ0wb7ffnY84F5e1q+htYLzVdcR6IK0T6wpZZTySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r1CTi+4Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r1CTi+4Q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hipr016221;
	Fri, 7 Aug 2026 11:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gp/SO3
	46/jU8wXrYYbLsjoHJnrWiQ1xanGO39bC4iis=; b=r1CTi+4Qg08s9KAU9oIUGy
	1h9bYkoSfEuRlPDKgjEhiJMFDntqCgs7/leUwX/XvFCP/PG45e3//4FiNQlZuuqt
	nr6TlXLYg4gx8AlwZlojuvdsBDzvhvp3dXtSh2OYQ/uM/k6rdRBN/IfW3WsiWK4n
	8mnbQea7qLmNtql+gxLzHuQ+ym4kVmS5DZvVVKKa2UZefYLSnVlvjAZiUyOQIhCX
	IrT+SBP2QOgGsmf0deJ5rxRaWwOEIUS2LS0/C38VNMD4UqHDB5iQRAsMq+9Oqq1d
	HZuzc9veHlV3hnxFb080ieL5p1LqA2+OF6lXhUY3qjDi1mPPOdVhLvaBkDSdPRAA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00bgjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:28:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BQI89011431;
	Fri, 7 Aug 2026 11:28:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqcrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:28:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BSror43647278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:28:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7878620040;
	Fri,  7 Aug 2026 11:28:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AF5C2004B;
	Fri,  7 Aug 2026 11:28:53 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  7 Aug 2026 11:28:53 +0000 (GMT)
Date: Fri, 7 Aug 2026 13:03:17 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/6] KVM: s390: vsie: Remove duplicate assertion
Message-ID: <20260807130317.7f08f8f3@p-imbrenda>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-2-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
	<20260807-vsie-cleanup-202607-v1-2-b18659b55e3d@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX3Fz62wK4axPt
 mzh7Ivgn7hZvABL2VZIqBWqE7HgFuZOJGGWdNHjShXsRCkEAMXgVZEjqnN4xh9pfzdD4TMiRjV7
 ev3AE9ZpM7/RbAsWXML6OD7c8TtlcVU=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a75c17a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=dsCqYqjRkpx5ERYlrjUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: GjK7_HeB-ytXsv-G49voikyReXNvFI92
X-Proofpoint-GUID: GjK7_HeB-ytXsv-G49voikyReXNvFI92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX6IwWlFfj104y
 2npZ6/59WZ7t2+dzyMaC6OGmRuANsQR22g4aetOJa5hmh1Mf922maHKdDfde/x2ZKPqL+QTQUqX
 0jUbaZaNrR3pzu8AVMrUnPlYHvT9IDFm+kTMMAeOvgiJFMupYme+X3Xm+0EvcCnzBU+VQMeY0Aq
 /d6EDBY1ByR2taDNPMhfEL3Zo0AC8as7/ZDiUivANb5PAVz463VpUbyV65d0uxHZ9/9jQRb/OX/
 CB657DqOjMkkUFZMYBM6s8NkJ1/hB265WotfXcRWfbDSepEPvX6GrMwSUxxXiWGnxTYl3qzbmYh
 lIN8f/yeKdM/ybYzoGolYCtz2euSVwAPfXrpmzD7N1vZrn0BM+j7w5XTrn8NKy9eQNfUtSy3NqK
 VgVXlsh/HkAZN4VLKjTUOqfqg3qae/sTJwv7fJL/ZuHGd2CvrcRcx6zUltAbBgSSbqzuadbM/T2
 ux0veKmJ/v4dCt2QEDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070087

On Fri, 07 Aug 2026 11:57:43 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

Add this above:

"Remove useless BUILD_BUG_ON() checking the size of struct vsie_page."

and then this:

> This is covered by a static_assert at the struct vsie_page definition.
        ^^^
I would add "already" in there

> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index eea24562e7db..3e956c7faa4b 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1565,7 +1565,6 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>  		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>  
> -	BUILD_BUG_ON(sizeof(struct vsie_page) != PAGE_SIZE);
>  	scb_addr = kvm_s390_get_base_disp_s(vcpu, NULL);
>  
>  	/* 512 byte alignment */
> 


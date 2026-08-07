Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A042AF81;
	Fri,  7 Aug 2026 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102138; cv=none; b=hz7SeNBnkmKQQQU/FAnkPY77KGTIF3u/ggY6UyTeudfMChuVwsSLVmebcUSlBBQA+bywREv/Cq+91157jNQJkNlcdwy6Gyxvmsc6xL8QBz0/y7njNaQVt2/fJ3+okZLADSPVVr1/rJNMQMuvLN/6f6FLYBvnuZbShW7X7XzlTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102138; c=relaxed/simple;
	bh=JwvEfRbazXx+IsGGi5mryhkAh8VZM2Aa7pENlDJB8wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGx1sg2vP5A0o7fmXyBB0S1HQj7iU9OwtsKkIk6mRI7zF2riHsUfwh0LR7x9oZS0dEnFLZNtR8UdwtvoBPM2FtXSMtWP1N6zc3Je7fyWIx87N+ATSY+3nXtkWGU2MjHY5b4QwP0JNonxefExN5Ny/Hp6s+n5V31xXt10BEu82Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I+qhQF9k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I+qhQF9k"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HgAb2276108;
	Fri, 7 Aug 2026 11:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aCFgJD
	Us837jILBO95ZwjH/IZrfBaZkEt3MRrWTXkx8=; b=I+qhQF9kfctjTZ5XAW/dIl
	tbtloEat9bvFOIjfj17jM2gMEtzt8LXlmtJ7ILEAN033TWN3n5KBiPu9SHyI8m5v
	IRtAL8ZrSpLHjJXUKnHerkI40Ho+hxYftbaGyczpqSjS0K4vB4ZrEIHopuBLI/Vt
	wmYPNkxanFo0mtEN6tbse1V0FF0y7xnBbF16gKSIGlhyBMZhovLIiIR9UHtWMfos
	dPUCUwDTnPHY85A/q+SpbrCWXaZmNEa+GkgzxvDPtiBBQycaX+D743g98b+XzEml
	CeNB/XFU9R3cwlKNmSCvTBbCm+ae3r5hyZa/yVUHCk5fckZrvtf72IUOlaRLyzsA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01kkup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:28:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BQIvp028462;
	Fri, 7 Aug 2026 11:28:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kffxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:28:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BSnhd43188540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:28:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D03D2004F;
	Fri,  7 Aug 2026 11:28:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 650CA2004D;
	Fri,  7 Aug 2026 11:28:49 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  7 Aug 2026 11:28:49 +0000 (GMT)
Date: Fri, 7 Aug 2026 13:04:01 +0200
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
Subject: Re: [PATCH 3/6] KVM: s390: vsie: Convert shift to phys_to_pfn()
Message-ID: <20260807130401.47565c2c@p-imbrenda>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
	<20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
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
X-Proofpoint-GUID: y0zZDnd0piyrPkAaXSZ_qZJdY3QwtUDq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX/ToieOE0iKHE
 8vVCfECUy4lUA0MgQ2hsUBIbrruRyxcgAUga5gJ58kqvK+QWj2+EX0EWiCpDkMVdzDvlsgrebt+
 orntP7rcQEIc036e1J6c4j3NUocxoKw=
X-Proofpoint-ORIG-GUID: y0zZDnd0piyrPkAaXSZ_qZJdY3QwtUDq
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75c176 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hV1t6Yna2l3WaQOZFLYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX+84kVVy7AfMA
 GKXpZ42fb1eFizPMkZ2/2wC01qfsCvkUah9SUQ8d8L59ppq/AG6Su+y0U1uqU30K3/b9Qn+py+y
 dHuZrqS9bFjqPcXHT0BrYnuFn//RI4JeqzAySbjgj+W9R6Fm0EHaBHyHL5wLK35LU5YIpR/aReR
 9tX0YOJwIBklXyG1UKKWN332WR3ol6HVLpdLGd8i7ZWeBwpsXKhqHrNt7yLioLIbdqWO2LnC1li
 6TF8QYd1TYeLH3SWV1zfmQxybzwG6rLcPhcFOv0u+igHGOnPpBmedUmLkOAlVPx5S8van1YPL5W
 ztUDjkfAIEC2VZwrElsMs8JE5Zm5Zwf3VVXuy7EICyi0MS/3d6XDNQiwG8ok+CKBJZCLkRfINuF
 7iSjq4LXxL90Z2rKa8cQIAlEkY1jlZXVFo886//QvVPClFJ5bWH9dtGPGh+2XJ7wM9SuBuycZG3
 CEAnpXgiE75+2vWH3WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070087

On Fri, 07 Aug 2026 11:57:44 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Make the code slightly more readable.

... "by using phys_to_pfn() instead of an open coded shift"

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
> 


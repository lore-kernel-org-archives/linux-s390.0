Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CBEADC;
	Mon, 16 Mar 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666435; cv=none; b=F0KA0KZYqP1h4L0DbGwXWPseSp8XQ7PGRNdVZcg4F2imbJG+flHSKGlC3vvSpbTnvAWKZphWNfZagOXYNta6OfeqMQoemDJCoP5xMpC8uR+zACE8pwG3gIhc6ZmN3jw4JAuxd7yq9/p4n4COvZX+UUtEfNs5FD1ZoZbN5S9AbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666435; c=relaxed/simple;
	bh=5Sjk9oVd5M8H/gQvoSt+21METUld7t+/TJs5KsA7Y70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRfup1erJYtiNUUffWvIYk3oJfaKQ3nq4JUlS5V6J+CI32Un62MjSCoqqmQvfAMG7et3Mcoibz7ItsvS6w1AGlnNQ27cnlsspmdCa84uVcZhPEbVOQQy7D0huCLxy+TzszgMOCY/Q4uJdtzvjIsHfNehuvQiejuC59YbWYTIJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JaFt4AxC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JaFt4AxC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FNmgnJ1368595;
	Mon, 16 Mar 2026 13:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mFWHM9aR2HNRu14bWadLvEFP7ydyY1
	yQQeJvy/5rjh4=; b=JaFt4AxC3Alo0HWLT+T9l1CrQdyFtAU4GepTEjmB5Z4Nty
	yN/Jbc75dsEkJgCRQwvKKHTXvzbKBF7ZxhTGBHhuNeA2lc9/DgzsFSZkGoxclCX3
	4PGjhipzyiPNHaXOJm2OLjL56Su1wnegSFrztnaWMCNqvjGmRXHUiBBQVK4ozO4X
	Bn8QPLi9hwEZsX7KWo9Yk5/YLqpcAIqOSJvNgc1v113xErqi0CpE+xC9TwPzH1dt
	nY81EvBPJgVDid5+Q1Iwlf70C5nvCH3lNOIXMvOJAxoKMvXI4DlgPmXCspYKZLGT
	80pVVKKsTD4QQxfJD5wKN0x0+8Tm7gYTuW7PNuIg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64g0cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:07:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GAptOO028713;
	Mon, 16 Mar 2026 13:07:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk4uu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:07:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GD74II28377564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:07:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67A552004B;
	Mon, 16 Mar 2026 13:07:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E343B20040;
	Mon, 16 Mar 2026 13:07:03 +0000 (GMT)
Received: from osiris (unknown [9.87.141.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 13:07:03 +0000 (GMT)
Date: Mon, 16 Mar 2026 14:07:02 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: vsie: Avoid injecting machine check on
 signal
Message-ID: <20260316130702.17080Dcf-hca@linux.ibm.com>
References: <20260316122546.11573-1-borntraeger@linux.ibm.com>
 <d291035f-8bf1-493c-a629-5852a1e65caa@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d291035f-8bf1-493c-a629-5852a1e65caa@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 38OXA4AtvNmF_afZy2UZOGbmhLXVjGN2
X-Proofpoint-GUID: 38OXA4AtvNmF_afZy2UZOGbmhLXVjGN2
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b8007d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SNB7pasY5Tquubnop8QA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfXzO7ei5jAS1T6
 LaNeNzQ+qZXMtwQAROlV7M8lEFeRAs4pCEruCvKxVT+A/9Kv4YVMr8Nrs/+JSmyqeULSXlfj53r
 RQ1Zet/A5VbXKkzvcYkYuhFggLurml1sCDBI0VBX4ibU98QelBdVN+BHBGw9un48gP3b/vD0b3G
 6FzgHdWXNm86FK7KowJsf/tWUHJ11kuFK2hWbBEyMw7tyXu7sPEaBA9zkMtCKY8IWcdke2tKTdh
 R5uVo5gXHkpeWZbmSZUmhBTPj6+ZyIn6G46w0rRyHt8mdIw8B6ggpd4JdBH7tR/ks+H2yj5cHr0
 fPlxDuRCTgsssh1BhgDlQJrVbi357oHgRPfXB7wQDiUT4if3ZETTgCPCGIai9p53KQYB/vgjrYC
 IqaYTAfIHGKbe8LQkK/Jtd9K5X6p6oHsI10OjAvIa552EqH3hgsEEoGYue5xd08WvXuZUiFj7Mg
 XnVhHzzCd1iNOGJO++g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160097

On Mon, Mar 16, 2026 at 01:35:59PM +0100, Christian Borntraeger wrote:
> Am 16.03.26 um 13:25 schrieb Christian Borntraeger:
> I guess we should still add something like
> 
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1123,6 +1123,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
>         struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>         struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>         int guest_bp_isolation;
> +       int sie_return = SIE64_RETURN_OK;
>         int rc = 0;
>         handle_last_fault(vcpu, vsie_page, sg);
> @@ -1163,7 +1164,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
>                         goto xfer_to_guest_mode_check;
>                 }
>                 guest_timing_enter_irqoff();
> -               rc = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
> +               sie_return = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
>                 guest_timing_exit_irqoff();
>                 local_irq_enable();
>         }
> @@ -1178,7 +1179,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
>         kvm_vcpu_srcu_read_lock(vcpu);
> -       if (rc == SIE64_RETURN_MCCK) {
> +       if (sie_return == SIE64_RETURN_MCCK) {
>                 kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
>                 return 0;

Yes, this looks better and makes the code more understandable.

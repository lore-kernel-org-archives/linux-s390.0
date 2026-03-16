Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BE25228D;
	Mon, 16 Mar 2026 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666853; cv=none; b=RcvOsnr/X3V9AJdgYGNVyBw0YDmc30B1riv4EXwkdo3YEj1Kiavorh08l90AAkX2Cguii3shYwvAsC5tqpIyMxtfY3SjyBq/8VUSZN1gePSh05QpKBiey8U9XdmSX+3OisPabYCA6R1mXRPDHcOCDq527gJUHmGR25a9teEBGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666853; c=relaxed/simple;
	bh=fIB8XAt8cqUxaDdboNgvwaFWkZcGjjC04G6TXhphBcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkkhXQm8TrV7txacv+mlUTRcvm8n49i+wvcZ7CzrFt+ip7KYWt4YLjWXj3+fTO3jlt8I8WrDARr73tXXeZw8iiShwjhLsvVyJnAsfBDaJiwS5YaFqnoS9AcdStpkhJlL/FkpVOF8VOs/IKk8pH4oiP5mKZIg+jjWU7+x7CeRNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T+9fXE+y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T+9fXE+y"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FKFJC1972322;
	Mon, 16 Mar 2026 13:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uZQtFgNltjjBzHk5pdFEbiarahR2zt
	tjNZh3MOB8Sug=; b=T+9fXE+y93w00ook31cuIHtqDPdkZP/2lBPwD9GtJXR9vy
	dqcFUHK5ZytWB+1HJnG6xYRDHIlsaQQR9FphjERqThoOerpgqBix1Pil6M7kJt5a
	1IJIddC0X2DJfU95uclR9CqEUKHY2wZTOLPW2tmOnAbJipiQ5++2qQimFQkp/Uib
	B/6zKdfZQYl/Md0Ar0/LVoPbHOxOMaBTuhJgV9qkGo9v2rsT0/0XRNRskIRqrXoJ
	oT1KhExnrDvEdZMVyZBUWLmDDCzZygXr2KdU3l06igl4uhU2yQrSyaW7uM3bHO4G
	njSIFUb7IZcFRS8PXjH6FzKJBLBkxOWSeDrXhSpg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64g19n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:14:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GAkfUS029194;
	Mon, 16 Mar 2026 13:14:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk4vv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:14:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GDE09W53477774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:14:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F4ED2004B;
	Mon, 16 Mar 2026 13:14:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25F520040;
	Mon, 16 Mar 2026 13:13:59 +0000 (GMT)
Received: from osiris (unknown [9.87.141.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 13:13:59 +0000 (GMT)
Date: Mon, 16 Mar 2026 14:13:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3] KVM: s390: vsie: Avoid injecting machine check on
 signal
Message-ID: <20260316131358.17080E1f-hca@linux.ibm.com>
References: <20260316130947.40466-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316130947.40466-1-borntraeger@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T2-hzR1Oq_5_0VUvsQK9bORGmWmBCiOH
X-Proofpoint-GUID: T2-hzR1Oq_5_0VUvsQK9bORGmWmBCiOH
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b8021d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=qbISLwkX9i_CiVSkf0IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMSBTYWx0ZWRfXwxoTuUh9EIJK
 SshW2t/Gu5s3mLy/8MPGU+UjTtTGS7NfQU/65wMykB7zvJuQx9vaOv1o03pb+vZNxj8+JoDTCMt
 ANXuZhT0fcxLwZWsDPF7zPoMdi1K0/z1gUKkyHRUEtudZ18AyIS4ZsPMULpYarNpl8/igyzs2kn
 xi3ItIed3PGHboLtd4qy6Q0AqXtzY0w8Msy3seZhTkzV0qaYNLOOvDH9tsFpb3RObz7VHtHB5QR
 5m/mWXlRHGZVP7l4deSAvMiMCzN/3fA+CHfaihg0sElbibETIY9htzWIKNtJgZCJLNTJDcvMe3z
 xuB54w0GZ+9prVsAvhK0QMFY7HVfheIi68vg3yUjJZqQhBrpA4oabAPwgOpthX3vciIGMoSZ506
 6IDIQQlgVHICm23+hm13YkecEJtU177ZAXwrqxIp1YCo4aC+p/8O4xeFQLjEubE4nnKsG4NYQoo
 QABGeja4uv+9JPAnrjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160101

On Mon, Mar 16, 2026 at 02:09:47PM +0100, Christian Borntraeger wrote:
> The recent XFER_TO_GUEST_WORK change resulted in a situation, where the
> vsie code would interpret a signal during work as a machine check during
> SIE as both use the EINTR return code.
> The exit_reason of the sie64a function has nothing to do with the
> kvm_run exit_reason. Rename it and define a specific code for machine
> checks instead of abusing -EINTR.
> rename exit_reason into sie_return to avoid the naming conflict
> and change the code flow in vsie.c to have a separate variable for rc
> and sie_return.
> 
> Fixes: 2bd1337a1295e ("KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
> v1->v2:
> instead of a band-aid, make the machine check more direct
> v2->v3:
> avoid overloading the rc variable in vsie.c
> 
>  arch/s390/include/asm/kvm_host.h   |  3 +++
>  arch/s390/include/asm/stacktrace.h |  2 +-
>  arch/s390/kernel/asm-offsets.c     |  2 +-
>  arch/s390/kernel/entry.S           |  4 ++--
>  arch/s390/kernel/nmi.c             |  4 ++--
>  arch/s390/kvm/kvm-s390.c           | 15 ++++++++-------
>  arch/s390/kvm/vsie.c               |  7 +++++--
>  7 files changed, 22 insertions(+), 15 deletions(-)

...

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c0d36afd4023..42c53134e0b8 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1123,6 +1123,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>  	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>  	int guest_bp_isolation;
> +	int sie_return = SIE64_RETURN_NORMAL;
>  	int rc = 0;

Move that one line up to keep the reverse x-mas style?

> +	WARN_ON(sie_return != SIE64_RETURN_NORMAL);

And as written in the previous version: both should be WARN_ON_ONCE() I guess.

Anyway:

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0A2EA47C;
	Wed, 15 Apr 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262873; cv=none; b=u2GS1blfXbA6LOk/YQX08Ts1gi8m7tbnTD417YwHuAibn3KHfUl2Kh469cM50pHQDPkKT8BmwMe4EXcl0NlKJdp1Y51ys5xQO+1GumCOA2fJJXdPGgXghxT/d3uSxYG774NLQ4uzoC55bQDXDLGtBoImXLa8cVdSxj8TokQCGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262873; c=relaxed/simple;
	bh=BaJyqL4XMh22YhbcuSAiJ2s7ZYUPXiXrXzD6uVpeeDA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a5GCbK48GlpgWhaJn2fzVyg7SdInesF7HiKjgxTGRICvFFoTe/XKCXsh/5dH1zj9dgeHGYKctks+GnCWqVa2agpkHA7tL8V50ifzheQVDmEUs+t8RPxe0TS9FI+HYpMtm8eii8WNP6xK5mjlfo6Yfn0Q+MZXvj0n6cnK6S1/LNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UQyyDY2X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UQyyDY2X"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F42VK52131063;
	Wed, 15 Apr 2026 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mSw1Y1
	JdOic9upgIXIQbBltP2F+giaRq6K23+o3yT3c=; b=UQyyDY2X37OYaYxsTW92Dr
	6z79oQaz1aug/S18WojDUlA9D0uCQXZnFs26ELHt0wtXFwnk0CRwIpeN9eGiR88H
	8RjMHFJwOG2dFaDtSFB4niEacy6qixEGaANlkkgsrYQ/+R1b66SReTT7aY3IAPQz
	xF8YnRwqPE/MgSvxM9EFf++vc0AGTN8ir40BPmUe1zK3d/Ojj7fVmYXrgs5FR0AN
	6PxtWj1FE7W5J5k3zy8dz7JbYYBt5LCUNxbjQa9tkFlQ3+IGftKHBDESKSfRS9GI
	BTFS569U+8oXIwVQ67bmioK4jFFNsyL3VFfFF34bzGuFI0B/oNmEA3IaBv6oN7sw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ngj5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 14:21:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FCNMN9015621;
	Wed, 15 Apr 2026 14:21:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mspryh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 14:21:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FEL7fs60227856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 14:21:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DF042004D;
	Wed, 15 Apr 2026 14:21:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA6D920040;
	Wed, 15 Apr 2026 14:21:06 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.91.157])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 14:21:06 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 16:21:06 +0200
Message-Id: <DHTSMVSISIZM.3MS0YLDBLMB09@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
Subject: Re: [kvm-unit-tests 3/5] lib: s390x: sie: Free guest memory on
 destroy
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260415085145.91197-1-frankja@linux.ibm.com>
 <20260415085145.91197-4-frankja@linux.ibm.com>
In-Reply-To: <20260415085145.91197-4-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BcPV82StESS0BIS0olCuzC92bGieZvUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEzMyBTYWx0ZWRfX9t/9hlytyRr6
 MF5GHp44S+rdEQff3m1+KON5pgLJruwcyV0mkWUc/rtk3u8yn8eXGE0GA93zQaNpKdrQRltEDOI
 WHjC0kyKySKVYya+zWNNeJdffV28+xCCbCEDIci/d8/B3jBPdFB01a+StJDpKW04pOwh6MIbKzC
 3TuZ05Lrjw6vN3oUai91DqFy3JAR657c5+m00poTPw/mDVxhAbHXGR8vzlTfKQqCACPJeqNO05n
 CnlSD69jGOAUqzJ9NWXpPQyqZG5Pg7AmBiSybjU1ZArhbFZJPUqtZC/mthXzBH/BWPk+8aaGMCG
 cZxfVJIMmVNw92JiuLY9LpRiAZHb4iqKag1l2pICuMkCnoYZw7CX//Uai9uZ2fGw1v6wFEWvz8w
 JnD+wRz3FgUlKbpY/hVYc05R/YRd+bOluC4sftKeXa7Lwl5iPjbVFeY4mzPt9pVHSMWFTiHN5eH
 KkHE+c3buv0M4ZEr+OQ==
X-Proofpoint-ORIG-GUID: BcPV82StESS0BIS0olCuzC92bGieZvUu
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69df9ed7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ZuHsrYXmR3UY6TQJZS0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150133

On Wed Apr 15, 2026 at 10:45 AM CEST, Janosch Frank wrote:
> We never freed the memory that the sie library allocates as the guest
> ram on destruction of the VM. Most tests reuse the VM or just leak the
> memory since the standard allocation is one megabyte and tests only
> use single digit numbers of VMs.
>
> It's time to add automatic freeing to the sie library when a VM is
> destroyed.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/sie.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> index a49c45c7..758ead77 100644
> --- a/lib/s390x/sie.c
> +++ b/lib/s390x/sie.c
> @@ -192,4 +192,5 @@ void sie_guest_destroy(struct vm *vm)
>  	free_page(vm->sblk);
>  	if (vm->sblk->ecb2 & ECB2_ESCA)
>  		free_page(vm->sca);
> +	free_pages((void *)virt_to_pte_phys(get_page_root(), vm->guest_mem));
>  }

Is there a particular reason why we have a two-step process of calling
sie_guest_alloc() for memory allocation
and then
sie_guest_create() for initializing the sie_block etc

but
sie_guest_destroy()
cleans up both?

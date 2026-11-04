Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784015;
	b=RUbED7I1RO4IowspYiZ0GZ1u7AV5XTY4XmKG2nWqDD6IJ3oy47vgj3gejDUXcECu+/Yn
	 uNZFw0Z/v8r8vZffW4jQaSC2m1M9RDO2Ua5tiUfrkos1LS+IOupiGaRXFazsb+e5327y8
	 hQkhlv3p92lS3myQiGwy7ijiLnCPZasj6PkTQREbGRHFAVvIxP7znpou7TBHic5M6hPDa
	 EdNroiGaYrhMUW+JBZSGuhJsLk1m9OwDASVUuVUWfv5aXPJArABmSpPzNLjsdrZZ0g7jw
	 klv+4UeO33AVaj4AwTZZMEYpNwyp0t4MD/xfEWzDaCECP7ji8kHnYr/Iufgr3dVnD/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784015;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3UCPB24rTuITEeSTMB5srYO/uaFE0fKZn4zwyU1cyOM=;
	b=Y5Jug83Jt/RV7woiajU2InuDgHblpbgPBk9IrT4F2xlDuejmU45qJPyLDcRnd1ox8YjZ
	 eBfodXSKenVi/CiqOxofeMgJGXtgaJq9E8f5XuGHTkbaWHJG8G94tQzLeZl0knmnlEFmQ
	 y+N/qo5F0CQ8p8lBNSaYKHFTCLnaw7hnBxJQuNfh++tcAlxD5j8VImoXzZshjJT5G9xu/
	 r6rW5amwFiZHHiSwVhw/2MYK5uArmsq9nuk2VaAWaQRCNGngs9kh+0w/gx1/O+w3GLulJ
	 WIzDsu/r4acARwZyDFDOj54fXpmcpykJ0Vk4UnN3rKWg1hBOF/bMqL45FUhZuJwaQwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d4IiwFK+;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA954606A31B;
	Wed,  4 Nov 2026 09:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA954606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d4IiwFK+
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48iKoj086668;
	Wed, 4 Nov 2026 09:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3UCPB2
	4rTuITEeSTMB5srYO/uaFE0fKZn4zwyU1cyOM=; b=d4IiwFK+fhaUR97qI6lD3h
	l5FREBA39pqLyKp0thRnJlVEvKFCchy/+DNRXRUv713T03UG0rfJYxT2ElZlh1yI
	jnVKs5kT6wkZD5swrdWR73EQTt9PdIosfsqEaZDuomMTkBwuVtzlLaJnT1eqJR1f
	yM6uLcU+n1ldNCybBqWcKZDLe/8zzLwvhl1ykpgjcj7MQEGm+n2kR9DTdEhYGgiM
	9MkM5mh4ECY6jR5KjhexM54RAPekAb0PInCkFx3//m5T8q0416jWlbpvBehEH/JI
	CXOh2r4jhrDM/havp1GWVbKZ+K9ixrhZO+Gsdy1oTlTDH58u3mw8quBymvAX3kYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826twm7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:20:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48K3M53844324;
	Wed, 4 Nov 2026 09:20:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqkdn47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:20:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A49K83Q37618128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 09:20:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 640C820043;
	Wed,  4 Nov 2026 09:20:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E36C620040;
	Wed,  4 Nov 2026 09:20:07 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 09:20:07 +0000 (GMT)
Message-ID: <73075ede-e9c7-45a4-ab03-5acc2f5f4dd2@linux.ibm.com>
Date: Wed, 4 Nov 2026 10:20:07 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: s390: arm64: Declare enum vcpu_sysreg
To: Andreas Grapentin <gra@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-2-21c36fedd878@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-2-21c36fedd878@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3_plcpZZddRqFPpDlvAFRFi_J3DHDAAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX+QrevJsU6Nto
 tU9/7+BOFSmgoeZBVFFa3tawciXQwn0PvriAe+N8uyjWDckSwLjPmpptSolt7V5qXcEJxl15WAy
 zyd2QP0Ibcxk/3ToqUpxP3DyEltb8dRiqPjDDzHi+TNWKMpmTn0fPIZcz9nt17je0e8WO8AsoiA
 e9b3KEcyF7ss0vS0ERjLN3ejPm42rQnOWGE6B0JbmLErxKKZAYzs/P3CkzczxJ2hoTjYKNG6G5D
 YEtY1Q9P5sD+7nCzrhTaUK07x/zQglmUfa8prEqBlkm/6VX29W/ecgLtIyW347+kjJ1Lz3vARlo
 +BD85VN4vxsyYD/wTV+6MiEynENdf1uvZavMgIwUhBw0+frY9/1z/Q4fQbSTfvbdks9rLACE/9V
 DIW2rfQMQOFeZiuZCLJR3qOhtpE1/wR7hr7pLcGWitQ57D7C4Z0gUe+58EwKq7Kj4pPoXQaRxG2
 Kl73vaJZaVmMSFtyOVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX7G9U+49YnujR
 6SOGQfkCGnUhRLPhtOsntqJhkQ6ZwpnxRxIRbNHwhxJh4XjwZSZ28iVblDWNwdFrOflzpRNKFqt
 07UJZWDFs9Ltwc4zkBC+xjkKH/mwI64=
X-Proofpoint-GUID: 3_plcpZZddRqFPpDlvAFRFi_J3DHDAAh
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aeaf8cc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=3tMoE_lpgaAus7QnUx0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040036

Am 03.11.26 um 17:37 schrieb Andreas Grapentin:
> Forward-declare enum vcpu_sysreg in kvm_host_arm64.h. This should have
> been included in the first iteration of the header, since we will need
> it to talk about system registers.
> 
> Since the definition of enum vcpu_sysreg is not shared yet, and not used
> on the s390 side, this should not cause any functional changes.
> 
> Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/include/asm/kvm_host_arm64.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
> index a3e40650d75d..3e69724f17c9 100644
> --- a/arch/s390/include/asm/kvm_host_arm64.h
> +++ b/arch/s390/include/asm/kvm_host_arm64.h
> @@ -8,6 +8,7 @@
>   #include <asm/debug.h>
>   
>   #define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
> +enum vcpu_sysreg;
>   
>   #include <arm64/kvm_host.h>
>   #include <arm64/ptrace.h>
> 


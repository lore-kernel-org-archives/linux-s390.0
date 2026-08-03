Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D033B7B8C;
	Mon,  3 Aug 2026 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747216; cv=none; b=kg4JiUxeOf7RyX2pCpgIRJyjXfIXblv0w8ezJKIQqanZ3EJu/C7IPmq9xy5PObhWe4Och8vCnYBocws1wqFd4AYdOkBDdJdOXwiue90L9Ami0cZ6C9SuRGVayK8Xxhq+9uLmgTpefcWAc1P6T5n7y+2Rm+PTGqVi+TPOpCaHzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747216; c=relaxed/simple;
	bh=qnPYF0dJ5LoNIFjT78YN2sF0bfY+98UGKuPLsb9OGMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJtAyhFtZoRozO6a/8A9bBaKUKeaNDdwHvL+wF/kccP/FXNUtIIJf2JqsRlaYfT+eyG0Ndl/1EUfF1rKrH47kjZT4qSrpvZJOm9KlOPjp/QZ66xK96LN/4PrX6gaqXBd/ACEx88oJARW/0HLB4QO30GqgYq4WZYhHMd/59o8ZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qHKMukGl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qHKMukGl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llk1u223083;
	Mon, 3 Aug 2026 08:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ojNpVX
	Ar9C6kbXB5se49F0UrV/sUPl4K6fMjvo2qdPU=; b=qHKMukGlVP9+jJau+pAbRM
	suxzs4fbcVLj3ZSx6m6F48xKdwy2E6I7ugbuFIatfiQDwPoYgN1oinjeUmKAa59w
	lD29jmdMvAkCvhY6K1lS6XnTjwJM2JEXXi2bKAU+F1cSiYUG/o4hbknbB8cOPPSn
	OsbP2pfc/70POkj28kQy/uboa2QewQ4jbnhU+jGR3LFOyS/CbH6wEio8TTAJoa1m
	aXWnq3ZlW93idf2IWojTopAI4IH+LrSYL5ZWYHjU+lPCRy0Ai7ldJxKcR/edlLO7
	tls6CecC3kX6erkl+0rwMrEWDVdB58ss1WwGkNVGkqGQw6OuWsb7cvqGP5UlPsSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3qu45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 08:52:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738fGbG017910;
	Mon, 3 Aug 2026 08:52:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtycb2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 08:52:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6738qrBG32375196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 08:52:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 219542004E;
	Mon,  3 Aug 2026 08:52:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6461020043;
	Mon,  3 Aug 2026 08:52:52 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 08:52:52 +0000 (GMT)
Message-ID: <d1d3f628-901a-490a-b077-c55f0bb68625@linux.ibm.com>
Date: Mon, 3 Aug 2026 10:52:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/31] KVM: s390: arm64: Introduce host definitions
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-25-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260731130902.654679-25-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7056ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ye4JxvfrUpV3zCvSIqoA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: t1Dj1E_DQmMMSorX4K-67CMEBVSvlida
X-Proofpoint-GUID: cMhc1a_myABnYRnnGiE4USWT9ryT-0lW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfX6PJv2oGosg+N
 CHnHrtrD4WWX07CwEHTtT/Lv3Pzg4jEzZla3G5+PjZWwi7tsAtgm/Y+PA4qEa7XOnAEk6c1zAPt
 nUPWiSoSXJ3LIikSyXAK49So5E/hXK0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfX+L66dUp1JQOE
 fnqUPi7+V5o0X6nsmVjVwCoWlA4qggI4CW/rnAt8UhxkZh1zSHUqD5SZ/6zQtRORLxI7Q/HrrAV
 bKtOhei9pHECD7chuEAc6wEsVF92SKEqmIloyG+mPD2UY6t1DbqWuP+yOgEyVJwUyMG+LoP5LBF
 SKnqkcmii0vH2uvQTPErarvmnO2vdpG3bDxwtEuOfCtcPCTEPFRPzlopyLPcnIY45xiBYmQBc9Z
 MUGgMir/zUao9gG1RSxqG1alak8Gyv+63Sv7hGsvfhS9N+BpQF5wZy3Cy4elFAaNebQvit5O9jP
 3pOLF/5wdYNrHwPFKfT1/fhlCcVVtc5SsYUM02pus71VYPNcrNFm8/2tU48b90/ljVNHXGBU+JP
 3c2MQ5P9QD8Eg6RP1rBExq0nhG9rdbNK60rMOVpTLwQl7RIBIUgyIH88iRFhPN4fshKCRHo30vI
 UFINK577+EdfncHm5Gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030077



Am 31.07.26 um 15:08 schrieb Steffen Eiden:

> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -253,9 +253,6 @@ SYM_FUNC_START(__sae64a)
>   	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
>   	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register
>   	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution
> -# Let the next instruction be NOP to avoid triggering a machine check
> -# and handling it in a guest as result of the instruction execution.
> -	nopr	7

rebase artifact. This was introduced by patch 23.

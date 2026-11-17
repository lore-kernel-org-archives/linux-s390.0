Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929508;
	b=2eTy8PJWnCUDTPN1ZlDE8Svxm8xvxkAWT7Q4AbVGQze9BO2J24Kb9njKYDoE8hvWaC+0
	 +mY22twGsJUwLeYZZ52NNW0FxAG6XiO3il935hTY6u3LXGo/UQ5H+UqOiLTgkJaX7OQ+L
	 o03t2gQJqfwysCAc1KqQhbg+bHnhNXukUFzGpsYHMW6Ypvwj58Sjmji6+2HEfhpT9Nl/X
	 rJ/L/ocIOdJ2vvaH40GGzJI52SIC1WKYakNkUO/vo729J3d+XYzuyaKKHo+80FaDZVniq
	 0wd65gc7+x4OM2vrX36N8weCTknhelqJnAfOKN1PG0ku93njbHiJ6iq2CY5Y/sfCHQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929508;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Q3pxy6l9w14wNwnvpous4lbZt4UStE7GloFZJhr73F4=;
	b=Uygv2YoRdKIzDNxKVmy8nTV3fsfLKsVd8Jt3etyLezWJqoYy5ElM+bk7gzG62XgTIe7Z
	 xcJbKJeT2tcKe1Uzh+d0W1rnI2f4MGhJV5YR/It0UsmJh1NakYoILNnPhc9QcJw6EkMvB
	 QhK7AYuku2p4HZ84hwJDZKW664iv28KvI6ktn1RLMlSBxY26au2ZX+j8TRmw71ux7YuJm
	 MdcoB9Uu4+uMq0A9UWosDyDAks4OoKBo8v6Xp5C9vtaHE2nEkZ/qZeCdxxPZ/ek+3qtIR
	 tChH+ipcSoJKQMxsVIIlv+Hv7jChdD4c2qEzpnBBxjOJgU8Z2wfyo2cQ950MINEh9wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EejZFTFd;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBF606A32C;
	Tue, 17 Nov 2026 15:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19EBF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EejZFTFd
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQeJq1529798;
	Tue, 17 Nov 2026 15:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Q3pxy6l9w14wNwnvpous4lbZt4UStE
	7GloFZJhr73F4=; b=EejZFTFd/6MWGCD/OkD0Wfo9wegrxGfQZHapeiEUFGJ8xo
	yy374/yr9lQxMkdUjlBams9LSQWDQypidlkP0W9Klbf2ruHBHlC6ts9zzfFETjwu
	f4kouj7tzu3ngr8i3rQtPD0HcJKGFEbQsTuIrzdOPE71WPEw6NXw0MRCftNKUHiH
	SO/iQW/rWZH0xeK1LGRAGBnBaY4HztCyWn+xAe/m8y9eX9RgRl9PCw1IWehx5Ih+
	i25QwhnSkPvcgfYRxj68qnJ6/CDlN8I4BqumLycW/bwncjCBYILk1UdXGOSpECGn
	hpj2xT8pifnhd1gu4CBkNjYMeuXlCNE0wF9/bX4g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxe2dbdcx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:31:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC5sZ53508336;
	Tue, 17 Nov 2026 15:31:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067nc8e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:31:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFVeSJ28246332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:31:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91B572004E;
	Tue, 17 Nov 2026 15:31:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47BE420043;
	Tue, 17 Nov 2026 15:31:40 +0000 (GMT)
Received: from osiris (unknown [9.111.0.235])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Nov 2026 15:31:40 +0000 (GMT)
Date: Tue, 17 Nov 2026 16:31:38 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/kdump: write protect the crash kernel memory by its
 virtual address
Message-ID: <20261117153138.32016Aa0-hca@linux.ibm.com>
References: <20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfXx4q+cx3dhe7l
 AP17M1+GISI0ZBtIGN5bpBJQeiQZR8yUPgP8EQdOCRJrgVa+kQaJFLdxVIs/AU9hftbMtmLgWuN
 tmMSpy7B+R9mgdve+7RB8erXODOfr2k=
X-Proofpoint-GUID: 7LqO1WDmkk_ADvkEEpua0fNTlCsn_5TK
X-Proofpoint-ORIG-GUID: 7LqO1WDmkk_ADvkEEpua0fNTlCsn_5TK
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6afc7361 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=hEEx0vRmW5ZvsO25xewA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX0FkcogyT+H0G
 Id2DpltpE3ZoAM+ZZirUN3paGlkCLUiuGWIdEfvpr6+5nWuwpJs7NqDtevtNNNf6WkjBRS2t3g8
 Pbt7biz1oYA9AoNPG+Mt3W+21atnqgQ/Gnbrk3zL/G8mV/6bOeonH8WRJz9c6fdWcsJI5wSP+K3
 Gki/f/dZc3ov9RJyzSc9z01rNLhgGFUoYg/oALLRH89Ykj2xEVql3cqS0jlPkvdE4cIAVG6RJYe
 A21Gf2168e5q3QQdFKxbmb6GRdzGp6M6QWDAIzefIQchQ9gQ6ncLneOxytpwdMFoiD7ABac2Kpl
 t/Az+DsJZeFPASLLp5njZn8FdOZZV/ZSL5ZelMJg/t34csQ8L/5J16lAB8flCsOVIa/FVk9TJry
 ZlLTPO07fZbJL0GEPLgNYI6BsuBlG7FZCHLDwGFWvUH5bh6TXuiBlEJiyUsoTPvJhfNOuelJKfp
 C+yAizxcMFruyYL9R2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170061

On Tue, Nov 17, 2026 at 04:01:04PM +0200, Mike Rapoport (Microsoft) wrote:
> crash_protect_pages() passes crashk_res.start to set_memory_ro() and
> set_memory_rw(). That is a physical address. Since the identity mapping
> may start above zero, it is not the address of the crash kernel memory
> in the kernel page tables.
> 
> With CONFIG_RANDOMIZE_IDENTITY_BASE the page table walk finds no mapping
> at that address and fails. The error is ignored, and the crash kernel
> memory stays writable after "kexec -p" loads it.
> 
> Use the identity mapping address of the crash kernel memory.
> 
> Fixes: c98d2ecae08f ("s390/mm: Uncouple physical vs virtual address spaces")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> I found this while working on a generic implementation of the set_memory
> APIs. Only build tested.
> ---
>  arch/s390/kernel/machine_kexec.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

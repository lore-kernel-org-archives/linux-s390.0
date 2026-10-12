Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA43C1093;
	Mon, 12 Oct 2026 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793352; cv=none; b=goFKHxoozlT7dSN1sHvqtlswWsDO/fOLtzU8Mcjm+qjMduvY/3MQlIyPcDa/c+rN//dqUHvi3zPrDkmTXHcr6JNNncK+IOrw0tILznBXo0WhB1WgCOOPvKkSdwjBmarZkeqtxS99ZUgBDrndyEyVJdm77kuU8Fz/N2fzByupTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793352; c=relaxed/simple;
	bh=TBMfwyZ+TIqg07Q6qdPri/s2diGYKg9dgTw29msxEvs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rfFTYtMy2//UHA0IskD69T09LSQJ9MVpkEvdcQr//6vVyUdi/TTTwlZLaIHwg//HFwlWojWh3TB1BN0nvaWprDRnheAoCyUurqCrt1Eh9Fa8sNogkOE7gj+cA1EWu4XR3wcOb0SUdxZmoA6MP72GJIAKNLQhmaBJrrM/APiA0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D12Y+2SG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D12Y+2SG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EnkG3565807;
	Mon, 12 Oct 2026 08:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9HCGW2
	Vc7yPU2dhbpgPlIBiOnNpyuBqWVCUx7C0BKpY=; b=D12Y+2SGvDeUJ8FMOmlgW9
	UOVvPiaCcEPrh4Uz4uyzt5ONZwVHtieH+4b07xrLQ2z54DKPQX4vmEeGbL57flJi
	sUb8xHfGlRbJdH5n+NpVVsdOyACLjiCLI+GDpU2EkdyKa7Oq+EVmDOGBmyBtK8Gd
	Ue8WStE7hUV47tkyMCQ9W8nafGZVod5gIGbw3eXcKcMdr6b8Lam9JvT75Q9A4Ezx
	Oyja/WVlwStnbpdjaFS9b+POP1oL//WUBjGi+g0G6ffDe9PIz+/dH0kXvq5+xi/M
	X+hwfnTuZAhU5q09UoQ6fEuRDRJKOww9FNI10siLNw4Bv6sh5770WqfAhv/Nhd4g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug7wm8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:22:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K35E1013624;
	Mon, 12 Oct 2026 08:22:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyc2fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:22:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8MRNQ50200970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:22:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9884C5805D;
	Mon, 12 Oct 2026 08:22:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2908158052;
	Mon, 12 Oct 2026 08:22:25 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:22:24 +0000 (GMT)
Message-ID: <465464313a5f441557182cdc072acb9815206f4a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/8] s390/pci: Fix use-after-free race in zpci
 floating interrupt cleanup
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Gerd Bayer
 <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Farhan Ali
 <alifm@linux.ibm.com>,
        Christian Borntraeger	 <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-4-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
	 <20261009-s390_irq_domain_fixes-v3-4-ced19028da3c@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 10:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc98c6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KZR02ZteluYoJnSiorMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P33E0lvl3kK2sO67O5QtryjFj6iDBAZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfXz30ofv70fs35
 wqPFMino8fA308nzd7KtV3Jvk8lvK44cxo6vsi4UOesbgt8CQlGXHouySTGHh+9x42aVnwmM/Ol
 uA5j9fZwKtHcfL74wVzbl3HLUrGuOyGZf7740nO2xBf4hoChtuHaWjCii7AIVAAcc/+nenahlYM
 IiiZsu1psJCAUVpgsPhNIo3gY1uPnA7tPb3FD6SgZWvKJjj8mi1AJbMaR4w6N1tssp3v+YTy/hr
 Po81mib+Pkce48nQHfOUr2xwUrhqR8MQtDqldcAHdOjUSk6jMLQJ3/lpKr9OUFlYgnMknkWqSQl
 4PSyZeI670fCxk0mKUU04dtjUay34BlevcyQsN6dBPfKyeWYliRTcnkvDMDBKDxtPiUrjCGWb/r
 S61dLyp5hzrzwlHGzEZJxPgQVeASJl6q5r+y5kLlerR+LxAsbvAafCJ1IygCrZH7/ja/9gEymJ0
 5+ntWgj3tcyhyV9xB0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfXzXntf6zq8uG6
 aEx+Q7vFcy6M6h/ThOxl7GHpXKlQNYiC1ulw2Y7AcoKwDxztIOrVrWeHbDaI4zzkWiOKtDttHqm
 zK0BS8Z9W3VR3+dCpRtyxhl/54lmiYU=
X-Proofpoint-ORIG-GUID: P33E0lvl3kK2sO67O5QtryjFj6iDBAZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032

On Fri, 2026-10-09 at 08:15 +0200, Tobias Schumacher wrote:
> zpci_clear_irq() stops the adapter from raising new interrupts for the
> function, but a zpci_floating_irq_handler() already running on another CP=
U
> can still be scanning zdev->aibv when zpci_msi_teardown_floating() releas=
es
> it.
>=20
> Clear the zpci_ibv[] entry so no further handler picks the vector up, the=
n
> wait for a grace period before releasing it. The handler runs inside the
> rcu_read_lock() section that do_airq_interrupt() holds across
> airq->handler(), so synchronize_rcu() drains any handler still in flight.
> Release the vector and free the summary bit only after the grace period, =
so
> neither can be reused while a reader still holds the old pointer.
>=20
> zpci_ibv served both delivery modes, indexed by function under
> FLOATING and by cpu under DIRECTED. Only the floating vectors are
> published to and torn down under the interrupt handler, so split the
> directed vectors out into zpci_dibv and annotate zpci_ibv __rcu, which
> lets sparse check the accessors above.
>=20
> Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c | 58 +++++++++++++++++++++++++++----------------=
------
>  1 file changed, 32 insertions(+), 26 deletions(-)
>=20

I agree with Tobias' assessment of the Sashiko reported issue and doing
it in a separate patch. Code looks good to me and fixes a real race.

Thanks for the great work! Please feel free to add my

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

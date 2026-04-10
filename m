Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCA339D6DA;
	Fri, 10 Apr 2026 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822559; cv=none; b=DWcVzCJ85n2P5LqpT//XRMbRecx63cQB4rRnC6SiAk8IWCPYMNPE1J7yt494vaxopEKgBPIHZcVCj/qQkan9ZdK38NOXQd6IJ9sW90f5PSdga9GcBSZ08arpT0Fo9h/ShxH+49DSZHBJYui4awKX0Oeab5mfBygbaUGWCojTZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822559; c=relaxed/simple;
	bh=g1kmFEDWtBFjsNJ3wS60GqZgBbgDZmvxLxOccNJoMIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=mLWdhpIm5H1cwpYE/9CIhRaDbpfvDAYn8UuVIOjjalVKqTlVK8uc/u2TxUjX31pP38VP8n2VSwQX3+lE4jVCCtEz/U05yZ4z1kpEIAWKx62v46ONBA4VPoPIbTgqjUWnktnMJLjKRxgEFmR+ENrhFuFU71otTviN6ENXbfsypZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SUNIfv1D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SUNIfv1D"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A4lX6V3885072;
	Fri, 10 Apr 2026 12:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5CZpGO
	y3VbFy3zQrUNCgF0ant6Mr0auZRaqyqZqV15A=; b=SUNIfv1DnPVHacrZ40x1Rb
	66fOq+0pIZDC7Gdvw5ZUxddFaJ33wwEL8W1ouG0/FGre8C0sc+omiT3lbF08UAml
	zfxCFpAuP3DJoJ2KZchCuX48rZoxattTu2XMZamfTzkc9Pndo3iToJ7enbs1eXkU
	bVsvI/InsQ68S+Zt/xYBmjbdjIAOA+0LmQtp/+drhFP2WGYKGCBn8tBBnJb+Aod2
	8VowPZdBm1qTQh39UQpz8YD9Qg9do5hNjfqW5c+1DBxLca+NaAdLRXMKo35t5KnK
	2M2Y3kUHEcr5ViPify/193vjXTP+8OUriae3FxxSah0gQVr4pnOY8ytf6y4GJo2A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hrmy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 12:02:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A86F8d007881;
	Fri, 10 Apr 2026 12:02:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2qumb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 12:02:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63AC2ThS45154772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 12:02:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80BC920040;
	Fri, 10 Apr 2026 12:02:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EE752004D;
	Fri, 10 Apr 2026 12:02:29 +0000 (GMT)
Received: from darkmoore (unknown [9.111.44.245])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 12:02:29 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 14:02:24 +0200
Message-Id: <DHPGJYGZJ28Y.15Z0CAJ6HVYIA@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <nrb@linux.ibm.com>,
        <seiden@linux.ibm.com>, <schlameuss@linux.ibm.com>,
        <gra@linux.ibm.com>, <david@kernel.org>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] KVM: s390: selftests: enable some common
 memory-related tests
X-Mailer: aerc 0.21.0
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-6-imbrenda@linux.ibm.com>
In-Reply-To: <20260402150135.196943-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDExMCBTYWx0ZWRfX1YkyI0T0fSpH
 DxQaqGdGA0SjCAKdVPS3+ae5TSp0Q2vijK9LutKRNoXm3mDIGYFcwcZGY2pqQbKJ7gO3phjYiOm
 ZmCy9qfMsEg9CvzkOFCcJooIZSKND26naApmNC5F1svivwtWes4PyNf21avIogMtAAXKvq5butZ
 HXSMvuGH0hr8+60PHrgmTEpVuujuJDa0gAW/OVxDqp9xT3Q+PqbmyMDTEHn0d62UCDSDPj/CjB+
 smE4q56m/IAu80El42C59DoVXpFILyMksnremaQFZ/bY/UBSaTMjaGSg3tPup6klRSEl86U4T2A
 bn2MHiGBGixYlZDEqMR4jQBEfwLfV/I4G6Tq0MlfrK/WrA5wDKgbWw+Hnfa0KRlMitEKt4BVZpz
 kJswzdYGzMgMP07AeYMcs2Oo+KVpVf06ozR+/NH/Y8rt6DvkU4B9c6SAfTExaqHiEx9Ux7iL1Tp
 EITNUi5fyzUJzLHXNbA==
X-Proofpoint-GUID: 1KkEXrUDVmaYSwPBhqkLsZwEAo47PnsS
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d8e6da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=zBtu8v2KzdITmXKmy5wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1KkEXrUDVmaYSwPBhqkLsZwEAo47PnsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100110

On Thu Apr 2, 2026 at 5:01 PM CEST, Claudio Imbrenda wrote:
> Enable the following tests on s390:
> * memslot_modification_stress_test
> * memslot_perf_test
> * mmu_stress_test
>
> Since the first two tests are now supported on all architectures, move
> them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/Makefile.kvm | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

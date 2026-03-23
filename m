Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9B386C35;
	Mon, 23 Mar 2026 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257071; cv=none; b=TJBiRoL/lDUvnCJhwDbxSIYxckqWiu+KqB/09KjbRKXp5U19DAGzh1sYj38PrGeqf/2sOPTDSPGkwQgkwt20lkXJ4Jo2uXJhoa0sqIoxPZeKx+c2d5UeCmwHX19vr608pA178dE4cHIwTIyjDe/Y02EoVWK8M5s8DEU3RlBW7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257071; c=relaxed/simple;
	bh=5VFrUn4BEOe7RnrT32XGA73Ct4OWgcU/tjOhg6uhTFQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=ivfuUYvEujQzqQeljU23vnyWnUdHcdgWFkCuCSNkBwwm0Tn9x6G9wM/+JL4HOBR/uSCA90pPe0l+fI2JIc7iOlCVu4/BKBmBpMOJ2cNAWf9p5GwwkTXRzG2iEjx5eWcNbRSPuYrN4EkRZfRuEKj9tY1mwZGhE9j8d31Tz68yjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cAI3ML+c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cAI3ML+c"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N83p4r3481709;
	Mon, 23 Mar 2026 09:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UouNbb
	OFiDpPkR1bCYhivO3gYan99GloGTqKMwamfPk=; b=cAI3ML+cw1uix0iWFbzyDD
	39ELeOMW1H+hrb0G786lceokRyhAXraCD7x3Huvw4LGhvsAvjIPVU8A46lGLbi42
	Tfg0gy6kvhoZON8KI7WbNPQyw9sSCK4nk9gWtdvaf+su8d1bjJ6siKWww7txSnhN
	qgLY2oPeqYATv+Qikg2h3rwc2bCm5FVRYVrC271JPnCVOTvm9jVb1+XyK3OSm/2R
	McRaIumF9lR+7O9QeEdYikR/L8LJebljWigiWQ31vGyWd+oimFpoHouIugnO0zV7
	omV9KgUflkt9TbwzEY0FufQhWvSaghnTZY26T0HVeXLKxEXORhSqCy+4esT3yiYw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq64pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:11:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N7nhB0026771;
	Mon, 23 Mar 2026 09:11:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kmnds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:11:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9B4Fr53608736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:11:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE0C2004D;
	Mon, 23 Mar 2026 09:11:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B63D2004B;
	Mon, 23 Mar 2026 09:11:04 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:11:03 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:10:58 +0100
Message-Id: <DHA1MWHURY08.1J7MEKGGFHKOU@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 07/10] KVM: s390: Use gpa_t and gva_t in gaccess files
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-8-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-8-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hFv1EpojN4W98AxFh-mnHMHmCrCcTz09
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA2NyBTYWx0ZWRfXwPD5rbIQhZqk
 nFPjC3guD7chyB+jfFiIqpYKdjPxqKSjQBldCHOvE1UTZAFrN9Xy5cutvvuc6wwoXI015W9P+71
 YHQdeCHO6DFPYEQJEJaHm7Q7L0ansDHHteWpid4+DIGf8Oe1lI5+7Ryl0Wk95e7M+xM+RE9qER8
 xc95LqXMa5Ig1Nms+3Ca8vfA2dvCB2oNbtUwpfVSISf1+cZQvFRQI5h7YnIC43QKq1dVa3vQKN0
 i1PggxT1xBbXP9AYlgNsMRzT5EOTK1eYNiyHv0ZAxjWs1OX4zFF11RyAwGP/NBfLKmezpfsAXNJ
 /sv+1161+i3s+mF/bT/7nDbfIjpWtyviluRcFxpIyAcAQYRokdqMz33fwEBOFmZQ7rixNl2X5vO
 pkXlhK14iiKy0KsGFGFRKLsjVavFYyUzvrvOMet+l+1FsHO3I1XdTDKJCC1APgs2xEZmwnN1uY2
 E4fN29DtzSlbiL/w3NA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c103ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=_aBxfZIwchjsUgKDmDQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hFv1EpojN4W98AxFh-mnHMHmCrCcTz09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230067

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> A lot of addresses are being passed around as u64 or unsigned long
> instead of gpa_t and gva_t. Some of the variables are already called
> gva or gpa anyway.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/gaccess.c | 20 ++++++++++----------
>  arch/s390/kvm/gaccess.h |  3 +--
>  2 files changed, 11 insertions(+), 12 deletions(-)
>

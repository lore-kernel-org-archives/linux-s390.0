Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6A29B8E1;
	Wed, 22 Apr 2026 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837751; cv=none; b=WPEdw2rUoJf76/qZVFxY/bCKSVQNdHF6OeNDI6qfUmkQBOCqA0M1DdjuX0/S5KhtIrcpeKKr8YQW9wR0YfaQErRnEyoIpnP5/DP3j5gpglCY1PHeIpU56Pj0M1KODJYRghcf9AoNbgvugauM4MqHrcd1u7IO+x/sVkqhlJX8EAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837751; c=relaxed/simple;
	bh=n6PLBt4Ey5y1LWJdXd6YJhZth5Ln8ufIDf8chpEAiMM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WvkNIpV5Pmh6mFOSmhPABZyA6l0eBgTp4Fcj5IYTkZW2BsvijFCFOTlJD8vqQAVeesrOFq/wb8EwO6Fllt8sJ31GyhcNLzkmLH2vt7l/DgjE0dC64wPIGTG7QKjKEC6FebdvfV3v7iE9NXa7tm5r7EjHUfljrKwVMWhVRUIaUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mVzmq7nu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mVzmq7nu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIlrlj970411;
	Wed, 22 Apr 2026 06:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n6PLBt
	4Ey5y1LWJdXd6YJhZth5Ln8ufIDf8chpEAiMM=; b=mVzmq7nuFUcIdX+jaNLUPz
	y41eNx5L/sDqh4KSl/GEmyAhgLbSsUF2Fgl3hX0r64QgXCpMNYWRUoeM2oo2hFks
	/ySnf1ds4KwwMb48dxKAASfo3QItFJM4Tu+mIsPSGZNuVFnrb4F/BZU34/2SI/Ox
	9aY4RqHSKAf8D0yTc1895qHbwXtLeJ5WG1+JE6b2K84g04+EwLHmZprpL/nKUHKI
	yE0tFeBFZqevAg9qZTkNGoSDHNRrviC3qwozDqme7GgDwjkOL+/BlWPlWZyoCGr9
	q6dhIC/6KAmTNfgcZC8xV61UiXD5kaKGgNjSCRgG+0yR40OR7iulJ+Y8E6Cvn6KQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3hrwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:02:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M5oVvi021172;
	Wed, 22 Apr 2026 06:02:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyh0g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:02:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63M62OBW56099268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 06:02:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A225020043;
	Wed, 22 Apr 2026 06:02:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 690D020040;
	Wed, 22 Apr 2026 06:02:24 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.40.84])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 06:02:24 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 08:02:23 +0200
Message-Id: <DHZGEUO4CC4D.2Y1QTQFF014U7@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/4] lib: s390x: Add function to get
 page root
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260420084933.251244-1-frankja@linux.ibm.com>
 <20260420084933.251244-2-frankja@linux.ibm.com>
In-Reply-To: <20260420084933.251244-2-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: twMFXFVZWU2wjBs8a1Gi7hMS38wMVHvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1NSBTYWx0ZWRfX5HU2/3zbeES9
 yP8JB/+Esr+V9RIhm/gYmcsrURBvAyCoMf/JWeoob1TRCdMP+NC7Ub/mIboMeb7VDPiKwgPHxBo
 5/FKrSc0idgtr89esUzeyNCMELJ/lnK94nj2VD1UsC9qzVGR/39iL28MyJlW/RCn/eJV1lyUv90
 98i7Y80vROFvZFUieMHEvu2l5q365nLN4FJq3EMSKo/kMn5FM1ps285bdMx7rJMQq07dv1fKAHa
 XsbE0t8Kh8XNVG0HTwGkOtk0cd6Pu732GzTJjiqfW7QlYZHD5WgzPRYTls2NgrfKm5qPh6IfAF7
 +VO33zZLZmht1tI7Bfi28zcvjWvsDrmQcpZ04qL5y1bET92XntcaC4i/xND7AwNEZKkjjr1tCY7
 YnUsuZM8B5yeSwKlXxA/4ODMc2fisWoAJAO6n3sqg4NlwqF9xDQwFVEJXuWvVqye3bctVNqzMZr
 cdPqLuCKI25xRBmQRaQ==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e86474 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=JpOM-OZrDOjRqmxhRBYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: twMFXFVZWU2wjBs8a1Gi7hMS38wMVHvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220055

On Mon Apr 20, 2026 at 10:44 AM CEST, Janosch Frank wrote:
> It's time to hide the access to cr1 behind a function and add typing
> to the tests that used void* instead of pgdt_t*.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>

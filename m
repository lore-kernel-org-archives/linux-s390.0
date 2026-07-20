Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466A2D7D47;
	Mon, 20 Jul 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538190; cv=none; b=mt1MpmggmWJi/PvQ42TSogI1+7n6Vw4Y/BeNLMxWUBUAHCwmY2Xcbj2A/ughCzuUT6AvizXNS1HmXR9LAD1HdNCuJThm3BhU33gQPHJMJVnPujh3GV5gvlu8waTdei/mjfTtzhJ/FZfpgDpuHFXXp06N3HaUhv3bEN8fYYHGutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538190; c=relaxed/simple;
	bh=WDr6F6RhJU6xH64nMdP1MDi10i/3c6+JCSfOt2xqZvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rStYD1v37SvU4VsCdQrs7yrW4cRtVHR0a2XzKVt7NpfUM5b4yhvWtHcrAxnjvyFqjxTvswzp/p7a2IGpf8yWsBWo45WkZC2KkOY+VIjBk/t6nO8UmNzTsvqeCvpbBHF5ONNwKauP2Bn6QPsUNPhkzYkJ8fFcJQOeS8DGfaVowoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n2r5VsqI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n2r5VsqI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fiAn1461500;
	Mon, 20 Jul 2026 09:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+whUxk
	VqJVBW+96CRXSzOpQL/sARUAHrB/f+G3baTBc=; b=n2r5VsqIp6gawVUcGjSFcl
	LAFaQdCDO8V500cO1YQlIKlbQdxXZyHht/aHJJS/9dJ1xXYluJ9lVF9Mr1mi0neL
	UjyWThZUkugjUNhizbYOwA0okHQbH2Occ1f4DOP2rWpXd2yP3wFm0cTr+Me1Ze40
	BieFkhAdEAC77G2ZR7gnUSoi5k31MeN0pz2WzceNBENHggTjX9dH1eJIYurE26Cc
	k9kc06zkF6cQIasutV/fyINYOn9IbOPcDZIJEyXgZ7OtBpIgay6Be0CGldirhl8m
	0aHQw0aH0NLpqRudwpqC5s8vWdwAxOoy4TPfO+aFubcjd+55rrHFh7TqoWGNHboQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab6n27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:03:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8ncAx012965;
	Mon, 20 Jul 2026 09:03:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy4jev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:03:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K932Vb48693610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 09:03:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 999DB2004F;
	Mon, 20 Jul 2026 09:03:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35AE02004D;
	Mon, 20 Jul 2026 09:03:02 +0000 (GMT)
Received: from [9.111.21.55] (unknown [9.111.21.55])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 09:03:02 +0000 (GMT)
Message-ID: <e1660375-1d0b-4948-8abd-aa336bc5d171@linux.ibm.com>
Date: Mon, 20 Jul 2026 11:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] s390: Reintroduce support for DCACHE_WORD_ACCESS
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720085834.898025-1-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260720085834.898025-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXyrLycevSSUtw
 X2RMQ+/n0gZBLrFi/eV5KhfpK4gFrxezYIqYCtJ8lQtQ+jklltZdX/1XCfO7F/y9gsMpHwsiG5M
 IwaEQ7ByD08wnD5F+OmyXocFswNfcCSZPCOgBZsw4wQsaB8j8WS3jiQoRl/A9aoxLwJBLqdcxut
 r/0wrXHR2mddY0XxA3SoqqoE89BokqbSp+CJZAqmwXusS+828wt2ObDUnSKTXxvADub0TpJk76b
 8qXoZrhfNVeQqVj2jT9qskxhllIkGR21iNSzosXdFjd9oNpICTbPR02mLvaeuogi6a01g5xSiFL
 /YOgtykU2chY2x2PaDwz2U8fYSC6NCO/5JDi6rik5m4IKDaPkc4a/LxRX3ZE/04e7ZqjjLv1dCO
 TIfmn5nm5aAlu8q57teY8UQd3Isnn8eYIPEOpF/+/i6dbl7fP3gAFUpk1VB0Pm2tm7+8tWi2F+V
 8ET27arA30GBhr3RLZQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5de44b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=6OClagNwZMX5feE_IwYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XZVwgqaZXrtyNKXovKrZBmFL2P-EDEr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX5ySpq8Iu9D7Y
 IzuAoPEfT5S6Fxw37EiIuRd5DV6PW9l1ciLpw0qFufhxl6+J9uDVG8pfH7/taYD4VPX3g3EZik8
 wJ/KMeYyZsl4DuITAKGyJmKwZ3toYeI=
X-Proofpoint-GUID: XZVwgqaZXrtyNKXovKrZBmFL2P-EDEr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096

Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> v4:
> - Add two more cleanup patches based on Sashiko feedback, however I
>    don't consider them as bug fixes. This is more cosmetics:
>    - Use handle_fault_error() in do_secure_storage_access()
>    - Use goto statement in do_secure_storage_access()
Shall we run the kmemleak fix (for the initial memblock) and maybe additional
kmemleak changes for the other secure memory arady  on top of your patch set
or shall I run them independently?

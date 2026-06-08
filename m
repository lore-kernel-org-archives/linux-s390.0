Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF83A9631
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906793; cv=none; b=VqNJMscSD8Xu4mIF9tOCAydisrFyA4FnaYS91vpOgPMfNDLwya4St6NaqHhH9LNN70Iqm703m5T9znaTWuHcX6xQB5nPH7cfl88ilyvwkshOPZarvkZFj22WryMjZpzgmqYbGd9aLTfJ/FPgj99OKR841V2oDKqAVdSgnIw+38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906793; c=relaxed/simple;
	bh=u6vfY3nBgtWiNskcV3CZqXbrCwHY0d5SbCHPWBV+LiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ512ejDI1qbIQbS81NWKaolpFmmjoFe+wz9rEq8RnRcg7Kqk/gvVS7RpPuCRjg6msqS33jC8J+kltJLLieZToxKKfLUjJ3iojt6VRsv82gqMxXVGh1J+fe0UE9+PGAalKv1Owm0fOt1/Iv6uFXsyCb/viQWHKf/lI6wLuWaWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bUEaXfsj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bUEaXfsj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657MBcAo3003996
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 08:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=u6vfY3nBgtWiNskcV3CZqXbrCwHY0d
	5SbCHPWBV+LiE=; b=bUEaXfsj/sHVNAH7N4gaZLzMzwk7lkccZLMKda3FJrFCu7
	MEXgxa0QwvnNx7RmmzXzYcUTCi5Vo2XeBT8UFQuEm1YnLa8Zu25y9R+ymiDHTO7q
	3qCIHPCZmVSuFgrNkpEVTKwdyNXD8AvpwkdtkjIqs3aoMAbNtLWkCq4wXJ6of7Ge
	+i2RLSeiuMjsZLZ/DDt1tTXFwjACJRiftV9+UdXtO8uBK41Vg5C3ZdO9SJNz6rGd
	1En0GaLpHALOcPswFgglhVmQfMueOo6l/SxCiYXh846YnN17sTcwJc/8iZjR+/3T
	KPTf7wLtEQjyVCPvvkIMawWyvAd00LFjftw1Mlew==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb956b4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:19:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6588JbEr031414
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 08:19:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgvcmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:19:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6588JfdB29688104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:19:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83EB120043;
	Mon,  8 Jun 2026 08:19:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2463620040;
	Mon,  8 Jun 2026 08:19:41 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.139.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 08:19:41 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:19:39 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 8/8] s390/tishift: Convert __ashlti3(), __ashrti3(),
 __lshrti3() to C
Message-ID: <507926e4-d6a5-45f6-822c-1196e6d5d18a-jchrist@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
 <20260608053754.571282-9-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608053754.571282-9-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a267b22 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=ltDrcrLIAUG-mvjXoIgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0d4RDcdoPsl4g85gnckIsOEc5QubCbYd
X-Proofpoint-GUID: 0d4RDcdoPsl4g85gnckIsOEc5QubCbYd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXwym4J+4Mowf3
 d1WyMpn2VoairrI4bK/KVYK52BSd/JlTWgHmWlE7x49C86pqhwZqVfZ7kPsKo63U+ibGf0Wx9l4
 888LLquxANIZr6rCWMN22k2y2TxD02uuvxUUL3GTd+Ul5EOOXRg/wGj6T/Cv6z2PNRkZxjzqYh0
 BRYx41yqrdzzjMTh5f8q/KMpo9XzlwWQN8KSZyOwA1NQOgXWRTgoJjoA9Ib59EqlUMlrMss4jEy
 8Ww+Wu9qrhE78pyvCm/Dn8NuuOn0i9Bk5ltttK54hiHM++8wj5qiPKg/iRxp8v6IP36F5HJLuFX
 fipaAxVveBgV3Y/kuqma9ydyihwkiFWobvayOZxwjyd3xe6T+5R8MSnC7yOIuEciJkOu00qmzP8
 7F7Uxw1YycCokLBXBihYJeBNZwX1ZkFJ5+Gn+AnKKp0OvTuBWXdkAshjvKdX7WhaGrjojFSYii3
 CJBc+jtE+exV6gph2iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080074

> There is no reason to have __ashlti3(), __ashrti3(), and __lshrti3()
> implemented in C. Convert them all to C, which allows the compiler to
> optimize the code if newer instructions allow that.

I guess there is a typo and you meant to write "implemented in
Assembler"?


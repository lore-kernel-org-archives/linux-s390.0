Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D61E2614;
	Thu,  9 Jul 2026 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585052; cv=none; b=G+2EKgkFB8ITlPyAA5BQ4UaXYOxTzkHwsjLpV8tXtQcmJ4jZ3H2c0h/eKheDsz8ys9cdjvlacegWLCM0Aub/HlsCYXEh/zuxFYdn1EhLE3JMuwlGqlC9wRN3N7ndOKw1i+bDoNSTkxy7NO+QR9januNXmi8K5VdC3sR76m6PnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585052; c=relaxed/simple;
	bh=DTdFAkdYI0/mlNZy0XXyzS7ZkC74xQmKKCkAlgA742g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HThEeXnuMhKPXyTRTscr7/XRDBtloARQVLiI2w32AIl/vrJbxaMuCn3Q436J5NkJPRCHxNMEo7zyQuObIZB9D0fhzfXM7LyQzz/dFDhcKnpBZO2VG+qSls8G6KpwFS2A2ksbAoqC4KQdJm5RVVgOcvA6YIp7aJSG/GaetLlX1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bmZbNUeV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bmZbNUeV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IiRK480696;
	Thu, 9 Jul 2026 08:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HaTLhG
	4UNLo9wZrfPzq39KgpfCAGPp7p72ZzjXJ1h7g=; b=bmZbNUeVLG+dC1Z9hPpQ+e
	yXq/dkKVNO3R+L5TWTdcqiXtQXtPLjlXZu6+kDKyeduFpGufW/y+IJ1c4NeVeTLf
	fOWYAX6XUtDBUzwFjZaxeQ3AFjEHjP2wtybM+8wGmnhgdSR1HnglNf5k4HUvcjIO
	+xybE01Oen7tWQGEehw4uDF+xKQblRIcJKX1kDZ5CZq9dppZ8umSq/WoxrV/Gqr7
	8vS+OeY4LpfXBLrl5JURbeHV1UYtt29QOCPDJnvHx9GF3948HFF2Y7nZrSGo8i93
	c+1YRNQo1MElZ/McTGBkrZvgu4LTIbK7xqVWkwC8Cu8odBXTmF7BonxBQeM4HfZA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt112g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 08:17:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66984h96021328;
	Thu, 9 Jul 2026 08:17:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgc1cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 08:17:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6698HNrG59703738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 08:17:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B54A22004E;
	Thu,  9 Jul 2026 08:17:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CB1B2004B;
	Thu,  9 Jul 2026 08:17:23 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 08:17:23 +0000 (GMT)
Message-ID: <c2329cef-5b0d-4d99-8832-4ef957f652b8@de.ibm.com>
Date: Thu, 9 Jul 2026 10:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] KVM: s390: Misc fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ndSzlChLPm_GII86gwSpFplHyc5wAAVv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MyBTYWx0ZWRfXzG2hY5zr00nZ
 Hjrt8WLAZZ+mLAXY8UJyET2DnwYqj1FFbVqrr6w02l/LkNQI1cwmv+LMoSlN5bHJLyHT5oJRdQG
 B/hjbkgz0jG5WQV90Ny+Ymtp2iebf7U=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f5918 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=cH8sZqYsz63F55QzsN0A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ndSzlChLPm_GII86gwSpFplHyc5wAAVv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MyBTYWx0ZWRfX8+DPGH9a60k+
 58Dw88FDv8i8eSoV2Ewf7NWDKDuoqyQINxVxQ78x0FLje36MK4983OGedY9T5zz4Fa5PK1M+tSL
 CBGAV5kGI+7HFQeSR5YN28yLyo7oujoZwL65zjwehbtGOppexmV5rFmMU9ImFYGfmcVmMRy7jfj
 BEYz7u//1JmJ5HMtZHStlA2b1oNZYdUipffqvdBdDINacwxCRVDs5lmrT6H7un4luZ81wDOJViF
 V9QqoON6DCvOZyZzNGCvZ350qAvSRhdSPQBCgH4jy0kdXc3xCHrdB/Nd4ZsEICIJmCZ4x1xNMXR
 F4bQhOIDaIxa+ZPcfesQpk1Zv+BQGCwxN6tqTcI1UmN/XPOTvBHm4en+K3+PxBaSHtOLgyfzV/O
 lcx9gND5xxH4NASdnxqwMmMNVCR3kOV4J4BapyZgoHIO5Lj1cnZs9+CKUfkJzDImKjxfeI+gQpZ
 zjj+U9cp0g5G9Jb+kbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090073

Am 02.07.26 um 17:23 schrieb Claudio Imbrenda:
> Fix a bunch of small issues that came up during the previous round of fixes.
> 
> They are mostly extremely unlikely races, but they should be fixed
> nonetheless.

So I picked the ones that have no sashiko concerns and that I reviewed.
Looking into the others at the moment but many patches to review.....> 

picked and Reviewed:>    KVM: s390: vsie: Avoid potential deadlock with real spaces
>    KVM: s390: Fix dat_crste_walk_range() early return
>    KVM: s390: Improve kvm_s390_vm_stop_migration()


still reviewing...>    KVM: s390: Fix unlikely NULL gmap dereference
>    KVM: s390: Fix unlikely race with KVM_CAP_S390_USER_OPEREXEC
>    KVM: s390: Fix return value of kvm_s390_set_cmma_bits()
>    KVM: s390: Fix race in __do_essa()
>    KVM: s390: cmma: Fix dirty tracking when removing memslot


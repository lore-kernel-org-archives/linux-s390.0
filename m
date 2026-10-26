Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009026;
	b=3GmGrgDXzSutTH86DSWGyX5/fUC9E1NMRIyXYVVXTcmZYQA5YyxsSzVX9eaSA3AeROBT
	 QziCq8KGb4ib+fSJIyKtmiefp6FJr14wNT9n0ORpkwnpqAt534Lu53QorNEXZ9DtcznEX
	 HMeqEqQp6Og249JsIPO9QBh3x9LtY5ve1E+SqHruqVoJgKsTTKJaRR8GvDneNbTSt46eK
	 VySb9hhgEXcoJZr56I2umaviLZAVbmIu4bCyuv2d/u28ePpBgBnsFZoxbNf9c6zset8HE
	 NG/KUl6k+fUYJ3s7CuoZeaer1qYYv/qzywogBSWWCw/EFK9D0LKQoixTacGIK3bf3Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009026;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Cc:To:
	 Subject:X-Mailer:References:In-Reply-To:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xCktAOtrIXlMUdZfhydjqeG39UfDnbT0LmYjvVkSdCE=;
	b=gHuWXK5uV4JBEZb3pwhWnljGa10U6aVIl5XzOT+o4635MkeOjS+7SlCW/UBIKsBm5rSP
	 c41tPzOH7+IVm3L/x/c37IyNNh2H3cR58kMB26pROoGsl9tOf5puaSzg4KCXQCeIxJZY8
	 8DINgJedKluGQMXib6JJMPoeInLUpoLhxjzJhSTzmFJ1nZKJyAUtazoaByQuMisOHohYT
	 zQFtYvJY7U9NLwxeE29BxWCcr6WAnA73vg3fjzd9FjaVO74nQIl9wwWeSQjN23t8jeX0q
	 Y9aAUbAcUzplbQYVY/8xkzgxxjmbLAY6rubValy64S+x95yFriOOfFEPxufJ+e80JZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TeqHiqsE;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8E606A32D;
	Mon, 26 Oct 2026 10:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A8E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TeqHiqsE
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2iLud1990697;
	Mon, 26 Oct 2026 10:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xCktAO
	trIXlMUdZfhydjqeG39UfDnbT0LmYjvVkSdCE=; b=TeqHiqsErPSsnnPn3Roe91
	p6AMic0egOjlY0SCEDggmjKQlAP951L0lf3xJw+dziqezGDdsY6HMg7XjqTi42tP
	x3X0IzEAgnFlLhzODoUid/IY9kNMLBPQWA2KoiqGagToXlalRhis1iqNWnioXGLQ
	j07M+byAfFdGsmkm4uHx3lp3HCgMW9P4Fc96Pk2ywEdhEJ/lTde5QzUlE3YU+e+4
	p3APM6JIfFJUHwHxa8KjHVnalU01PS6aucooWjPsuAKD7JfDrt3kkU1EnmDSOShn
	Sdt1A7y5SY+YSuBGRZVhAVUL/d8tikECSyqregyBXYPQLyXz8cIgN/wl+lRVQHUg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6s6fs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 10:03:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q7N2Ig1924572;
	Mon, 26 Oct 2026 10:03:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8ggw6d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 10:03:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QA3c5x29753638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 10:03:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C3D620078;
	Mon, 26 Oct 2026 10:03:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7919920071;
	Mon, 26 Oct 2026 10:03:38 +0000 (GMT)
Received: from darkmoore (unknown [9.68.0.144])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 10:03:38 +0000 (GMT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 11:03:33 +0100
Message-Id: <DMEONDGJ1YZJ.3FKMTP7P8PZQ@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <borntraeger@de.ibm.com>,
        <frankja@linux.ibm.com>, <david@kernel.org>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] KVM: s390: Rework some helper functions
X-Mailer: aerc 0.22.0
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-7-imbrenda@linux.ibm.com>
In-Reply-To: <20261023155531.206113-7-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf257f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=hWlUGzjMdFzisyG0TwcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX8AkfrqpxSJNQ
 7pGD4HzjbDCKpjIIbk+SLjrpPhl6ZZqudF7Xhqj86SSJfErjLjY3PUbhMJ6LRUouZ0asRAnITE0
 uDRVZyErxrm8I1BUdEW0SUQ16lcu/N7kSYrpni30CdjUFFZaLnnHToww3QsusUc1iW7XJ7GKQ1L
 mfxhM7CblSfFMDsEAV+aFpPFB7TTodPkqJX1Wybxz28G3ieLU5QI1jLlKcm8iEBTOq/9IOFBxvk
 BqXj/5Dc4y1FBYoNzvqClNrZ9hj2dfjoTEBZYQTG/gVS41p9ijxJg/jXRXRmfsAN0AekUSpoSYJ
 1Ddb2AwdQAIQzKRuXkuRBB8nFD/vR4btcpotrfxDhqmJans5O2H8NM2XCRgreMrsrqivNmnj+VQ
 a16BindvovJ877junR0zDM3wHXk6ipxLYwDTJmUbNwvJfmRrjHkfkIkxPxBus1YA6eOKvBDBzag
 xrDZtbqS2JI1tPLr8uA==
X-Proofpoint-GUID: gwjGy9-sl4dKzy7J-HvmECiRAhu0TvSK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX0FhlHmJoBvow
 C2LQZQ1dTIoFhKT+FKa+ePwzrkYZfpYyVN+nFSm/IVN/9I+ZYCZrUU/n5fPXKEgFWfW1+rtGd0d
 KeA7Iu5h3PVeRvTmutiGD2sPoHixZzs=
X-Proofpoint-ORIG-GUID: gwjGy9-sl4dKzy7J-HvmECiRAhu0TvSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260038

Change is fine, but you could also consolidate the logic in gmap_add_child(=
)
which does currently test for is_ucontrol() and kvm_is_ucontrol().

On Fri Oct 23, 2026 at 5:55 PM CEST, Claudio Imbrenda wrote:
> Introduce export_on_unmap() to make the code more readable
>
> Move the #ifdef inside is_ucontrol(), make kvm_is_ucontrol() into a
> wrapper around is_ucontrol(). This way the compiler can remove more
> code when CONFIG_KVM_S390_UCONTROL is disabled.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/gmap/gmap.c | 2 +-
>  arch/s390/kvm/gmap/gmap.h | 9 +++++++++
>  arch/s390/kvm/s390/s390.h | 6 +-----
>  3 files changed, 11 insertions(+), 6 deletions(-)


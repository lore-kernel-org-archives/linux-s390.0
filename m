Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185773;
	b=AaIE6XFv9w8b+ayE0NoZNmdJHFAHQxCG20q8LYCVKWgyY44ZUxzkj/VErtFbXHxYb419
	 OFfZI8IlNE9CTWvqorqSGLXxrHc9iXdciJEEliG28dtTVsJkRKpW43eUJn7sIMqCH8Z/2
	 xal7jiSPSPcePDA/AJcb0n0bEB80n6w6bX+J3IUFDrlFwYOS2ew09mlRqzZLRtP/2NUEH
	 2PItUVhfukEkdSp45nwSNY/RG/w2vW6ozyk8G7yZPAjUGcTdgWb953qqvbxIMeL8ruSNR
	 5WLOXDhCUECCYX3UwbuATbE21C7ivjHHbaAA9x96vdg1UsSgAiLD9bectcsWECsg2dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185773;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4WdawUbyLxjhQ6ufEdrvonrCqfXUGUAsal3nEAabSuM=;
	b=uvZ/YF0l4fit9tvrTBdDBhJ2nvaw4U2eFrFL/WQeGmqhSHkcIlE/HIPCtCLbfHstd8UV
	 Fa86Z5lXmGysMwiHhrUmsuAZBaGL1T9Lu5YcVg6aCkoLEA0VB33MoLPyITp5fpPNP3056
	 sf3JSERI6VQs8STZXpMPlTe0uX8bqB81wrYIHF6fDlMb81f3nIihYJRC9WoVru6pHB4rU
	 4nKCnxrCKi1tf17GC8oMwMEGntEVI4HfBJkW+IWIxYLuic3CD4oTV0O6hA35u4U5YWylJ
	 4HtH05phELJZDxmscBisWA8sOd8MvsfarZl0VC+5szHSTXIGGdJqdmbd+nAhJzCpwGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BoJE9Llq;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58927606A31D;
	Wed, 28 Oct 2026 11:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58927606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BoJE9Llq
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8iSoO3807035;
	Wed, 28 Oct 2026 11:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4WdawUbyLxjhQ6ufEdrvonrCqfXUGU
	Asal3nEAabSuM=; b=BoJE9LlqlAtTHQDsQrxCYMmnabTaXUID61XHXwk4WEevBu
	U/Tbm71QDbb62eLA4hc8d6UjDmZA8jEpyBsY2IDipgH3zR1+SCd+6zrro0Uu+qrb
	oxQZv/vjFLqyZaHRYe88XppfL33t6Ik2N5cgouD+h2uNsxBUU3K4zx27HcxgKKug
	5G13HSNWVlRX1Z7Is/U/3Ss2qoEFAmnUQDAAiJTIDMJEsijU7pb9LQLDcDzNs2w5
	QWkQhRBk49Goiu8iusINa6bdHCia4SQI/lo3d8YGUMMPTvMIZ4F6t4NdQt3wpz3U
	OZbcqVP2xFH7TBQhoxA6vnNjuUuQhy2xjdZNfOcg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g44au-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:09:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K0mk1274966;
	Wed, 28 Oct 2026 11:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7vw1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:09:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SB9Rwc43843906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 11:09:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2F7720040;
	Wed, 28 Oct 2026 11:09:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D81C2004B;
	Wed, 28 Oct 2026 11:09:27 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Oct 2026 11:09:27 +0000 (GMT)
Date: Wed, 28 Oct 2026 12:09:26 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 04/10] s390/runtime-const: Serialize text patching
 with text_mutex
Message-ID: <20261028110926.8417C5c-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-5-hca@linux.ibm.com>
 <034dc4fa-520b-4ad5-9d9d-8ae469692698@linux.ibm.com>
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
In-Reply-To: <034dc4fa-520b-4ad5-9d9d-8ae469692698@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae1d7ec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SoOlLlOYVDHFfBhTSR0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: qHb4vcB2bfdmTTQjx5QKVEmqlX_bMzjI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX4YwjaWp2HCav
 Rgx+O5aa8CkAXuE0/SwdSZW+DD11Qae40nx5zqBL93vkxWW9RhHfMH/wXlG4HS7iSHC43M5kBBZ
 I/2//V4c1Uazm9bmIm2WDcKklBhqcDED07hCOf22833rzlEjacIer+HhkeKUY1MOFXHUe6LcpnZ
 kocq3+r8Ln3PH3+MyDLgtbR4nCNs/PA6N5V8xwSrrnT4NKg3/yrjlMOuhmPEQmu9LqURr0r+04P
 Pkf/BHnV3eBXWsObafFnUKuevfzT3LKkimrfnvrqqpQ3JaHo1bVut0iyd/ye0pMxva/rUrDZR+A
 hc5r//zpHFjwqm2A0XmwPvDxcmMOisapoYZumPy+W6KTzb8jiNrM8Hut5V4gf9rWbBWkeBUWKlY
 6ff4SAzMeSSnRI6hQW7qrFQ+7jAk+dHPn05gDOj7wnmtYmEezFFjnhGxd2Twmzad49xIKROXEYl
 eU3sibRBA1WmB2k8cCg==
X-Proofpoint-GUID: qHb4vcB2bfdmTTQjx5QKVEmqlX_bMzjI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX6fSzC89in7I5
 /l9YdahMcNaZe/FJ8OCXcGZYUcU6zwJJvHe8t3W20Ul1UVWhTT1BQsNk0UCdUMl0i+URlfCyRRF
 xkT+HPSvrFxL7kDXpcyUDGxox6BLkDA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280042

On Wed, Oct 28, 2026 at 11:58:27AM +0100, Ilya Leoshkevich wrote:
> > @@ -88,6 +89,7 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
> >   static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> >   				       unsigned long val, s32 *start, s32 *end)
> >   {
> > +	guard(mutex)(&text_mutex);
> >   	while (start < end) {
> >   		fn(*start + (void *)start, val);
> >   		start++;
> 
> Interesting, so clang is able to propagate context even through indirect
> calls without explicit annotations?

There is no clang context analysis involved here - this is purely lockdep
based (with the last patch of this series, which adds lockdep_assert_held()
to s390_kernel_write()).

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470099;
	b=0CXsCfYKAN3ex0qChl4cpVH7qyeUYetomTNR4EKmdHOEWuUiS7V3oAEtrYHWFg0E54Jk
	 W43EsHfFUL+O49fqaRY2dzwQMbLJ0gaKMJY74e++3YRo1SLAZTITQs5dwl8rQHSvD+1hF
	 NlSo2zikW2NCVFFrCkE6WLwp2gcHfHry4+KzjUp9GYOgUzWlbGV87gT4G304IKpmWoJM3
	 IohVFTuSa+k6USJJSUpcuz5b1BfYpGKLMVtAU0xATnFLlUS8gSj5NSQExccF1cGpmeHF9
	 q2/BzCiO/FJNTl5GtjqX3EGwHvbBalT0Z6hH9c6BM2fpLJfYGDSgPmrj3sRS36YREVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470099;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vJLwmUL9nCXoDZ6cdxtW6DcSQziimyn2Mp0CG9uGD8o=;
	b=ajc+EnTllFLCX9w5/TjuBt9c7T3pUlWBdBHBDepqPS2hZDOXKMy50LGCT++8GBOIkWTc
	 5tDH4OALDg+qkVi7SCQ0ZhWkEEHpcsvHsoSECHuFjQITKwIK4IcSd4wjhxG3lHq/OKomr
	 TXimrOwWy+Ri+9T6tG5ntYilFK3t+JvPQEQGjI0BKtupCQkDz8aIkeaw+My9uhnsltVZR
	 Y2i1dKRk+LOjQcGJ9bMN8fb+60kU7NJAqIVeGNNm720GvIjQVaAL5u0+UKZtLpTMC6MlX
	 LMQvrupfZaGSUdXdj94MgDYEl/s5MAMTtG1LOQayIboWcgJLTCv3E6SfxXR8WrMBjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EMFO3HMv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8E606A330
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 07:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D8E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EMFO3HMv
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2i8Os3053570
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 07:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vJLwmUL9nCXoDZ6cdxtW6DcSQziimy
	n2Mp0CG9uGD8o=; b=EMFO3HMvzsb0vEzFo2lDcsDBuWFC+FCPpimaXSFEcGgPOL
	XS05a2CFN/a5INFnyfsMDE5ztcYWF5vo1TupfzeeXP2tkqSWLrNoEmmW7QEZ310k
	Uk3l9VPt60gcsE5L7rd4utTnGUows1iv+fgExeMz9VqRImFIuOZBK++p9a+wmkrQ
	iLEaNb3LcbkjrCiKHrtkscHtStt4F838YKhGOifBey9dskqRJlhQOnBWl/7NaDvd
	wBAlXvamkC405QupQOEIodMVK+Dzptrblu2Duf+Q/0WiTohHJBvzEpqJ1cJ7czwz
	8WeW+nEXqk+e1efBVxzFAq96Jp4lIw4/45YR6WXg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6ee3h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 07:54:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZnIQ016704
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 07:54:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3327wmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 07:54:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC7sqWg32440758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 07:54:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D882004F;
	Thu, 12 Nov 2026 07:54:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 875C02004E;
	Thu, 12 Nov 2026 07:54:52 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.69.86])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Nov 2026 07:54:52 +0000 (GMT)
Date: Thu, 12 Nov 2026 08:54:51 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2] s390/mm: Allow hugepage migration for s390
Message-ID: <76c9d6b0-77d3-46df-9c64-e4489b5a92c7-agordeev@linux.ibm.com>
References: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
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
In-Reply-To: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t4tAE8W3a0u1IOY89YvVfDF5Q_tdxVRR
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af570d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xxPbDROubBk5HubNp58A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: t4tAE8W3a0u1IOY89YvVfDF5Q_tdxVRR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMCBTYWx0ZWRfX7rI96VclPFUi
 YUfB7Dx0KWPSNRcjAZgTo5ZmH9YchEsBZkCklbEBaPv+x2T/zHx01wCXQZdWDholraPlAw9ASP5
 o2X0eaY7ZNbntvu98LExXtwdJ9A2NkVNTeIt5ANCt8OX6Dj0RWKBzoRxVf6afv42ZfHU1GSBBrG
 uK9TP5e84lTeiBYgjZfjCERHD9969fPXOVuuXZBwku7jbW2oVs5coWF9Y7zGHvF3QQ161Ppnirh
 qYp1WcxJlqGG5ECfZsaHyRgXA1SIeBfS6ndjF/0iGZp3JyxRRBrLdYF3U8CUB//EQCofTX0DEuI
 eTfb7mNvcxCKR2aKq/kWIFPiBAsu7g+pQLTkl9/2S7gIxWpZw8haaz/TTlBLwbm8y6vp5WyIOoa
 DEK+V0QoeSyRuJzrqwNef0MX8B0nLI5705Z0bAsTMAY1Ig6/IKTA8gha0L5dZgwH73Zkeim+UBI
 mfLF00gJFqC+Dof+zWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMCBTYWx0ZWRfX+IWU9muCsGi3
 6XmCbG7Du82zZSlOWpgEFeDuqUCimgcjQ+9HHNXVOPW+vIQY4t39VTu4abaRam+Gkyxv4U0Guw9
 1VUigm7DVBy+QIry54LYSHRso+EB9Mo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120030

On Wed, Nov 11, 2026 at 07:29:44PM +0100, Gerald Schaefer wrote:

> +#if IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION)
> +bool arch_hugetlb_migration_supported(struct hstate *h)
> +{

Oh, would you agree to such one? ;)

	return IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
	       __hugetlb_valid_size(huge_page_size(h));

> +	return __hugetlb_valid_size(huge_page_size(h));
> +}
> +#endif

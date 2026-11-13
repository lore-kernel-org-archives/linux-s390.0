Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569516;
	b=LJa8B2aPGEptzcDU4YZdS10Hp2WHzJGPkrxD17AamCK2lDx3b2n5J4+TwJJGqZBEljmF
	 0QWwaYX4EsHSL/kJ/T2s8Rea02xqyqs46qC9waLSLoskriEHbm8vUl1nOe7L5Yyx4CRTs
	 FVCegTBVosnT/KKifdWgrQ//qilXydwQGAdbsMy7B9AiR/zkGTy5SLhlF4fx30QvllyIE
	 Op/wrAogJ6zBQUyPQb5N+O3sY4G0IW2JcUbZAGj5AOz6PdKdvuotit1chBAklv56gQKa8
	 ts4OML2S58YK2YoBapzEeYlo6Fb2VWQO8uxL1+yVcb+VpIWyEDwcvt3pJ7AIQKB+0uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569516;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=A0dpOklkQMpwl1k9skhqZQ2BlzNOA2ntpbagiKOn2AY=;
	b=BVv0JS7Tr6xci2NXL2taEoii7wBXcyNxIEvWBeYkH+Cgiu6FCz31xpZuh+121rTr4cEE
	 O4NiZaB0Ebc8hYgLPqUxiVshhR8lxd14dKHsjuZ1lWCzDSV0ZPWYhEtMDwbpnlcX1w5Mt
	 fCX8kTY12b5kU0wKhcMJdmKx6KuTVHwlXJcspdo6fE4D6a+9PO+/2uIUlk7cmYj1f3mhr
	 YY3t+vHDYv1W38W4rDWEnYAotbT1+5/y6qpiMzvQY4fon7ffDW2mWtOvi9gEfZvq5YVJV
	 v5GXrYawVrs4AN/fBgwb87LXc9ZhHyZUB/vzs0gOfZWDkRD4dip7dvD+35LZ6o+VjOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RfhXpwdy;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0E606A327
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 11:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D0E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RfhXpwdy
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADBMKKs2690305
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 11:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A0dpOklkQMpwl1k9skhqZQ2BlzNOA2
	ntpbagiKOn2AY=; b=RfhXpwdyrnVVzviXqCjp/yYDudsJHDeK5mQ0BbuM6NTeJv
	tK/tvRJVN+Zs6cPpmoh2O4Yjc55VFSmj/xtZNfMTR+4PS/CNXbViRJ3RH8VItvTH
	nZDOQSBpDnbdcNhcSmDvyXUOS3NeB3MRR66AInKoeOQCg/93iels0JDSKF6UiYYc
	6YBCfpyBGSHVvPUw9pXoqNlfhiZQVcyBnYTSVAeozzRKIJfR6TYHioigetFPRVwd
	i86hKBHNsBi2X5v0KHQQLLjmVUyXJuVxhuc15eCegXGYJQw6mc8nYj0EJTyZxMih
	056vsGwRxnJ13sB+g5PACNpvX45uUXaKGK3p+Yig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdm2aqd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 11:31:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8Z1Zg2053913
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 11:31:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwjcf2h6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 11:31:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADBVo1145023536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 11:31:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1823320043;
	Fri, 13 Nov 2026 11:31:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA45C20040;
	Fri, 13 Nov 2026 11:31:49 +0000 (GMT)
Received: from osiris (unknown [9.111.48.15])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Nov 2026 11:31:49 +0000 (GMT)
Date: Fri, 13 Nov 2026 12:31:48 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2] s390/mm: Allow hugepage migration for s390
Message-ID: <20261113113148.28437A08-hca@linux.ibm.com>
References: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
 <76c9d6b0-77d3-46df-9c64-e4489b5a92c7-agordeev@linux.ibm.com>
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
In-Reply-To: <76c9d6b0-77d3-46df-9c64-e4489b5a92c7-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af6f52a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=iZIUybvRM2fWnCdp4i8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0NCBTYWx0ZWRfXxkkUYn8hpIIu
 ZClQ7T/dngimK/jzz03ckXRDh6XwDORZFBeS0qZnnDJEP96kMq658dJmXSZqM45bwr716U8HPkO
 RMKWwUbO2sC5SxgUM4L8ccIcl79I4z62ONmHiAqoSf/NwbfuOGcYIv/s1aOmlWvQsxitaAxSyeq
 0sdcsUVT1stPZUy0UCoczE0KGPgUY07mSboMbBjYDwGZJyIPDHomcxi5eLbqjfX5Y+ViigVQho5
 yGXmg6rE+fxsfr/FTooMolz1/FkQ89GVljTUa8qNfi5j1XxoPOvFSy2KNcY57chQvYu+5IYcV4f
 thgslvtivU/d3qHoeDfu0cGtjPIk1n42b9/Tg4J2hF2kfk6eF/iaSSNePazfipJCrdMqj9pznSZ
 qam9KwTpvOkkaPusdaglMrd4X/vpcg+CnA05bY+X7wr07OZgISs6EXCoiBKxg8O9wSbmrcpd1f6
 Xbsk55uaL85hsUcufEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0NCBTYWx0ZWRfX4S/I1vQ+eej2
 46gNqvfyoz7V3+7RV2j+q/Hh19456vA/pMWi4jfxPZbmLf8nqOi25IH6ufxEUC6/k+gGjxu5SNq
 b9rnk/erxQARQ4q2lz7JGvyar3e3qP8=
X-Proofpoint-ORIG-GUID: 9-h0mEZTzBvFiMVytqM2A1IVrnHV_7G1
X-Proofpoint-GUID: 9-h0mEZTzBvFiMVytqM2A1IVrnHV_7G1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130044

On Thu, Nov 12, 2026 at 08:54:51AM +0100, Alexander Gordeev wrote:
> On Wed, Nov 11, 2026 at 07:29:44PM +0100, Gerald Schaefer wrote:
> 
> > +#if IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION)
> > +bool arch_hugetlb_migration_supported(struct hstate *h)
> > +{
> 
> Oh, would you agree to such one? ;)
> 
> 	return IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
> 	       __hugetlb_valid_size(huge_page_size(h));
> 
> > +	return __hugetlb_valid_size(huge_page_size(h));
> > +}
> > +#endif

Out of curiosity: why?

All other architectures do ifdef, instead if IS_ENABLED to make sure the
function exists only if the config option is enabled (IS_ENABLED would also
make sense if "m" would be a possible option, but that is not the case
here).

Then if this is only inline within the function, like suggested above, the
prototype in the header does not exist (rightfully), leading to compile time
warnings. The arch_hugetlb_migration_supported define also indicates the
availability of the feature.

So I'm wondering what the point of this exercise is and what the
deviation compared to other architectures would buy us.

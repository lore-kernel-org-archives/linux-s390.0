Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779666;
	b=wOxJExRi5bt22Xg0JDVUQGnzP2MS9meYbiivxaDioLapSBs9QiixE5n1BmBi+5jxir9t
	 meZrb4BLku21q+rf/BMfw7iDIr8c5SxwY3knRLazgolUYV11nXUNp6RLh08232DHUShRP
	 SqQoNEwsuxWAUgMbubQff3l+LqqgLrE1JePY/oc4dNFwHUnBiqjVod/RJEUaQcTiaVNHy
	 EQLY6mVAuIumzwsgi1hzQz+eY/TGKtkFd4Df9wQUhxjdcrQnptjQvzaP0Llyvf3U0hJmD
	 XdV//+TgqXchETOveZKp1dn3oFOcF89jfG68esCTTwLNVxYxgrR2SpUt65cx+UyCzIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779666;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ysPj1FqJGEnbnxAJTWHZEmIcjNTlyw1VO9YeQb7d1L4=;
	b=WRAkK3rS8j1CfAK9wlCrpqXODMShwN4stcdZutp6ECUPC4eSttOxezIqgZzylmlc5PTy
	 Z3SCHo7wWgOPYaEfKFCuojggIqrN9VoWZjdK5i1aNqpMerl7QFtiv/KXKOqAqzgkcVa5f
	 GcxWOeGX9pDNWZbP3Y5zimR7/7p2OnEaUaZua0RlZO3JiNpm7NDoKuvwE8FYHwiisZSib
	 rekmS+pXXtaMos4Fx9BoY6/ca/frAwxqzSejITVIKVFuu3znSB+0PyPs1acJsK6u28e4U
	 9mUr+n40hK/wPTWBFfWfukX/TN6qDWmsTfKRlk89S462NbHyJCiJHCIbVygBBQAQ0VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GiPcNhbm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D51606A328;
	Wed,  4 Nov 2026 08:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D51606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GiPcNhbm
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40iNsS3263196;
	Wed, 4 Nov 2026 08:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ysPj1FqJGEnbnxAJTWHZEmIcjNTlyw
	1VO9YeQb7d1L4=; b=GiPcNhbmeAyeInaYAfte4wxyIvH5ErSCLvS5UeiZ92Oc0E
	T/+88tyCK43gENXx2C56DGVXNa4Iem/6NcHv1DOwkyymrKbA44xMNsh3zeygof2a
	U9O+U0gpGMQVhzTaqtnvB2cd+QOKQCxm9CQsg8+iSIFkTLBAwsWMYddp05IyjX5c
	lvJuuYJsvPMByE18ubNl3RS0BliVs+8ryVYvfNdzn9Jq+3ydDXDWpujoC9zRGzjE
	1+sJyhSJqMAemHBnlpzWbKT+lusxIZafHgqcXC381PmpVHqCi1yfOYEd099fa59h
	lLimS3RRf0752EcSVTs+QeZ9BvHDD+8VljHJD7yw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhtj0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:07:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A47OwKl3480364;
	Wed, 4 Nov 2026 08:07:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1us18u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:07:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A487bga50856258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 08:07:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB6EA20040;
	Wed,  4 Nov 2026 08:07:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB1D620043;
	Wed,  4 Nov 2026 08:07:37 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Nov 2026 08:07:37 +0000 (GMT)
Date: Wed, 4 Nov 2026 09:07:36 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Andreas Grapentin <gra@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: s390: arm64: Fix kvm_arm64 module naming
 consistency
Message-ID: <20261104080736.8132-C-seiden@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-3-21c36fedd878@linux.ibm.com>
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
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-3-21c36fedd878@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KfFMbfTK3ziqRYTfPhNowb6n5kHh7qWq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfX8yc97WnK7IDG
 DFQ24Auvfeqnn5DodiUjybKao9h+fGZaEuqQgdQachX7cP/MWaz0pgsKEyKHDptPm/nfsGpCXsC
 BIgEeL7NJvtZRzf00oF/aixvl903bhU=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aeae7ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Iiu6E0SwzgXP69u23PUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfX0BpYhfQ+6A/8
 7QsY6I7ixYeLOGRjlGSJlUG4yEOpDAxoOC5ji8Lj0lcYJT1U03xVhKF2bldjPScZP01JmcJzm+8
 a3R+QujyIyZzX4m4wj2VDSDQF6AFGX5AsKlK0uzWzO6J2UBaQ/lvBPFnvmxecA7JwBDPYRYz1Nc
 f8IoWZymiZSm+iSIWoOQauOCqxj6+c4sYp69qfoEbJVuoaeKee8jXDntg2IUbJmbZf4XdWu6veh
 1SrEORJ2ijSp+nOWoRTbwIUioK7ieXUTS0eTp9YDiOY/RBdL1hvLFJLyneCDDkWEv6I+hp3nrZ8
 rHso33ljDxfOSk7Hu1DC1VzBOKbWdADdn7WqbtPx6BrvZorASq/pz4s+ccIz4mNQm+VOTu8sgxL
 kP0VCYvC0xf7aHaMpVxqzIR8esEZnhFJzarilLB8zqMDsyi7HCl2ZBZi452JTWcDfLHcMy+9jSJ
 VOqneIXS56SszamhARA==
X-Proofpoint-GUID: KfFMbfTK3ziqRYTfPhNowb6n5kHh7qWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040030

On Tue, Nov 03, 2026 at 05:37:04PM +0100, Andreas Grapentin wrote:
> the module build for the kvm_arm64 module produced kvm-arm64.ko, fix the
Nit: start with an upper case T

> Makefile to produce kvm_arm64.ko instead, so the output file name
> matches the module name.
> 
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


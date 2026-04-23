Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56839A7F6;
	Thu, 23 Apr 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941667; cv=none; b=LNTpN/OsGGkA6/HmKnTCDESE1bidAftIAGE525Iy8qUtCE9DrilQUUXQdqFXcXCOqmxXl0/SM+pGKkYsMIgC+w+wv0xeCjxd48FnYMR53Z2vecpkfd2kd0NbyXgkgnV+gFQCR1A+1LEWLsU31/mMKy7kmxVmvKeLjRAFz7NhZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941667; c=relaxed/simple;
	bh=lEagp+3k8Spa+aYhWcPn8aZoIyzsCsn+QNmQPu6rELI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StHEdCZ/emFxvucEWyTn9p6yBzLRDdhIUTxy3oV5PpLUDmyRr2lSUlvt2HK3dAEuiZU9WewaReWMeWN5+bC1BsfeJP5olY18iewF41dX04R7RNgG5VYSR0aJBs+SW2sqnG6pLSIW8oh5BDDRl59cOYSWOgzlmj6LbYQvDM1aFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KIZHBZAX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KIZHBZAX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6wv603229030;
	Thu, 23 Apr 2026 10:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hPfzzL
	EnCkfwTfx2ZbFAbPEPqrheLL97qiHOGhGTitI=; b=KIZHBZAX5F6DP77sMLvNux
	FZl39+tfKMVUGd4MOPNxcFlmh3lMzCcEiXY7GQJA24uKavOpJtR86lXSr2V2ajF+
	uW3OyBeFmFw9Ukm3sO4JG2Bfk02ksmABl23Xpc4dPyPnTpYh0ka3Lbh3JHb4d/Ny
	X9R3a3V7EY0V3OFaHmuoBTE6RobIuvuaGXgvDN4WZCOcPr9isTH6wOGF9rh/xh8X
	oyb3oB8VSXP7J4leHBJOv+AMa1o2pJgvt/kvLhaQ1aclk8/rnY+paiL+KRKLrwKS
	PsSLswecLgeQpd5KCcLE96doqla6hbqm2GvZGxZZm0fPIT3IccLCuHPQsmg3hChg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu287sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 10:54:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NAZOVw011202;
	Thu, 23 Apr 2026 10:54:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky699k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 10:54:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NAsCMp31588740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 10:54:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B82F20040;
	Thu, 23 Apr 2026 10:54:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5FA22004E;
	Thu, 23 Apr 2026 10:54:11 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Apr 2026 10:54:11 +0000 (GMT)
Date: Thu, 23 Apr 2026 12:54:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] s390/mm: Make PTC and UV call order consistent
Message-ID: <20260423105409.10371Da2-hca@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <7b0e73e3c6f4000f9bf7cb161d8ca9a9f2312d70.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b0e73e3c6f4000f9bf7cb161d8ca9a9f2312d70.1776264097.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GLLWoXTr8z_IeoG4--Vv7oyWzsfXxGBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNyBTYWx0ZWRfXwT8Lczbqy7xY
 OGvraXKfJPG7z9DAO+DoJqu8R0ugjPMYivAs1rA3UYYx55v7PmVxQ4f/WNsz57v2P/YNXhjN58L
 fRx2y/+gsCFjyC3pRWtjiCn6z6gnvMH4Ko0/YUZut+N61esL8qRYtZTer1zyVqjO05jcupUwijF
 YNNJYYqs2WuI4RMWJrCxrycaQCoYPKFqNhnlHD3x5rCVCNWKw/PnrYcc4QtnLsPZBaBGX1Xj7QQ
 Kbgn6iH0ky8G/nobsYG2jgib55Bu7uSazMiUZQb6niXRRltdhBsDPifZCNc2IGjbQVLvLBU4Sv2
 D94XV6tzXEmdgz3Wf2O2+wFpf3LOCmWTS6mJpSPj/ywxPxbw6cnsalqMckvLhzoigVSRZ3TTikM
 hy8/VAdlowWqZbU023IkR+NiwJtpY4h5/SyTmkB6teCY8RmHH6gSKjOzdNpF8cGm8gECSzGEhuC
 p1QS+tnHnKw2fTOCuiQ==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69e9fa59 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=E1xz_aSQ8MwAHGTOyykA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GLLWoXTr8z_IeoG4--Vv7oyWzsfXxGBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230107

On Wed, Apr 15, 2026 at 05:01:22PM +0200, Alexander Gordeev wrote:
> In various code paths, page_table_check_pte_clear() is called
> before converting a secure page, while in others it is called
> after. Make this consistent and always perform the conversion
> after the PTC hook has been called. Also make all conversion‑
> eligibility condition checks look the same, and rework the one
> in ptep_get_and_clear_full() slightly.
> 
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/include/asm/pgtable.h | 39 +++++++++++++++------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)

Why is this required for this series? It is anything but obvious to
me. If it is required please add some reasoning e.g. in the cover
letter or to the above changelog.

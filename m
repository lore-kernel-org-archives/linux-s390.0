Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30213A258
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780249933; cv=none; b=a3CF859pi1lE/mvc1sMVzl0l7PnWtcDm35bWzeNMa0ExRrMNhyZeejpLVo097tpD3x9LqsScAMP3CweDW403AyM/671vQRGF5XPgGTriAloJxqA1s7L5n/Xtv4RfgbtlF1lT+xfp0QI7wjOPJoan2AumIPRNb0bCcH9loy4MGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780249933; c=relaxed/simple;
	bh=W03UDYlEDaizDTHQAWjdv5qvXcCCITXjuAHFER3yvPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuBeP1S6ZeNcS5Wq8BNbtVCnoPsrH/hocVzrT9zeIfYYe5uAcmZW1befXDQ6AKzFKWuGbRnatwB18xSsMZq30xFwmdkpV7lALKF4VWLfYEmK9egLHEynCy66Ctiz2fZ17JkrZwnFlB04JYG9G5KWCFpDq6kgLqnIN8H8axFebC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N4ysxQHA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N4ysxQHA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V0dYap849167;
	Sun, 31 May 2026 17:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ReX2Sr082YhS8eUQIWg2dNWBgOQSMV
	oSmmEg5Y0UFfs=; b=N4ysxQHA5KLcuyUH79iKWizouUtxzDEi9xgUo6zAI5WCoM
	yaqcotcRcPU6AfTH9j/rj8SvD3EVZCi1E+cez2cAClUo2TeFF6q3TRJtxf8FnU43
	m5SBD7QX8NBO52DJcOuq/ME1hBooL8g0a5LwCmBkOha1kBik0lNBdEianwRd/y+4
	OBFJIW3EkgmdcwMG7gMeh/qhRJX7kbhErg8t6Aj127EaIPBklEECpcZDOz7fpXMk
	SFnwHhMyGz+XtjI3KDr8F4tNFRZT8Ouy42diuLmlKWtw9/nhbhLgY4tPTqMIZ9Fc
	kOtryEc20UrXDPteab0h+cbqG/IG4CyJ5pMTIbhA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhsw263-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 17:52:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VHdHnV001033;
	Sun, 31 May 2026 17:52:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jtky3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 17:52:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VHq5nr44630352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 17:52:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 507A620043;
	Sun, 31 May 2026 17:52:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95AB220040;
	Sun, 31 May 2026 17:52:04 +0000 (GMT)
Received: from osiris (unknown [9.111.22.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 31 May 2026 17:52:04 +0000 (GMT)
Date: Sun, 31 May 2026 19:52:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 2/6] s390/dasd: replace get_zeroed_page() with
 kzalloc()
Message-ID: <20260531175203.125536Bd9-hca@linux.ibm.com>
References: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
 <20260531-b4-s390-drivers-v2-2-f7985308ed90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-b4-s390-drivers-v2-2-f7985308ed90@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K_vx4KiuHrb31EaiXN_eP_hP7b1WqxEM
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1c7549 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kt7I_EveaTZZBW9BUTwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE5MSBTYWx0ZWRfX+TfnLPX1nfFn
 SOVmlujcJqKi3IVExunve9E+nbXqYqeFIMeKu6z6BKiIkSeCLVIvkPS1BWsGxZJJuzTZPQ9PRZ0
 Wtyl5+uQ+EHbLUheHXQT5pC3ZuRXpyKvA+Ot9MU5N/9resSFSaBka7C3ShYWRc3v7wC3OzP387+
 0socyzGNxCnzp8lSmlyDvezKCycVRP3Y81ZhpOs2c8KQm1OxL2CyDMmMrpDYSIVRtHuS2lnoxVN
 6p91J93blCV0WeJT0Lmw6sjIwqySfnv2uOdJyP7ql1xnckM3kB6k3YbHUOPhJgXq2uc7Xg5MjXL
 m3YLgJJAU4BHVeaKClO1wN3t/KXdAAhj5iIbPZQoPEeqE7GXubzr+lypEmvmTYstgVqJxhXfBX6
 +AThhiUlt1GanRKZMd4fZsxPhX0ko1zyNq5JPiY4mp769A+rPdnfLAKN7SiQK05l9dSSXAsIGoi
 mqAwySl/Xp9vhYlqNgA==
X-Proofpoint-ORIG-GUID: K_vx4KiuHrb31EaiXN_eP_hP7b1WqxEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310191

On Sun, May 31, 2026 at 05:08:23PM +0300, Mike Rapoport (Microsoft) wrote:
> DASD driver uses get_zeroed_page() to allocate pages for the Extended Error
> Reporting software ring buffer and for a scratch buffer for formatting
> sense dump diagnostic text.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/block/dasd_eckd.c | 8 ++++----
>  drivers/s390/block/dasd_eer.c  | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

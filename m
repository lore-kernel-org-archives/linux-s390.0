Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDED5372EA
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174299; cv=none; b=PxNzqRt5HliaZwIVK7pUZW+fkfPnhVT+5IMajnckr8lPp1ebPedffKNyu0BF8CBqBPf3/bPlyKvD/QSMHKfvul39NQWv8b40hU+5cvGUA3S3GjMgL2H1WjW2bm/fEV7WK5Mtq/OVEYshOCcMsZDUCEFHO7gLN8fauNW4ZBOxVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174299; c=relaxed/simple;
	bh=FIPaVlWXst5/4lOS/hGrGJHZeBmmZukHsiAS1Vf7RQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxcada08pu2Jm4X87udBxB+ZPr83lf9H3W0NhWK6Zyn4SvjKi21x/HU8eJVt/Rv0fQWRV8b4s3ztuNzLig+gmgQEo+550shZ12sNfYnoYB9tYUO4RSxe/zO61NQ1+dVVzMP+MGES+w/M+Wc3kKLKtUxY9ysaWS707tE8O2rKzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r4kZFkCf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r4kZFkCf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZkXQ1030933
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 14:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=28O0rK
	DPpggrLiCiyFuDimBCUHlAbkiC9U01o2Jw7UY=; b=r4kZFkCfT156l1wzYINZZi
	Za+ocPfuAHNgt+mSrzlFHWo/XlKjYrDzo/9gh7nScT3eXhOUVIJO5M3MiPATTcfI
	4v+UWWIz5Yo1OW7vyRYi+sLkiaddHFfX6dyZ2zyw/JUl67rdeqs4pBbDpMlz7ylx
	tGKH81oHc8NvjOCn1toBeZZ1KjkveNuEVW3Tq1sSQXO0OFC40po84FKe8k+KYlvz
	cDGfT+UhTbwKaudXKZzGcAxb8F7W4zh0hEm8aZLaV5brzYeGDaO775TXLj38IDO1
	ILmPQTBMhHi0muQ1yl3o1XbQQwuhAJOCYxd87CPsRy+jjfjODdj47OtBnTZAGTKw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1uw0e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 14:38:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NCIent2891810
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 14:38:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkhdxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 14:38:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NEcC0W40436046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 14:38:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 348E420043;
	Wed, 23 Sep 2026 14:38:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF62520040;
	Wed, 23 Sep 2026 14:38:11 +0000 (GMT)
Received: from osiris (unknown [9.111.16.152])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 14:38:11 +0000 (GMT)
Date: Wed, 23 Sep 2026 16:38:10 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: oberpar@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/cio: Fix NULL dereference in
 ccw_device_get_util_str()
Message-ID: <20260923143810.9636D86-hca@linux.ibm.com>
References: <20260922204839.965043-1-vneethv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204839.965043-1-vneethv@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U_e5hHroj89nsmZi67NP7tRXI9BnaLE8
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab3e458 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=IIzHxe9DFIFphaoEM7oA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfXzUt3ymT7ZaXN
 J9RHMDcSNGhkKLfMl33Nxhsv7XSErt1OG9m0WDwotyld3VGPkZavA38+6WGn5dsM+Eb/VRoXjKh
 10J+SjTyYvW6NlE+bqlz3F70mhNWXCU=
X-Proofpoint-GUID: U_e5hHroj89nsmZi67NP7tRXI9BnaLE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX4l2ndCGKRziv
 J3dsvMorpUcJvQ5pNKFHlTuvMQ/CcQsH7u5BfgDllhpQmHDgK6fes/uVeo/NWmiwccJ9fwwA2DR
 RMeXi9gPU1metYxz4X8ZX5A9XDw0TInw8N8fX/bgnd9fGPpQ4rMXdjo8z+rekKlRolJh2moJ9fs
 NIPfehrk/mkLGRjlN2RJ0jEaN04dv6IqYkOA+oqyTogFGTKzAZq42Bf7cErsLNWms0ELhL/L/6p
 e8Cia69QN0clPhDLuteWPEpcOxZWVwIhRM/0roC0eHbq2Zec8+VlSiFTJmB1CZbUFoXSQhRD4Kz
 imKIxgp3aqtEjDstEloLBudz0i109i+kfCg6IDHgbjJzRJBqV4V9vvoY19pfLhu7dMQrBC/ZSF9
 5/DjW/uRbznAPpBQnaRYHmMWdM5VIEOpoV6SQiwtIro4Zb5h24wWH3g8JfzsymzVyW5HSGKh89d
 sqBrmye8+dUna5dDZBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058

On Tue, Sep 22, 2026 at 10:48:39PM +0200, Vineeth Vijayan wrote:
> The channel path registry entry associated with a CHPID may be removed
> while the subchannel's PMCW still references that CHPID. In this case,
> chpid_to_chp() can return NULL, leading to a NULL pointer dereference.
>  
> Add the missing NULL check before dereferencing the returned pointer.
> +	if (!chp)
> +		return NULL;
>  
>  	util_str = kmalloc(sizeof(chp->desc_fmt3.util_str), GFP_KERNEL);

The context diff is confusing; as if this would be the to be fixed bug :)
But ok, just a few lines below chp is indeed dereferenced.

Applied, thanks!

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF045629C
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544916; cv=none; b=UCq5H8hNBG/D8mGYIn4APVdLnal+6TM5HSQk2MGho2sXDgEr7sdpR9y42Lqm4S65WKW6BzVxhygKUizQUW4iPoVfpEcz+R2o/spYMBjpbuAX0vm7mLHZufHncWl0giI0CmFFVLsG7sAQMmxmxQQ2vF831FCEeCgmL1/e/QMvwto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544916; c=relaxed/simple;
	bh=xbLLdFkxwAnttK5vCKBF5AEV8qrKwRwOvtVYDl2CNoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq+W4n9cv9rZYIj+HlBZeX8i3WPLbc5Ao/uljEOtAv/FebVH4zGthZm9GstUqMNYNNQ1tyMh39A8U965MSFLkeA6TNWwfgpaFWokPasMvysNaHOo8tG/FpoBtldw4Jjq7czIzB++BUhQX2A4EMWqqtml35sSAIH25mtWitBSvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d+boFNcX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d+boFNcX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1cSf3717222
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 14:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ofy99CYOa09yHyOGErwiy8ZAwTvjX1
	eSTaNFG6qLE8Q=; b=d+boFNcX6QGS8yD+dr09I4TLSn+rVoRi25X+Pa5nv1AS2A
	iV7KXbaxtsV68Jaa5cav6VnWT7tm8m06hkiBhzi8im9xPnGilET/nnKca9uHNe5e
	j7C47E2PQ6qdoS6Fl9S1bemGWceU2HQNefYwYBb3Lx9sFCr5OuFlt0RfRf6k9cp1
	82e2ffVk1WZ45jYb4Hwx//oUzbPu2g8DxUmYMr7Au31a5tMleayi9xCKhUQS9y8c
	HGyslSXB3rAThF5JlmOLjZb2fY374Hvlx0nFS1R5DvYkaXTkVnbYHiD//ug+1Ybv
	+VOD+rcQfJRzOLrOt4Kg4b2n7eNzmFTqbJq7pU7g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwa35h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 14:28:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CEQY0o011534
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 14:28:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy66v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 14:28:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CESQ6h49611124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 14:28:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 784B020043;
	Wed, 12 Aug 2026 14:28:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC8220040;
	Wed, 12 Aug 2026 14:28:26 +0000 (GMT)
Received: from localhost (unknown [9.111.41.232])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Aug 2026 14:28:26 +0000 (GMT)
Date: Wed, 12 Aug 2026 16:28:24 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] s390/debug: Fix deadlock during unregister
Message-ID: <ttjnuvc@ub.hpns>
References: <20260812075319.2007940-1-oberpar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812075319.2007940-1-oberpar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c830f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=CNkE3Pl81vnWf-qNC4EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p7hp6DhDi8cAmYz-Pm0mqQwd9w_pH7WW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfX/5mpO1hc36T2
 UwRYtWNHlk/YP7I8gjWKj21CGoPzB9Sngc2n79DscHBKHWRLckyZpmbWubKx/5z1ZMhCIHTX1Lm
 sJQ2znVMnoKMcxHknhxiJV6WG+M1vgpEp8DBq3UjI8OkT9j9yifNCnYD/8XvpHV96BJDbYvEkG9
 55kekIsX4yXHaI7gQrhtNwSw+J2y6XwWrXIxa8n9/Pq5MpsD4vD1Tf1ROmdmKQIJiqXj7MKSFie
 bP0K+MV/BHyrIULFAFjd7qrRBq+C374OC8n8hN+Xsr5cfn3IiKb9I2tEuchOn64pzG7QmvESbgu
 ITX5kg8gmHs2epXis86gYQxHXMK1BTOpBat/3iqKH10GJGdbipIqPp9lK3wAKWrupkWINT6V99f
 XXIhmkcRu+Xy9FScRZD6kdR95aiQqN4W/5t7k7vQ6skbFvF229tddQjJUnu4AWxv/Z4qYe4I8VY
 LcuCqdluLv2ClqcmXXw==
X-Proofpoint-ORIG-GUID: p7hp6DhDi8cAmYz-Pm0mqQwd9w_pH7WW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfX5cavIZFgqg5l
 sBoO5n+WspDocJnCDHVLfTrxbL5SlwhfAHPP8wssrbD3GPBMcz4S2gRKZGElz99+i68b9Rg3aJF
 0BDEIoavwr6KL21sTK/ppgFcDpohS38=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120114

On Wed, Aug 12, 2026 at 09:53:19AM +0200, Peter Oberparleiter wrote:
> Unregistering an s390dbf debug area while one of the associated debugfs
> files is being written to can cause a deadlock:
> 
> $ echo >.../vmur/level    $ rmmod vmur
> ===================================================
> debugfs write
> debugfs_file_get()
>                           debug_unregister()
>                           mutex_lock(debug_mutex)
>                           debugfs_remove()
>                           wait for debugfs_file_put()
> debug_file_ops.write()
> debug_input()
> mutex_lock(debug_mutex) ==> DEADLOCK
> 
> Fix this by splitting debug_unregister() into an s390dbf and debugfs
> part, and running only the s390dbf part with debug_mutex locked.
> 
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
>  arch/s390/kernel/debug.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Added
Fixes: 9372a82892c2 ("s390/debug: fix debug area life cycle")

and applied, thank you!

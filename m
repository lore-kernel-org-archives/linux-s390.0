Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1A3793AD
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072045; cv=none; b=jju1NxrS7+MCyv90QyjlBJcc8hFRIBMgDJHBeUTlVDxQ5XstIbz9NoFXdmwpGsfn2VdDg8oCn8aHHKE3iO2KJnuPp6Vq1jMmY2AvkSirVu/D8SM5s6h42Xe0cG9C9VXDKBe3UvkndZmmdNBgp7M/8ODd+5kccGsYvemdErlSWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072045; c=relaxed/simple;
	bh=/GORDimmEhsfYLWU46RczHNue5xilvycY+t/lsSGoVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BObzgz8NhuJZJR3k4PMD4VgOJpTXm1P2jmj9tDX12ZZ2blFTDoVO15JHYSGJS4SVJ1E6e0hQNbvd/c3STxHtTsjJSnz9VkZjt4Cll1jOiCUQcvPXQf7GcBhPwWVkAxX4wI99Ry0nhBi/t+9p5UAW8IQa2V9+yskIkwWxFAHZHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sMn9uilF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sMn9uilF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IR851814107
	for <linux-s390@vger.kernel.org>; Fri, 3 Jul 2026 09:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9N+Q8ziZfXvhH/aM4GhFGWt6hJJEVX
	N4QjpK3PecBp8=; b=sMn9uilF8qHe85L43eW/4NNlOu1RNK5iW65chyF284R/Vg
	MH88HugF7RAu+Y/MU9cw9gL0HHFL+86YmdBhxxl4cvrWbnoBLb/odeI/fO2mxDXh
	AavhFXSQUMUXawvaMp8uEi/f7harHt9VfrdzW4FM0enFjxBIQv4WYUDWmI4YDL+S
	9WIoJUclsKyUjplUlvKn1ji7OV7mF6r8h46j3/woRyUIZM+zGt3TKuCp6avPUlQU
	QdauGtfP2Esj6Eg0PmTLphde80+37ODkZqFmpqpSmvVStqdPwsbMI0w0ZSUvTbum
	jnnMmHl1OvZsWOr5FOXvzqJZvIL3KDDnKT3Iyc/Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfdxbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 03 Jul 2026 09:47:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6639YZDW013669
	for <linux-s390@vger.kernel.org>; Fri, 3 Jul 2026 09:47:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gr289-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 03 Jul 2026 09:47:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6639lI1c48234896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:47:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AF5820043;
	Fri,  3 Jul 2026 09:47:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5468A20040;
	Fri,  3 Jul 2026 09:47:18 +0000 (GMT)
Received: from localhost (unknown [9.111.9.151])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 09:47:18 +0000 (GMT)
Date: Fri, 3 Jul 2026 11:47:16 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Fix type mismatch in get_align_mask().
Message-ID: <t@ub.hpns>
References: <20260630173214.3114408-1-gerald.schaefer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630173214.3114408-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47852b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1fKKc4b2T8MJKYKtYEAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: H67DEjYF2ltv6xOHXT_p10VqRmpaVSLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfXwWKk5z+wHm+1
 w4SW7wF1SxavgGuk5JBZNIarmj8m1NelPiNKafDM8XVOWME/bHMbxNSrm6MIkwyFZ/lY5DiLfrB
 ZAhVHWZjl6ItvgRNk1PTLSdiIy/BktB1yCmqZBm3BPw7OA1qq+Q0bsBZnu242zLANKmZ9gLYRoC
 1442aYKAIzNuov+lexOGgRXY9V9YWuOlZsZoGhnLNoUeJrlMlk/y+iBRjkkcpwQ8HwpFYh6OgJr
 Pv3uzu0paRcbtwt3HFb95DRKMddJfVcmWq4gG5tIEeBpCPOijoOxb3dkuHMqFWRSj5P14V6JUB7
 D0HWNzn1zQBm3qw/pCl9MN0qZiLQObRAN/HimoE5VOoWUjmNA8GASkCt0BDp+SM10Q8W4qcuKGM
 neQwGNDRlwzJgU06UJLLYGU0G8QBZ15yM02NQIc//7HyQWBEMOYdNoOOHfqkJ/3XZ9+DhVxwcEx
 csSZzNDrTHChVOOOPvg==
X-Proofpoint-GUID: H67DEjYF2ltv6xOHXT_p10VqRmpaVSLF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX4eSwRBKEvmW8
 WFxIt9i05LA/Wm+zfGUGcd4GQZ7Ac3vyeX4KueZxRFEZJge36iTyXMS/bBJdiLAFGUbrAWnv5MB
 PY9dK81WrEM8xrsZm+bQFuDhuDj7G3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030088

On Tue, Jun 30, 2026 at 07:32:14PM +0200, Gerald Schaefer wrote:
> Commit 86f48f922ba79 ("s390/mmap: disable mmap alignment when
> randomize_va_space = 0") introduced get_align_mask() with return type of
> 'int', while the target field 'info.align_mask' in struct
> vm_unmapped_area_info is 'unsigned long'.
> 
> With currently used masks, this should not cause truncation issues, but
> fix it and return 'unsigned long' to avoid future problems.
> 
> Fixes: 86f48f922ba79 ("s390/mmap: disable mmap alignment when randomize_va_space = 0")
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  arch/s390/mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thank you!

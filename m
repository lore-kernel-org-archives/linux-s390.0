Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEA3F7A85
	for <linux-s390@vger.kernel.org>; Fri, 26 Jun 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480155; cv=none; b=mP7b2m/0BDiXySVl/R5RHNo/ne/FzTuA0E8v6+c13WgcONXlEPCdHnun8ANjKgyv6gIXi77XeXSYeaz70+bW4n2o8wzd79SMGWjLmAYqFnN1C0GTkQiwaL5CNocU3N5Mjbxz6VXOF7+5ILZRKIHFIfZJiL9TMEtexx1Nk+0qQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480155; c=relaxed/simple;
	bh=icdWcjCOi3Z66X9U2iYMhNuYFy3TbnqXCKwyuPKRLEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPV1W6cdo/czsXy2tbgvSpkNwbWXtpBHzgHjyyeeBOP2i6ttk6pGfmOKEzYcqlHXGp+MN6otTH5FSQGBn6G9bLqJjhPxevLSDVbvyIbVZwIbsPImkZr7IKCZCuk1HoGLfyRN0R7TvnsbD53HTU/p5yC3pZiN3oGed8Vu/e5dpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PrsUGZ64; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PrsUGZ64"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIHJx2919862;
	Fri, 26 Jun 2026 13:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PzeFDD
	7mv7Qtp3Ak3Be1pgYItU112XlGxaiDB9PpsmQ=; b=PrsUGZ64TR9A9tY2M3lM7P
	XEzk8qiVewxwpASyc4IAel0OQWP4Jo3+eh5iHB38ly5ZmFA5baWfVAcBp58iNJiW
	YyI3VCkWOzR4OM4HDeSqgLqAtMCyeXOSVHBri1E2gTh88rBeZ7ewEynqKZFez6EP
	mF6FSGftveUE3T5t2K339Y6fVsctxLWDlCiZcahU4QMCqSNIDs5yxKJIPWDkTLnA
	I0M/GbZrJgI9yerKJg9sy0u4B8kxkApa4KhrSkgD6+CgyeqkQ/K1qh+qhqYzInPW
	uj6EHrS8D8x1oLFfVeqfO/VoOKysA+nvInCAxWLb9gZpqnqYOZ/3b7BrS5oFwA7Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr72yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 13:22:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QDJdC1028364;
	Fri, 26 Jun 2026 13:22:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qufna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 13:22:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QDMN4O31064526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 13:22:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11AB520043;
	Fri, 26 Jun 2026 13:22:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2A420040;
	Fri, 26 Jun 2026 13:22:22 +0000 (GMT)
Received: from [9.111.69.29] (unknown [9.111.69.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 13:22:22 +0000 (GMT)
Message-ID: <f14a8a43-b93c-4737-a966-ba28ca130ea2@linux.ibm.com>
Date: Fri, 26 Jun 2026 15:22:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/zcrypt: Remove the empty file
To: Rongguang Wei <clementwei90@163.com>
Cc: linux-s390@vger.kernel.org, freude@linux.ibm.com, hca@linux.ibm.com,
        svens@linux.ibm.com, Rongguang Wei <weirongguang@kylinos.cn>
References: <20260626055820.376212-1-clementwei90@163.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260626055820.376212-1-clementwei90@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3e7d13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=OxPPU11sa_40hDLK8BoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEwOSBTYWx0ZWRfXx+5NfCS3N6k5
 Yfn9+AmIx3ZDbsWAcJtXKl/baUepKCqrrDCdJKnV7xAMH/j2n9EIATqTwBcViPY/QX6+b04BZYZ
 7JMnoKE9GwKnOc4ckj2FouUHA9vAXpYkH3bvNcQNz+XtlnUyHMfwSvk+IpXQTq3h4HOeLUMJw0j
 77ogicc9thR1xlW61GHeYg5//A7e248sWhY/eqFh7f8F8UX4pO6tmloqDU2uY4ODciXptYHOwTh
 TeHwRWykLBqLwm3Y3oV059I3Ud9yAxKFIwSvlt5MJn1SFnyYXOM+GwnNt8UgWeE+xs5dRz4yknU
 rI1VBt3GPeX9WPPauJIbvZ2WStDyldDVv4YbynN8B0os5UZV/X4EvFPGOzAYnIlADBIXBoXBcur
 0hgjqM+MzWNvsxy+Q/SKgJyjau7qBx0J+5+DqMe84/YuOpPSe6ksiPux+ajJUhINt6pRND0uJg8
 15SKCZb/RoEZvI1xp5g==
X-Proofpoint-GUID: VpbZmIb4SFDZYtJHBYSGY5eHVt6fX0_z
X-Proofpoint-ORIG-GUID: E2dLTO6rgTobjxLM4FjxAj_DhBUHWSmI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEwOSBTYWx0ZWRfX6D4l5jPzs9rR
 5aE2J0YuJzcVh+0Se81Dv2QvJusN+E87B2niii+FN0jGzHzvGMbjp1VLtKA1G1pVoLouZa762Lt
 2OMjloVQB8DrV1kKHoOub7khRXsccss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260109

On 6/26/26 07:58, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The files has no real user because CEX2 and CEX3 device drivers
> are removed, also remove these empty files.
> 
> Fixes: 5ac8c72462cd ("s390/zcrypt: remove CEX2 and CEX3 device drivers")
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler


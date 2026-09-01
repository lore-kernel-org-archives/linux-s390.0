Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E637377A9A
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272426; cv=none; b=VpAwklCMhxZ4D1QrDw7midocrkeswIaAMrVM30hFcLyh1itBEgsAO+WjLkUgsh5uWn79FyLUKn031QMUfPsdr0Vftfzrf/MFSlbybdlujTbGM4IR23uVegaxAnzdzHJd6S7q0n3aUjn3mb4E78WiFSogIN6pBavFrN9kBAG/VNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272426; c=relaxed/simple;
	bh=cLu2lIvuxy4OswMjrdpDkFgu5dhMTsLkJrpkGVri8mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sppS59ST2NBj7r4enBof9AVU7+R2aibotyk05LVU59WJDf/24S5V8hjzJWNKawitTRq/yQB7IhHWUk21hWmtYqzb3VrvJ6gziYWMoVC12skayX4DlN89oatQy8AGOYsR3etbdeZuQZycoCSXYkXJwHZlOs2PhVYuJc4lNwezmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tUlBI5kg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tUlBI5kg"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DVmja1211191
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 14:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=S4UEF/vXENeoupZ+HdlUv7lx7elaKz
	8NTJOSlwNP1NM=; b=tUlBI5kg9CBSUn1L0KCmVxXop75FoiEnuspguIuTFBtZ5t
	7PL9zyXpAav/qwX93rMW0Bfd8KGgPOtGhQfYYNXvCT7BJCgneqm6My2vVAzTAIWT
	SiwLqvlbkNk+ti+xDrFEpbOsmtkpsGxlf0sG32+cD2lI0owztWMPqLlSvb2761Cq
	xKgj4pqcVGCQcyKFpmucfTQP78Y6l7Iq4hgmu2G7Yqn/hFvN1bDjUmtXZWtcJbno
	Tz72o25hnnElF+H9jx0ZphcVpx8fedp3pbqImDH+oFz9OlbnpWg7r5oFMJDPLyU2
	+xf/CrJnB/yJjvjT5+0ih44XwPaZTEbCWybQzKWA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhrbvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 14:20:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EBh7t006962
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 14:20:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w46rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 14:20:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EKIUl41419060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:20:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203EB20040;
	Tue,  1 Sep 2026 14:20:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05ED2004D;
	Tue,  1 Sep 2026 14:20:17 +0000 (GMT)
Received: from osiris (unknown [9.111.45.16])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 14:20:17 +0000 (GMT)
Date: Tue, 1 Sep 2026 16:20:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/3 v8] Add CPU hotplug support for PAI PMU
Message-ID: <20260901142016.14482Fc5-hca@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901085448.2260658-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5LZkL6ZEojojQ1tnGaMn47PwrRd1zfBP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfXwh2pDBBK205I
 STTWzUhgLlp+1Ohv/Xew0Was/rDM9GyZd25lR0vCqzXb2VyR2j9lwZcui6vRSe/nNOom53Lcpzn
 NW/LbG5SvcD2uptyHD5XyesPiTtNXCe1qBbrpeEh6GMfARCy3M95fcr1M4/lwgwV3q7BKS5xcl9
 nbm5MfuCctIxkxuN5ggbYUnQ2iA6G9yuLzvw3MmE79pR1LsSiixX4z/hTslNce/zyqNl1jhNc2r
 mGlGRC+ndimXKa58LvYuwNfG1zskoLLoNq+YZDTz+4CJkfmGI+3cMsaBMDYWC673jTUu+u7V3yy
 iMqognsZPEguo6DkTNgaifTCIbfOM/Og5SAgCvQVZZUVQjDjTlgiKKw+7HHFUAH/t+LOkNvnjUx
 Mqov7Nq59PHLVpxyTr03jw70nNqDkxiOhcSikYbmGTNvlZePC4idlFkEL8xqQdm085ewzvTuTbn
 UwsgFBGAOsPgK78SJxA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96df26 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=mNk3Nu2FOYNDAnvZWEYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX1uyn5NUYWq4h
 LpUUp5kYHAB4pUr1OsjDE9cWyIXMyKcL08it5eAYafo6HTh7DCrnsYdSXj4iC27INXmnvbML97B
 d9zVQRJtmRhTebI0dwVbu85YFCYItyY=
X-Proofpoint-ORIG-GUID: 5LZkL6ZEojojQ1tnGaMn47PwrRd1zfBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010124

On Tue, Sep 01, 2026 at 10:54:45AM +0200, Thomas Richter wrote:
> Add support for CPU hotplug add and remove for PAI PMU.
> 
> Patch 1: Change function argument list
> Patch 2: Move locking from CPU scope to event scope
> Patch 3: Add CPU hotplug handler
> 
> Thomas Richter (3):
>   s390/pai: Use PAI PMU index as parameter replacing event
>   s390/pai: Move locking to event init and delete
>   s390/pai: Support CPU hotplug for PMU PAI
> 
>  arch/s390/include/asm/pai.h |   1 -
>  arch/s390/kernel/perf_pai.c | 182 +++++++++++++++++++++++++-----------
>  2 files changed, 128 insertions(+), 55 deletions(-)

Series applied, thanks!

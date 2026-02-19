Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76023BD06;
	Thu, 19 Feb 2026 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771502134; cv=none; b=d4JGEZ8l5mGUicSSobaX3g9e5XAxc7XRFL6/X/4Uuk6cT5PP4dmNP7Fm4nWtmlgentGcraf/HDEeT9Od6Au6DbTw05pR427wrclatRXrjgLFFCdWqacIZbLWsqCtb6KThapu7pFQO5IXiHgrkkXIMrZV48n52jaY8hBm0k6B33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771502134; c=relaxed/simple;
	bh=j+I1U3fntMSXpUmmSstBGlvki0YvrZd+5uSTcXlnlKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe+nA3BXp2d9Iv/NSYcqjLx4BUexjR8WZqm48Rk/YLUaVWqDO39KggWhwmOwee2IcDMEPooSTCt+jiP6AXBy4znZhhNF0eW3n0dkQGLKJYekpVsXgg3dTq6oSAjb6b2GCnl3ofGtPwa00YsEbpxFEXU9FBJ41ta3YG8WvS/p/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G0I/rJVt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G0I/rJVt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J9Adc91371206;
	Thu, 19 Feb 2026 11:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=j+I1U3fntMSXpUmmSstBGlvki0YvrZ
	d+5uSTcXlnlKs=; b=G0I/rJVtZDfJ0XkoLEk4f8vcwS2IB+y/hJXsk+6EofMlek
	xKVoDmyNw0mnWn17G5FY1mUU+LXmspeVpB/u03pINOfm8spQpcqJyNVnLG8Q4i8k
	hXMKgI/doJ7t0HjiqzPfz83KUmyLb+oRUgGW0T0X1K/i67F86FxSAzpEFTSA4hKL
	O5p3pDewkmR1zd/RQ/8ConviNYFLosCRrnB827fvLThxNPG+byQlPz7tdznUJQK8
	EGH0sFXT/sf/6BejNQwfauPc4yNpOJi8KBIgHwLQaOlIcm2OcWgdIWN3I21qkv5p
	WEmz61QllqkkHw/wwJ3O0Wp8HzBhbQ+MSCflNNvw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjmnrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:55:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61J8c2BR001883;
	Thu, 19 Feb 2026 11:55:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bm0cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:55:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61JBtPjf6685028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 11:55:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFE0320043;
	Thu, 19 Feb 2026 11:55:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE5720040;
	Thu, 19 Feb 2026 11:55:25 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.52.197.53])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Feb 2026 11:55:25 +0000 (GMT)
Date: Thu, 19 Feb 2026 12:55:24 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v2] perf symbol: Remove psw_idle() from list of idle
 symbols
Message-ID: <aZb6LDcE_xlinY1U@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219113850.354271-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rzwVppszj8iVYPlOyTOFnJEnSGEBt4h2
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6996fa32 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=G4jJH_jHd3thOZ3YYNoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwNiBTYWx0ZWRfX8mlZ9t+fjSio
 xufMsVYQ3dqg4kLT7yW+MtCKEEd21oC2aGjxMWtrYrPd2RhLE4fK7WZImvzc14eo7awSlkVyBHh
 N7I9NW+0qzP7Qlj+h4HVdkrb46A+Y5UkxUHLW35kb5PAV+1SEurJMZ4GGommmdnqvfaCd5qFJgG
 IzGSquwn03ToitrX523jUdLanyr8t1efNPDx04wK7vUUw3WycKLfMQwPpBncKuuBgVTwgX4/u6B
 fUmox0k8XKnYhhIoLt7N8352vHL52MbtZ+zVOYCxoc0Rz8JFWUEs60KL0JtwiwoKRSFEhfejJIs
 You/YPU/s3VawlQ8h9FPraHGAzCRnGpzeOpJOgqHnsL5g4dSR7uxL28Utvm+MyCa1NGcu3CQj3R
 t6L1fap7A992iFzvjJWSsetwF/pOl0rY8X3fLuSITB0AHVJBsP1fZujUYhjqFY4uLJ7kqRBJjVe
 DIuxgga+Vo3KS3OQEWw==
X-Proofpoint-GUID: rzwVppszj8iVYPlOyTOFnJEnSGEBt4h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190106

On Thu, Feb 19, 2026 at 12:38:50PM +0100, Thomas Richter wrote:
> Commit fa2ae4a377c0 ("s390/idle: Rewrite psw_idle() in C")
>
> removes symbols psw_idle() and psw_idle_exit() from the linux
> kernel for s390. Remove them in perf tool's list of idle
> functions. They can not be detected anymore.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>


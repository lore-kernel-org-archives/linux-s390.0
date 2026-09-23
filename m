Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5D443E52
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153866; cv=none; b=cjTsU/njv+nR/wqb486QK3jkHVi/RCbrUo7jANA+aRVdX9BjDrPxNatkQj47lFtXf96ZtdrPOMMgKcYB8gshyoN7TmKSkH1dZ02uxD7PGZ14kAIdOO9x/sK5n+UhjgtDUaP8fJwIFQuMw7rxZCDZS7e/DS/EyauDSCCe8n7Hb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153866; c=relaxed/simple;
	bh=d8XFVPxSiMtcrlTblK3Ld1EN9z35B4QgKu7Ml0Kx/7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEm9FzbHAbyLNA0EM/8gYaUfm5SoGD2uc6RNY3Cyc2yp8hkI04hVh7nXjGIa5Bo8C36Uj7EKhI8984oPLGrTtLTFBwi82AXwmfJt8Oc9j1ov8xrZaaOsIy0N7bUqhr6YFOoacqYH3hsINlJUFdMLi/ogYLr1aSfwyu22QzPbK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GNkP6cGn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GNkP6cGn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8Zrdf1729873
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 08:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xzlH9s
	BeURquh9RYFxhR6G7VSmIsnJpiAt+3qiFwJfc=; b=GNkP6cGnntk9hQ24ysxl/9
	gQDEgKlZFSNmT4i0u1VzW0bp3lxemhirB9XSVZmi0Xqeg/VCmsMVaZktvCQptxWK
	1sc1kSR56NgmrrBV09yDXwFHT8RGUlpVB++n1Fq2mqG0YP2vOCxyOwE2s9Ph3dqN
	CsK4r4Ou+n4emn29JwQLL7mTeAEQ+dIefHGjsp5Oubz6+Q3DkcSBuAozlIdoFmIM
	w4jo8F+EyoTc+8dkac4hJdDmZ2frYC5qsIvLmkhpXZhXe1vMXxwjZVwLfuhLG0AZ
	j9FvP7gh5BUAlR9OzI+7SB7VYAsOc8aS5Ba85qwKaWfNR63TYNPA8RGRygB1Kx6g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqhpg2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 08:57:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8HiVn4120621
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 08:57:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjwhae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 08:57:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N8vfcX36700690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 08:57:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71DE758055;
	Wed, 23 Sep 2026 08:57:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 893555805E;
	Wed, 23 Sep 2026 08:57:40 +0000 (GMT)
Received: from [9.111.195.112] (unknown [9.111.195.112])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 08:57:40 +0000 (GMT)
Message-ID: <b7d20111-db61-4e47-9e84-5232b179b974@linux.ibm.com>
Date: Wed, 23 Sep 2026 10:57:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/cio: Fix NULL dereference in
 ccw_device_get_util_str()
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org
References: <20260922204839.965043-1-vneethv@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260922204839.965043-1-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab39487 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t6LKY7qUztlgNV1eqxoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX75C2QDJJVQqW
 d9uewtUCk3xZy6IvanyXiFyxNJZHhogZlAEDTSchxDfAIyRq7l7S4szLr0A7Wlt/KP8cHasy0RY
 gqivim7sxf4FrV1EDBNcSUvAfDalIsKFeeSi80SgfQCN4Ypl6xIjAOv+P05+jarWPZmik5DC6sq
 YYuZnRHSSx66DaBstlyso0RRmjfvTxhQtlyBydMvUy5bPld7eeQgTgq5ac16B+H9bkTGfFdB1Wc
 NnX308rBuWlHSrF5dLufOHoKQ/nOH60uPBFNCBCE1RQHvZhuuUgppGPrekwI6OyoF/aEUSisjqH
 u+r0/GAxHF2ta8bOO8+j2lUN5iM7LB0iQUXuOXw/r6dbWn4EKeobahZhdIf86kaPjFy5M2QAUx2
 iLj0NoyK6FaX9mUnk0wBgyrRufhoviK1zF3TLW86z1+qKdxvbooEfctlf8vOCyQeKnxXB+9/gEq
 goRpTa+1zjomvW9rwtg==
X-Proofpoint-ORIG-GUID: sgCIaXEW-PAe8i42PVO7jb0baomDGSv3
X-Proofpoint-GUID: sgCIaXEW-PAe8i42PVO7jb0baomDGSv3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX6P8zuYyJcBuv
 RC/wDVsL/wJpJazem8ofDaaenLlPEO2IZ5ieAYztsvBa5KfDH3GxOg8200sDxMWerGp65p3tMJ1
 Wj4ZTpuGI/FXPC8Ovdo9+87tfDiXz50=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230034

On 22.09.2026 22:48, Vineeth Vijayan wrote:
> The channel path registry entry associated with a CHPID may be removed
> while the subchannel's PMCW still references that CHPID. In this case,
> chpid_to_chp() can return NULL, leading to a NULL pointer dereference.

Actually as I understand it, it is the other way around: the registry
(css->chps) still contains the entry, but the PMCW CHPID list contains 0
due a cleared SCHIB. Therefore the lookup will return NULL, unless by
chance a CHPID 0 exists.

> Add the missing NULL check before dereferencing the returned pointer.
> 
> Fixes: 199652309a4d ("s390/cio: add helper to query utility strings per given ccw device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

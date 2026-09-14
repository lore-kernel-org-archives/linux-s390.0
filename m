Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760D451983
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388054; cv=none; b=VyVzVBqF+HQLHRdhSeGv6RiCaNmKwnHBz6SSTKDLYBpOOPtGXcShwaWYwE4fHY+gJUiOwM90pnZ0Y2wG4bVWjeM6pb7OCB6y3sbxNiDlimissK18bUrgqUgSW93AI4aMARbE8B2l5JJnyK7b0FwNGYn/4+PYnWs3LE5wNSClOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388054; c=relaxed/simple;
	bh=2glxHBz2QhH1QFHuzWcg7Gq8+LtCH8vMc8xFJ+U66/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7yjGKWJsQTkEDktRxuUFp6i9o/Wl/Sz3tgJ4UbZAfdaf83G7ehMMebfNz9A9rfM5s2G2kIBXgh3a7GkeKALZY2jxlxIJfq2z6KI17bJW1BJDJdHl08KP2155uCF0atM0O1CBYrXxs2rWolJyZDtG6L7/9Yj5SmuDklMjT89i8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZNlqAGWD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZNlqAGWD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EA1Wxi1740926
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 12:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2glxHBz2QhH1QFHuzWcg7Gq8+LtCH8
	vMc8xFJ+U66/4=; b=ZNlqAGWDbCCRp2nMOU2ySFg2X9iAUDJc/QjG9bJVLumDVl
	w3JgWcRi044gCMB/X6r3A/ULYxOijTgr+tc+r3ames5kAGlcX1Le1HtvY/jYD0lM
	fNGdK7lNNCpgfiSDb0T2Kuc/ITySuQNvv22WfR8285fE2NbSpUjUrNm984Mw6UfV
	KZla4qGbAzVu8oL5pcNmPZunkghWQSfq8v3lyF/Vj19JmZ5/En6bOqEjRxojvC/r
	8bCZEZgDBsagQR4EsvZkiyVQLGwA1Ms9dK09xpKGknio5pnQY+3ZOgfuobAU+Gj7
	W5piR8hF0Ehbig8sk5fPpNmsZOdcjXcrzRAhux+Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcus23c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 12:14:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9o4942098738
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 12:14:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry5n6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 12:14:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ECE7dT51642878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 12:14:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83C6E2004F;
	Mon, 14 Sep 2026 12:14:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2442004E;
	Mon, 14 Sep 2026 12:14:07 +0000 (GMT)
Received: from osiris (unknown [9.111.83.12])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 12:14:07 +0000 (GMT)
Date: Mon, 14 Sep 2026 14:14:06 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, japo@linux.ibm.com, sumanthk@linux.ibm.com
Subject: Re: [PATCH] s390/pai: Simplify pai_init() and always return -ENODEV
 on failure
Message-ID: <20260914121406.39845Aa3-hca@linux.ibm.com>
References: <20260903081557.2023814-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903081557.2023814-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfXw4OHDaUHZdxP
 nJTdA3X5VQXrE3RtT7oyNV/u7s5802ewn4A/vzkhb6x6DWcpcpOOEg+An0+Zw8OO7/KrVj+0eOg
 h2S1svbm348Ks2nClDg/xEiY1gmfvKY=
X-Proofpoint-ORIG-GUID: --O58DEKFxPDI5Wq8pGlEvs_Bz038mI-
X-Proofpoint-GUID: --O58DEKFxPDI5Wq8pGlEvs_Bz038mI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX3sivihC4S5ip
 fO6EWTlcz07914LUXp6aSH/2XBDS1VXlRVNjitH8ZOcbfFowRKZHQJneN6sUEd6nIRPwaaHfJP+
 dW8tTZC8E5n01PJFMg3uVphVmwBzSBJjGNNPnOhH5Adt35OZRieFjCLfMA4J5NlVCX3qhrWZ4F9
 fn5Q3Xc82fTcGzuVxbh5qVHL3y5q4bDAauIcL5+3ur9rVwQmvK9fbFMhr7XEKZo463/T375mSL/
 yJ/LDLw6THI85YiOocVPjOWAsIDll7Wzxivoryggf/Ax1BfgikdXSMV5MzwsuPorRKF8Hc2IgIR
 mQn9CX8LmxEkJ8jhtUu5hzaRfzy0GIQcN1z3Lg4LmnO9Dw+IeHobwSmfaorQDHHhf9iuelGH0bd
 PL5QhJDXOUnhI9rTJktvQkwG3GSaRt8+8eEEE23vapWlIrcj2v6cXnY8VI64NXd+swQxy87ZIEL
 ViifJ7JqaRbXmcTVbyg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa7e513 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=oWIZ3QBRBYHYsP2WJVoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140171

On Thu, Sep 03, 2026 at 10:15:57AM +0200, Thomas Richter wrote:
> Code simplification and remove variable state.
> Return -ENODEV in all failures to indicate the PAI PMUs are not
> available.

Why do you want to hide different error / return codes? That makes
debugging in case of an error more difficult.

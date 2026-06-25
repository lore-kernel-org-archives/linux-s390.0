Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563230C14A
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403335; cv=none; b=p2xij/PAEgE5ys+f92zWxwKD6/ZZoqZWBC9bT8jCA0TazSTFmRoCyeD5RyqzvPpQu981lXe6NsYC7P5VexAql1uMRIV9mjJahC9LYi9AN8oKWS4N9uomiSnhjiGoJbGSv4DwaJ9g7k5jGNzMJW6iRPziBoYMd2+ZKAqIzgYcaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403335; c=relaxed/simple;
	bh=hpG3s7WhxbJEtIBPzkhrTx04ZiOK97ljd0VUWHCOqb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXRo6y5GrM7sNtLae00oXmuMm+M++ZqiRi4lk4NYhkfjfdaWMnpB8W3HZ1gCswaHygQsSRDPPH6AJeIkr+IXCpNzY361i6lj4d2g7CEJUgV8XCIkPYPUVV8tBTgYSdGJzSUfgquy92f3OkhLovyJAO7U3OEI/TdlZ/Vx+MoSloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iYzfpXpC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iYzfpXpC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFne4h643838;
	Thu, 25 Jun 2026 16:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vGIT7n
	365t9AbJvRwKrJebeczzuzPvgALgvmZfoA8y0=; b=iYzfpXpClPJag6AEI7JgOZ
	PY5egKax4HupYW+ZOnJdiO5wK+1w+Ot/09vUwWpq577dTA6Q0VnbjxMyCqO1oCRW
	r0nqMr9O+bt8e0+qjTBu6Z+GBENBu/DYKeABmTp2cl61VKnrpnZTEtFghVY0IxhX
	tdcBGE/2QmHabP8WKFhjWYY/3qZWPvEOB0IKlE76ZPNpCcs02QUkPVgIJv1S6hnu
	0RHFwv2OuNEy9k11kEFduRM0+mjq2QzfUU9RXjFAP5vahI5wSutSWD+HFk/14AKt
	urrLJ58iu3vY51niJtM1oypabK1NpNBbmj+xnwiCdUbtS6MAKpx87MXnz8HmVP4g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr2jr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 16:02:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PFo34P006372;
	Thu, 25 Jun 2026 16:02:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qq575-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 16:02:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PG27su44826954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 16:02:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98EC420040;
	Thu, 25 Jun 2026 16:02:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74BF320043;
	Thu, 25 Jun 2026 16:02:07 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 25 Jun 2026 16:02:07 +0000 (GMT)
Date: Thu, 25 Jun 2026 18:02:05 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Ciunas Bennett <ciunas@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH v2 0/2] Improve DIAG 9c observability
Message-ID: <20260625180205.0a7bf80b@p-imbrenda>
In-Reply-To: <20260625131615.262367-1-ciunas@linux.ibm.com>
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3d5104 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=D-UhKRAzZGDjIJxll7YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfX1TNPPK/HZslj
 skH/zxkiUgW8iIcwhZB4tTCk7zXiHDU1VZsjay4Q9ydpn31LKCEJZAQ1givJoCOLIw9LJezRZIR
 d+FxMKXjHYRpXiSU38TwC3UFTJdPY727WE61XYR2fj+aZGrbj9dYijZX8/SY6RTRLErsxg/QC3t
 +Xf12F55Yxysb5PPPTkz5nTp0ay2vAXKbg4r6jneWLdHJkfLU7vFEhidb79VDNiO1oxuJ0uKCKA
 FN7AG0PwhlTK8nHHdALr3PoCevtwgd/e2SSGU1FK9VrqZDtYCKMcWzBujan01uIl2wXv0Bl8Eid
 O2iEoGV97PrJk26jKjrt0TGxYIqeIWjEoTh6t12JkY4HRZN3HfhUT+G2qxuqMp8mQQc3f+dx/VU
 XxtqJmRgS+OH6jNf9sEscGaE1iYm6shXK02LQWpdghlU77TRWXPUtGEsrEZk/3sCSyJEnxtdYMQ
 byvJN3R+R9LreFmAoOw==
X-Proofpoint-GUID: Ked2FRnMHCEw0k6cZZE5SFjcU7fexG9X
X-Proofpoint-ORIG-GUID: Ked2FRnMHCEw0k6cZZE5SFjcU7fexG9X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfX5DrcsmkQVvos
 aomXlxIkRRW80opa3d1TvxTcTBCEIm/d4UuFdArtwKw0SPVgTzPEo4kdR0xFU3LmaaUv32kFfT9
 +9g6ca3BdELJ2DL/cHsUDZzud9GppUo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250136

On Thu, 25 Jun 2026 15:16:13 +0200
Ciunas Bennett <ciunas@linux.ibm.com> wrote:

> This series enhances observability for DIAG 9c directed yield operations
> in s390 KVM by refactoring the handler and adding comprehensive tracing
> support.
> 
> The first patch refactors __diag_time_slice_end_directed() to use a
> single exit point with a result string variable. This consolidates the
> control flow and eliminates code duplication in logging statements,
> making the function more maintainable.
> 
> The second patch builds on this refactoring by adding a new tracepoint
> kvm_s390_diag_9c that captures detailed information about directed yield
> operations, including source/target VCPU IDs, physical CPU numbers, and
> operation results. This enables better analysis of VCPU scheduling
> behaviour and helps diagnose performance issues in virtualised s390
> environments.
> 
> Together, these changes provide kernel developers and system
> administrators with better tools to understand and debug VCPU scheduling
> patterns related to directed yields.
> 
> ---
> Changes in v2:
>  - Add system maintainers to review mail
> ---

whole series:

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
> Ciunas Bennett (2):
>   s390/kvm: Refactor __diag_time_slice_end_directed for single exit
>     point
>   s390/kvm: Add tracepoint for DIAG 9c directed yield operations
> 
>  arch/s390/kvm/diag.c  | 19 +++++++++++--------
>  arch/s390/kvm/trace.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 8 deletions(-)
> 
> base-commit: 184fc1890bcc8242f00fee660d2651290f1461a2


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBE387592;
	Mon, 23 Mar 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257092; cv=none; b=EUhijwYHBHXfd5uFCPFlbs1C8YbP7jeJ1SAKu+FEhiSD00aJ/xPL8m6rkbd9H6pSveNu5gd1yJjw6RaX39neKBjhPgGoIXHsaQGPcIHNHcX5P2npQVnoXKn9VIFHGBb4vUxviSUwLJqVAAILtg7BA3bA1avuVWwA0b6/gMHLfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257092; c=relaxed/simple;
	bh=AP5KY4T2Cg7YeGgbjTYEiu4xzLxMyYXNfiIVXnO/K+k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=iZKIwC2SYVsTfNCIGEih5cEKoHGYVCERFooqjaiDmwavlxVaHuvbOQl9G0XvPHiHUMtXXWSY44K7tRFWcHMfTdhy1pkDYF/AVWiz82hlby9nSVT3t16sS2TP7KqB+PWWdxdfDwTuLICSSv7HX2fWun9h8L5kTzP1jeO3PifNzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dfb+uDst; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dfb+uDst"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNCZuT632924;
	Mon, 23 Mar 2026 09:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mY4Hf2
	kcPTaHRazeRbniJqTGHvhzcGULisr5Cjn7dcg=; b=dfb+uDstWEk7o6/9uJLiAr
	NaRqFNrfyqgdTK5U/xTT5Mq1VQjlGfVSGyAz0xRJHzTLsIRu5kshYawQW91xtt+r
	VRaW3j0/KLjRkTMYGHWPTHJzU/tVLBMm+4eQiO3GvnToZzeha9p9zkST9fOXqjfw
	e0QTkm6eylkKI9u1+HHbLGZQjNcJS3LI8+udHvoVFq5huaLRLk78ZtBfZ6X8tnZ+
	NS9K4weBTnfCiRKLsY/lioQf6rGr3OUuY1eg9++Zs7GRM0u86xh6IB59UbMVSQik
	O1GyvFg/p9mBcajAMMiN9qYCAPaFyaL/GamdFslHWYrDYesBOs0fkHcqFhhbroTw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumdvng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:11:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N76NsZ008722;
	Mon, 23 Mar 2026 09:11:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nncqvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:11:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9BPWl36897150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:11:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CCED2004B;
	Mon, 23 Mar 2026 09:11:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AFBB20043;
	Mon, 23 Mar 2026 09:11:25 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:11:25 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:11:20 +0100
Message-Id: <DHA1N6AM078C.2IBSWWYGH68K9@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 06/10] KVM: s390: Rework lowcore access functions
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-7-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-7-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HZ0mvvmskqr1UEbMLe5Nj3Mni1DWpQEa
X-Proofpoint-ORIG-GUID: HZ0mvvmskqr1UEbMLe5Nj3Mni1DWpQEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA2NyBTYWx0ZWRfXzmiVXCej+DS0
 cOWbXi60p0Zk3lDNbz8AoTYf+Nmj9MvkrUTWzJtCuNl6RF35U2Mr+WuuMk+XJRA57mqMGDtixJ8
 7Fj/hYMwLiaEAow6IEjtH6wtFERXvjBeiqVhV5CVjAzD2LKISTBIKr1IP7qeGOi+US5FWF0E6rA
 nkBsPqxq5PO+qwySxLmm9HPSfR0TpT39H2YsZLWIMIEaAuqsVHiFtyP02jl4Vj3G+PxyQEqpfsg
 sTCSr6LhtIZDEfSjCbsQk125TlnftsVsG81C7jimMdN+N+VeYkVX/tjhbgjDrLRw9/pb4nroRwu
 zVMFfvk9VveyOmP97TzLY41H5oyr7FWFSD7LxP5QZIA1YiN1nELkOjDOrxQW8U/aPYEsg2J+UDH
 hTg4qFC6oo0yEVYAuvTEV5/ZuxoX1+y3G9Fs1IzBET7Fi0wVOrUOvsuEQ3lNkySvuSJDQyrGgU1
 gQ8QZ7w+r2ppU7UVNQw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c103c2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=vxaBBA8Nc43h-djOecUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230067

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> These functions effectively always use offset constants and no
> addresses at all. Therefore make it clear that we're accessing offsets
> and sprinkle in compile and runtime warnings for more safety.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Acked-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/gaccess.h | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>

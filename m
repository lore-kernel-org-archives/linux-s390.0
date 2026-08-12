Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7542048E;
	Wed, 12 Aug 2026 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530113; cv=none; b=A+XjpNAmcyONnd6otO1oWbWw0MvLdZR9dLyoVVw0UZS+fpGT3AFnXDJ5lVDyLtpIbXOuWrmMOY/QNhzYkbaE4oIf46ds+UUWhyBXlZ4QHg99Ts1BuQtHLh6AoUPFNDcPPediwuxy6QqDmO+BZ3jbE2PeE2enXBNDymdKauGCt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530113; c=relaxed/simple;
	bh=Fnm/NwVzgNJikc6UxTyQecbizuLLQwDbXLyB8j0J2wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTllWIXGWJcttkOVa95j9Ftji2vZjCrrwvoIGH894B/gd3cWxxt6FsLCFRkpqH8vKNKwiOTeKjY4PqNTjOi8QBVL93ifE+hkR/S0kFbI8VqAUN0eDtYwl3oRXMM9yVxiGJJhJWIUaeDvpDtEWwthwJaaRnSLd+GjFy5LG2/aoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cqyGD/aT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cqyGD/aT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1me02078021;
	Wed, 12 Aug 2026 10:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bSm8nA
	ItODasQTnlDuR6kdvk+BKwubj6/O0NIF8QBM4=; b=cqyGD/aTjxFdAwytp8c+Ky
	8JbbXuTEcgNA0WK7p0mNU1bGB1b9gUo042KHLVyvAMrUnTAOMYWcsP1ov7fqx29W
	nN3Rhy517oP5wIpNKHKovGf0Y64vBO+Dxy/nq9PC0oPYqlzVgnWaD/6CGKnOA6iJ
	E+T3jBJotLUZ7F/43ZIxxio8fvWaduG/tvJkkzy8obSwQXhw4+TISUlB8CquX937
	c8Fp8YtPXgKYfDEJtdE/QT44znISmi0+3dlKOZ4+oFLawyDs6DHTUSuHYz1qo9kJ
	wjpaprTiWqRzIYMXR4BTGMhLHoJscXZ+RuFigPmhQFnH7tAH8f+34s1OnRVdnyug
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23tgsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:21:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CABKkv016702;
	Wed, 12 Aug 2026 10:21:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w5nqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:21:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CALdcn30409208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:21:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C05EF20043;
	Wed, 12 Aug 2026 10:21:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CADC20040;
	Wed, 12 Aug 2026 10:21:39 +0000 (GMT)
Received: from osiris (unknown [9.87.155.64])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Aug 2026 10:21:39 +0000 (GMT)
Date: Wed, 12 Aug 2026 12:21:37 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] s390: uv: Fix loop condition in uv_find_secrets
Message-ID: <20260812102137.18999Bd8-hca@linux.ibm.com>
References: <20260811-uv_secrets_fix-v2-0-64444968ec55@linux.ibm.com>
 <20260811-uv_secrets_fix-v2-1-64444968ec55@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-uv_secrets_fix-v2-1-64444968ec55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c4937 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=JP91DYv6CA5BUcaABPAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX0ykuHc+FycKX
 GcgHuhgnUS6czhWpYOOzdpNzAJSqJXN23w0TUIKDfI8JwlcMQMfcLUakqO4wjPlOfDsmrE/u9+H
 aMsnXQU/YZEneZ/LNNV6PCzEoRUWothBjqqbMFI2YfAPMs+fwIZ2AxyeuDNCQW0bGgLxsualzk1
 z+wLl0NoRhYp5JHGynubIFGWaYnA2/C13XNLyX+70hoOPEb7qkCAqQVnIaIxSBjpD+IuWWTBXcT
 3og6X8tDcxI10rJLtJmsKDFuOdZuwppwwixOMGepfUHa20PyFQaH+9XqYFIo6yQxgBTxsFqcH+3
 ppCQqAJ/guJ6rcS0OuJEs2SBkp9mjbsN9p4DoIyMdAL16ESgb60DyvN0bnUXFtn26cDjoVOB5VI
 buWB6VFze2RLpRZ9LWBg6gxM7qkP6Fbt0e6B/nasH4nnnafjlQFopY1olm31wT9i/mMVLqhSHQh
 HyxN+Aqe+d2rDxoybhQ==
X-Proofpoint-ORIG-GUID: RQPnj2g4uGwMNP652HC5txgABxfKWwo5
X-Proofpoint-GUID: RQPnj2g4uGwMNP652HC5txgABxfKWwo5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX1PldV+q7nZjt
 RsL3yxTIUvjDorpESTFWk0RKSKepz4z8vngxWcmmj0omLIjGvmV+9v4o0fO9NldTsMKUnsUZXFz
 PSN/+3Vrrri/5250UndBwDNorK+urAI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120080

On Tue, Aug 11, 2026 at 06:14:21PM +0200, Steffen Eiden wrote:
> Nothing modified `start_idx` between the assignment and the comparison,
> so the condition was always false and the do/while ran exactly once
> even when the UV returned UVC_RC_MORE_DATA. Systems with more than
> 85 UV secrets got -ENOENT for any secret past the first page.

If you would leave the first sentence away this would be much more readable.
Starting like above  makes me wonder: "what is this all about? context?".

> Fix this by setting the start index at the beginning of the loop not at

Please add reference to the function where you fix a loop.

> the end. First test if there are more secrets left by comparing
> start_idx with list->next_secret_idx, and then set the start index to the
> next secret index.
> 
> Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/kernel/uv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Please also fix the patch subject: It should be "s390/uv:"
instead of "s390: uv:".

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3D27C162;
	Tue, 21 Apr 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784359; cv=none; b=c2fb6y1fm6GcoNSfQm3pg2GzqCIWfJrLoCiSZMQMnfcltzUlidwV/fP2TwAsqUUbKCYobgjPg+5HLP/xpfU24/TgCZ5oYc6RacDeuotUUAJkJR3PgxHu1Si3yslT6j08o1/zPuS0uGPqRDaQHLNqyVfvJsf8Pq/LWGCpSE0S4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784359; c=relaxed/simple;
	bh=p9WKjqTv52AjPNv/cZ4Y9IdMXv2Tu5011e8KVzfRtEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=MqGeaod4vhj2Ao0jWNtJd02HLjt0fO8OD72kfXDLgUDqWb98T4lDknsNwkVI7SjBkaWtYJiCyvmxCLRQS7MiHqVk43nVFRGYVjirUz+1BqYWcMfL9RjTDTzOr+KP9D9Po4OwzKlZshyDRjoozEadI8A0jPT4GPV0vUZEJyfBoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k3C04ywW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k3C04ywW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LBspWT1535555;
	Tue, 21 Apr 2026 15:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aK0ZiT
	42Q6SYE7Qyfx6GlhAwoBrTWnkl655CdVfuuLM=; b=k3C04ywWayq/Trr3mDpT+0
	WOhEtqmiAq1pBYpcfNwkZgn35MtDA92CTAOVfcy8OE3oVHix97duqqFa+eO+EVm6
	WQ0knndVH9NqDiTsb8FDgozftThsoYMr0YUfjNCCXbr850H/OlHYTcwg0gfXTpTB
	JprbXDNalsS8QM//xBqGac7Z4xFnITQ0KNSPoA/A/GoaFuiI3I/XV+c4ZJW7O8gm
	ShQqYELDxV7Kx4Ah6ZImxxBZbQCSkOQoEfZR+12V5Gk0oezAttw7T222oL2aV0vm
	oGN/OZ+iO/Zg+dArlyRaFR0AolAyQhoDT8Vbry7eR1ySjUhEBawBCZIC+VXpTgsQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6m6g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:12:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LF5Pns029178;
	Tue, 21 Apr 2026 15:12:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg91g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:12:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LFCWSW26215008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 15:12:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39F12004B;
	Tue, 21 Apr 2026 15:12:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92A4C2004D;
	Tue, 21 Apr 2026 15:12:32 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 15:12:32 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:12:27 +0200
Message-Id: <DHYXHGUPI6PB.15M7IL9UYO69D@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 1/4] lib: s390x: Add function to get
 page root
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260420084933.251244-1-frankja@linux.ibm.com>
 <20260420084933.251244-2-frankja@linux.ibm.com>
In-Reply-To: <20260420084933.251244-2-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e793e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JpOM-OZrDOjRqmxhRBYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfXxQrIpiwkZLqI
 EPJ5rPH8l9VzeM/lHUZ9/owSirAsXAJRINqmLBpJzBinX6YNwHI+xF/ScSGqegdwhKSUo0DJeR3
 9tFp5KErkNgSrB608+n1OkcwFGKA+qs5DGMoVvZhTiLMaSyW1ky7rDiJjaHYTOy82XRw4FdNXtZ
 FEwAnFtV2NfrMI+qz8vlofhDq+F8R7W2mugBGOEEiMUb+CukVVBwdSkLR/bjhBd179skl1BNPCd
 XmPvm2t6EfqRy+WNdhQ430d7fsbRfaucMOpOPozCTY4EpsTPmP0yBD0UkxSSPcwhRXxVvugAz1Q
 tOY4Vta7J8dH+RmUVhwa2MyV2PcAsGNAqYhFa2f+4cAaxrR3grTGn+XR0qwcrzld3LRUbqOLack
 sL05yVTTBbnboZz6yU7R5r6iHUbiNTL+Ub2wnl0HnFuIcRLgY3g47CvSB3vP8qS6PNtjiuBUlHC
 57kCIfbgQeg1ugr2N8w==
X-Proofpoint-GUID: KgGJdI60HgB9yxFCj8hkt8wT4AkkACZR
X-Proofpoint-ORIG-GUID: KgGJdI60HgB9yxFCj8hkt8wT4AkkACZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210148

On Mon Apr 20, 2026 at 10:44 AM CEST, Janosch Frank wrote:
> It's time to hide the access to cr1 behind a function and add typing
> to the tests that used void* instead of pgdt_t*.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  lib/s390x/mmu.h  | 7 +++++++
>  lib/s390x/sie.c  | 3 ++-
>  s390x/diag258.c  | 4 ++--
>  s390x/edat.c     | 5 +++--
>  s390x/mvpg-sie.c | 2 +-
>  s390x/pv-edat1.c | 4 ++--
>  s390x/sie-dat.c  | 2 +-
>  s390x/skey.c     | 7 +++----
>  8 files changed, 21 insertions(+), 13 deletions(-)


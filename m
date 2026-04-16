Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8638C2B5;
	Thu, 16 Apr 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325720; cv=none; b=OCg47pWzgRqNRjRSFXYijTkYfe1FSb/rHQvQG+eY3NdpPcnAcoQHkJFa5AbB2rgHSuM+/jDWztGda58/T7vqvb0lVDq1/alJEQ54YFgz+wHsCX5os3Os9zEhMSsWyCtQi/kRmpM77f5tzAu/fM3e8lpdGEo9UdnCz6YxmZM6iRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325720; c=relaxed/simple;
	bh=JSNvLO/qmgM2s4BkKmat5XmisvdcBMqMik9OB+7VaXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ehvCmjul4cTrylDdrUOA4MqG/FwGu507G2BurJ0+XX0fCSPgNZmy7Y2pQ3kf2TkNuP0YHLBtnMapj211izGMwc0/ixOcaDJOM0fTcQC31neGTvWloggXmT7IMu/27IQ89r9LrQiy9d0gOkKyQvjIXinrTYiheSMgsyKdugrpKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y4ssymDb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y4ssymDb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G7Es7s1842923;
	Thu, 16 Apr 2026 07:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JSNvLO
	/qmgM2s4BkKmat5XmisvdcBMqMik9OB+7VaXI=; b=Y4ssymDbv6wOHEFkhLm0h3
	8mWg+959mTgR2WWMgkaCywcb8wcWV4Mkz869H5uFhe3J5yHq12YewInVNjuMRfHy
	PRjYqJYISL8QrAx7750LytB2FBW2BL7525iU1UAwglM4ylTlZu/b77PHmADgvPoc
	0uz8as3CIyPATdEFA4mVXP5U45HKFXeApDebSryEn2GUVWApC4rQNCh8zYZfZssT
	ccNQxEkUuAew2D2Kix0qEjm7lowTjj0Fw2ZdtWLWtBRh5cqD2u25cEPsbBjDGHKH
	noXj0/wadtELgG1ZzS38fZeoxWxsJ2402xqhFyeKEVvetLazkkI+Sorj2lIOyppA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mv9pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:48:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G7bKua004162;
	Thu, 16 Apr 2026 07:48:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnhwj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:48:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G7mWSS12845406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 07:48:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF52F2004B;
	Thu, 16 Apr 2026 07:48:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9582720040;
	Thu, 16 Apr 2026 07:48:31 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.59.166])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 07:48:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 09:48:28 +0200
Message-Id: <DHUEWSSY4DCK.13BQA6YYBXJK5@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
Subject: Re: [kvm-unit-tests 5/5] lib: s390x: Remove kvm s390 prefix from
 sie control block
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260415085145.91197-1-frankja@linux.ibm.com>
 <20260415085145.91197-6-frankja@linux.ibm.com>
In-Reply-To: <20260415085145.91197-6-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MiBTYWx0ZWRfX5m5wqmva3o37
 sxcgj/ajMMo8GZ3c2q0nUvmeFGKFH1umDNEzkpc5NDqAUkxIG1B6KzyoQTN7clOLL8cfpUV3ENf
 zPhibyJR/ZDXNuVkYch3YfQFoLalLkp7nPW0dooZd5X4Io3ar5pCGd9O9nEt/tf041HnIWPCfU7
 5cgWX9tAS2fXyt90ooiYN1GhLIccgwHhRXwDr4+GdLt2OoH1ivrqer31G9zNBkMXwBaBZa7hBWG
 B/UrThSLBUw26kJxFPgEYP9eU4D54luUtE75T8bfeyjxo8Uid/OgNS3LBbaDeURw0wCTZNuaVvC
 64Tah/jqcFA2BXCzXiC4dnprQmVq4PhsKQ6EdIUmemJ1FyVQXrsPhXYHY3fNPJk9u8+bgPFYZb9
 prY5sL1DW/OeD1hR2YFyosrOkwS3oaQvpFguS6G2Ge297u1pDo99aNN1xG3WPFrSDZQRXN/niPN
 WUQvWsc/Vuxu0AzeO/A==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e09456 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=tIrQHYovq9rv662ohxIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 02zq9OiSd9J6w4otTMw_CbcAwPfKgFcs
X-Proofpoint-ORIG-GUID: 02zq9OiSd9J6w4otTMw_CbcAwPfKgFcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160072

On Wed Apr 15, 2026 at 10:45 AM CEST, Janosch Frank wrote:
> We're not kvm.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Hm, is this just a cosmetic change?

On one hand this will make it harder to copy things from Linux to kut.

On the other hand, there's already a ton of divergence between Linux and ku=
t.
So it already isn't just copy&paste, this will make it just a bit harder.

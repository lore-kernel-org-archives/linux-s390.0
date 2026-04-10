Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF72FDC20;
	Fri, 10 Apr 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820512; cv=none; b=d/SAlpkbwvz4jQdwJNtqxrFfAmImw73HDQBK9MXdK+/vDDGONiKqGvMt0KN7SjA/UA2uqZhMedsPcZ+CBz6VBXt+DSc1e6IWck7u4DD9zUE/twlRS7NBfS3oO1YSfrjqBn32yqWw7DIwNYlAsFHPCqY63vD0zXxKe/825x0QEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820512; c=relaxed/simple;
	bh=dd4WGQTrPD3LVc+AsaEFYIfL0HNOVO8IdL56J4tiAhE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=VJWDlKgwBZbCWWDMnNlffStAbpxRALRzk/xB/rTi7B0nSiF9Cc6WvTucMeKdcrThUISPrAcdtwDus3ONCghIoW5V5ymgGJaKe3LHgB5ICMViXbO3KtaacQs593hjd+2U6YEhijtC1ItWFypo2m3QbFDUj0kqvJmYJkRqAjTSReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tAnGzSze; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tAnGzSze"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A0KLLt2316383;
	Fri, 10 Apr 2026 11:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4HP2Ol
	2WWAJ1B7BcznsDWn12H3CGDhoqvts3QAiGZzU=; b=tAnGzSzeXv8RT/hhhnxXsm
	GJ0Tbg/sTShZBhv8U6sSmKSC3oFst50I7v36LTDdxvqlUQduKoG/DWFLLcuLTYxf
	f4A2Wi6dXTsfquK9S4ijDrHZ9y2vRPm9Rjz4YdFHBH+6e2p5IdeOHxzbCwdkp2Nf
	zE75wmeIXuTsjRqF2/qGc8QC1enhgIdIOvJZ1HrtFTfqJamyozcUiau6yTMXfzWv
	itSPamwrBN1/PzFlVT80+/JMxS6hNrbAgtXDUNItX6TlfhzFHIGumJai4wW4rWHo
	PIwQhH4aE7iAZ3C0i7Ik989I3CoYFITSu1d1cBLp2oXUWYETCDRY9yhphn2cHAJQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g9n2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 11:28:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A85kAE014361;
	Fri, 10 Apr 2026 11:28:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4yr66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 11:28:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63ABSOcF46137648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 11:28:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 615F720043;
	Fri, 10 Apr 2026 11:28:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B86C20040;
	Fri, 10 Apr 2026 11:28:24 +0000 (GMT)
Received: from darkmoore (unknown [9.111.44.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 11:28:24 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 13:28:18 +0200
Message-Id: <DHPFTUWLWPLF.2W943AMJRMPE5@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <nrb@linux.ibm.com>,
        <seiden@linux.ibm.com>, <schlameuss@linux.ibm.com>,
        <gra@linux.ibm.com>, <david@kernel.org>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] KVM: selftests: Remove 1M alignment requirement
 for s390
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-5-imbrenda@linux.ibm.com>
In-Reply-To: <20260402150135.196943-5-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d8dedd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KC_igQenHm2MEnVbiCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ve0Qp9YpWN23CxutEknC6s73bMTggK6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwNSBTYWx0ZWRfX3rZcA2blBEj2
 JPFtY76sR0rGLiJV9TIRmykVrN0yactEri21Y4RY2OfzfdV5bCKTFc30DgJAI5IUyVbSr+iQi7/
 wTc2tRdpNN4pHpsqikUYzUtl0yUBIdfqM/qs//NUI+3VUyM4JUG89ejg0W1fkA551LkwypKRWK/
 Yb7M9wLGu+JmZpfeM4wTG9Nv+yQy8y7XDShwQvIpEBkTI9mdgjdYbp4pPeDeRN4LZiXpOvPbJd4
 bkDY8TBE553dUWrsq853kTUaD081l3SXC/nov/wKNwYL9sfKtn7GqdEGnhaPfMfHZMrxZhHmGxN
 UTcJJ7qMeiBymVnv8rChlEw0zhuCqqmlHVV0838BBULLQX5daI3+aBeZmvSEjoyPjQ0f1v7UkYm
 L5xUXVjpKc5Yx05JvuHbzAZJL6JlAve/Gm1xX2w0H4fx4NBJGr0wy2AY1SOUfP/HKwQRDdnUdUF
 asAU4o/eVdNpYEg9VEA==
X-Proofpoint-GUID: ve0Qp9YpWN23CxutEknC6s73bMTggK6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100105

On Thu Apr 2, 2026 at 5:01 PM CEST, Claudio Imbrenda wrote:
> Remove the 1M memslot alignment requirement for s390, since it is not
> needed anymore.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/dirty_log_test.c         | 3 ---
>  tools/testing/selftests/kvm/include/kvm_util.h       | 4 ----
>  tools/testing/selftests/kvm/kvm_page_table_test.c    | 3 ---
>  tools/testing/selftests/kvm/lib/kvm_util.c           | 9 +--------
>  tools/testing/selftests/kvm/lib/memstress.c          | 4 ----
>  tools/testing/selftests/kvm/pre_fault_memory_test.c  | 4 ----
>  tools/testing/selftests/kvm/set_memory_region_test.c | 9 +--------
>  7 files changed, 2 insertions(+), 34 deletions(-)
>

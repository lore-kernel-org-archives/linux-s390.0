Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783769;
	b=rFlHt80emQW8rPZVseABrttx2HzD2tCpAv4GvjdlZslCWCKbVEdzH47h6tbj1PdnxWgx
	 P2HHibTE0dnVHEHCwzngOGYvFyaJIQ4vjcN1r+o82RFmxL2eKItRu+GLkT34BI3TfE/CW
	 TvP1VtcHLEqWSz0WtodLyYF10rg1Gz9YKxe2zDVAWkgoe/JdCCy+jp1gtsB+jN/a6dIIL
	 ZNC2hab7TNWkIHy5I/Qogc+hFtheyA2K3lPIoyrXzu6MW/3q/bGWFivhQ68+xOkWQ/Np+
	 gnHHIq61g6J5+3+V5cExg15rLeRSmxuo9PAZulRhdYaXAcJWIWbO8U4L04p1CYOcsig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dYrltLS6eWpuLknlNcux+LN4h5oejRIvnVm7yogZ8T8=;
	b=L7/O9LYVR0xAsppdUF5m/RPVWbKZg099Z/WV07Y8dsXxarUa3uWaB/v7rkIfW9R/FMla
	 /7UiNC2JP5bn0jzCfCLLZw9mLPceKTuh9fLYck13T5iXXrPGXdUDm1FBIfmONMwwQa2Ro
	 riEwKjZWoIOBgW7zB4iI2fFOWKY0UZGB/OcSdp5Yrof7CBxuh89bXe0XRqDkXxlfxymwp
	 q6+3pBjz/fQO+N+OhJ32Or6cByHFaXlsa+nXnajyB3pLCU0zXcutyszt2VBK3szEcHimx
	 FHHtlRfpapy22jt2GK3ISf/6ytQmoTGL89kaDeODNuvuc1MLPuiRj8A3ETUcFmJhM0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="ihid3q7/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C90606A326;
	Wed,  4 Nov 2026 09:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C90606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ihid3q7/
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48iDLZ086580;
	Wed, 4 Nov 2026 09:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dYrltL
	S6eWpuLknlNcux+LN4h5oejRIvnVm7yogZ8T8=; b=ihid3q7/Ox7fb3hpz/YXQm
	hebgs79WarucZ0PvS7MPTnpqz3bqC/dcqwp9db+MQInEvp/3tBUWFlYFdzCdvnS8
	/R3W7FcxNQcBbfeMDvY18T0ANqfVS7d/8IW8F/X+hYqgfEki+EslgcBp+zDkLDlq
	RwU1E889AD0oDOoWxrfoV+06Rt5gVNvcA5LfmDvonxsYRKSYo7BygrJfvYkD1Rxj
	3hoac6gyhsJHSELrZK5oXPjiUELDyiYpxBUQ+xgWADh9BvT+mXRSoIbHPVdAumIC
	rZALVcYkVqvPDoQPFNLSFumLE2AubxnvQhEEvCj6Hg6ih1U5cXc06ZUr+zcZ+tTw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826tw51-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:16:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48K27e3844313;
	Wed, 4 Nov 2026 09:16:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqkdmqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:16:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A49G23M48890196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 09:16:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE36C20043;
	Wed,  4 Nov 2026 09:16:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 524E620040;
	Wed,  4 Nov 2026 09:16:02 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 09:16:02 +0000 (GMT)
Message-ID: <763403da-9818-4848-b901-f843a4e6f6f9@linux.ibm.com>
Date: Wed, 4 Nov 2026 10:16:02 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: s390: arm64: Fix kvm_arm64 module naming
 consistency
To: Andreas Grapentin <gra@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-3-21c36fedd878@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-3-21c36fedd878@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jaPXHhELVthnUQSvI_7sCycpFOtYyoX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX2rxuFsRnpWvc
 Z1l60YUDBCe1b1q9dMkFJwXxWsvf7/yX+5+H/JtHKD/aCGoZxtP3JXfumRCF28zASQUU99FZkze
 Dqk/kIx3U+zRALGjZouPr98EEEhYUddrWvhYYOLrYIUXVNlcIf/fvSDvfMo2mgAa96sckfTooaa
 arwkpf6Ufjptf1MqqUR7XjGsrQ35ocjYDSNaD0srXa1HpjGEDYL3D6uTuNjts/TBRGuwwdU3Pcj
 P9WpSntSQq/rkXn8fYJZN5eALsB7gY+aNojX/Cq5Kv0xwdDYrvUboFmO1oPP0ss1uenNuDNa4ba
 F4gPDk5uAtW0uoC4/aKWhgDEFDoJlkWg9OmyhCKcRB98q0uk1v6Xe+7vw50H2oI/zsFBVEeVaAI
 YKF46IOSDkYscmkeEUSSFKXqFGveE8oK4V7HNIwGRrB4dLze2pibRpSFd4SyNPhwQKSjwQ7nRBm
 7aGXxBjLF9I0Kj2ot6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX6reDjqMxNrcy
 ZGBjB4tlwr9+lEmFodWYZfuuu6ydtIBgN4edKNJAdHt64uX0YFn3lVTZ8vucKiEBRhADlLvLfm1
 x7NtUA0B6IjGKflOQqffmIthW1RvwrQ=
X-Proofpoint-GUID: jaPXHhELVthnUQSvI_7sCycpFOtYyoX5
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aeaf7d7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xBgh3BRkg_6EFAFTfF0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040036


Am 03.11.26 um 17:37 schrieb Andreas Grapentin:
> the module build for the kvm_arm64 module produced kvm-arm64.ko, fix the
> Makefile to produce kvm_arm64.ko instead, so the output file name
> matches the module name.
> 
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Its a stretch, but maybe add
Fixes: 91b87e6eea4d0 ("KVM: s390: arm64: Integrate arm on s390")
so that any backports will not miss this.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


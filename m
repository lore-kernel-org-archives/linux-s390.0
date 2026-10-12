Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8CE3EEAE5;
	Mon, 12 Oct 2026 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815666; cv=none; b=aXfL6WQs2ETAeM/qb1PzcbQm0kkR5xgr5pdt1rjgzSMjn9COMa64MovGAoqENMWhSCno0+AmFY/zVsKUmiICtsuwCuYJEmxWDaI42hCU5MDCE5ORGqWq2S6rHIABg5TwUTVSwzY32M+empJPjjAkoElyDAUXkBuJcBRBgShsEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815666; c=relaxed/simple;
	bh=SZXy4wNq3cmvCUsQZTYQIXSY36BeuDhHJpaLvRyiA7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhmU95fSXLrhQ0BkVkVE/rnSlDuE1+dcXgL6hWRirpJv0v6hpclrvqzccexMnpCany4wneJAB+N5rzehjHh/x4mPFRZ7o43Uxfg0KA5jHzpG86leeph3TboSSEVn0Tsh2+9/UWxyFbSgY6qJIjUrxNJskoFCdYL3UZzToZ24354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K7FN0HJ+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K7FN0HJ+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEcRG3210035;
	Mon, 12 Oct 2026 14:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qVt6/F
	IT52gfK5kMZ4TlrQ6wjoYgZ6mDpHTIOLFPeDc=; b=K7FN0HJ+hb5BJjvmDQmiQ6
	DtgQEc+6xcTWjNi70vHqAgf9wSMpdzng0mjsCCMUnEn/usAVT24tAndZpd120sUJ
	fmV8JFalxHsoAKWAV/RlaVgaHCxSudR5cBiJF6McpqlJ//jkIUrGO+IywuQDnS+/
	Jpy6r4VEvI3bLQREnAco1YqOXm5IfwvVyXVYhUtSORapQVsybuS3nM1Mr6xiTDVZ
	/WmpFJ123lISl0zpG8YCiO+NyzvtKtqDPqAH8BECmRrI/RKYzwmVrkIEsS4gJncS
	UdNV4KqqS3qmRmHoV5aojTj/GZelNZVVD3BhibgaD5kmBEuqOI98tlJTd9uJON8Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv092m8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:34:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC556F1238609;
	Mon, 12 Oct 2026 14:34:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnqtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:34:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEYJ4Z30081718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:34:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 275B520049;
	Mon, 12 Oct 2026 14:34:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE3520040;
	Mon, 12 Oct 2026 14:34:15 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:34:15 +0000 (GMT)
Message-ID: <60adfdfa-1531-4f18-b824-c264b46b10ce@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:34:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/32] s390/sclp: Convert inline assembly to EX_TABLE_INSN
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-31-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-31-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX2j0KE2COpKit
 LHF5Ctt5RBObHgMcduDBbLoRJY9fk4pY4xXNlIQm+QBGz7qJc/md6Uf5f9A+fxw1ucdR9p34K91
 e2qTokrMcPrdmymlj7M4huPaG1UZs4ifX+uwtAblu/YOFh2jsA023y7oY2EhUYtSyA0nkWmJ1ix
 GmE4Y4D1czRTYujTx+m8HUvc5phLsXAhXRhmzTlHowJYfn4uF2c4EDSRt+6OdHXsWHj1vpcatDQ
 MFiTZlaYBZv6CuPijLgjp0IDgzigb2fTxaY8S6CijUavTpJ6WB1r8ASylFv6QgIowjK4knlyED0
 q+67OAQ3PfC1oVDjsUOAy3+f8XSCbvGwuq9+lU09FIdQHUZjPTZTQjBm3JUKGvMtggVtR2MGqDo
 pSo3n2yb48SKIt4pTaTOpZPfTZg6O57C9brALhY0qxcTUcsegn4rM60OTY0egstiZ9RrSsh0DQw
 9f++xnp36OKRX9fTKiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX0RL6W9JLl7TG
 nxg/ONFsXwXynd3arhT4ncZUVfUmhfs9KVLXWGaoPnjyR9EA/ppZfX54cTmlvP2ASeIYl1MDk8T
 6AJPOyHzh7mSM2a44hayDNORxLXWSs4=
X-Proofpoint-ORIG-GUID: opUCsacdXORyTGcfmG2EL8Fc2mb_FtUC
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acceff0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=UvQ0rWvqHNa0LO94rs4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: opUCsacdXORyTGcfmG2EL8Fc2mb_FtUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the sclp_service_call exception table entries to use
> EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   drivers/s390/char/sclp.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7906388E65;
	Tue, 17 Mar 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743893; cv=none; b=D5BmGgimLiv8Qh5uI2PzYgZuJLWWnjQ+NNTWqMuYlRePIUL/2XTy2RaPZQpz8gh6n/NlFiRhivtB67LFRNRM6SLCT7JSH9ir7V5tdbBS1Ur3uvRzaaGFSBNwgHNTVQjansjX4D+biK6Wvn2wU1E7vYszFDYvxu7NBBlrPB1d89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743893; c=relaxed/simple;
	bh=9RQ0Tvco2BwCrno5HAySN/PgXfW3wX22o+3PPwc2mmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=a3ZlMFsCoBmxldvQgEz38xE2ulsPaBqiOnYbtoB6kOe2bM4IW2pjlJZMu7cai4epcFKU8G+Q3U5xgM46iKNhke34DusJHxiMGEs5G9i/xJN1mhfmN1N4h8VLWRT2js/GRZ6gp0eoVN9qOimxCaTbxqiZW0zsUhOKDJATLw0Wj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PwhV24xI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PwhV24xI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8NjR61093922;
	Tue, 17 Mar 2026 10:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6n4QT0
	OrpXydZ1M1Xoqb1LF4gLQ/ZCRinRqoY1RW+fA=; b=PwhV24xITjQ4mQ7ximH2N1
	D1kYv1kPpluEhTH9U01M1dxw3Dz1iVqACibnHFXb7eW0c2Q3NnbyBQ75KPDNta90
	zbx+T+3W3chKXL5Ry5PbzkjGTzB0Vtictr2g6nz1vu4d/nmF8kGBBkFfxz6PFg6j
	V2oQz2mewjyezmsipfKPe9IMofTa0k7c0IbpIjOy63HQc11SEqZ/NFM6FWGPpmwr
	0lAJqyFx8Bfj30BJIWj/6eO9bbNYaVHJtIm7+Cr6syPm5hMov3ety5Df9QwJVEXU
	olrQylM0+sLzo0MW+Mq2A0bpPHONsWezOqvfS95xGG4OxJIAw/GvmykYGsfXE6xQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64m8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:38:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H8F5UT028496;
	Tue, 17 Mar 2026 10:38:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq18f7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:38:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HAc7pU49283498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 10:38:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C12D2004D;
	Tue, 17 Mar 2026 10:38:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05FDD2004B;
	Tue, 17 Mar 2026 10:38:07 +0000 (GMT)
Received: from darkmoore (unknown [9.87.132.213])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 10:38:06 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 11:38:01 +0100
Message-Id: <DH4ZQA5VYDE0.1SW16U6AQ6HCX@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 03/10] KVM: s390: Convert shifts to gpa_to_gfn()
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-4-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-4-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zTTNjaKhjZcHcUFJo8qE8ARgClkaSsFu
X-Proofpoint-GUID: zTTNjaKhjZcHcUFJo8qE8ARgClkaSsFu
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b92f14 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=-yrtnzFoinabFxpHE94A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA5MCBTYWx0ZWRfXwPmF990i2iCP
 i3aDng4YX07QnKc5G0lGNjc/bTc6OmAWg+uYvIxqrgsA3gZ2dIapJ0KDWrAYcMZca6uoGUo6o0F
 gG5lf47k4D9FQvk11NHb7w/qLS/VK1yDb0GwfTk0x30M+t0+kMXUPWt36eYXzP+8OuopoJawZfe
 67sYuh7gf2s4zafA5oUxbCfurnqLU+BPoFXb7RvUVopzRtv4NW4c81zmaMjqa8ABaHAwtE2Bd+5
 i4meYC4OcnaQ7wwOUZzBH68mG+l0RdKVD/GUNs4I6TKj9sCfYMwklX3qG16yb5i1bMi2myF1Vc9
 og83th5NJ9jRfbpsc6heVvunYc2UlvNKpD2NwJyBIOLtaOPgdqRw75TH/IpFq5c0pgqTTQNPaUG
 TzLigyBbmnA3hl8ORQ+ySba7yryq5Wd76BcqAVejime56OtRJxHNhMjTHWd70GBVZn8NJAFuci0
 N3PCHzABzDEeMy05zxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170090

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> Not only do we get rid of the ugly shift but we have more chances to
> do static analysis type checking since gpa_to_gfn() returns gfn_t.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 4 ++--
>  arch/s390/kvm/priv.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

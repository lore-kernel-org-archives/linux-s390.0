Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AA493632;
	Mon, 12 Oct 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816785; cv=none; b=Y24r74sYDThAzZ3geyUeVX9gcplDDQMEPs9b0y1EWAJJa/Ongmk7uCQ43MSSubvnBrWxShqZ5SdvO6kWsbBMkXisAk7Kx6krsYe2m6DtWXCc/O3kHyOZXoxyyB1MUYw0k2m/OGfeqrBMlkfwfI4KIlQk3aodyliwaZlYTIcd5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816785; c=relaxed/simple;
	bh=pgOoRpddikIhHJhPAl8qqDmtfwK7IFMaRz/Zu2JJ92k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7oX2HTflvl1Ee2vgRi9wQUmNYnKpQystB5MH/eYj6yRDWdoXn6pKJN1UiOSRm65WNVacxXxWjVXGz/xhz93CBwrg6RsCyKeO0wfDgsDa+2ZRA8GnriyxYRd/tZnsCh65XdxqeyGO9dZU4k8MyUPMPgYIgdog4tjGrH/lE5D9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iztulPWG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iztulPWG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEFF2231216;
	Mon, 12 Oct 2026 14:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vy6WDu
	fo2kCerIuEVbzeT31qd3eero5l0DiUlFNlXJI=; b=iztulPWGNZLpeXLDb1OPWe
	dtOlMGJ/7h/xKIZFybRGqpvnFIgNrE4pI4ycpDWfw0E2dsYkGPDBiRnx2Id4gRFh
	GSQnGIMZQ/HpLGkbLftiJ6kkdYL0s87H83ipQm3Nxly/s7sjP5P5Jzy5Jais93tf
	ScyvUDmPWaQUXSE/Z2ZujwxTGLNTYUMaaXrqq+o31hu3tBlrQre15OFOwvHFKGfC
	Xxu/VZLL8Mkk4UA9PMVmy7/6ol7AO3FvRBnOsx1F6MxG5un6BmZ4i/GgYM7Mimhq
	rX6QZuGNoEEwvL2pGv1xqXkWdDkb7lChjSPpmIUcnZCo9dg8858xicJkIOD1J3Rw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w1495-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:53:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4rjt1286231;
	Mon, 12 Oct 2026 14:53:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cydccp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:53:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEqwhe51118524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:52:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0AB520049;
	Mon, 12 Oct 2026 14:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3EB320040;
	Mon, 12 Oct 2026 14:52:57 +0000 (GMT)
Received: from [9.111.10.235] (unknown [9.111.10.235])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:52:57 +0000 (GMT)
Message-ID: <4e720607-ddc8-4839-9723-b1a4e4552b49@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:52:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/32] s390/dasd: Convert inline assembly to EX_TABLE_INSN
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
        Jan Hoeppner
 <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-29-hca@linux.ibm.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-29-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfXx8nVK++jlztX
 ZbX3Suus93RjFzPjYj+i68gbr39dPzY5RTTsyVQeHjUlbV3IpKqH5SuIDtSgAlf6K9OsHXt8hL1
 yAs4DI2nfziDCBgHnXTBcPe273wbhN8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX2+CIhw7ZFLke
 mTZthcKjmPeSP8d51eicKbuUre1SL8EA1jglSboC1hS4eyFLIZmPzG9AHCwxCLS5J2AmNNonp7i
 LusBkX1EAo60no9SpPA1mGcOvxAaIqAs1CAP+TAfnmNrU25Dy77hCeOThi2Sf8Dxuej4MG7ERlr
 MxxJsNTm6/vPjeVzOV4rGSd3D3wEp0/NSP23E8drD3KroRzWFAGrqQN6NXUZ+w0IxK6joBjvtjZ
 B+yetskqYsWKAciEuF4nCijfZi/p3j0knFFU06qB7b5xlGKG/l2FibaOEWV/1VsZo+rbpQVexL4
 SF/0cgJ0f40TqR24ezv7Rrp1pf0qCJxgsYZ4fY1YX4FZz96ORLb+Lg7NKHFZJdewY/yCNH/LWMM
 h6i9OKUhKg+/jmPbWml18MVSkTDeIj71mcM6cFqLDL2mVxYtiY/vBx/sh8Up5zuE0yycCOe1P34
 jBO7wAl+ueNnLAj3v+Q==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accf44e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=aTFTrbAScIvJpor55YMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hSdXDWgwE8mR7xjbj880cAT9tW-CXC0X
X-Proofpoint-GUID: hSdXDWgwE8mR7xjbj880cAT9tW-CXC0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120058

Am 01.10.26 um 12:32 schrieb Heiko Carstens:
> Convert the dasd_diag exception table entry to use EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---

Acked-by: Stefan Haberland <sth@linux.ibm.com>

FWIW: tested on z/VM with EDEV devices.

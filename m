Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1248CD55;
	Mon, 12 Oct 2026 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815001; cv=none; b=aYH4eDiIK9i5sxRhTOuPXe4ej2CjOL/Ak/W2xISofnZB4Cp+94igrG+cdMNThBwHuBoK9g9Sxs4HPQ/iU6NFmf/mYiCffJ9JH7PQEEtN3ktMx83QFZe1xDH5vL08Tyc8WT2fPV24HxX0KdDeKdxotuZt6p0Ud5Kwtl66DbSYlBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815001; c=relaxed/simple;
	bh=2bytl9vN0KE5qN1G/SnfTyERvKEm0d1aOtjySvzD+hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWaJ1onvuel/VOu4Xf/mZbqMwTrCAK4iyuWAwgnqiycoaTnCE7V7anZ2jiGU0eUZ1e1TZAbx2fFmlmolQDAOm/kcEcmDZe00/H7v3eRcyru4/a/KOTmdi9jyBCplL7PGY1WbsZishoIZ4C84SXekMs9r6kFcqvKP/vdgkiDn1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pmkEsg/Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pmkEsg/Z"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEjkS074178;
	Mon, 12 Oct 2026 14:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=obC2fP
	OMk/1I5FIrIGJcqqK8tv1JSaYesffBU9acZiA=; b=pmkEsg/ZUF7OZUGp1r3NnB
	zoRdd6A8HuSkrGxrZQLeBmp1FNz7xb1zCgzrOp5BZuUzUWEm+ta7mClwEEKAtX3k
	BjG91tB0NVBI1OokuBSGIY91jMVmPMo76jDa15/pnQGcUA1d6lvzo5720qRhDw0R
	+ehglzyczn0AXTmBI1Y01+uKhPb3RuUzbR6qCgnxL9IDMMYcpqx2KXk+UW85SeQ2
	X0M+ETJAKnwzP1QG3HTqTdxH17xKHtF25+NvQ2F73/cyutUsi9PykRwC+wtH07Q0
	vHqs6I3wwq9qAsIy24gjhxxepIJmMK75sK1V3HF6HGWVrjfhs9b7tEqCaUcxeVGA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhs2gf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:23:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCJrr31255393;
	Mon, 12 Oct 2026 14:23:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vnn83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:23:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CENEG529688376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:23:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A19DC2004E;
	Mon, 12 Oct 2026 14:23:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EE0920043;
	Mon, 12 Oct 2026 14:23:14 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:23:14 +0000 (GMT)
Message-ID: <e2398cc9-9a39-4cec-8eb1-87a92d81ed93@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:23:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/32] s390/cert_store: Convert inline assembly to
 EX_TABLE_INSN
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
 <20261001103247.1989111-18-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-18-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX1tryDhyDE/ix
 4LFlbnpryLgbIy93fgPujmEXVyYk3LdfeFXjfaPXlO0IkUW6yMhU7f0fyxeMdwo5dNRBO1UGHVp
 0u8OdCzZoBF0mVKSWqrHVlHnJaHnuXihev8rIebVOc/LxvFCsiaNeYRrD/otIoIGanMBPswPpg5
 hDgEGS/+ww3KC8/0exSJKw3MZ+CSM/bTII0D1iJBM9181YhACvnNJgnSPlC8BfauyCN9d3U58uU
 ThCA2I+4XgFDJeihlxibU3GgPXdj7DSDQIwTPOqvDZZwYnIZiABszAYGDG+PB5Oyp0/xGKtxKB3
 6mu/meX9y3TwV5iAzWBBNOyz+B7wpKZS/FJKuZo/2rR65HfPL8hkQ+294UEsj7nyPOwyQfhhvzX
 hKC6MAsb25iSRZW8OgzkzNY94SwvyCN8U0VRZ5c5kJDysKfaKHls5nyLv2lRn0+fAFaXsX3mZEq
 3DRggkK5C6EfWhtqubA==
X-Proofpoint-GUID: TNdmkMumOPOwOLra3dsQCDj7P9WhuWux
X-Proofpoint-ORIG-GUID: TNdmkMumOPOwOLra3dsQCDj7P9WhuWux
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXyOMaF5PBU+i4
 +jL9z+2p8Fq5/tD/ciGl1cu+8QNPG/dWttzJyXyWV/K+wQG/S0xhuFAu2w7bF5ooQeWSqe8gGhh
 QeVYv9evyzZ1I4cP+3lcl1IgBoMdb08=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acced57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Xd7Fr9RBzWlSPAaGVCQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the diag320 exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/cert_store.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


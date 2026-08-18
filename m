Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898B35BDC2;
	Tue, 18 Aug 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787021418; cv=none; b=gLGGS5FZ0yYv9kYIDSyL9WA1HtdZLL6b3t9cU2YioxTZOYU6w3WEQXB6+Pl3PkKIPLJJb++nxqqiwCtQiUgSxb2t/0AqUsapdiJ/JhGyG/T3QanbbjP3d83iw6KinH4XDloTwyn4aZShs+WGJFiy5Q348+4TTBiGTbYLgLqqFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787021418; c=relaxed/simple;
	bh=g6uhDJXu+B7EWCWejoCODzvTHMgp+/bQtfPxf9plNXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8t2ipJtKJEkYJdi8cj/Hj9Up/5rCCrBSgp1Rbq0ypLKzn1qUzc8Fw/TeQNYjlgqPKpi48bVtLSvW2rxb0jY5wMVUAy+KOzBhUfmnXANxhRLB4fPiQaC+wmRELdjhIY7EcF9vwlFxmCdmcjh/gfwcxrmUztr3/1rHYWjkcfNF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gw4Hvt1B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gw4Hvt1B"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1mlC1515108;
	Tue, 18 Aug 2026 02:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g6uhDJ
	Xu+B7EWCWejoCODzvTHMgp+/bQtfPxf9plNXA=; b=Gw4Hvt1BzPq7UBW0A0ve7m
	NdQHfVvaQSSc2VRb+skosqlFPntGg9ie6AS2tHmH2xG6pn5YflsKuRmwE1k/lwUu
	5BuG6t3tQK/dCLGyHhZwXPFZi8PyzOFneIvYVcOPq9jjw1J5BzeHbP9sKS3YEmnQ
	lr8tpeaT84aa+0500awWIDEJbLB/PiOU0hCd6ZSs1OBGv9DnFU1hHmVEqVmJDq+U
	11wreWcm5tID01prsG6kfzBdEEA7c2eAKwyUEDISNC0ShsxTw4G0696sxBsbdIbF
	WUVQNUXw3XF32rXnOFhMq+lb1kdL+97R8lCx5o6voeBF1wksbeRkRbnBVupHTDQw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe5can-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 02:49:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I2fIrK023633;
	Tue, 18 Aug 2026 02:49:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek10jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 02:49:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I2nrrG44761580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 02:49:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D01020043;
	Tue, 18 Aug 2026 02:49:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D47420040;
	Tue, 18 Aug 2026 02:49:48 +0000 (GMT)
Received: from [9.39.19.127] (unknown [9.39.19.127])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 02:49:47 +0000 (GMT)
Message-ID: <f69f1585-06a8-4e5f-b9f3-d2167f9d05d5@linux.ibm.com>
Date: Tue, 18 Aug 2026 08:19:46 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/ctcm: Prevent XID null dereference
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
        andrew+netdev@lunn.ch, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, wintera@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
        jeff@garzik.org, stable@vger.kernel.org
References: <20260809105536.541453-1-aswin@linux.ibm.com>
 <20260817174148.3456594-1-kuba@kernel.org>
Content-Language: en-US
From: Aswin Karuvally <aswin@linux.ibm.com>
In-Reply-To: <20260817174148.3456594-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAxNiBTYWx0ZWRfX5VuM6HOXc1RZ
 QprAVbQ9k/jleJoDesOiDdayF4pUGx+B3VH+b3rVZ8h7vZjqE4YiQeCPDiTQGdy/6GuXEXyl0RB
 QCHW7AeQ0G5pwf43j4p+TmKuwglzJeqIcrsfegMVa/FlVdS/uGer075VbzMn1ypkeLIlTx8HFpY
 cYPD7sSKZNn4DHVvjmTMgZnhgzWpHi2wMiN/bCMsvU9WMHFA41rYBxLbex7/K/URWDAmiiktkI3
 G47m8aMcmQZjA5Ab3fBgnKy8decsEnhrC3PhnvLcxWdy9pRtgqWHKHxc4abM90ROrkI5wib7qWZ
 HD/88I93sImx4oqcnkF6arV/YWoPXRyGPleNaYdZF5q1CQgk/5yCAtWtKjcovG/359TZQfoT55t
 zJrxXU+2ml5i7huRgXniuTdy6I3zFddtkvInCt4ItaM0MIL2bB3mOdgDxAHvGWrDvsCmmfNTcbx
 v8ddkBixuDx4BExPsmg==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a83c856 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=F2m9J7YYG7PLqnBJ6x4A:9
 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-ORIG-GUID: VBQxeEyNz0PK-EOKuVpZJvJLReC_nUYP
X-Proofpoint-GUID: 67GPWOJqxRugK6TtLPpJPF4ZCnP-8y5E
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAxNiBTYWx0ZWRfX/oleWyQJ/HHN
 NBEiufdAFqbVKsgmLWiookKGMIlIX4N5SOKh888gYhOuJ+VeMG8WK2o3TLzJWjMISEXEOvHgxG+
 VTyrzGIDyA7Gwid1vnDsqsMPZk7rPXg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180016

On 17/08/26 23:11, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
Hi Jakub,
Terribly sorry about the delay. Our team is working on the issues
highlighted in the Sashiko review, will be sending out the patches
ASAP.

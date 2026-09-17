Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791F3CB563;
	Thu, 17 Sep 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630151; cv=none; b=mNpbaHMrjOJhxxRCO5gnQj+gF1qYqcAgrIbSImeVltjY26UFJYtII643iEEY6LcZZO7jR6GRnpUBaf5+hwu+nccUrlN6gqiDwqTXuAri6dyKwTRwfh5n3CS3OAkFf5aN5PTk+99lxsbS/TBSY/ui+eRvLTd29ZZ26A+3c1mwA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630151; c=relaxed/simple;
	bh=JkAeNspU3McztXyygCjKCcKYcHJmOgDhQqLtm+g1Dew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVd5rmKRKWrElq6u3ZI76izft6aktFxVBv0dwyS7Mb5LA914XdnO/083LFlUK2h8gyNa/dNEqauXnA1haaEVgHUJVL1GXgs6AStOVSwOOr5s24GBJ6mmes0UCHilD4x7EYPUwEcVq7E/EnQlw7t4vysSAfDj/05DxK92JNqzbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UVxZE6MQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UVxZE6MQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H62UWH543279;
	Thu, 17 Sep 2026 07:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HrNqlv
	ne+h30yD1aOME+nBA0oQ3YIMTAigAGhfKIKXk=; b=UVxZE6MQHSQv8br3mlBAeA
	uuJi04ANLVwAipCaYAN3K4DBBOteNJ7d0maNCnR4PMr965MFOp8PLR5EiiwDHXkj
	s4h6Nuu4/zKtFcT+3QB0L12iQ4W6RUVmehmD/iEdHz7lPKn84zFlnfo0KVaQfogn
	zpCS//J9YqufI8A/iDnhRD9kDv9HS5MTra7uNOnfUn5zpovwYuAh+3Xj2zmA7c+h
	lyk3gU4xCzT1bH66iZbj5Xzc26frAnpLORGDCp7P+XzQzZ1jsIRRtVqn90BRal7i
	KIGojW0pS0yz5tYs7hpEAIPk7XnerLA6oUMdeL+xGB9P8OkjAvXtHCze7awwLmbQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e8mwt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:29:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H65BkH2638636;
	Thu, 17 Sep 2026 07:29:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3f8cjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:29:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H7T3Zp34669048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 07:29:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9BD92004B;
	Thu, 17 Sep 2026 07:29:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2FE620040;
	Thu, 17 Sep 2026 07:29:02 +0000 (GMT)
Received: from [9.123.3.144] (unknown [9.123.3.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 07:29:02 +0000 (GMT)
Message-ID: <43395bfc-f41b-43ca-9be0-9dbeeb3fa614@linux.ibm.com>
Date: Thu, 17 Sep 2026 12:59:01 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event()
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
 <20260804182120.535961F00A3F@smtp.kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <20260804182120.535961F00A3F@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfXw9KKCWtVlopg
 s2D2WawRTPM5+yr3YeeaQIia/3VU4dpOHHhYSkMW1DiKhE30yS96mW1jwkB5IEBAVxKSuGOFI+W
 jETTwBK8x3eVvn4VQmJZ47JXtD2r+uzYLig8WhlPFU3kg7AWv66LmxsW6ObzvpX6DgaOQCj6pFN
 JHmmcb74snuNqJK0Gz+ijf78EUuXtqL/XXynTYvrJPCVpPhGNkTk+PiZr3UwNn5BHGl4Sklg+6b
 t6+6tkAqUS3yj56vb0q5LP4U/RdnaykRph7ci5yUGHdv6T54senz6qhEQJBem4+FBoNeoNidPY6
 mS6R+aDx6T0Yl/erzAxJ7GOUNyFZoEZClzi5inbPxsyb/8HZv+5qzmOC4QP/GGGf3fHIrDbZx9p
 GrqCH2loRRrw9Gp12E+pJMhL4+INVgdee0vxtjxLwvuNkyPwH7WesfeHDpP67NLke3b51dseuZU
 AdHvW7P59kjaVtd0wzw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab96c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cFzD1ptanSrodPJrcKUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C9O-HcMJBPjBiah7sUz2CJr3yhRgpAEm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX3ZS93eCkrseq
 pJKuJ/t8afLBkUIB1qpXIjCtb++07ZBWkm8kXlLqtDbgOKr70E+psei/kpTxfpun4NAk+pwbGJq
 3oL46W4ZSQl9VL7fztd/0dJr8Yoo05Y=
X-Proofpoint-GUID: C9O-HcMJBPjBiah7sUz2CJr3yhRgpAEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170093



On 04/08/26 11:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The patch introduces a sleep-in-atomic-context bug by calling a sleepable memory allocation function while holding a spinlock (`read_lock_bh`) that disables bottom halves.
> 

Correct.  Fixed in v2 by a two-pass design: iucv_send_ctrl() is only
called in Pass 2, after read_unlock_bh().  Pass 1 uses GFP_ATOMIC.

> Pre-existing issues:
> - [High] Socket state, shutdown flags, and transmissions are manipulated locklessly, leading to data races, lost state updates, and a potential NULL pointer dereference if the socket is orphaned concurrently.
> 

Correct.  All three sub-findings confirmed with KCSAN on IBM Z.
Fixed in v2: Pass 2 acquires lock_sock() per socket, serialising
sk->sk_state, sk->sk_shutdown, and iucv_send_ctrl() against
iucv_sock_close() and sock_orphan().

Pass 1 reads iucv->hs_dev under read_lock_bh while iucv_sock_close()
writes hs_dev = NULL under lock_sock() — orthogonal locks. READ_ONCE()
/ WRITE_ONCE() document the intentional concurrent access and suppress
KCSAN reports on those accesses.

v2 posted to netdev:
  https://lore.kernel.org/netdev/20260917071706.23831-1-nagamani@linux.ibm.com/

Validated with KASAN + KCSAN TAP on IBM Z.

Thanks,
Nagamani PV


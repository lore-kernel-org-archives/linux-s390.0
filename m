Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C774C6EF6;
	Thu, 23 Jul 2026 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811627; cv=none; b=U2cduk1wBCMDnG6mnNeFcQe0yyKjMj3k16ZSBwZMLOEUXGRlAphJd93r7NFEGh0LnwszcmfDT71nG27DrC2CNIs2oUaGhy6KYvy/5RujtM45U6yDUYiSDS3aKHav7rJmaMDAyR8ixcs8Omehri5jVU/F/NmwKDZko0eit9KuAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811627; c=relaxed/simple;
	bh=18bxurMo1CP67DI8Mz6mFrk4C6L0okoKJFnm6WoQT4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMCkKPiknGZcMMqk3PlBuh5JwVV6XOCastxVSjyc9rMhj8naARW5DvxfWLZ8L3jhNH7Q/jfpAOfsHL4D9vslbFemCVmoBUgfzBK1+AxpGRNAXxHFX9YKn6aEyXZM2PCKNG/t5jmHeR/AkVx5s172C9gndUBZbL0RroJPl60+gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CbDTVJjQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbDTVJjQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BtLN701594;
	Thu, 23 Jul 2026 13:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+kIbBp
	HL1+N/LjQAuPhuyjGHCc1I4GjyvjAhSyRFtBA=; b=CbDTVJjQk+Reulq6fQ7woF
	8ZJI4cGW8MtRSdcTJovRFOgdfAxHVBBEzI7mzqohnOyTE4onINhuggx9jt8wTm56
	69xRzo2PVrmqX13W4u9o4XTOSoDDgwvsv6hnEva47hE6wLyQcN1bMkwt9ysJKz/o
	hbkNHLPzHi0FnjsCcZh89GA9OZs1rOw2KsXgqsMiiczHAJ8EelWMOzk2w20KHity
	VMyXw6OHmO2y7ka5eIW81szsm1aC3g11bLI7gBy1aOmnkqqE3YDutE+cirB20VHn
	r7F33F4Qk0HzrXqYP2SfE0BnPlVobN0wt0D7BrnR8vJwlC9so0dNx5pi7CgE7hZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aqjpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 13:00:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NCnicL031827;
	Thu, 23 Jul 2026 13:00:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wc9wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 13:00:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ND0LEX28246604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:00:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67D2958067;
	Thu, 23 Jul 2026 13:00:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE7835805D;
	Thu, 23 Jul 2026 13:00:20 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:00:20 +0000 (GMT)
Message-ID: <695f10af-317b-4de0-a66a-4257d40d8cc9@linux.ibm.com>
Date: Thu, 23 Jul 2026 09:00:20 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] KVM s390x PCI fixes
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <6cefe506-b36c-472a-8ab7-ca2483dcc0a9@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <6cefe506-b36c-472a-8ab7-ca2483dcc0a9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p0Zsi9M53S5f9geizKEfhutErHBEmQkN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfX6DmkeSw0BHz3
 4dS12O4V9Asn99uug+LcT5WQOiTskafjqboQEVO5uiNrxFtBG+eqyRWTShfb3v4VrNFJtooMEAt
 8CJdyq1+YSA2SElEdLIUdWrqWMg13j8=
X-Proofpoint-GUID: p0Zsi9M53S5f9geizKEfhutErHBEmQkN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfX2r7/CUSk4sT6
 X03gPiEBZq/CeXlS33sfpvq9CtCZHLKD/yzN7K8YrCDaZvbR7zNxeDqshERK6aplIQWWRzF0aYV
 +O8k2rSJwkxVgZ6J9zMMpx9ZZv/UnwHe4PTa0F7hVcdMYNZVv1OBtroKF2U0riBxBDBt1VYw+Rm
 8ULetOg6xRU3QNv7sMab0oZI3FHPMm/wIcxB72SjECXGE4s9Rw0F879XAKN5Ss1ownk0M5Fg9ql
 cTCyfTgmpnB/Us3JB23VC7v0YRhI8ijJ6YncRhX/pLZZXFwT6NIBeNqSZci+gsjK0e1qvUsKo20
 ndyX1oMP2FiMXIjyV28Nst7RVXaOO/J6UFlZ80MhXJUSre6UtTcLj4akbe2QGBR/LemEic3gof/
 m+Vq/DuLlkh/efe5EpYE+Dhoy23472UBgHNFQTFhs+S4j2Ie60TfX7lkPJzfMBDk2yefkTuEt97
 jADHgDmL++2jAnNXyGg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a621068 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=bxUVQvDyOijYMLjhxLwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230125


> I would take this series and do small fixups where necessary. Just tell
> me if the change for patch 6 is fine. Or provide a v5.
> 

I am reviewing and testing this today, please give me a few more hours.

> I suggest to add cc stable to all patches.

Agree
